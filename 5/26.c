#include <stdio.h>
#include <stdlib.h>

int* solve(int* arr, int size) {
    int* result = (int *)malloc((size - 2) * sizeof(int));
    for (int i = 1; i < size - 1; i++) {
        result[i-1] = arr[i-1] + arr[i] + arr[i+1];
    }
    return result;
}


int main(int argc, char *argv[]) {
    if (argc < 4) {
        printf("Size of the array must be greater than 3!");
        return 0;
    }
    int* A = (int *)malloc((argc - 1) * sizeof(int));
    int* B = (int *)malloc((argc - 3) * sizeof(int));

    for (int i = 1; i < argc; i++) {
        A[i-1] = atoi(argv[i]);
    }

    B = solve(A, argc - 1);

    for (int i = 0; i < argc - 3; i++) {
        printf("%d ", B[i]);
    }

    free(A);
    free(B);

    return 0;
}