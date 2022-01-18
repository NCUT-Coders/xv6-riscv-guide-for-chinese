
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  16:	02e00a13          	li	s4,46
    if(matchhere(re, text))
  1a:	85a6                	mv	a1,s1
  1c:	854e                	mv	a0,s3
  1e:	00000097          	auipc	ra,0x0
  22:	030080e7          	jalr	48(ra) # 4e <matchhere>
  26:	e919                	bnez	a0,3c <matchstar+0x3c>
  }while(*text!='\0' && (*text++==c || c=='.'));
  28:	0004c783          	lbu	a5,0(s1)
  2c:	cb89                	beqz	a5,3e <matchstar+0x3e>
  2e:	0485                	addi	s1,s1,1
  30:	2781                	sext.w	a5,a5
  32:	ff2784e3          	beq	a5,s2,1a <matchstar+0x1a>
  36:	ff4902e3          	beq	s2,s4,1a <matchstar+0x1a>
  3a:	a011                	j	3e <matchstar+0x3e>
      return 1;
  3c:	4505                	li	a0,1
  return 0;
}
  3e:	70a2                	ld	ra,40(sp)
  40:	7402                	ld	s0,32(sp)
  42:	64e2                	ld	s1,24(sp)
  44:	6942                	ld	s2,16(sp)
  46:	69a2                	ld	s3,8(sp)
  48:	6a02                	ld	s4,0(sp)
  4a:	6145                	addi	sp,sp,48
  4c:	8082                	ret

000000000000004e <matchhere>:
  if(re[0] == '\0')
  4e:	00054703          	lbu	a4,0(a0)
  52:	cb3d                	beqz	a4,c8 <matchhere+0x7a>
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  5c:	87aa                	mv	a5,a0
  if(re[1] == '*')
  5e:	00154683          	lbu	a3,1(a0)
  62:	02a00613          	li	a2,42
  66:	02c68563          	beq	a3,a2,90 <matchhere+0x42>
  if(re[0] == '$' && re[1] == '\0')
  6a:	02400613          	li	a2,36
  6e:	02c70a63          	beq	a4,a2,a2 <matchhere+0x54>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  72:	0005c683          	lbu	a3,0(a1)
  return 0;
  76:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  78:	ca81                	beqz	a3,88 <matchhere+0x3a>
  7a:	02e00613          	li	a2,46
  7e:	02c70d63          	beq	a4,a2,b8 <matchhere+0x6a>
  return 0;
  82:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  84:	02d70a63          	beq	a4,a3,b8 <matchhere+0x6a>
}
  88:	60a2                	ld	ra,8(sp)
  8a:	6402                	ld	s0,0(sp)
  8c:	0141                	addi	sp,sp,16
  8e:	8082                	ret
    return matchstar(re[0], re+2, text);
  90:	862e                	mv	a2,a1
  92:	00250593          	addi	a1,a0,2
  96:	853a                	mv	a0,a4
  98:	00000097          	auipc	ra,0x0
  9c:	f68080e7          	jalr	-152(ra) # 0 <matchstar>
  a0:	b7e5                	j	88 <matchhere+0x3a>
  if(re[0] == '$' && re[1] == '\0')
  a2:	c691                	beqz	a3,ae <matchhere+0x60>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  a4:	0005c683          	lbu	a3,0(a1)
  a8:	fee9                	bnez	a3,82 <matchhere+0x34>
  return 0;
  aa:	4501                	li	a0,0
  ac:	bff1                	j	88 <matchhere+0x3a>
    return *text == '\0';
  ae:	0005c503          	lbu	a0,0(a1)
  b2:	00153513          	seqz	a0,a0
  b6:	bfc9                	j	88 <matchhere+0x3a>
    return matchhere(re+1, text+1);
  b8:	0585                	addi	a1,a1,1
  ba:	00178513          	addi	a0,a5,1
  be:	00000097          	auipc	ra,0x0
  c2:	f90080e7          	jalr	-112(ra) # 4e <matchhere>
  c6:	b7c9                	j	88 <matchhere+0x3a>
    return 1;
  c8:	4505                	li	a0,1
}
  ca:	8082                	ret

00000000000000cc <match>:
{
  cc:	1101                	addi	sp,sp,-32
  ce:	ec06                	sd	ra,24(sp)
  d0:	e822                	sd	s0,16(sp)
  d2:	e426                	sd	s1,8(sp)
  d4:	e04a                	sd	s2,0(sp)
  d6:	1000                	addi	s0,sp,32
  d8:	892a                	mv	s2,a0
  da:	84ae                	mv	s1,a1
  if(re[0] == '^')
  dc:	00054703          	lbu	a4,0(a0)
  e0:	05e00793          	li	a5,94
  e4:	00f70e63          	beq	a4,a5,100 <match+0x34>
    if(matchhere(re, text))
  e8:	85a6                	mv	a1,s1
  ea:	854a                	mv	a0,s2
  ec:	00000097          	auipc	ra,0x0
  f0:	f62080e7          	jalr	-158(ra) # 4e <matchhere>
  f4:	ed01                	bnez	a0,10c <match+0x40>
  }while(*text++ != '\0');
  f6:	0485                	addi	s1,s1,1
  f8:	fff4c783          	lbu	a5,-1(s1)
  fc:	f7f5                	bnez	a5,e8 <match+0x1c>
  fe:	a801                	j	10e <match+0x42>
    return matchhere(re+1, text);
 100:	0505                	addi	a0,a0,1
 102:	00000097          	auipc	ra,0x0
 106:	f4c080e7          	jalr	-180(ra) # 4e <matchhere>
 10a:	a011                	j	10e <match+0x42>
      return 1;
 10c:	4505                	li	a0,1
}
 10e:	60e2                	ld	ra,24(sp)
 110:	6442                	ld	s0,16(sp)
 112:	64a2                	ld	s1,8(sp)
 114:	6902                	ld	s2,0(sp)
 116:	6105                	addi	sp,sp,32
 118:	8082                	ret

