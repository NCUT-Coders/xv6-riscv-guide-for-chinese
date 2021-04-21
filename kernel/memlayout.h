/**
 * @file memlayout.h
 * @brief 这个文件规划物理内存结构的详细信息。
 * @details 这个文件的原作者在编写时参考了qemu的内部实现，并以此为依据，在这个文件
 * 中详细规划了这个操作系统的物理内存布局。
 * 
 * 基于qemu的hw/riscv/virt.c，qemu -machine的virt是这样设置的：<br>
 * 00001000 -- 启动时用的ROM，qemu提供<br>
 * 02000000 -- CLINT<br>
 * 0C000000 -- PLIC<br>
 * 10000000 -- uart0<br>
 * 10001000 -- virtio硬盘<br>
 * 80000000 -- 启动ROM在机器码中跳转到这，-kernel把内核加载到这
 * 这之后是未使用的RAM。
 * 
 * 内核这样使用物理内存：<br>
 * 80000000 -- entry.S，然后是内核的text和data<br>
 * 末尾 -- 内核页分配起始区<br>
 * PHYSTOP -- 内核RAM的终止处
 */

/**
 * @name UART布局设置
 * @brief 内存中串行设备的地址和IRQ
 * @{
 */
#define UART0 0x10000000L ///< qemu把UART放在这
#define UART0_IRQ 10
/** @} */

/**
 * @name virtio布局设置
 * @brief virtio的mmio接口相关的设置
 * @{
 */
#define VIRTIO0 0x10001000 ///< virtio0的内存位置
#define VIRTIO0_IRQ 1
/** @} */

/**
 * @name CLINT布局设置
 * @brief CLINT有关的设置，与时钟中断控制有关
 * @{
 */
#define CLINT 0x2000000L ///< CLINT自身的位置
#define CLINT_MTIMECMP(hartid) (CLINT + 0x4000 + 8*(hartid))
#define CLINT_MTIME (CLINT + 0xBFF8) // mtime从启动时就会一直增长
/** @} */

/**
 * @name PLIC布局设置
 * @brief PLIC有关的设置，涉及其他外设中断
 * @{
 */
#define PLIC 0x0c000000L ///< qemu把PLIC放在物理地址的这个地方
#define PLIC_PRIORITY (PLIC + 0x0)
#define PLIC_PENDING (PLIC + 0x1000)
#define PLIC_MENABLE(hart) (PLIC + 0x2000 + (hart)*0x100)
#define PLIC_SENABLE(hart) (PLIC + 0x2080 + (hart)*0x100)
#define PLIC_MPRIORITY(hart) (PLIC + 0x200000 + (hart)*0x2000)
#define PLIC_SPRIORITY(hart) (PLIC + 0x201000 + (hart)*0x2000)
#define PLIC_MCLAIM(hart) (PLIC + 0x200004 + (hart)*0x2000)
#define PLIC_SCLAIM(hart) (PLIC + 0x201004 + (hart)*0x2000)
/** @} */

// 内核把这里当作用于内核与用户页的RAM
// 从物理地址0x80000000延伸到PHYSTOP
#define KERNBASE 0x80000000L
#define PHYSTOP (KERNBASE + 128*1024*1024)

// 在用户和内核空间上把trampoline页映射到最高地址
#define TRAMPOLINE (MAXVA - PGSIZE)

// 把内核栈映射到trampoline下方，
// 每个都由不可访问的（invalid）守护页（guard pages）包围。
#define KSTACK(p) (TRAMPOLINE - ((p)+1)* 2*PGSIZE)

// 用户内存布局。
// 从地址0开始：
//   text
//   original data and bss
//   固定大小栈
//   可扩展堆
//   ...
//   TRAPFRAME (p->trapframe, used by the trampoline)
//   TRAMPOLINE (the same page as in the kernel)
#define TRAPFRAME (TRAMPOLINE - PGSIZE)

