struct utsname {
	char sysname[65];
	char nodename[65];
	char release[65];
	char version[65];
	char machine[65];
	char domainname[65];
};

struct timespec {
	uint64 	tv_sec;        /* 秒 */
	uint64 	tv_nsec;       /* 纳秒, 范围在0~999999999 */
};

uint64 nanosleep_lock;		// specific lock for nanosleep