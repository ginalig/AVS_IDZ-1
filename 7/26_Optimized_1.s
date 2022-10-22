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
	