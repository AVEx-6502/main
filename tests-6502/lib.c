#include <stdarg.h>
#include "lib.h"


#define SCREEN_WRITE    ((char*)0xFE00)


void write_char(char c)
{
    POKE(SCREEN_WRITE, c);
}



void write_string(const char *s)
{
    while(*s != '\0') {
        write_char(*s);
        s++;
    }
}



void write_int(int n)
{
    char s[10];
    itoa(n, s);
    write_string(s);
}



void itoa(int value, char *s)
{
    int i = 0;
    int sign = 1;

    if(value < 0) {
        value *= -1;
        sign = -1;
    }


    while(value != 0) {
        s[i] = value % 10 + '0';
        value /= 10;
        i++;
    }
    if(i == 0) {
        s[0] = '0';
        s[1] = '\0';
    } else {
        if(sign < 0) {
            s[i++] = '-';
        }
        s[i] = '\0';
    }

    strreverse(s);
}



int atoi(const char *s)
{
    int res = 0;
    int sign = 1;

    if(s[0] == '-') {
        sign = -1;
        s++;
    }

    while(*s >= '0' && *s <= '9') {
        res *= 10;
        res += *s - '0';
        s++;
    }

    return res * sign;
}



int strlen(const char *s)
{
    int len = 0;
    while(*s++ != '\0') {
        len++;
    }
    return len;
}



int strcmp(const char *s1, const char *s2)
{
    while((*s1 && *s2) && (*s1++ == *s2++))
        ;
    return *(--s1) - *(--s2);
}



char *strcpy(char *dst, const char *src)
{
    char *ptr;
    ptr = dst;
    while(*dst++ = *src++)
        ;
    return ptr;
}



void strreverse(char *s)
{
    char c;
    int i, j;

    for (i = 0, j = strlen(s) - 1; i < j; i++, j--) {
        c = s[i];
        s[i] = s[j];
        s[j] = c;
    }
}



void *memcpy(void *dest, const void *src, int count)
{
    char *dst8 = (char*)dest;
    char *src8 = (char*)src;

    while (count--) {
        *dst8++ = *src8++;
    }
    return dest;
}



int memcmp(const char *str1, const char *str2, int count)
{
    const unsigned char *s1 = (const unsigned char*)str1;
    const unsigned char *s2 = (const unsigned char*)str2;

    while (count-- > 0)
    {
        if (*s1++ != *s2++) {
            return s1[-1] < s2[-1] ? -1 : 1;
        }
    }
    return 0;
}


void printf(const char *format, ...)
{
    int n;
    char *s;
    va_list vl;
    va_start(vl, format);

    while(*format != '\0') {
        if(*format == '%') {
            format++;
            switch(*format) {
                case 'd':
                case 'i':
                    n = va_arg(vl,int);
                    write_int(n);
                    break;

                case 's':
                    s = va_arg(vl,char*);
                    write_string(s);
                    break;

                default:
                    write_char(*format);
                    break;
            }
        } else {
            write_char(*format);
        }
        format++;
    }
    va_end(vl);
}
