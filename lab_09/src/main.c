// #include "float_operations.h"
// #include "double_operations.h"
// #include "long_double_operations.h"
// #include "sin_func.h"

#include "../inc/float_operations.h"
#include "../inc/double_operations.h"
#include "../inc/long_double_operations.h"
#include "../inc/sin_func.h"

#define OK 0

int main(void)
{
    printFloatCharacteristics();
     printDoubleCharacteristics();
     printLongDoubleCharacteristics();
     printSinCharacteristics();

    return OK;
}