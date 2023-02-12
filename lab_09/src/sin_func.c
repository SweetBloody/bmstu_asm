#include "../inc/sin_func.h"
#include "../inc/config.h"
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