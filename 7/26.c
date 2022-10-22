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
    register int* A asm ("r13") = (int *)malloc((argc - 1) * sizeof(int));
    register int* B asm ("r14") = (int *)malloc((argc - 3) * sizeof(int));

    FILE *fp;
    fp = fopen(argv[1], "r");
    int size;
    fscanf(fp, "%d", &size);

    if (size < 4) {
        printf("Size of the array must be greater than 3!\n");
        return 0;
    }
    for (i = 0; i < size; i++) {
        fscanf(fp, "%d", &A[i]);
    }

    B = solve(A, size);

    FILE *fp2;
    fp2 = fopen(argv[2], "w");
    for (i = 0; i < size - 2; i++) {
        fprintf(fp2, "%d\n", B[i]);
    }

    free(A);
    free(B);

    return 0;
}