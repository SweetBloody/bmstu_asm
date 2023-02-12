#define OK 0
#include <stdio.h>
#include <time.h>

#define REPEATS 1000000


int getDoubleSize(void)
{
    return sizeof(double) * __CHAR_BIT__;
}

void getDoubleCSum(double a, double b, double *res)
{
    *res =  a + b;
}

void getDoubleCMult(double a, double b, double *res)
{
    *res = a * b;
}

void getDoubleAsmSum(double a, double b, double *res)
{
    // __asm__(".intel_syntax noprefix\n\t"
    // "fld %1\n"
    // "fld %2\n"
    // "faddp\n"
    // "fstp [%0]\n"
    // : "=&m" (res)
    // : "m" (a), "m" (b)
    // );
    __asm__(
        "fld %1\n"
        "fld %2\n"
        "fmulp\n"
        "fstp %0"
        : "=&m" (res)
        : "m" (a), "m" (b)
    );
}

void getDoubleAsmMult(double a, double b, double *res)
{
    __asm__(
        "fld %1\n"
        "fld %2\n"
        "fmulp\n"
        "fstp %0"
        : "=&m" (res)
        : "m" (a), "m" (b)
    );
}

double getDoubleFuncTime(double a, double b, double *res, void (*func)(double, double, double *))
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


void printDoubleCharacteristics()
{
    double a = 2.3e307;
    double b = 1.1e307;
    double res = 0;

    printf("\n\n----------------DOUBLE----------------\n");
    printf("Size:     %9d bit\n", getDoubleSize());
    printf("----------------sum----------------\n");
    printf("C     %9.4g s   res = ",
        getDoubleFuncTime(a, b, &res, getDoubleCSum));
    getDoubleCSum(a, b, &res);
    printf("%g\n", res);


    printf("ASM   %9.4g s   res = ",
        getDoubleFuncTime(a, b, &res, getDoubleAsmSum));
    getDoubleAsmSum(a, b, &res);
    printf("%g\n", res);

    a = 2.3e153;
    b = 1.1e153;
    printf("----------------mult----------------\n");
    printf("C    %9.4g s   res = ",
            getDoubleFuncTime(a, b, &res, getDoubleCMult));
    getDoubleCMult(a, b, &res);
    printf("%g\n", res);


    printf("ASM  %9.4g s   res = ",
            getDoubleFuncTime(a, b, &res, getDoubleAsmMult));
    getDoubleAsmMult(a, b, &res);
    printf("%g\n", res);
}




int getFloatSize(void)
{
    return sizeof(float) * __CHAR_BIT__;
}

float getFloatCSum(float a, float b)
{
    return a + b;
}

float getFloatCMult(float a, float b)
{
    return a * b;
}

float getFloatAsmSum(float a, float b)
{
    float res;

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

float getFloatAsmMult(float a, float b)
{
    float res;

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

double getFloatFuncTime(float a, float b, float (*func)(float, float))
{
    clock_t start = clock();
    
    for (size_t i = 0; i < REPEATS; ++i)
        func(a, b);

    clock_t end = clock();

    return (double) (end - start) / CLOCKS_PER_SEC / REPEATS;
}

void printFloatCharacteristics()
{
    float a = 2.3e38;
    float b = 1.1e38;

    printf("\n\n----------------FLOAT----------------\n");
    printf("Size:     %9d bit\n", getFloatSize());
    printf("----------------sum----------------\n");
    printf(
        "C     %9.4g s   res = %g\n",
        getFloatFuncTime(a, b, getFloatCSum),
        getFloatCSum(a, b)
    );
    printf(
        "ASM   %9.4g s   res = %g\n",
        getFloatFuncTime(a, b, getFloatAsmSum),
        getFloatAsmSum(a, b)
    );

    a = 2.3e19;
    b = 1.1e19;

    printf("----------------mult----------------\n");
    printf(
            "C    %9.4g s   res = %g\n",
            getFloatFuncTime(a, b, getFloatCMult),
            getFloatCMult(a, b)
    );
    printf(
            "ASM  %9.4g s   res = %g\n",
            getFloatFuncTime(a, b, getFloatAsmMult),
            getFloatAsmMult(a, b)
    );
}





int getLongDoubleSize(void)
{
    return sizeof(long double) * __CHAR_BIT__;
}

long double getLongDoubleCSum(long double a, long double b)
{
    return a + b;
}

long double getLongDoubleCMult(long double a, long double b)
{
    return a * b;
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
//
//    puts("FORBIDDEN!!!");
//#endif
}



#include "math.h"

#define PI2 3.14
#define PI6 3.141596

double getFPUPi(void)
{
    double fpuPi;

    __asm__(
        "fldpi\n"
        "fstp %0\n"
        : "=m" (fpuPi) 
    );

    return fpuPi;
}

void printSinCharacteristics(void)
{
    printf("\n\n----------------SIN(PI)----------------\n");
    printf("PI = 3.14              : %g\n", sin(PI2));
    printf("PI = 3.141596          : %g\n", sin(PI6));
    double fpuPi = getFPUPi();
    printf("FPUPI = %.14g: %g\n", fpuPi, sin(fpuPi));

    printf("\n----------------SIN(PI / 2)----------------\n");
    printf("PI = 3.14              : %g\n", sin(PI2 / 2));
    printf("PI = 3.141596          : %g\n", sin(PI6 / 2));
    printf("FPUPI = %.14g: %g\n", fpuPi, sin(fpuPi / 2));
}



int main(void)
{
    printFloatCharacteristics();
    // printDoubleCharacteristics();
    // printLongDoubleCharacteristics();
    // printSinCharacteristics();

    return OK;
}