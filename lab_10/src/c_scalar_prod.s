	.file	"c_scalar_prod.c"
	.text
	.globl	cScalarProd
	.def	cScalarProd;	.scl	2;	.type	32;	.endef
	.seh_proc	cScalarProd
cScalarProd:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	movq	%r8, 32(%rbp)
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -8(%rbp)
	movq	$0, -16(%rbp)
	jmp	.L2
.L5:
	movl	$0, -20(%rbp)
	jmp	.L3
.L4:
	movq	-16(%rbp), %rax
	salq	$5, %rax
	movq	%rax, %rdx
	movq	16(%rbp), %rax
	addq	%rax, %rdx
	movl	-20(%rbp), %eax
	cltq
	movsd	(%rdx,%rax,8), %xmm1
	movq	-16(%rbp), %rax
	salq	$5, %rax
	movq	%rax, %rdx
	movq	24(%rbp), %rax
	addq	%rax, %rdx
	movl	-20(%rbp), %eax
	cltq
	movsd	(%rdx,%rax,8), %xmm0
	mulsd	%xmm1, %xmm0
	movsd	-8(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -8(%rbp)
	addl	$1, -20(%rbp)
.L3:
	cmpl	$3, -20(%rbp)
	jle	.L4
	addq	$1, -16(%rbp)
.L2:
	movq	-16(%rbp), %rax
	cmpq	32(%rbp), %rax
	jb	.L5
	movsd	-8(%rbp), %xmm0
	movq	%xmm0, %rax
	movq	%rax, %xmm0
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (Rev5, Built by MSYS2 project) 10.3.0"
