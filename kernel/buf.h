/*
  缓存块的定义
  各个块之间之间采用双向链表进行连接
*/
struct buf {
  int valid;   // has data been read from disk?
  int disk;    // does disk "own" buf?
  uint dev;
  uint blockno;
  struct sleeplock lock;
  uint refcnt;      // reference-conut：引用次数
  struct buf *prev; // LRU cache list
  struct buf *next;
  uchar data[BSIZE];
};

