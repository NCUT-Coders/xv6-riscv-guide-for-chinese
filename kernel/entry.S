	# qemu -kernel loads the kernel at 0x80000000
        # and causes each CPU to jump there.
        # kernel.ld causes the following code to
        # be placed at 0x80000000.
        
        # 0x80000000：作为内核起始地址，此处的物理地址将会映射到虚拟地址的0x0处
        # 之所以将内核放在0x80000000而不是0x0，是因为地址范围0x0-0x80000000包含I/O设备。
    .section .text.entry
    .globl _start
_start:
    add t0, a0, 1
    slli t0, t0, 14
    // lui sp, %hi(boot_stack)
	la sp, boot_stack
    add sp, sp, t0

    // add by retrhelo, write tp reg 
    // csrr t1, mhartid 
    // mv tp, t1

    // lui t0, %hi(main)
    // addi t0, t0, %lo(main)
    // jr t0
    call main

loop:
    j loop

    .section .bss.stack
    .align 12
    .globl boot_stack
boot_stack:
    .space 4096 * 4 * 2
    .globl boot_stack_top
boot_stack_top:

