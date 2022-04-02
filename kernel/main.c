#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "riscv.h"
#include "defs.h"
#include "sbi.h"
#include "config.h"

volatile static int started = 0;

static inline void inithartid(unsigned long hartid) {
  asm volatile("mv tp, %0" : : "r" (hartid & 0x1));
}

extern char kernel_start[];
extern char rodata_start[];
extern char data_start[];
extern char bss_start[];
extern char end[];

// start() jumps here in supervisor mode on all CPUs.
void 
main(unsigned long hartID, unsigned long dtb_pa)
{
  // TODO: try to use cpuid()
  inithartid(hartID);
  // 仅有主cpu(cpu0)加载boot部分代码并加载硬件线程(hart)
  // 余下只需加载hart
  // 加载完毕后，调用scheduler()调度线程，保持工作
  if(hartID == 0){
    consoleinit();
    printfinit();
    printf("\n");
    printf("xv6 kernel is booting\n");
    printf("\n");
    #ifdef RUNNING_TEST
    // TODO: 为何地址空间从小到大（是置入了栈内吗？）
    printf("space check: \n");
    printf("kernel_start: \t\t%p\n", kernel_start);
    printf("rodata_start: \t\t%p\n", rodata_start);
    printf("data_start: \t\t%p\n", data_start);
    printf("bss_start: \t\t%p\n", bss_start);
    printf("end: \t\t\t%p\n", end);
    consputc('\n');
    printf("base: \t\t\t%p\n", KERNBASE);
    printf("PHYSTOP: \t\t%p\n", PHYSTOP);
    consputc('\n');
    #endif
    kinit();         // 内存全置1，清理空间
    #ifdef RUNNING_TEST
    printf("kernel space clear\n");
    #endif
    kvminit();       // 构建并初始化内核页表
    #ifdef RUNNING_TEST
    printf("kernel page table has been initialized\n");
    #endif
    kvminithart();   // 启动分页模式
    #ifdef RUNNING_TEST
    printf("Sv39: \t\t\ton\n");
    #endif
    procinit();      // process table
    #ifdef RUNNING_TEST
    printf("process init: \t\tdone\n");
    #endif
    trapinit();      // trap vectors
    #ifdef RUNNING_TEST
    printf("trap init: \t\tdone\n");
    #endif
    trapinithart();  // install kernel trap vector
    #ifdef RUNNING_TEST
    printf("load kernel trap vector\n");
    #endif
    plicinit();      // set up interrupt controller
    #ifdef RUNNING_TEST
    printf("PLIC init: \t\tdone\n");
    #endif
    plicinithart();  // ask PLIC for device interrupts
    #ifdef RUNNING_TEST
    printf("PLIC interrupts: \ton\n");
    #endif
    binit();         // buffer cache
    #ifdef RUNNING_TEST
    printf("bcache init: \t\tdone\n");
    #endif
    iinit();         // inode cache
    #ifdef RUNNING_TEST
    printf("icache init: \t\tdone\n");
    #endif
    fileinit();      // file table
    #ifdef RUNNING_TEST
    printf("file table init: \tdone\n");
    #endif
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process（开始创建用户进程）
    __sync_synchronize();
    started = 1;
  }
  // else {
  //   while(started == 0)
  //     ;
  //   __sync_synchronize();
  //   printf("hart %d starting\n", cpuid());
  //   kvminithart();    // turn on paging
  //   trapinithart();   // install kernel trap vector
  //   plicinithart();   // ask PLIC for device interrupts
  // }
  printf("Nice! first step\n");
  sbi_shutdown();
  // scheduler();        
}
