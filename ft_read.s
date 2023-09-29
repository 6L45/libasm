SECTION .text
	GLOBAL ft_read
	extern	__errno_location


ft_read:
	; PROLOGUE
	push	rbp
	mov	rbp, rsp
	; ------------------------

	mov	rax, 0	; set rax for sys_read
	syscall

	cmp	rax, 0	; if (rax == 0)
	jge	quit	;	goto(quit)

	neg	rax		; rax *= -1
	mov	rdi, rax
	call __errno_location	WRT ..plt	; return a pointer to errno in rax

	mov	[rax], rdi	; *errno = rdi
	mov	rax, -0x1

	quit:
	; EPILOGUE
	mov	rsp, rbp
	pop	rbp
	ret
	; ------------------------
