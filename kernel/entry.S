	# qemu -kernel loads the kernel at 0x80000000
        # and causes each CPU to jump there.
        # kernel.ld causes the following code to
        # be placed at 0x80000000.
        
        # 0x80000000：作为内核起始地址，此处的物理地址将会映射到虚拟地址的0x0处
        # 之所以将内核放在0x80000000而不是0x0，是因为地址范围0x0-0x80000000包含I/O设备。
.section .text
.globl _entry
_entry:
    # set up a stack for C.
    # stack0 is declared in start.c,
    # with a 4096-byte stack per CPU.
    # sp = stack0 + (hartid * 4096)
    
    # 似乎rustSBI启动内核时将hart号存至a0寄存器内保存
    # 该部分即作为区分hart的依据
    # 当然，似乎直接用csrr也并不影响实现
    la sp, stack0
    li t1, 1024*4
	csrr t0, mhartid
    addi t0, a0, 1
    mul t0, t0, t1
    add sp, sp, t0
	# jump to start() in start.c
    call start
spin:
    j spin
