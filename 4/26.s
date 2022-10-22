	.file	"26.c"
	.intel_syntax noprefix
	.text
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
.LFB6:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 56
	.cfi_offset 3, -24
	mov	DWORD PTR -52[rbp], edi # argc
	mov	QWORD PTR -64[rbp], rsi # argv
	cmp	DWORD PTR -52[rbp], 3
	jg	.L2
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L3
.L2:
	mov	eax, DWORD PTR -52[rbp]
	sub	eax, 1 # argc - 1
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -32[rbp], rax # A
	mov	eax, DWORD PTR -52[rbp]
	sub	eax, 3 # argc - 3
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -24[rbp], rax # B
	mov	DWORD PTR -44[rbp], 1 # i
	jmp	.L4
.L5:
	mov	eax, DWORD PTR -44[rbp] # i
	cdqe
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -64[rbp] # argv
	add	rax, rdx # argv + i
	mov	rax, QWORD PTR [rax] # argv[i]
	mov	edx, DWORD PTR -44[rbp] # i
	movsx	rdx, edx # i
	sal	rdx, 2
	lea	rcx, -4[rdx] # -4 + i * 4
	mov	rdx, QWORD PTR -32[rbp] # A
	lea	rbx, [rcx+rdx] # A + i - 1
	mov	rdi, rax # argv[i]
	call	atoi@PLT
	mov	DWORD PTR [rbx], eax # A[i] = atoi(argv[i])
	add	DWORD PTR -44[rbp], 1
.L4:
	mov	eax, DWORD PTR -44[rbp]
	cmp	eax, DWORD PTR -52[rbp] # i < argc
	jl	.L5
	mov	DWORD PTR -40[rbp], 1 # new i
	jmp	.L6
.L7:
	mov	eax, DWORD PTR -40[rbp] # i
	cdqe
	sal	rax, 2
	lea	rdx, -4[rax] # i - 1
	mov	rax, QWORD PTR -32[rbp] # A
	add	rax, rdx # A + i - 1
	mov	edx, DWORD PTR [rax] # A[i - 1]
	mov	eax, DWORD PTR -40[rbp] # i
	cdqe
	lea	rcx, 0[0+rax*4] # i * 4
	mov	rax, QWORD PTR -32[rbp] # A
	add	rax, rcx # A + i * 4
	mov	eax, DWORD PTR [rax] # A[i]
	lea	ecx, [rdx+rax] # A[i - 1] + A[i]
	mov	eax, DWORD PTR -40[rbp] # i
	cdqe
	add	rax, 1 # i + 1
	lea	rdx, 0[0+rax*4] # (i + 1) * 4
	mov	rax, QWORD PTR -32[rbp] # A
	add	rax, rdx # A + (i + 1) * 4
	mov	edx, DWORD PTR [rax] # A[i + 1]
	mov	eax, DWORD PTR -40[rbp] # i
	cdqe
	sal	rax, 2 # i * 4
	lea	rsi, -4[rax] # i - 1
	mov	rax, QWORD PTR -24[rbp] # B
	add	rax, rsi # B + i - 1
	add	edx, ecx # A[i - 1] + A[i] + A[i + 1]
	mov	DWORD PTR [rax], edx # B[i - 1] = A[i - 1] + A[i] + A[i + 1]
	add	DWORD PTR -40[rbp], 1 # i++
.L6:
	mov	eax, DWORD PTR -52[rbp] # argc
	sub	eax, 2 # argc - 2
	cmp	DWORD PTR -40[rbp], eax # i < argc - 2
	jl	.L7
	mov	DWORD PTR -36[rbp], 0 # new i
	jmp	.L8
.L9:
	mov	eax, DWORD PTR -36[rbp] # i
	cdqe
	lea	rdx, 0[0+rax*4] # i * 4
	mov	rax, QWORD PTR -24[rbp] # B
	add	rax, rdx # B + i * 4
	mov	eax, DWORD PTR [rax] 
	mov	esi, eax # B[i]
	lea	rax, .LC1[rip]
	mov	rdi, rax # "%d "
	mov	eax, 0
	call	printf@PLT
	add	DWORD PTR -36[rbp], 1 # i++
.L8:
	mov	eax, DWORD PTR -52[rbp] # argc
	sub	eax, 3 # argc - 3
	cmp	DWORD PTR -36[rbp], eax # i < argc - 3
	jl	.L9
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax # A
	call	free@PLT
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax # B
	call	free@PLT
	mov	eax, 0
.L3:
	mov	rbx, QWORD PTR -8[rbp]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
