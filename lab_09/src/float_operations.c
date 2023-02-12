#include "../inc/float_operations.h"

int getFloatSize(void)
{
    return sizeof(float) * __CHAR_BIT__;
}

float getFloatCSum(float a, float b)
{
    float res;
    res = a + b;
    return res;
}

float getFloatCMult(float a, float b)
{
    float res;
    res = a * b;
    return res;
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
