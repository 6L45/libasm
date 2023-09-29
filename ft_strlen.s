SECTION .text
	GLOBAL	ft_strlen

ft_strlen:
	; PROLOGUE
	push	rbp
	mov	rbp, rsp
	; ------------------------

	xor	rax, rax

	loop:
		cmp	BYTE [rdi + rax], 0
		je	quit
		inc	rax

		jmp	loop

	quit:
	; EPILOGUE
		mov	rsp, rbp
		pop	rbp
		ret
	; ------------------------
