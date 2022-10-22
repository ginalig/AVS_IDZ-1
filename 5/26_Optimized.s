	.file	"26.c"
	.intel_syntax noprefix
	.text
	.globl	solve
	.type	solve, @function
solve:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	DWORD PTR -28[rbp], esi
	mov	eax, DWORD PTR -28[rbp]
	sub	eax, 2
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -8[rbp], rax
	mov	DWORD PTR -12[rbp], 1
	jmp	.L2
.L3:
	mov	eax, DWORD PTR -12[rbp]
	cdqe
	sal	rax, 2
	lea	rdx, -4[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	eax, DWORD PTR -12[rbp]
	cdqe
	lea	rcx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	lea	ecx, [rdx+rax]
	mov	eax, DWORD PTR -12[rbp]
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	eax, DWORD PTR -12[rbp]
	cdqe
	sal	rax, 2
	lea	rsi, -4[rax]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rsi
	add	edx, ecx
	mov	DWORD PTR [rax], edx
	add	DWORD PTR -12[rbp], 1
.L2:
	mov	eax, DWORD PTR -28[rbp]
	sub	eax, 1
	cmp	DWORD PTR -12[rbp], eax
	jl	.L3
	mov	rax, QWORD PTR -8[rbp]
	leave
	ret
	.size	solve, .-solve
	.section	.rodata
	.align 8
.LC0:
	.string	"Size of the array must be greater than 3!"
.LC1:
	.string	"%d "
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 56
	mov	DWORD PTR -52[rbp], edi
	mov	QWORD PTR -64[rbp], rsi
	cmp	DWORD PTR -52[rbp], 3
	jg	.L6
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L7
.L6:
	mov	eax, DWORD PTR -52[rbp]
	sub	eax, 1
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -32[rbp], rax
	mov	eax, DWORD PTR -52[rbp]
	sub	eax, 3
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -24[rbp], rax
	mov	DWORD PTR -40[rbp], 1
	jmp	.L8
.L9:
	mov	eax, DWORD PTR -40[rbp]
	cdqe
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -64[rbp]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	edx, DWORD PTR -40[rbp]
	movsx	rdx, edx
	sal	rdx, 2
	lea	rcx, -4[rdx]
	mov	rdx, QWORD PTR -32[rbp]
	lea	rbx, [rcx+rdx]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR [rbx], eax
	add	DWORD PTR -40[rbp], 1
.L8:
	mov	eax, DWORD PTR -40[rbp] # eax = argc
	cmp	eax, DWORD PTR -52[rbp]
	jl	.L9
	mov	eax, DWORD PTR -52[rbp] 
	lea	edx, -1[rax] # edx = -1 + argc (size)
	mov	rax, QWORD PTR -32[rbp]
	mov	esi, edx # esi = size
	mov	rdi, rax # rdi = array
	call	solve # solve(array, size)
	mov	QWORD PTR -24[rbp], rax # return result
	mov	DWORD PTR -36[rbp], 0
	jmp	.L10
.L11:
	mov	eax, DWORD PTR -36[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	esi, eax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	add	DWORD PTR -36[rbp], 1
.L10:
	mov	eax, DWORD PTR -52[rbp]
	sub	eax, 3
	cmp	DWORD PTR -36[rbp], eax
	jl	.L11
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	eax, 0
.L7:
	mov	rbx, QWORD PTR -8[rbp]
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
