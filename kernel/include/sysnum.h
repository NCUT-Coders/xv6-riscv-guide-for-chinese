#ifndef __SYSNUM_H
#define __SYSNUM_H

// System call numbers
#define SYS_fork            1
#define SYS_exit            2
#define SYS_wait            3
#define SYS_pipe            59
#define SYS_read            63
#define SYS_kill            6
#define SYS_exec            7
#define SYS_fstat           80
#define SYS_chdir           49
#define SYS_dup             23
#define SYS_getpid          172
#define SYS_sbrk            12
#define SYS_sleep           13
#define SYS_uptime          14
#define SYS_open            15
#define SYS_write           64
#define SYS_remove          117     // TODO: changed
#define SYS_trace           18
#define SYS_sysinfo         19
#define SYS_mkdir           20
#define SYS_close           57
#define SYS_test_proc       22
#define SYS_dev             81      // 太草了..差点冲突
#define SYS_readdir         24
#define SYS_getcwd          17
#define SYS_rename          26

// written by Gon laze
// some syscall for oscomp 
#define SYS_dup3            24      // WT
#define SYS_mkdirat         34
#define SYS_unlinkat        35
#define SYS_linkat          37
#define SYS_umount2         39
#define SYS_mount           40
#define SYS_openat          56      // WT
#define SYS_getdents64      61
#define SYS_exit_noret      93      // WT
#define SYS_nanosleep       101     // WT
#define SYS_sched_yield     124
#define SYS_times           153     // WT
#define SYS_uname           160     // WT
#define SYS_gettimeofday    169
#define SYS_getppid         173     // WT
#define SYS_brk             214     // WT
#define SYS_munmap          215
#define SYS_clone           220     // WT    // 可以试试fork？
#define SYS_execve          221         // 可以试试exec？
#define SYS_mmap            222
#define SYS_wait4           260






#endif