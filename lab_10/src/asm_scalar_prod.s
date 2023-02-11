	.file	"asm_scalar_prod.c"
	.text
	.globl	asmScalarProd
	.def	asmScalarProd;	.scl	2;	.type	32;	.endef
	.seh_proc	asmScalarProd
asmScalarProd:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	movq	%r8, 32(%rbp)
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -16(%rbp)
	movq	32(%rbp), %rax
	salq	$5, %rax
	movq	%rax, %rdx
	movq	16(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -8(%rbp)
	jmp	.L2
.L3:
	leaq	-16(%rbp), %rax
	movq	16(%rbp), %rdx
	movq	24(%rbp), %rcx
/APP
 # 15 "asm_scalar_prod.c" 1
	vmovupd ymm0, (%rdx)
vmovupd ymm1, (%rcx)
vmulpd ymm0, ymm0, ymm1
vextractf128 xmm1, ymm0, 1
vaddpd xmm0, xmm1, xmm0
vhaddpd ymm0, ymm0, ymm1
vhaddpd ymm2, ymm0, ymm1
movsd qword ptr [%rax], xmm0

 # 0 "" 2
/NO_APP
	addq	$32, 16(%rbp)
	addq	$32, 24(%rbp)
.L2:
	movq	16(%rbp), %rax
	cmpq	-8(%rbp), %rax
	jb	.L3
	movsd	-16(%rbp), %xmm0
	movq	%xmm0, %rax
	movq	%rax, %xmm0
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (Rev5, Built by MSYS2 project) 10.3.0"
