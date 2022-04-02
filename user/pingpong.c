#include "kernel/types.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
    char info;
    int p[2];
    if (pipe(p) < 0)
    {
        printf("pipe error\n");
        exit(1);
    }
    
    if (fork() == 0)
    {
        printf("%d: received ping\n", getpid());
        write(p[1], &info, 1);

        close(p[0]);
        close(p[1]);
    }
    else
    {
        close(p[1]);

        read(p[0], &info, 1);
        printf("%d: received pong\n", getpid());

        close(p[0]);
    }
    exit(0);
}