000000000000011a <grep>:
{
 11a:	711d                	addi	sp,sp,-96
 11c:	ec86                	sd	ra,88(sp)
 11e:	e8a2                	sd	s0,80(sp)
 120:	e4a6                	sd	s1,72(sp)
 122:	e0ca                	sd	s2,64(sp)
 124:	fc4e                	sd	s3,56(sp)
 126:	f852                	sd	s4,48(sp)
 128:	f456                	sd	s5,40(sp)
 12a:	f05a                	sd	s6,32(sp)
 12c:	ec5e                	sd	s7,24(sp)
 12e:	e862                	sd	s8,16(sp)
 130:	e466                	sd	s9,8(sp)
 132:	1080                	addi	s0,sp,96
 134:	89aa                	mv	s3,a0
 136:	8b2e                	mv	s6,a1
  m = 0;
 138:	4a01                	li	s4,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 13a:	3ff00b93          	li	s7,1023
 13e:	00001a97          	auipc	s5,0x1
 142:	962a8a93          	addi	s5,s5,-1694 # aa0 <buf>
    p = buf;
 146:	8cd6                	mv	s9,s5
 148:	8c56                	mv	s8,s5
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 14a:	a0a1                	j	192 <grep+0x78>
        *q = '\n';
 14c:	47a9                	li	a5,10
 14e:	00f48023          	sb	a5,0(s1)
        write(1, p, q+1 - p);
 152:	00148613          	addi	a2,s1,1
 156:	4126063b          	subw	a2,a2,s2
 15a:	85ca                	mv	a1,s2
 15c:	4505                	li	a0,1
 15e:	00000097          	auipc	ra,0x0
 162:	3e2080e7          	jalr	994(ra) # 540 <write>
      p = q+1;
 166:	00148913          	addi	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 16a:	45a9                	li	a1,10
 16c:	854a                	mv	a0,s2
 16e:	00000097          	auipc	ra,0x0
 172:	1d4080e7          	jalr	468(ra) # 342 <strchr>
 176:	84aa                	mv	s1,a0
 178:	c919                	beqz	a0,18e <grep+0x74>
      *q = 0;
 17a:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 17e:	85ca                	mv	a1,s2
 180:	854e                	mv	a0,s3
 182:	00000097          	auipc	ra,0x0
 186:	f4a080e7          	jalr	-182(ra) # cc <match>
 18a:	dd71                	beqz	a0,166 <grep+0x4c>
 18c:	b7c1                	j	14c <grep+0x32>
    if(m > 0){
 18e:	03404563          	bgtz	s4,1b8 <grep+0x9e>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 192:	414b863b          	subw	a2,s7,s4
 196:	014a85b3          	add	a1,s5,s4
 19a:	855a                	mv	a0,s6
 19c:	00000097          	auipc	ra,0x0
 1a0:	39c080e7          	jalr	924(ra) # 538 <read>
 1a4:	02a05663          	blez	a0,1d0 <grep+0xb6>
    m += n;
 1a8:	00aa0a3b          	addw	s4,s4,a0
    buf[m] = '\0';
 1ac:	014a87b3          	add	a5,s5,s4
 1b0:	00078023          	sb	zero,0(a5)
    p = buf;
 1b4:	8962                	mv	s2,s8
    while((q = strchr(p, '\n')) != 0){
 1b6:	bf55                	j	16a <grep+0x50>
      m -= p - buf;
 1b8:	415907b3          	sub	a5,s2,s5
 1bc:	40fa0a3b          	subw	s4,s4,a5
      memmove(buf, p, m);
 1c0:	8652                	mv	a2,s4
 1c2:	85ca                	mv	a1,s2
 1c4:	8566                	mv	a0,s9
 1c6:	00000097          	auipc	ra,0x0
 1ca:	2a4080e7          	jalr	676(ra) # 46a <memmove>
 1ce:	b7d1                	j	192 <grep+0x78>
}
 1d0:	60e6                	ld	ra,88(sp)
 1d2:	6446                	ld	s0,80(sp)
 1d4:	64a6                	ld	s1,72(sp)
 1d6:	6906                	ld	s2,64(sp)
 1d8:	79e2                	ld	s3,56(sp)
 1da:	7a42                	ld	s4,48(sp)
 1dc:	7aa2                	ld	s5,40(sp)
 1de:	7b02                	ld	s6,32(sp)
 1e0:	6be2                	ld	s7,24(sp)
 1e2:	6c42                	ld	s8,16(sp)
 1e4:	6ca2                	ld	s9,8(sp)
 1e6:	6125                	addi	sp,sp,96
 1e8:	8082                	ret

00000000000001ea <main>:
{
 1ea:	7139                	addi	sp,sp,-64
 1ec:	fc06                	sd	ra,56(sp)
 1ee:	f822                	sd	s0,48(sp)
 1f0:	f426                	sd	s1,40(sp)
 1f2:	f04a                	sd	s2,32(sp)
 1f4:	ec4e                	sd	s3,24(sp)
 1f6:	e852                	sd	s4,16(sp)
 1f8:	e456                	sd	s5,8(sp)
 1fa:	0080                	addi	s0,sp,64
  if(argc <= 1){
 1fc:	4785                	li	a5,1
 1fe:	04a7de63          	bge	a5,a0,25a <main+0x70>
  pattern = argv[1];
 202:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 206:	4789                	li	a5,2
 208:	06a7d763          	bge	a5,a0,276 <main+0x8c>
 20c:	01058913          	addi	s2,a1,16
 210:	ffd5099b          	addiw	s3,a0,-3
 214:	1982                	slli	s3,s3,0x20
 216:	0209d993          	srli	s3,s3,0x20
 21a:	098e                	slli	s3,s3,0x3
 21c:	05e1                	addi	a1,a1,24
 21e:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], 0)) < 0){
 220:	4581                	li	a1,0
 222:	00093503          	ld	a0,0(s2)
 226:	00000097          	auipc	ra,0x0
 22a:	33a080e7          	jalr	826(ra) # 560 <open>
 22e:	84aa                	mv	s1,a0
 230:	04054e63          	bltz	a0,28c <main+0xa2>
    grep(pattern, fd);
 234:	85aa                	mv	a1,a0
 236:	8552                	mv	a0,s4
 238:	00000097          	auipc	ra,0x0
 23c:	ee2080e7          	jalr	-286(ra) # 11a <grep>
    close(fd);
 240:	8526                	mv	a0,s1
 242:	00000097          	auipc	ra,0x0
 246:	306080e7          	jalr	774(ra) # 548 <close>
  for(i = 2; i < argc; i++){
 24a:	0921                	addi	s2,s2,8
 24c:	fd391ae3          	bne	s2,s3,220 <main+0x36>
  exit(0);
 250:	4501                	li	a0,0
 252:	00000097          	auipc	ra,0x0
 256:	2ce080e7          	jalr	718(ra) # 520 <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 25a:	00000597          	auipc	a1,0x0
 25e:	7e658593          	addi	a1,a1,2022 # a40 <malloc+0xea>
 262:	4509                	li	a0,2
 264:	00000097          	auipc	ra,0x0
 268:	606080e7          	jalr	1542(ra) # 86a <fprintf>
    exit(1);
 26c:	4505                	li	a0,1
 26e:	00000097          	auipc	ra,0x0
 272:	2b2080e7          	jalr	690(ra) # 520 <exit>
    grep(pattern, 0);
 276:	4581                	li	a1,0
 278:	8552                	mv	a0,s4
 27a:	00000097          	auipc	ra,0x0
 27e:	ea0080e7          	jalr	-352(ra) # 11a <grep>
    exit(0);
 282:	4501                	li	a0,0
 284:	00000097          	auipc	ra,0x0
 288:	29c080e7          	jalr	668(ra) # 520 <exit>
      printf("grep: cannot open %s\n", argv[i]);
 28c:	00093583          	ld	a1,0(s2)
 290:	00000517          	auipc	a0,0x0
 294:	7d050513          	addi	a0,a0,2000 # a60 <malloc+0x10a>
 298:	00000097          	auipc	ra,0x0
 29c:	600080e7          	jalr	1536(ra) # 898 <printf>
      exit(1);
 2a0:	4505                	li	a0,1
 2a2:	00000097          	auipc	ra,0x0
 2a6:	27e080e7          	jalr	638(ra) # 520 <exit>

00000000000002aa <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 2aa:	1141                	addi	sp,sp,-16
 2ac:	e422                	sd	s0,8(sp)
 2ae:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2b0:	87aa                	mv	a5,a0
 2b2:	0585                	addi	a1,a1,1
 2b4:	0785                	addi	a5,a5,1
 2b6:	fff5c703          	lbu	a4,-1(a1)
 2ba:	fee78fa3          	sb	a4,-1(a5)
 2be:	fb75                	bnez	a4,2b2 <strcpy+0x8>
    ;
  return os;
}
 2c0:	6422                	ld	s0,8(sp)
 2c2:	0141                	addi	sp,sp,16
 2c4:	8082                	ret

00000000000002c6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2c6:	1141                	addi	sp,sp,-16
 2c8:	e422                	sd	s0,8(sp)
 2ca:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2cc:	00054783          	lbu	a5,0(a0)
 2d0:	cb91                	beqz	a5,2e4 <strcmp+0x1e>
 2d2:	0005c703          	lbu	a4,0(a1)
 2d6:	00f71763          	bne	a4,a5,2e4 <strcmp+0x1e>
    p++, q++;
 2da:	0505                	addi	a0,a0,1
 2dc:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2de:	00054783          	lbu	a5,0(a0)
 2e2:	fbe5                	bnez	a5,2d2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2e4:	0005c503          	lbu	a0,0(a1)
}
 2e8:	40a7853b          	subw	a0,a5,a0
 2ec:	6422                	ld	s0,8(sp)
 2ee:	0141                	addi	sp,sp,16
 2f0:	8082                	ret

