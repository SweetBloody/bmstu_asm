	.file	"float_operations.c"
	.text
	.def	printf;	.scl	3;	.type	32;	.endef
	.seh_proc	printf
printf:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$56, %rsp
	.seh_stackalloc	56
	leaq	48(%rsp), %rbp
	.seh_setframe	%rbp, 48
	.seh_endprologue
	movq	%rcx, 32(%rbp)
	movq	%rdx, 40(%rbp)
	movq	%r8, 48(%rbp)
	movq	%r9, 56(%rbp)
	leaq	40(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rbx
	movl	$1, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
	movq	%rbx, %r8
	movq	32(%rbp), %rdx
	movq	%rax, %rcx
	call	__mingw_vfprintf
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	addq	$56, %rsp
	popq	%rbx
	popq	%rbp
	ret
	.seh_endproc
	.globl	getFloatSize
	.def	getFloatSize;	.scl	2;	.type	32;	.endef
	.seh_proc	getFloatSize
getFloatSize:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movl	$32, %eax
	popq	%rbp
	ret
	.seh_endproc
	.globl	getFloatCSum
	.def	getFloatCSum;	.scl	2;	.type	32;	.endef
	.seh_proc	getFloatCSum
getFloatCSum:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movss	%xmm0, 16(%rbp)
	movss	%xmm1, 24(%rbp)
	movss	16(%rbp), %xmm0
	addss	24(%rbp), %xmm0
	movss	%xmm0, -4(%rbp)
	movss	-4(%rbp), %xmm0
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	getFloatCMult
	.def	getFloatCMult;	.scl	2;	.type	32;	.endef
	.seh_proc	getFloatCMult
getFloatCMult:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movss	%xmm0, 16(%rbp)
	movss	%xmm1, 24(%rbp)

	///
	movss	16(%rbp), %xmm0
	mulss	24(%rbp), %xmm0
	movss	%xmm0, -4(%rbp)
	///

	movss	-4(%rbp), %xmm0
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	getFloatAsmSum
	.def	getFloatAsmSum;	.scl	2;	.type	32;	.endef
	.seh_proc	getFloatAsmSum
getFloatAsmSum:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movss	%xmm0, 16(%rbp)
	movss	%xmm1, 24(%rbp)
/APP
 # 26 "float_operations.c" 1
	fld 16(%rbp)
fld 24(%rbp)
faddp
fstp -4(%rbp)
 # 0 "" 2
/NO_APP
	movss	-4(%rbp), %xmm0
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	getFloatAsmMult
	.def	getFloatAsmMult;	.scl	2;	.type	32;	.endef
	.seh_proc	getFloatAsmMult
getFloatAsmMult:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movss	%xmm0, 16(%rbp)
	movss	%xmm1, 24(%rbp)
/APP
 # 42 "float_operations.c" 1
	fld 16(%rbp)
fld 24(%rbp)
fmulp
fstp -4(%rbp)
 # 0 "" 2
/NO_APP
	movss	-4(%rbp), %xmm0
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	getFloatFuncTime
	.def	getFloatFuncTime;	.scl	2;	.type	32;	.endef
	.seh_proc	getFloatFuncTime
getFloatFuncTime:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movss	%xmm0, 16(%rbp)
	movss	%xmm1, 24(%rbp)
	movq	%r8, 32(%rbp)
	call	clock
	movl	%eax, -12(%rbp)
	movq	$0, -8(%rbp)
	jmp	.L14
.L15:
	movss	24(%rbp), %xmm0
	movq	32(%rbp), %rax
	movaps	%xmm0, %xmm1
	movss	16(%rbp), %xmm0
	call	*%rax
	addq	$1, -8(%rbp)
.L14:
	cmpq	$999999, -8(%rbp)
	jbe	.L15
	call	clock
	movl	%eax, -16(%rbp)
	movl	-16(%rbp), %eax
	subl	-12(%rbp), %eax
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%eax, %xmm0
	movsd	.LC0(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	.LC1(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	movq	%rax, %xmm0
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC4:
	.ascii "\12\12----------------FLOAT----------------\12\0"
.LC5:
	.ascii "Size:     %9d bit\12\0"
	.align 8
.LC6:
	.ascii "----------------sum----------------\12\0"
.LC7:
	.ascii "C     %9.4g s   res = %g\12\0"
.LC8:
	.ascii "ASM   %9.4g s   res = %g\12\0"
	.align 8
.LC11:
	.ascii "----------------mult----------------\12\0"
.LC12:
	.ascii "C    %9.4g s   res = %g\12\0"
.LC13:
	.ascii "ASM  %9.4g s   res = %g\12\0"
	.text
	.globl	printFloatCharacteristics
	.def	printFloatCharacteristics;	.scl	2;	.type	32;	.endef
	.seh_proc	printFloatCharacteristics
printFloatCharacteristics:
	pushq	%rbp
	.seh_pushreg	%rbp
	subq	$64, %rsp
	.seh_stackalloc	64
	leaq	48(%rsp), %rbp
	.seh_setframe	%rbp, 48
	movaps	%xmm6, 0(%rbp)
	.seh_savexmm	%xmm6, 48
	.seh_endprologue
	movss	.LC2(%rip), %xmm0
	movss	%xmm0, -4(%rbp)
	movss	.LC3(%rip), %xmm0
	movss	%xmm0, -8(%rbp)
	leaq	.LC4(%rip), %rcx
	call	printf
	call	getFloatSize
	movl	%eax, %edx
	leaq	.LC5(%rip), %rcx
	call	printf
	leaq	.LC6(%rip), %rcx
	call	printf
	movss	-8(%rbp), %xmm0
	movl	-4(%rbp), %eax
	movaps	%xmm0, %xmm1
	movd	%eax, %xmm0
	call	getFloatCSum
	pxor	%xmm6, %xmm6
	cvtss2sd	%xmm0, %xmm6
	movss	-8(%rbp), %xmm0
	movl	-4(%rbp), %eax
	leaq	getFloatCSum(%rip), %r8
	movaps	%xmm0, %xmm1
	movd	%eax, %xmm0
	call	getFloatFuncTime
	movq	%xmm0, %rdx
	movq	%xmm6, %rax
	movq	%rax, %rcx
	movq	%rcx, %xmm1
	movq	%rax, %rcx
	movq	%rdx, %rax
	movq	%rax, %rdx
	movq	%rdx, %xmm0
	movapd	%xmm1, %xmm2
	movq	%rcx, %r8
	movapd	%xmm0, %xmm1
	movq	%rax, %rdx
	leaq	.LC7(%rip), %rcx
	call	printf
	movss	-8(%rbp), %xmm0
	movl	-4(%rbp), %eax
	movaps	%xmm0, %xmm1
	movd	%eax, %xmm0
	call	getFloatAsmSum
	pxor	%xmm6, %xmm6
	cvtss2sd	%xmm0, %xmm6
	movss	-8(%rbp), %xmm0
	movl	-4(%rbp), %eax
	leaq	getFloatAsmSum(%rip), %r8
	movaps	%xmm0, %xmm1
	movd	%eax, %xmm0
	call	getFloatFuncTime
	movq	%xmm0, %rdx
	movq	%xmm6, %rax
	movq	%rax, %rcx
	movq	%rcx, %xmm1
	movq	%rax, %rcx
	movq	%rdx, %rax
	movq	%rax, %rdx
	movq	%rdx, %xmm0
	movapd	%xmm1, %xmm2
	movq	%rcx, %r8
	movapd	%xmm0, %xmm1
	movq	%rax, %rdx
	leaq	.LC8(%rip), %rcx
	call	printf
	movss	.LC9(%rip), %xmm0
	movss	%xmm0, -4(%rbp)
	movss	.LC10(%rip), %xmm0
	movss	%xmm0, -8(%rbp)
	leaq	.LC11(%rip), %rcx
	call	printf
	movss	-8(%rbp), %xmm0
	movl	-4(%rbp), %eax
	movaps	%xmm0, %xmm1
	movd	%eax, %xmm0
	call	getFloatCMult
	pxor	%xmm6, %xmm6
	cvtss2sd	%xmm0, %xmm6
	movss	-8(%rbp), %xmm0
	movl	-4(%rbp), %eax
	leaq	getFloatCMult(%rip), %r8
	movaps	%xmm0, %xmm1
	movd	%eax, %xmm0
	call	getFloatFuncTime
	movq	%xmm0, %rdx
	movq	%xmm6, %rax
	movq	%rax, %rcx
	movq	%rcx, %xmm1
	movq	%rax, %rcx
	movq	%rdx, %rax
	movq	%rax, %rdx
	movq	%rdx, %xmm0
	movapd	%xmm1, %xmm2
	movq	%rcx, %r8
	movapd	%xmm0, %xmm1
	movq	%rax, %rdx
	leaq	.LC12(%rip), %rcx
	call	printf
	movss	-8(%rbp), %xmm0
	movl	-4(%rbp), %eax
	movaps	%xmm0, %xmm1
	movd	%eax, %xmm0
	call	getFloatAsmMult
	pxor	%xmm6, %xmm6
	cvtss2sd	%xmm0, %xmm6
	movss	-8(%rbp), %xmm0
	movl	-4(%rbp), %eax
	leaq	getFloatAsmMult(%rip), %r8
	movaps	%xmm0, %xmm1
	movd	%eax, %xmm0
	call	getFloatFuncTime
	movq	%xmm0, %rdx
	movq	%xmm6, %rax
	movq	%rax, %rcx
	movq	%rcx, %xmm1
	movq	%rax, %rcx
	movq	%rdx, %rax
	movq	%rax, %rdx
	movq	%rdx, %xmm0
	movapd	%xmm1, %xmm2
	movq	%rcx, %r8
	movapd	%xmm0, %xmm1
	movq	%rax, %rdx
	leaq	.LC13(%rip), %rcx
	call	printf
	nop
	movaps	0(%rbp), %xmm6
	addq	$64, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC0:
	.long	0
	.long	1083129856
	.align 8
.LC1:
	.long	0
	.long	1093567616
	.align 4
.LC2:
	.long	2133657700
	.align 4
.LC3:
	.long	2124776053
	.align 4
.LC9:
	.long	1604294709
	.align 4
.LC10:
	.long	1595451354
	.ident	"GCC: (Rev5, Built by MSYS2 project) 10.3.0"
	.def	__mingw_vfprintf;	.scl	2;	.type	32;	.endef
	.def	clock;	.scl	2;	.type	32;	.endef
