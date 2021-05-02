#include "./stub/Safe_stub.h"

#include <stdio.h>

int main(int argc, char *argv[])
{
    int i;
    hs_init(&argc, &argv);

    i = fibonacci_hs(42);
    printf("Fibonacci: %d\n", i);

    hs_exit();
    return 0;
}