00000000000002f2 <strlen>:

uint
strlen(const char *s)
{
 2f2:	1141                	addi	sp,sp,-16
 2f4:	e422                	sd	s0,8(sp)
 2f6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2f8:	00054783          	lbu	a5,0(a0)
 2fc:	cf91                	beqz	a5,318 <strlen+0x26>
 2fe:	0505                	addi	a0,a0,1
 300:	87aa                	mv	a5,a0
 302:	4685                	li	a3,1
 304:	9e89                	subw	a3,a3,a0
 306:	00f6853b          	addw	a0,a3,a5
 30a:	0785                	addi	a5,a5,1
 30c:	fff7c703          	lbu	a4,-1(a5)
 310:	fb7d                	bnez	a4,306 <strlen+0x14>
    ;
  return n;
}
 312:	6422                	ld	s0,8(sp)
 314:	0141                	addi	sp,sp,16
 316:	8082                	ret
  for(n = 0; s[n]; n++)
 318:	4501                	li	a0,0
 31a:	bfe5                	j	312 <strlen+0x20>

000000000000031c <memset>:

void*
memset(void *dst, int c, uint n)
{
 31c:	1141                	addi	sp,sp,-16
 31e:	e422                	sd	s0,8(sp)
 320:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 322:	ce09                	beqz	a2,33c <memset+0x20>
 324:	87aa                	mv	a5,a0
 326:	fff6071b          	addiw	a4,a2,-1
 32a:	1702                	slli	a4,a4,0x20
 32c:	9301                	srli	a4,a4,0x20
 32e:	0705                	addi	a4,a4,1
 330:	972a                	add	a4,a4,a0
    cdst[i] = c;
 332:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 336:	0785                	addi	a5,a5,1
 338:	fee79de3          	bne	a5,a4,332 <memset+0x16>
  }
  return dst;
}
 33c:	6422                	ld	s0,8(sp)
 33e:	0141                	addi	sp,sp,16
 340:	8082                	ret

0000000000000342 <strchr>:

char*
strchr(const char *s, char c)
{
 342:	1141                	addi	sp,sp,-16
 344:	e422                	sd	s0,8(sp)
 346:	0800                	addi	s0,sp,16
  for(; *s; s++)
 348:	00054783          	lbu	a5,0(a0)
 34c:	cb99                	beqz	a5,362 <strchr+0x20>
    if(*s == c)
 34e:	00f58763          	beq	a1,a5,35c <strchr+0x1a>
  for(; *s; s++)
 352:	0505                	addi	a0,a0,1
 354:	00054783          	lbu	a5,0(a0)
 358:	fbfd                	bnez	a5,34e <strchr+0xc>
      return (char*)s;
  return 0;
 35a:	4501                	li	a0,0
}
 35c:	6422                	ld	s0,8(sp)
 35e:	0141                	addi	sp,sp,16
 360:	8082                	ret
  return 0;
 362:	4501                	li	a0,0
 364:	bfe5                	j	35c <strchr+0x1a>

0000000000000366 <gets>:

