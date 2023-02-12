#include "../inc/double_operations.h"

int getDoubleSize(void)
{
    return sizeof(double) * __CHAR_BIT__;
}


double getDoubleCSum(double a, double b)
{
    double res;
    res =  a + b;
    return res;
}

double getDoubleCMult(double a, double b)
{
    double res;
    res = a * b;
    return res;
}

double getDoubleAsmSum(double a, double b)
{
    double res;
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

double getDoubleAsmMult(double a, double b)
{
    double res;
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

double getDoubleFuncTimePtr(double a, double b, double *res, void (*func)(double, double, double *))
{
    clock_t start = clock();

    for (size_t i = 0; i < REPEATS; ++i)
    {
        *res = 0;
        func(a, b, res);
    }

    clock_t end = clock();

    return (double) (end - start) / CLOCKS_PER_SEC / REPEATS;
}

double getDoubleFuncTime(double a, double b, double (*func)(double, double))
{
    clock_t start = clock();

    for (size_t i = 0; i < REPEATS; ++i)
    {
        func(a, b);
    }

    clock_t end = clock();

    return (double) (end - start) / CLOCKS_PER_SEC / REPEATS;
}


void printDoubleCharacteristics()
{
    double a = 2.3e307;
    double b = 1.1e307;

    printf("\n\n----------------DOUBLE----------------\n");
    printf("Size:     %9d bit\n", getDoubleSize());
    printf("----------------sum----------------\n");
    printf("C     %9.4g s   res = %g\n",
           getDoubleFuncTime(a, b, getDoubleCSum), getDoubleCSum(a, b));


    printf("ASM   %9.4g s   res = %g\n",
           getDoubleFuncTime(a, b, getDoubleAsmSum), getDoubleAsmSum(a, b));

    a = 2.3e153;
    b = 1.1e153;
    printf("----------------mult----------------\n");
    printf("C    %9.4g s   res = %g\n",
           getDoubleFuncTime(a, b, getDoubleCMult), getDoubleCMult(a, b));


    printf("ASM  %9.4g s   res = %g\n",
           getDoubleFuncTime(a, b,getDoubleAsmMult), getDoubleAsmMult(a, b));
}
