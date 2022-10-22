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
    