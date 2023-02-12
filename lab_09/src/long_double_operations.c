#include "../inc/long_double_operations.h"


int getLongDoubleSize(void)
{
    return sizeof(long double) * __CHAR_BIT__;
}

long double getLongDoubleCSum(long double a, long double b)
{
    long double res;
    res = a + b;
    return res;
}

long double getLongDoubleCMult(long double a, long double b)
{
    long double res;
    res = a * b;
    return res;
}

long double getLongDoubleAsmSum(long double a, long double b)
{
    long double res;

    __asm__(
        "fld %1\n"
        "fld %2\n"
        "faddp\n"
        "fstp %0"
        : "=m" (res)
        : "m" (a), "m" (b)
    );

    return res;
}

long double getLongDoubleAsmMult(long double a, long double b)
{
    long double res;

    __asm__(
        "fld %1\n"
        "fld %2\n"
        "fmulp\n"
        "fstp %0"
        : "=m" (res)
        : "m" (a), "m" (b)
    );

    return res;
}

double getLongDoubleFuncTime(long double a, long double b,
            long double (*func)(long double, long double))
{
    clock_t start = clock();
    
    for (size_t i = 0; i < REPEATS; ++i)
        func(a, b);

    clock_t end = clock();

    return (double) (end - start) / CLOCKS_PER_SEC / REPEATS;
}


void printLongDoubleCharacteristics()
{
    printf("\n\n----------------LONG DOUBLE----------------\n");

    long double a = 2.3e400L;
    long double b = 1.1e400L;

    printf("Size:     %9d bit\n", getLongDoubleSize());
    printf("----------------sum----------------\n");
    printf(
        "C     %9.4g s   res = %Lg\n",
        getLongDoubleFuncTime(a, b, getLongDoubleCSum),
        getLongDoubleCSum(a, b)
    );
    printf(
        "ASM   %9.4g s   res = %Lg\n",
        getLongDoubleFuncTime(a, b, getLongDoubleAsmSum),
        getLongDoubleAsmSum(a, b)
    );
    printf("----------------mult----------------\n");
    printf(
            "C    %9.4g s   res = %Lg\n",
            getLongDoubleFuncTime(a, b, getLongDoubleCMult),
            getLongDoubleCMult(a, b)
    );
    printf(
            "ASM  %9.4g s   res = %Lg\n",
            getLongDoubleFuncTime(a, b, getLongDoubleAsmMult),
            getLongDoubleAsmMult(a, b)
    );
}
