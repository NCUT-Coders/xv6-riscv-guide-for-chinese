// Long-term locks for processes
// xv6 2种锁之二：睡眠锁
struct sleeplock {
  uint locked;       // Is the lock held?（是否上锁）
  struct spinlock lk; // spinlock protecting this sleep lock（睡眠锁本身由一个自旋锁保护）
  
  // For debugging:
  char *name;        // Name of lock.（锁名）
  int pid;           // Process holding lock（当前持有这个锁的CPU）
};

