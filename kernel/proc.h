// 为系统上下文切换保存寄存器
struct context {
  uint64 ra;
  uint64 sp;

  // 保存被调用方数据
  uint64 s0;
  uint64 s1;
  uint64 s2;
  uint64 s3;
  uint64 s4;
  uint64 s5;
  uint64 s6;
  uint64 s7;
  uint64 s8;
  uint64 s9;
  uint64 s10;
  uint64 s11;
};

// 各个cpu状态.
struct cpu {
  struct proc *proc;          // 正在该cpu上运行的进程，若该指针为空则空闲.
  struct context context;     // cpu当前的上下文/语境，进程调度由scheduler在此操作.
  int noff;                   // Depth of push_off() nesting.
  int intena;                 // Were interrupts enabled before push_off()?
};

extern struct cpu cpus[NCPU];

// per-process data for the trap handling code in trampoline.S.
// sits in a page by itself just under the trampoline page in the
// user page table. not specially mapped in the kernel page table.
// the sscratch register points here.
// uservec in trampoline.S saves user registers in the trapframe,
// then initializes registers from the trapframe's
// kernel_sp, kernel_hartid, kernel_satp, and jumps to kernel_trap.
// usertrapret() and userret in trampoline.S set up
// the trapframe's kernel_*, restore user registers from the
// trapframe, switch to the user page table, and enter user space.
// the trapframe includes callee-saved user registers like s0-s11 because the
// return-to-user path via usertrapret() doesn't return through
// the entire kernel call stack.
// 包含指向当前进程的内核栈、当前CPU的hartid、usertrap的地址和内核页表的地址的指针
struct trapframe {
  /*   0 */ uint64 kernel_satp;   // kernel page table
  /*   8 */ uint64 kernel_sp;     // top of process's kernel stack
  /*  16 */ uint64 kernel_trap;   // usertrap()
  /*  24 */ uint64 epc;           // saved user program counter
  /*  32 */ uint64 kernel_hartid; // saved kernel tp
  /*  40 */ uint64 ra;
  /*  48 */ uint64 sp;
  /*  56 */ uint64 gp;
  /*  64 */ uint64 tp;
  /*  72 */ uint64 t0;
  /*  80 */ uint64 t1;
  /*  88 */ uint64 t2;
  /*  96 */ uint64 s0;
  /* 104 */ uint64 s1;
  /* 112 */ uint64 a0;
  /* 120 */ uint64 a1;
  /* 128 */ uint64 a2;
  /* 136 */ uint64 a3;
  /* 144 */ uint64 a4;
  /* 152 */ uint64 a5;
  /* 160 */ uint64 a6;
  /* 168 */ uint64 a7;
  /* 176 */ uint64 s2;
  /* 184 */ uint64 s3;
  /* 192 */ uint64 s4;
  /* 200 */ uint64 s5;
  /* 208 */ uint64 s6;
  /* 216 */ uint64 s7;
  /* 224 */ uint64 s8;
  /* 232 */ uint64 s9;
  /* 240 */ uint64 s10;
  /* 248 */ uint64 s11;
  /* 256 */ uint64 t3;
  /* 264 */ uint64 t4;
  /* 272 */ uint64 t5;
  /* 280 */ uint64 t6;
};

enum procstate { UNUSED, USED, SLEEPING, RUNNABLE, RUNNING, ZOMBIE };

/*
Per-process state（单个进程状态）
xv6 使用结构体 struct proc 来维护一个进程的众多状态。
*/
struct proc {
  struct spinlock lock;

  // p->lock must be held when using these:
  enum procstate state;        // Process state（指示了进程的状态：新建、准备运行、运行、等待 I/O 或退出状态中。）
  void *chan;                  // 不为0表示进程在等待链上休眠
  int killed;                  // 不为0表示已被杀死
  int xstate;                  // Exit status to be returned to parent's wait
  int pid;                     // Process ID（pid，进程号）

  // proc_tree_lock must be held when using this:
  struct proc *parent;         // 父进程指针

  // these are private to the process, so p->lock need not be held.

  // 每个进程有两个栈：用户栈和内核栈(kstack)。当进程在执行用户指令时，只有它的用户栈在使用，而它的内核栈是空的。
  // 当进程进入内核时（为了系统调用或中断），内核代码在进程的内核栈上执行；
  // 当进程在内核中时，它的用户栈仍然包含保存的数据，但不被主动使用。
  // 进程的线程在用户栈和内核栈中交替执行。内核栈是独立的（并且受到保护，不受用户代码的影响），所以即使一个进程用户栈被破坏了，内核也可以执行。
  // 另外注意！！！！！以p->pagetable为根页表地址的、进程的用户页表与内核页表完全不同。
  // 内核页表是以satp寄存器为根页表地址的，两个不同根页表地址最后得出的视角截然不同；
  // 不仅如此：两个的内容也有很大差别：两者都有trampoline页，但内核视角下往下是各个kstack和守护页，而用户页表下是trapframe。
  // 注：可参考as.pdf；似乎有了重大发现！（2021.5.7）

  uint64 kstack;               // Virtual address of kernel stack（内核栈的虚拟地址）
  uint64 sz;                   // Size of process memory (bytes)
  pagetable_t pagetable;       // User page table
  struct trapframe *trapframe; // data page for trampoline.S
  struct context context;      // swtch() here to run process
  struct file *ofile[NOFILE];  // Open files
  struct inode *cwd;           // Current directory
  char name[16];               // Process name (debugging)
};
