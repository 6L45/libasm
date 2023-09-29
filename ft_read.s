SECTION .text
	GLOBAL ft_read
	extern	__errno_location


ft_read:
	; PROLOGUE
	push	rbp
	mov	rbp, rsp
	; ------------------------

	mov	rax, 0
	syscall

	cmp	rax, 0
	jge	quit

	neg	rax
	mov	rdi, rax
	call __errno_location	WRT ..plt

	mov	[rax], rdi
	mov	rax, -0x1

	quit:
	; EPILOGUE
	mov	rsp, rbp
	pop	rbp
	ret
	; ------------------------