char*
gets(char *buf, int max)
{
 366:	711d                	addi	sp,sp,-96
 368:	ec86                	sd	ra,88(sp)
 36a:	e8a2                	sd	s0,80(sp)
 36c:	e4a6                	sd	s1,72(sp)
 36e:	e0ca                	sd	s2,64(sp)
 370:	fc4e                	sd	s3,56(sp)
 372:	f852                	sd	s4,48(sp)
 374:	f456                	sd	s5,40(sp)
 376:	f05a                	sd	s6,32(sp)
 378:	ec5e                	sd	s7,24(sp)
 37a:	1080                	addi	s0,sp,96
 37c:	8baa                	mv	s7,a0
 37e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 380:	892a                	mv	s2,a0
 382:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 384:	4aa9                	li	s5,10
 386:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 388:	89a6                	mv	s3,s1
 38a:	2485                	addiw	s1,s1,1
 38c:	0344d863          	bge	s1,s4,3bc <gets+0x56>
    cc = read(0, &c, 1);
 390:	4605                	li	a2,1
 392:	faf40593          	addi	a1,s0,-81
 396:	4501                	li	a0,0
 398:	00000097          	auipc	ra,0x0
 39c:	1a0080e7          	jalr	416(ra) # 538 <read>
    if(cc < 1)
 3a0:	00a05e63          	blez	a0,3bc <gets+0x56>
    buf[i++] = c;
 3a4:	faf44783          	lbu	a5,-81(s0)
 3a8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3ac:	01578763          	beq	a5,s5,3ba <gets+0x54>
 3b0:	0905                	addi	s2,s2,1
 3b2:	fd679be3          	bne	a5,s6,388 <gets+0x22>
  for(i=0; i+1 < max; ){
 3b6:	89a6                	mv	s3,s1
 3b8:	a011                	j	3bc <gets+0x56>
 3ba:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3bc:	99de                	add	s3,s3,s7
 3be:	00098023          	sb	zero,0(s3)
  return buf;
}
 3c2:	855e                	mv	a0,s7
 3c4:	60e6                	ld	ra,88(sp)
 3c6:	6446                	ld	s0,80(sp)
 3c8:	64a6                	ld	s1,72(sp)
 3ca:	6906                	ld	s2,64(sp)
 3cc:	79e2                	ld	s3,56(sp)
 3ce:	7a42                	ld	s4,48(sp)
 3d0:	7aa2                	ld	s5,40(sp)
 3d2:	7b02                	ld	s6,32(sp)
 3d4:	6be2                	ld	s7,24(sp)
 3d6:	6125                	addi	sp,sp,96
 3d8:	8082                	ret

00000000000003da <stat>:

int
stat(const char *n, struct stat *st)
{
 3da:	1101                	addi	sp,sp,-32
 3dc:	ec06                	sd	ra,24(sp)
 3de:	e822                	sd	s0,16(sp)
 3e0:	e426                	sd	s1,8(sp)
 3e2:	e04a                	sd	s2,0(sp)
 3e4:	1000                	addi	s0,sp,32
 3e6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3e8:	4581                	li	a1,0
 3ea:	00000097          	auipc	ra,0x0
 3ee:	176080e7          	jalr	374(ra) # 560 <open>
  if(fd < 0)
 3f2:	02054563          	bltz	a0,41c <stat+0x42>
 3f6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3f8:	85ca                	mv	a1,s2
 3fa:	00000097          	auipc	ra,0x0
 3fe:	17e080e7          	jalr	382(ra) # 578 <fstat>
 402:	892a                	mv	s2,a0
  close(fd);
 404:	8526                	mv	a0,s1
 406:	00000097          	auipc	ra,0x0
 40a:	142080e7          	jalr	322(ra) # 548 <close>
  return r;
}
 40e:	854a                	mv	a0,s2
 410:	60e2                	ld	ra,24(sp)
 412:	6442                	ld	s0,16(sp)
 414:	64a2                	ld	s1,8(sp)
 416:	6902                	ld	s2,0(sp)
 418:	6105                	addi	sp,sp,32
 41a:	8082                	ret
    return -1;
 41c:	597d                	li	s2,-1
 41e:	bfc5                	j	40e <stat+0x34>

0000000000000420 <atoi>:

int
atoi(const char *s)
{
 420:	1141                	addi	sp,sp,-16
 422:	e422                	sd	s0,8(sp)
 424:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 426:	00054603          	lbu	a2,0(a0)
 42a:	fd06079b          	addiw	a5,a2,-48
 42e:	0ff7f793          	andi	a5,a5,255
 432:	4725                	li	a4,9
 434:	02f76963          	bltu	a4,a5,466 <atoi+0x46>
 438:	86aa                	mv	a3,a0
  n = 0;
 43a:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 43c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 43e:	0685                	addi	a3,a3,1
 440:	0025179b          	slliw	a5,a0,0x2
 444:	9fa9                	addw	a5,a5,a0
 446:	0017979b          	slliw	a5,a5,0x1
 44a:	9fb1                	addw	a5,a5,a2
 44c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 450:	0006c603          	lbu	a2,0(a3)
 454:	fd06071b          	addiw	a4,a2,-48
 458:	0ff77713          	andi	a4,a4,255
 45c:	fee5f1e3          	bgeu	a1,a4,43e <atoi+0x1e>
  return n;
}
 460:	6422                	ld	s0,8(sp)
 462:	0141                	addi	sp,sp,16
 464:	8082                	ret
  n = 0;
 466:	4501                	li	a0,0
 468:	bfe5                	j	460 <atoi+0x40>

000000000000046a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 46a:	1141                	addi	sp,sp,-16
 46c:	e422                	sd	s0,8(sp)
 46e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 470:	02b57663          	bgeu	a0,a1,49c <memmove+0x32>
    while(n-- > 0)
 474:	02c05163          	blez	a2,496 <memmove+0x2c>
 478:	fff6079b          	addiw	a5,a2,-1
 47c:	1782                	slli	a5,a5,0x20
 47e:	9381                	srli	a5,a5,0x20
 480:	0785                	addi	a5,a5,1
 482:	97aa                	add	a5,a5,a0
  dst = vdst;
 484:	872a                	mv	a4,a0
      *dst++ = *src++;
 486:	0585                	addi	a1,a1,1
 488:	0705                	addi	a4,a4,1
 48a:	fff5c683          	lbu	a3,-1(a1)
 48e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 492:	fee79ae3          	bne	a5,a4,486 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 496:	6422                	ld	s0,8(sp)
 498:	0141                	addi	sp,sp,16
 49a:	8082                	ret
    dst += n;
 49c:	00c50733          	add	a4,a0,a2
    src += n;
 4a0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4a2:	fec05ae3          	blez	a2,496 <memmove+0x2c>
 4a6:	fff6079b          	addiw	a5,a2,-1
 4aa:	1782                	slli	a5,a5,0x20
 4ac:	9381                	srli	a5,a5,0x20
 4ae:	fff7c793          	not	a5,a5
 4b2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4b4:	15fd                	addi	a1,a1,-1
 4b6:	177d                	addi	a4,a4,-1
 4b8:	0005c683          	lbu	a3,0(a1)
 4bc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4c0:	fee79ae3          	bne	a5,a4,4b4 <memmove+0x4a>
 4c4:	bfc9                	j	496 <memmove+0x2c>

00000000000004c6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4c6:	1141                	addi	sp,sp,-16
 4c8:	e422                	sd	s0,8(sp)
 4ca:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4cc:	ca05                	beqz	a2,4fc <memcmp+0x36>
 4ce:	fff6069b          	addiw	a3,a2,-1
 4d2:	1682                	slli	a3,a3,0x20
 4d4:	9281                	srli	a3,a3,0x20
 4d6:	0685                	addi	a3,a3,1
 4d8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4da:	00054783          	lbu	a5,0(a0)
 4de:	0005c703          	lbu	a4,0(a1)
 4e2:	00e79863          	bne	a5,a4,4f2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4e6:	0505                	addi	a0,a0,1
    p2++;
 4e8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4ea:	fed518e3          	bne	a0,a3,4da <memcmp+0x14>
  }
  return 0;
 4ee:	4501                	li	a0,0
 4f0:	a019                	j	4f6 <memcmp+0x30>
      return *p1 - *p2;
 4f2:	40e7853b          	subw	a0,a5,a4
}
 4f6:	6422                	ld	s0,8(sp)
 4f8:	0141                	addi	sp,sp,16
 4fa:	8082                	ret
  return 0;
 4fc:	4501                	li	a0,0
 4fe:	bfe5                	j	4f6 <memcmp+0x30>

