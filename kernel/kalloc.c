// Physical memory allocator, for user processes,
// kernel stacks, page-table pages,
// and pipe buffers. Allocates whole 4096-byte pages.
// 为用户、内核、缓冲区各分配大小为4KB的页面
// 所有分配的页面都将位于RAM位置，即KERNBASE~PHYSTOP区域内

#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "riscv.h"
#include "defs.h"
#include "config.h"

void freerange(void *pa_start, void *pa_end);

extern char end[]; // first address after kernel.
                   // defined by kernel.ld.
                   // 由kernel.ld指定的、除内核代码外的首位

// 简单的一个单向链表
// 作为各个数据结构（例如空闲页）的成员提供连接功能
struct run {
  struct run *next;
};

struct {
  struct spinlock lock;
  struct run *freelist;
} kmem;


// 清空除内核外的RAM空间
void
kinit()
{
  initlock(&kmem.lock, "kmem");
  freerange(end, (void*)PHYSTOP);
}

// 清空pa_start至pa_end中的连续页部分
// 对于不连续的部分（例如首尾）似乎并不理睬
void
freerange(void *pa_start, void *pa_end)
{
  char *p;
  p = (char*)PGROUNDUP((uint64)pa_start);
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
  {
    #ifdef RUNNING_TEST
    printf("init addr: %p\n", p);
    #endif
    kfree(p);
  }
}

// Free the page of physical memory pointed at by v,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
// 清空 pa 所指向的页，并将其并入到释放列表(kmem.freelist)中
// 将每个字节置位为1表示这块区域已经废弃
void
kfree(void *pa)
{
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    panic("kfree");

  // Fill with junk to catch dangling refs.

  memset(pa, 1, PGSIZE);

  //对于页面，其 run 应该是默认为首个成员
  r = (struct run*)pa;

  acquire(&kmem.lock);
  r->next = kmem.freelist;
  kmem.freelist = r;
  release(&kmem.lock);
}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
// 从释放列表选择一个空闲页面供内核页表使用，返回其地址
void *
kalloc(void)
{
  struct run *r;

  acquire(&kmem.lock);
  r = kmem.freelist;
  if(r)
    kmem.freelist = r->next;
  release(&kmem.lock);

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
  return (void*)r;
}

/*
  有两个问题：kfree()和kalloc()分别用1和5对空闲页表进行了垃圾填充
  两个填充数字不同有区别吗？有必要填充两次吗？
  （原文档说是尽快使其崩溃，但还是不太能理解）
*/
