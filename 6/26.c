#include <stdio.h>
#include <stdlib.h>

int* solve(int* arr, int size) {
    register int* result asm ("r15") = (int *)malloc((size - 2) * sizeof(int));
    register int i asm ("r12");
    for (i = 1; i < size - 1; i++) {
        result[i-1] = arr[i-1] + arr[i] + arr[i+1];
    }
    return result;
}


int main(int argc, char *argv[]) {
    register int i asm ("r12");
    if (argc < 4) {
        printf("Size of the array must be greater than 3!");
        return 0;
    }
    register int* A asm ("r13") = (int *)malloc((argc - 1) * sizeof(int));
    register int* B asm ("r14") = (int *)malloc((argc - 3) * sizeof(int));

    for (i = 1; i < argc; i++) {
        A[i-1] = atoi(argv[i]);
    }

    B = solve(A, argc - 1);

    for (i = 0; i < argc - 3; i++) {
        printf("%d ", B[i]);
    }

    free(A);
    free(B);

    return 0;
}