0000000000000500 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 500:	1141                	addi	sp,sp,-16
 502:	e406                	sd	ra,8(sp)
 504:	e022                	sd	s0,0(sp)
 506:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 508:	00000097          	auipc	ra,0x0
 50c:	f62080e7          	jalr	-158(ra) # 46a <memmove>
}
 510:	60a2                	ld	ra,8(sp)
 512:	6402                	ld	s0,0(sp)
 514:	0141                	addi	sp,sp,16
 516:	8082                	ret

0000000000000518 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 518:	4885                	li	a7,1
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <exit>:
.global exit
exit:
 li a7, SYS_exit
 520:	4889                	li	a7,2
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <wait>:
.global wait
wait:
 li a7, SYS_wait
 528:	488d                	li	a7,3
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 530:	4891                	li	a7,4
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <read>:
.global read
read:
 li a7, SYS_read
 538:	4895                	li	a7,5
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <write>:
.global write
write:
 li a7, SYS_write
 540:	48c1                	li	a7,16
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <close>:
.global close
close:
 li a7, SYS_close
 548:	48d5                	li	a7,21
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <kill>:
.global kill
kill:
 li a7, SYS_kill
 550:	4899                	li	a7,6
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <exec>:
.global exec
exec:
 li a7, SYS_exec
 558:	489d                	li	a7,7
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <open>:
.global open
open:
 li a7, SYS_open
 560:	48bd                	li	a7,15
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 568:	48c5                	li	a7,17
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 570:	48c9                	li	a7,18
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 578:	48a1                	li	a7,8
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <link>:
.global link
link:
 li a7, SYS_link
 580:	48cd                	li	a7,19
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 588:	48d1                	li	a7,20
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 590:	48a5                	li	a7,9
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <dup>:
.global dup
dup:
 li a7, SYS_dup
 598:	48a9                	li	a7,10
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5a0:	48ad                	li	a7,11
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5a8:	48b1                	li	a7,12
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5b0:	48b5                	li	a7,13
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5b8:	48b9                	li	a7,14
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5c0:	1101                	addi	sp,sp,-32
 5c2:	ec06                	sd	ra,24(sp)
 5c4:	e822                	sd	s0,16(sp)
 5c6:	1000                	addi	s0,sp,32
 5c8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5cc:	4605                	li	a2,1
 5ce:	fef40593          	addi	a1,s0,-17
 5d2:	00000097          	auipc	ra,0x0
 5d6:	f6e080e7          	jalr	-146(ra) # 540 <write>
}
 5da:	60e2                	ld	ra,24(sp)
 5dc:	6442                	ld	s0,16(sp)
 5de:	6105                	addi	sp,sp,32
 5e0:	8082                	ret

00000000000005e2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5e2:	7139                	addi	sp,sp,-64
 5e4:	fc06                	sd	ra,56(sp)
 5e6:	f822                	sd	s0,48(sp)
 5e8:	f426                	sd	s1,40(sp)
 5ea:	f04a                	sd	s2,32(sp)
 5ec:	ec4e                	sd	s3,24(sp)
 5ee:	0080                	addi	s0,sp,64
 5f0:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5f2:	c299                	beqz	a3,5f8 <printint+0x16>
 5f4:	0805c863          	bltz	a1,684 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5f8:	2581                	sext.w	a1,a1
  neg = 0;
 5fa:	4881                	li	a7,0
 5fc:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 600:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 602:	2601                	sext.w	a2,a2
 604:	00000517          	auipc	a0,0x0
 608:	47c50513          	addi	a0,a0,1148 # a80 <digits>
 60c:	883a                	mv	a6,a4
 60e:	2705                	addiw	a4,a4,1
 610:	02c5f7bb          	remuw	a5,a1,a2
 614:	1782                	slli	a5,a5,0x20
 616:	9381                	srli	a5,a5,0x20
 618:	97aa                	add	a5,a5,a0
 61a:	0007c783          	lbu	a5,0(a5)
 61e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 622:	0005879b          	sext.w	a5,a1
 626:	02c5d5bb          	divuw	a1,a1,a2
 62a:	0685                	addi	a3,a3,1
 62c:	fec7f0e3          	bgeu	a5,a2,60c <printint+0x2a>
  if(neg)
 630:	00088b63          	beqz	a7,646 <printint+0x64>
    buf[i++] = '-';
 634:	fd040793          	addi	a5,s0,-48
 638:	973e                	add	a4,a4,a5
 63a:	02d00793          	li	a5,45
 63e:	fef70823          	sb	a5,-16(a4)
 642:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 646:	02e05863          	blez	a4,676 <printint+0x94>
 64a:	fc040793          	addi	a5,s0,-64
 64e:	00e78933          	add	s2,a5,a4
 652:	fff78993          	addi	s3,a5,-1
 656:	99ba                	add	s3,s3,a4
 658:	377d                	addiw	a4,a4,-1
 65a:	1702                	slli	a4,a4,0x20
 65c:	9301                	srli	a4,a4,0x20
 65e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 662:	fff94583          	lbu	a1,-1(s2)
 666:	8526                	mv	a0,s1
 668:	00000097          	auipc	ra,0x0
 66c:	f58080e7          	jalr	-168(ra) # 5c0 <putc>
  while(--i >= 0)
 670:	197d                	addi	s2,s2,-1
 672:	ff3918e3          	bne	s2,s3,662 <printint+0x80>
}
 676:	70e2                	ld	ra,56(sp)
 678:	7442                	ld	s0,48(sp)
 67a:	74a2                	ld	s1,40(sp)
 67c:	7902                	ld	s2,32(sp)
 67e:	69e2                	ld	s3,24(sp)
 680:	6121                	addi	sp,sp,64
 682:	8082                	ret
    x = -xx;
 684:	40b005bb          	negw	a1,a1
    neg = 1;
 688:	4885                	li	a7,1
    x = -xx;
 68a:	bf8d                	j	5fc <printint+0x1a>

