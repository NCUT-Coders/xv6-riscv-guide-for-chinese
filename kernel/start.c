#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "riscv.h"
#include "defs.h"

void main();
void timerinit();

// entry.S needs one stack per CPU.
__attribute__ ((aligned (16))) char stack0[4096 * NCPU];

// a scratch area per CPU for machine-mode timer interrupts.
uint64 timer_scratch[NCPU][5];

// assembly code in kernelvec.S for machine-mode timer interrupt.
extern void timervec();

// entry.S jumps here in machine mode on stack0.
// 由entry.S跳至此处：目前仍处于机器模式
// stack0作为其的运行栈
void
start()
{
  /*
    通过mret(Machine-mode Exception Return)跳出机器模式以进入监管者模式
    需要以下准备工作：
    
      step_1：首先改变异常寄存器mstatus的状态(通过定义的宏的掩码操作实现)
      step_2：将main的地址写入寄存器mepc(Machine Exception PC)
              这将使异常发生时跳转至main()
      step_3：取消分页, 通过寄存器satp(Supervisor Address Translation and Protection)控制
      step_4：mideleg（Machine Interrupt Delegation)全置1将所有中断给予S模式；
              medeleg则是给予异常；
              更改sie(Supervisor Interrupt Enable)使得mideleg所有位都可以被读写
      step_5：初始化时钟以进行定时器中断
    
    M=Machine S=Supervisor
  */

  // set M Previous Privilege mode to Supervisor, for mret.
  printf("start test\n");
  unsigned long x = r_mstatus();
  x &= ~MSTATUS_MPP_MASK;
  x |= MSTATUS_MPP_S;
  w_mstatus(x);

  // set M Exception Program Counter to main, for mret.
  // requires gcc -mcmodel=medany
  w_mepc((uint64)main);

  // disable paging for now.
  w_satp(0);

  // delegate all interrupts and exceptions to supervisor mode.
  w_medeleg(0xffff);
  w_mideleg(0xffff);
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);

  // ask for clock interrupts.
  timerinit();

  // keep each CPU's hartid in its tp register, for cpuid().
  int id = r_mhartid();
  w_tp(id);

  // switch to supervisor mode and jump to main().
  // 至此，mret正式启动，进入S模式并开始运行main()
  asm volatile("mret");
}

// set up to receive timer interrupts in machine mode,
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
  // each CPU has a separate source of timer interrupts.
  // 各个CPU的时间中断相互独立
  int id = r_mhartid();

  // ask the CLINT for a timer interrupt.
  // 对CLINT(core-local interruptor)进行编程，隔一定时间进行一次中断
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
  scratch[3] = CLINT_MTIMECMP(id);
  scratch[4] = interval;
  w_mscratch((uint64)scratch);

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
}
