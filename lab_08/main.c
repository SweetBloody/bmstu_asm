#include <stdio.h>
#include <string.h>

#include "my_string.h"

#define OK 0


int main(void)
{
    setbuf(stdout, NULL);

    printf("len %s = %d\n", "abcdefg", my_asm_len("abcdefg"));

    char buf1[] = "aaaaaaaaaaaaaaaaaaaaaaa";
    char buf2[] = "bbbbbbbbbbbbbbbbbbbbbbb";
    //strncpy(buf1 + 5, buf2, 10);
    my_asm_copy(buf1 + 5, buf2, 10);

    printf("%s\n", buf1);

    return OK;
}