000000000000068c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 68c:	7119                	addi	sp,sp,-128
 68e:	fc86                	sd	ra,120(sp)
 690:	f8a2                	sd	s0,112(sp)
 692:	f4a6                	sd	s1,104(sp)
 694:	f0ca                	sd	s2,96(sp)
 696:	ecce                	sd	s3,88(sp)
 698:	e8d2                	sd	s4,80(sp)
 69a:	e4d6                	sd	s5,72(sp)
 69c:	e0da                	sd	s6,64(sp)
 69e:	fc5e                	sd	s7,56(sp)
 6a0:	f862                	sd	s8,48(sp)
 6a2:	f466                	sd	s9,40(sp)
 6a4:	f06a                	sd	s10,32(sp)
 6a6:	ec6e                	sd	s11,24(sp)
 6a8:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6aa:	0005c903          	lbu	s2,0(a1)
 6ae:	18090f63          	beqz	s2,84c <vprintf+0x1c0>
 6b2:	8aaa                	mv	s5,a0
 6b4:	8b32                	mv	s6,a2
 6b6:	00158493          	addi	s1,a1,1
  state = 0;
 6ba:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6bc:	02500a13          	li	s4,37
      if(c == 'd'){
 6c0:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 6c4:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 6c8:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 6cc:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6d0:	00000b97          	auipc	s7,0x0
 6d4:	3b0b8b93          	addi	s7,s7,944 # a80 <digits>
 6d8:	a839                	j	6f6 <vprintf+0x6a>
        putc(fd, c);
 6da:	85ca                	mv	a1,s2
 6dc:	8556                	mv	a0,s5
 6de:	00000097          	auipc	ra,0x0
 6e2:	ee2080e7          	jalr	-286(ra) # 5c0 <putc>
 6e6:	a019                	j	6ec <vprintf+0x60>
    } else if(state == '%'){
 6e8:	01498f63          	beq	s3,s4,706 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 6ec:	0485                	addi	s1,s1,1
 6ee:	fff4c903          	lbu	s2,-1(s1)
 6f2:	14090d63          	beqz	s2,84c <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 6f6:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6fa:	fe0997e3          	bnez	s3,6e8 <vprintf+0x5c>
      if(c == '%'){
 6fe:	fd479ee3          	bne	a5,s4,6da <vprintf+0x4e>
        state = '%';
 702:	89be                	mv	s3,a5
 704:	b7e5                	j	6ec <vprintf+0x60>
      if(c == 'd'){
 706:	05878063          	beq	a5,s8,746 <vprintf+0xba>
      } else if(c == 'l') {
 70a:	05978c63          	beq	a5,s9,762 <vprintf+0xd6>
      } else if(c == 'x') {
 70e:	07a78863          	beq	a5,s10,77e <vprintf+0xf2>
      } else if(c == 'p') {
 712:	09b78463          	beq	a5,s11,79a <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 716:	07300713          	li	a4,115
 71a:	0ce78663          	beq	a5,a4,7e6 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 71e:	06300713          	li	a4,99
 722:	0ee78e63          	beq	a5,a4,81e <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 726:	11478863          	beq	a5,s4,836 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 72a:	85d2                	mv	a1,s4
 72c:	8556                	mv	a0,s5
 72e:	00000097          	auipc	ra,0x0
 732:	e92080e7          	jalr	-366(ra) # 5c0 <putc>
        putc(fd, c);
 736:	85ca                	mv	a1,s2
 738:	8556                	mv	a0,s5
 73a:	00000097          	auipc	ra,0x0
 73e:	e86080e7          	jalr	-378(ra) # 5c0 <putc>
      }
      state = 0;
 742:	4981                	li	s3,0
 744:	b765                	j	6ec <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 746:	008b0913          	addi	s2,s6,8
 74a:	4685                	li	a3,1
 74c:	4629                	li	a2,10
 74e:	000b2583          	lw	a1,0(s6)
 752:	8556                	mv	a0,s5
 754:	00000097          	auipc	ra,0x0
 758:	e8e080e7          	jalr	-370(ra) # 5e2 <printint>
 75c:	8b4a                	mv	s6,s2
      state = 0;
 75e:	4981                	li	s3,0
 760:	b771                	j	6ec <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 762:	008b0913          	addi	s2,s6,8
 766:	4681                	li	a3,0
 768:	4629                	li	a2,10
 76a:	000b2583          	lw	a1,0(s6)
 76e:	8556                	mv	a0,s5
 770:	00000097          	auipc	ra,0x0
 774:	e72080e7          	jalr	-398(ra) # 5e2 <printint>
 778:	8b4a                	mv	s6,s2
      state = 0;
 77a:	4981                	li	s3,0
 77c:	bf85                	j	6ec <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 77e:	008b0913          	addi	s2,s6,8
 782:	4681                	li	a3,0
 784:	4641                	li	a2,16
 786:	000b2583          	lw	a1,0(s6)
 78a:	8556                	mv	a0,s5
 78c:	00000097          	auipc	ra,0x0
 790:	e56080e7          	jalr	-426(ra) # 5e2 <printint>
 794:	8b4a                	mv	s6,s2
      state = 0;
 796:	4981                	li	s3,0
 798:	bf91                	j	6ec <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 79a:	008b0793          	addi	a5,s6,8
 79e:	f8f43423          	sd	a5,-120(s0)
 7a2:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7a6:	03000593          	li	a1,48
 7aa:	8556                	mv	a0,s5
 7ac:	00000097          	auipc	ra,0x0
 7b0:	e14080e7          	jalr	-492(ra) # 5c0 <putc>
  putc(fd, 'x');
 7b4:	85ea                	mv	a1,s10
 7b6:	8556                	mv	a0,s5
 7b8:	00000097          	auipc	ra,0x0
 7bc:	e08080e7          	jalr	-504(ra) # 5c0 <putc>
 7c0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7c2:	03c9d793          	srli	a5,s3,0x3c
 7c6:	97de                	add	a5,a5,s7
 7c8:	0007c583          	lbu	a1,0(a5)
 7cc:	8556                	mv	a0,s5
 7ce:	00000097          	auipc	ra,0x0
 7d2:	df2080e7          	jalr	-526(ra) # 5c0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7d6:	0992                	slli	s3,s3,0x4
 7d8:	397d                	addiw	s2,s2,-1
 7da:	fe0914e3          	bnez	s2,7c2 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 7de:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7e2:	4981                	li	s3,0
 7e4:	b721                	j	6ec <vprintf+0x60>
        s = va_arg(ap, char*);
 7e6:	008b0993          	addi	s3,s6,8
 7ea:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 7ee:	02090163          	beqz	s2,810 <vprintf+0x184>
        while(*s != 0){
 7f2:	00094583          	lbu	a1,0(s2)
 7f6:	c9a1                	beqz	a1,846 <vprintf+0x1ba>
          putc(fd, *s);
 7f8:	8556                	mv	a0,s5
 7fa:	00000097          	auipc	ra,0x0
 7fe:	dc6080e7          	jalr	-570(ra) # 5c0 <putc>
          s++;
 802:	0905                	addi	s2,s2,1
        while(*s != 0){
 804:	00094583          	lbu	a1,0(s2)
 808:	f9e5                	bnez	a1,7f8 <vprintf+0x16c>
        s = va_arg(ap, char*);
 80a:	8b4e                	mv	s6,s3
      state = 0;
 80c:	4981                	li	s3,0
 80e:	bdf9                	j	6ec <vprintf+0x60>
          s = "(null)";
 810:	00000917          	auipc	s2,0x0
 814:	26890913          	addi	s2,s2,616 # a78 <malloc+0x122>
        while(*s != 0){
 818:	02800593          	li	a1,40
 81c:	bff1                	j	7f8 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 81e:	008b0913          	addi	s2,s6,8
 822:	000b4583          	lbu	a1,0(s6)
 826:	8556                	mv	a0,s5
 828:	00000097          	auipc	ra,0x0
 82c:	d98080e7          	jalr	-616(ra) # 5c0 <putc>
 830:	8b4a                	mv	s6,s2
      state = 0;
 832:	4981                	li	s3,0
 834:	bd65                	j	6ec <vprintf+0x60>
        putc(fd, c);
 836:	85d2                	mv	a1,s4
 838:	8556                	mv	a0,s5
 83a:	00000097          	auipc	ra,0x0
 83e:	d86080e7          	jalr	-634(ra) # 5c0 <putc>
      state = 0;
 842:	4981                	li	s3,0
 844:	b565                	j	6ec <vprintf+0x60>
        s = va_arg(ap, char*);
 846:	8b4e                	mv	s6,s3
      state = 0;
 848:	4981                	li	s3,0
 84a:	b54d                	j	6ec <vprintf+0x60>
    }
  }
}
 84c:	70e6                	ld	ra,120(sp)
 84e:	7446                	ld	s0,112(sp)
 850:	74a6                	ld	s1,104(sp)
 852:	7906                	ld	s2,96(sp)
 854:	69e6                	ld	s3,88(sp)
 856:	6a46                	ld	s4,80(sp)
 858:	6aa6                	ld	s5,72(sp)
 85a:	6b06                	ld	s6,64(sp)
 85c:	7be2                	ld	s7,56(sp)
 85e:	7c42                	ld	s8,48(sp)
 860:	7ca2                	ld	s9,40(sp)
 862:	7d02                	ld	s10,32(sp)
 864:	6de2                	ld	s11,24(sp)
 866:	6109                	addi	sp,sp,128
 868:	8082                	ret

000000000000086a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 86a:	715d                	addi	sp,sp,-80
 86c:	ec06                	sd	ra,24(sp)
 86e:	e822                	sd	s0,16(sp)
 870:	1000                	addi	s0,sp,32
 872:	e010                	sd	a2,0(s0)
 874:	e414                	sd	a3,8(s0)
 876:	e818                	sd	a4,16(s0)
 878:	ec1c                	sd	a5,24(s0)
 87a:	03043023          	sd	a6,32(s0)
 87e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 882:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 886:	8622                	mv	a2,s0
 888:	00000097          	auipc	ra,0x0
 88c:	e04080e7          	jalr	-508(ra) # 68c <vprintf>
}
 890:	60e2                	ld	ra,24(sp)
 892:	6442                	ld	s0,16(sp)
 894:	6161                	addi	sp,sp,80
 896:	8082                	ret

0000000000000898 <printf>:

void
printf(const char *fmt, ...)
{
 898:	711d                	addi	sp,sp,-96
 89a:	ec06                	sd	ra,24(sp)
 89c:	e822                	sd	s0,16(sp)
 89e:	1000                	addi	s0,sp,32
 8a0:	e40c                	sd	a1,8(s0)
 8a2:	e810                	sd	a2,16(s0)
 8a4:	ec14                	sd	a3,24(s0)
 8a6:	f018                	sd	a4,32(s0)
 8a8:	f41c                	sd	a5,40(s0)
 8aa:	03043823          	sd	a6,48(s0)
 8ae:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8b2:	00840613          	addi	a2,s0,8
 8b6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8ba:	85aa                	mv	a1,a0
 8bc:	4505                	li	a0,1
 8be:	00000097          	auipc	ra,0x0
 8c2:	dce080e7          	jalr	-562(ra) # 68c <vprintf>
}
 8c6:	60e2                	ld	ra,24(sp)
 8c8:	6442                	ld	s0,16(sp)
 8ca:	6125                	addi	sp,sp,96
 8cc:	8082                	ret

00000000000008ce <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8ce:	1141                	addi	sp,sp,-16
 8d0:	e422                	sd	s0,8(sp)
 8d2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8d4:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d8:	00000797          	auipc	a5,0x0
 8dc:	1c07b783          	ld	a5,448(a5) # a98 <freep>
 8e0:	a805                	j	910 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8e2:	4618                	lw	a4,8(a2)
 8e4:	9db9                	addw	a1,a1,a4
 8e6:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8ea:	6398                	ld	a4,0(a5)
 8ec:	6318                	ld	a4,0(a4)
 8ee:	fee53823          	sd	a4,-16(a0)
 8f2:	a091                	j	936 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8f4:	ff852703          	lw	a4,-8(a0)
 8f8:	9e39                	addw	a2,a2,a4
 8fa:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8fc:	ff053703          	ld	a4,-16(a0)
 900:	e398                	sd	a4,0(a5)
 902:	a099                	j	948 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 904:	6398                	ld	a4,0(a5)
 906:	00e7e463          	bltu	a5,a4,90e <free+0x40>
 90a:	00e6ea63          	bltu	a3,a4,91e <free+0x50>
{
 90e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 910:	fed7fae3          	bgeu	a5,a3,904 <free+0x36>
 914:	6398                	ld	a4,0(a5)
 916:	00e6e463          	bltu	a3,a4,91e <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 91a:	fee7eae3          	bltu	a5,a4,90e <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 91e:	ff852583          	lw	a1,-8(a0)
 922:	6390                	ld	a2,0(a5)
 924:	02059713          	slli	a4,a1,0x20
 928:	9301                	srli	a4,a4,0x20
 92a:	0712                	slli	a4,a4,0x4
 92c:	9736                	add	a4,a4,a3
 92e:	fae60ae3          	beq	a2,a4,8e2 <free+0x14>
    bp->s.ptr = p->s.ptr;
 932:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 936:	4790                	lw	a2,8(a5)
 938:	02061713          	slli	a4,a2,0x20
 93c:	9301                	srli	a4,a4,0x20
 93e:	0712                	slli	a4,a4,0x4
 940:	973e                	add	a4,a4,a5
 942:	fae689e3          	beq	a3,a4,8f4 <free+0x26>
  } else
    p->s.ptr = bp;
 946:	e394                	sd	a3,0(a5)
  freep = p;
 948:	00000717          	auipc	a4,0x0
 94c:	14f73823          	sd	a5,336(a4) # a98 <freep>
}
 950:	6422                	ld	s0,8(sp)
 952:	0141                	addi	sp,sp,16
 954:	8082                	ret

