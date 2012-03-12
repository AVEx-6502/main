#ifndef LIB
#define LIB


#define MAX(a,b)        ((a) > (b) ? (a) : (b))
#define MIN(a,b)        ((a) < (b) ? (a) : (b))
#define EVEN(n)         ((n) & 1 == 0)
#define ODD(n)          ((n) & 1 == 1)

typedef unsigned char byte;

#define POKE(addr,val)     (*(byte*) (addr) = (val))
#define PEEK(addr)         (*(byte*) (addr))


void write_char(char c);
void write_string(const char *s);
void write_int(int n);

void itoa(int value, char *s);
int atoi(const char *s);

int strlen(const char *s);
int strcmp(const char *s1, const char *s2);
char *strcpy(char *dst, const char *src);
void strreverse(char *s);

void *memcpy(void *dest, const void *src, int count);
int memcmp(const char *str1, const char *str2, int count);

void printf(const char *format, ...);

#endif
