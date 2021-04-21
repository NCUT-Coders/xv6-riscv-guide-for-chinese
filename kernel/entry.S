	# qemu -kernel loads the kernel at 0x80000000
        # and causes each CPU to jump there.
        # kernel.ld causes the following code to
        # be placed at 0x80000000.
        
        # 0x80000000：作为内核起始地址，此处的物理地址将会映射到虚拟地址的0x0处
        # 之所以将内核放在0x80000000而不是0x0，是因为地址范围0x0-0x80000000包含I/O设备。
.section .text
_entry:
	# set up a stack for C.
        # stack0 is declared in start.c,
        # with a 4096-byte stack per CPU.
        # sp = stack0 + (hartid * 4096)

        # 声明一个栈提供给C代码，大小为4MB（即限制内核指令及代码上限)
        # 栈顶位置为 stack0 + 4MB （因为栈自上往下扩张）
        la sp, stack0
        li a0, 1024*4
	csrr a1, mhartid
        addi a1, a1, 1
        mul a0, a0, a1
        add sp, sp, a0
	# jump to start() in start.c
        # 唤起跳转至start.c中的start()处
        call start
spin:
        j spin