0000000000000956 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 956:	7139                	addi	sp,sp,-64
 958:	fc06                	sd	ra,56(sp)
 95a:	f822                	sd	s0,48(sp)
 95c:	f426                	sd	s1,40(sp)
 95e:	f04a                	sd	s2,32(sp)
 960:	ec4e                	sd	s3,24(sp)
 962:	e852                	sd	s4,16(sp)
 964:	e456                	sd	s5,8(sp)
 966:	e05a                	sd	s6,0(sp)
 968:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 96a:	02051493          	slli	s1,a0,0x20
 96e:	9081                	srli	s1,s1,0x20
 970:	04bd                	addi	s1,s1,15
 972:	8091                	srli	s1,s1,0x4
 974:	0014899b          	addiw	s3,s1,1
 978:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 97a:	00000517          	auipc	a0,0x0
 97e:	11e53503          	ld	a0,286(a0) # a98 <freep>
 982:	c515                	beqz	a0,9ae <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 984:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 986:	4798                	lw	a4,8(a5)
 988:	02977f63          	bgeu	a4,s1,9c6 <malloc+0x70>
 98c:	8a4e                	mv	s4,s3
 98e:	0009871b          	sext.w	a4,s3
 992:	6685                	lui	a3,0x1
 994:	00d77363          	bgeu	a4,a3,99a <malloc+0x44>
 998:	6a05                	lui	s4,0x1
 99a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 99e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9a2:	00000917          	auipc	s2,0x0
 9a6:	0f690913          	addi	s2,s2,246 # a98 <freep>
  if(p == (char*)-1)
 9aa:	5afd                	li	s5,-1
 9ac:	a88d                	j	a1e <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 9ae:	00000797          	auipc	a5,0x0
 9b2:	4f278793          	addi	a5,a5,1266 # ea0 <base>
 9b6:	00000717          	auipc	a4,0x0
 9ba:	0ef73123          	sd	a5,226(a4) # a98 <freep>
 9be:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9c0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9c4:	b7e1                	j	98c <malloc+0x36>
      if(p->s.size == nunits)
 9c6:	02e48b63          	beq	s1,a4,9fc <malloc+0xa6>
        p->s.size -= nunits;
 9ca:	4137073b          	subw	a4,a4,s3
 9ce:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9d0:	1702                	slli	a4,a4,0x20
 9d2:	9301                	srli	a4,a4,0x20
 9d4:	0712                	slli	a4,a4,0x4
 9d6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9d8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9dc:	00000717          	auipc	a4,0x0
 9e0:	0aa73e23          	sd	a0,188(a4) # a98 <freep>
      return (void*)(p + 1);
 9e4:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9e8:	70e2                	ld	ra,56(sp)
 9ea:	7442                	ld	s0,48(sp)
 9ec:	74a2                	ld	s1,40(sp)
 9ee:	7902                	ld	s2,32(sp)
 9f0:	69e2                	ld	s3,24(sp)
 9f2:	6a42                	ld	s4,16(sp)
 9f4:	6aa2                	ld	s5,8(sp)
 9f6:	6b02                	ld	s6,0(sp)
 9f8:	6121                	addi	sp,sp,64
 9fa:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9fc:	6398                	ld	a4,0(a5)
 9fe:	e118                	sd	a4,0(a0)
 a00:	bff1                	j	9dc <malloc+0x86>
  hp->s.size = nu;
 a02:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a06:	0541                	addi	a0,a0,16
 a08:	00000097          	auipc	ra,0x0
 a0c:	ec6080e7          	jalr	-314(ra) # 8ce <free>
  return freep;
 a10:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a14:	d971                	beqz	a0,9e8 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a16:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a18:	4798                	lw	a4,8(a5)
 a1a:	fa9776e3          	bgeu	a4,s1,9c6 <malloc+0x70>
    if(p == freep)
 a1e:	00093703          	ld	a4,0(s2)
 a22:	853e                	mv	a0,a5
 a24:	fef719e3          	bne	a4,a5,a16 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 a28:	8552                	mv	a0,s4
 a2a:	00000097          	auipc	ra,0x0
 a2e:	b7e080e7          	jalr	-1154(ra) # 5a8 <sbrk>
  if(p == (char*)-1)
 a32:	fd5518e3          	bne	a0,s5,a02 <malloc+0xac>
        return 0;
 a36:	4501                	li	a0,0
 a38:	bf45                	j	9e8 <malloc+0x92>
