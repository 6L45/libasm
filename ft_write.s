SECTION .text
	GLOBAL ft_write
	extern	__errno_location


ft_write:
	; PROLOGUE
	push	rbp
	mov	rbp, rsp
	; ------------------------

	mov	rax, 1
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
