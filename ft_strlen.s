SECTION .text
	GLOBAL	ft_strlen

ft_strlen:
	; PROLOGUE
	push	rbp
	mov	rbp, rsp
	; ------------------------

	xor	rax, rax

	loop:
		cmp	BYTE [rdi + rax], 0	; if (str[rcx] == '\0')
		je	quit			;	goto(quit)
		inc	rax			; rax++

		jmp	loop 			; goto(loop)

	quit:
	; EPILOGUE
		mov	rsp, rbp
		pop	rbp
		ret
	; ------------------------
