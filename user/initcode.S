# Initial process that execs /init.
# This code runs in user space.

#include "syscall.h"

# exec(init, argv)
.globl start
start:
        # init, argv为下文的两个地址
        la a0, init
        la a1, argv
        # 留疑：不太清楚ecall下的具体执行过程，貌似是读取a7作为判断（不确定）
        # (2020.4.8：可参考https://stackoverflow.com/questions/59800430/risc-v-ecall-syscall-calling-convention-on-pk-linux)
        # a7的值在syscall.c中定义，但尚不明白ecall中如何和本文件联系起来的
        # 细节还有待查阅发掘
        # (2020.4.8：搜索分析ecall跳转位置应该是和stvec和sepc有关：试分析相关代码)
        # 照着syscall.c的参数表，应该会调用sys_exec()，再由sys_exec()调用exec()
        # 作为参数的init,argv会使exec()运行init.c内的代码
        li a7, SYS_exec
        ecall

# for(;;) exit();
exit:
        li a7, SYS_exit
        ecall
        jal exit

# char init[] = "/init\0";
init:
  .string "/init\0"

# char *argv[] = { init, 0 };
.p2align 2
argv:
  .long init
  .long 0
