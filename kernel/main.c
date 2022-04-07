#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "riscv.h"
#include "defs.h"
#include "sbi.h"
#include "config.h"

volatile static int started = 0;

extern char kernel_start[];
extern char rodata_start[];
extern char data_start[];
extern char bss_start[];
extern char end[];

// start() jumps here in supervisor mode on all CPUs.
void 
main()
{
  // 仅有主cpu(cpu0)加载boot部分代码并加载硬件线程(hart)
  // 余下只需加载hart
  // 加载完毕后，调用scheduler()调度线程，保持工作
  if(cpuid() == 0){
    consoleinit();
    printfinit();
    printf("\n");
    printf("xv6 kernel is booting\n");
    printf("\n");
    #ifdef RUNNING_TEST
    #ifdef K210
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
    #endif
    kinit();         // 内存全置1，清理空间
    kvminit();       // 构建并初始化内核页表
    kvminithart();   // 启动分页模式
    procinit();      // process table
    trapinit();      // trap vectors
    trapinithart();  // install kernel trap vector  
    plicinit();      // set up interrupt controller
    plicinithart();  // ask PLIC for device interrupts
    binit();         // buffer cache
    iinit();         // inode cache
    fileinit();      // file table
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process（开始创建用户进程）

    __sync_synchronize();
    started = 1;
  }
  else {
    // TODO!: 修改了start，现在CPU将按照编号顺序启动而不是同步进行。不确定会有什么影响
    while(started == 0)
      ;
    __sync_synchronize();
    printf("hart %d starting\n", cpuid());
    kvminithart();    // turn on paging
    trapinithart();   // install kernel trap vector
    plicinithart();   // ask PLIC for device interrupts

    // __sync_synchronize();
    // started++;
  }
  #ifdef RUNNING_TEST
    printf("Nice! first step!\n");
    #ifdef K210
      sbi_shutdown();
    #endif
  #endif

  scheduler();        
}
