#include "kernel/types.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
    int p_0[2];     // forward
    int p_1[2];     // behind
    char ret_info;
    int p_ret[2];
    if (pipe(p_0)<0 || pipe(p_ret)<0)
    {
        printf("pipe error\n");
        exit(1);
    }
    // TODO: try sys_wait?

    #define SOINT sizeof(int)

    #define upper 35
    #define lower 2
    int i;
    for (i=lower; i<=upper; i++)
        write(p_0[1], &i, SOINT);
    
    int layer_Num = 0;
    
loop:   
    close(p_0[1]);
    int first_Num;
    if (read(p_0[0], &first_Num, SOINT)<SOINT)      // last layer
    {
        close(p_0[0]);
        write(p_ret[1], " ", 1);
        goto finish;
    }
    printf("prime %d\n", first_Num);

    if (pipe(p_1)<0)
    {
        printf("pipe error\n");
        exit(1);
    }
    int tmp;
    while (read(p_0[0], &tmp, SOINT)==SOINT)
        if (tmp%first_Num)
            write(p_1[1], &tmp, SOINT);
    close(p_0[0]);
   
    if (fork()==0)
    {
        close(p_1[0]);
        close(p_1[1]);
        goto finish;
    }
    else
    {
        p_0[0] = p_1[0];
        p_0[1] = p_1[1];
        layer_Num++;
        goto loop;
    }        

    // main progress exit after ret_info has been sent.
finish:
    if (layer_Num==0)
        read(p_ret[0], &ret_info, 1);
    
    close(p_ret[0]);
    close(p_ret[1]);
   
    exit(0);

}