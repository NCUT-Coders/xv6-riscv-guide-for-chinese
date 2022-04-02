#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

char current_path[512];
char find_name[512];

char*
fmtname(char *path)
{
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    ;
  p++;

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}

void
find(char *end)
{
  int fd;
  char *p;
  struct dirent de;
  struct stat st;

  if (fd=open(current_path, 0) < 0)
  {
    printf("find: invalid path for \'%s\'\n", current_path);
    return;
  }
  
  if (fstat(fd, &st) < 0)
  {
    printf("find: invalid stat for \'%s\'\n", current_path);
    close(fd);
    return;
  }

  // while (read(fd, de.name, sizeof(de)) == sizeof(de))
  // {
  //   if (de.inum == 0)
  //     continue;
    
  // }
  
  // switch(st.type)
  // {
  //   case T_FILE:
  //   {
  //     if (strlen(find_name)==0 || strcmp(find_name))
  //   }
  // }

}

int
main(int argc, char *argv[])
{
  if (argc < 3)
  {
      printf("usage:find path name...\n");
      exit(1);
  }

  strcpy(current_path, argv[1]);
  strcpy(find_name, argv[2]);
  char *p = current_path+strlen(current_path);
  find(p);

  exit(0);
}

