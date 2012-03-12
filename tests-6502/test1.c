#define USE_STD_LIBC

#ifdef USE_STD_LIBC
    #include <stdio.h>
#else
    #include "lib.h"
#endif


int fact_recur(int n)
{
    if(n == 0) {
        return 1;
    } else {
        return n * fact_recur(n-1);
    }
}

int fact_iter(int n)
{
    int res = 1;

    while(n > 1) {
        res *= n;
        n--;
    }
    return res;
}

int fact_test[] = {1, 1, 2, 6, 24, 120};



int fib_recur(int n)
{
    if(n == 0) {
        return 0;
    } else if(n == 1) {
        return 1;
    } else {
        return fib_recur(n-1) + fib_recur(n-2);
    }
}

int fib_iter(int n)
{
    int i;
    int fib[16] = {0, 1};

    for(i = 2; i <= n; i++) {
        fib[i] = fib[i-1] + fib[i-2];
    }
    return fib[n];
}

int fib_test[] = {0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233};



int pow2_recur(int n)
{
    if(n == 0) {
        return 1;
    } else {
        return 2 * pow2_recur(n-1);
    }
}

int pow2_iter(int n)
{
    int res = 1;

    while(n-- > 0) {
        res *= 2;
    }
    return res;
}

int pow2_test[] = {1, 2, 4, 8, 16, 32, 64, 128};


#define SIZE(x)     (sizeof(x)/sizeof(x[0]))

#define XGLUE(a, b) a##b
#define GLUE(a, b) XGLUE(a, b)

#define TEST(name,result)   \
    do {    \
        int i;  \
        for(i = 0; i < SIZE(GLUE(name,_test)); i++) {   \
            if(GLUE(name,_iter)(i) != GLUE(name,_test)[i] || GLUE(name,_recur)(i) != GLUE(name,_test)[i]) { \
                (result) = 0;   \
                break;  \
            }   \
        }   \
    } while(0)



int main(int argc, char **argv)
{
    int passed = 1;

    TEST(fact, passed);
    TEST(fib, passed);
    TEST(pow2, passed);

    if(passed) {
        printf("All tests passed!\n");
    } else {
        printf("FAIL!\n");
    }

    return 0;
}
