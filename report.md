# Нигай Александр БПИ-219

# Вариант 26

# Отчет по ИДЗ №1

## 4 балла

### Код на C

```c
#include <stdio.h>
#include <stdlib.h>

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

    for (int i = 1; i < argc - 2; i++) {
        B[i-1] = A[i-1] + A[i] + A[i+1];
    }

    for (int i = 0; i < argc - 3; i++) {
        printf("%d ", B[i]);
    }

    free(A);
    free(B);

    return 0;
}
```

### Компиляция программы без оптимизаций

```sh
gcc -masm=intel -S 26.c -o 26.s
```

### Компиляция программы с оптимизацией

```sh
gcc -O0 -Wall -masm=intel -S -fno-asynchronous-unwind-tables -fcf-protection=none 26.c -o 26_Optimized.s
```

### Тестовые прогоны

| Входные данные   |                    26.s                     |               26_Optimized.s                |
| ---------------- | :-----------------------------------------: | :-----------------------------------------: |
| _пустой массив_  | _Size of the array must be greater than 3!_ | _Size of the array must be greater than 3!_ |
| [1 2]            | _Size of the array must be greater than 3!_ | _Size of the array must be greater than 3!_ |
| [1 2 3]          |                     [6]                     |                     [6]                     |
| [-5 -3 -1 1 3 5] |                 [-9 -3 3 9]                 |                 [-9 -3 3 9]                 |
| [321 4 32 123 5] |                [357 159 160]                |                [357 159 160]                |

## 5 баллов

### Код на C

```c
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
```

### Комментарии в 26_Optimized.s

```assembly
.L8:
	mov	eax, DWORD PTR -40[rbp] 	# eax = argc
	cmp	eax, DWORD PTR -52[rbp]
	jl	.L9
	mov	eax, DWORD PTR -52[rbp]
	lea	edx, -1[rax] 				# edx = -1 + argc (size)
	mov	rax, QWORD PTR -32[rbp]
	mov	esi, edx 					# esi = size
	mov	rdi, rax 					# rdi = array
	call	solve 					# solve(array, size)
	mov	QWORD PTR -24[rbp], rax 	# return result
	mov	DWORD PTR -36[rbp], 0
	jmp	.L10
```

## 6 баллов

### Измененный код на C

```c
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
```

Явно задаю, в какие регистры помещать переменные, поэтому комментарии не требуются.

### Тестовые прогоны

| Входные данные   |                    26.s                     |               26_Optimized.s                |
| ---------------- | :-----------------------------------------: | :-----------------------------------------: |
| _пустой массив_  | _Size of the array must be greater than 3!_ | _Size of the array must be greater than 3!_ |
| [1 2]            | _Size of the array must be greater than 3!_ | _Size of the array must be greater than 3!_ |
| [1 2 3]          |                     [6]                     |                     [6]                     |
| [-5 -3 -1 1 3 5] |                 [-9 -3 3 9]                 |                 [-9 -3 3 9]                 |
| [321 4 32 123 5] |                [357 159 160]                |                [357 159 160]                |

## 7 баллов

### Измененный код на С для ввода/вывода из/в файл

```c
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
```

### Разбиение Asm кода на две единицы компиляции

#### 26_Optimized_1.s

```assembly
	.intel_syntax noprefix
	.text
	.globl	solve
	.type	solve, @function
solve:
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r12
	sub	rsp, 16
	mov	QWORD PTR -24[rbp], rdi
	mov	DWORD PTR -28[rbp], esi
	mov	eax, DWORD PTR -28[rbp]
	sub	eax, 2
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	r15, rax
	mov	r12d, 1
	jmp	.L2
.L3:
	mov	eax, r12d
	cdqe
	sal	rax, 2
	lea	rdx, -4[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	eax, r12d
	cdqe
	lea	rcx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	lea	ecx, [rdx+rax]
	mov	eax, r12d
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	rsi, r15
	mov	eax, r12d
	cdqe
	sal	rax, 2
	sub	rax, 4
	add	rax, rsi
	add	edx, ecx
	mov	DWORD PTR [rax], edx
	mov	eax, r12d
	add	eax, 1
	mov	r12d, eax
.L2:
	mov	eax, DWORD PTR -28[rbp]
	sub	eax, 1
	mov	edx, r12d
	cmp	eax, edx
	jg	.L3
	mov	rax, r15
	add	rsp, 16
	pop	r12
	pop	r15
	pop	rbp
	ret
	.size	solve, .-solve
	.section	.rodata
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits

```

#### 26_Optimized_2.s

```assembly
		.file	"26.c"
	.intel_syntax noprefix
	.text
	.section .rodata
.LC0:
	.string	"r"
.LC1:
	.string	"%d"
	.align 8
.LC2:
	.string	"Size of the array must be greater than 3!"
.LC3:
	.string	"w"
.LC4:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	push	r14
	push	r13
	push	r12
	sub	rsp, 56
	mov	DWORD PTR -68[rbp], edi
	mov	QWORD PTR -80[rbp], rsi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -40[rbp], rax
	xor	eax, eax
	mov	eax, DWORD PTR -68[rbp]
	sub	eax, 1
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	r13, rax
	mov	eax, DWORD PTR -68[rbp]
	sub	eax, 3
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	r14, rax
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC0[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -56[rbp], rax
	lea	rdx, -60[rbp]
	mov	rax, QWORD PTR -56[rbp]
	lea	rcx, .LC1[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	mov	eax, DWORD PTR -60[rbp]
	cmp	eax, 3
	jg	.L6
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L12
.L6:
	mov	r12d, 0
	jmp	.L8
.L9:
	mov	rdx, r13
	mov	eax, r12d
	cdqe
	sal	rax, 2
	add	rdx, rax
	mov	rax, QWORD PTR -56[rbp]
	lea	rcx, .LC1[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	mov	eax, r12d
	add	eax, 1
	mov	r12d, eax
.L8:
	mov	edx, r12d
	mov	eax, DWORD PTR -60[rbp]
	cmp	edx, eax
	jl	.L9
	mov	eax, DWORD PTR -60[rbp]
	mov	rdx, r13
	mov	esi, eax
	mov	rdi, rdx
	call	solve
	mov	r14, rax
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC3[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -48[rbp], rax
	mov	r12d, 0
	jmp	.L10
.L11:
	mov	rdx, r14
	mov	eax, r12d
	cdqe
	sal	rax, 2
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	rax, QWORD PTR -48[rbp]
	lea	rcx, .LC4[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	mov	eax, r12d
	add	eax, 1
	mov	r12d, eax
.L10:
	mov	eax, DWORD PTR -60[rbp]
	sub	eax, 2
	mov	edx, r12d
	cmp	eax, edx
	jg	.L11
	mov	rax, r13
	mov	rdi, rax
	call	free@PLT
	mov	rax, r14
	mov	rdi, rax
	call	free@PLT
	mov	eax, 0
.L12:
	mov	rdx, QWORD PTR -40[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L13
	call	__stack_chk_fail@PLT
.L13:
	add	rsp, 56
	pop	r12
	pop	r13
	pop	r14
	pop	rbp
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits

```

### Тестовые прогоны

#### Файл input.txt:

В первой строке задается размер массива _n_, далее построчно заданы _n_ элементов массива _A_.

```
5
3
2
3
4
5
```

#### Файл output.txt:

Построчный вывод элементов массива _B_

```
8
9
12

```
