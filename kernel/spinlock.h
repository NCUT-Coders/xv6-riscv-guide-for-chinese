// xv6 2种锁之一：自旋锁
// 没有抢夺到锁的进程将会一直尝试，简单地实现了互斥
struct spinlock {
  uint locked;       // 是否上锁？

  // 供调试部分
  char *name;        // 锁名
  struct cpu *cpu;   // 当前持有这个锁的cpu
};

