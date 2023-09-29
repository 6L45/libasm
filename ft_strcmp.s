SECTION .text
	GLOBAL	ft_strcmp

ft_strcmp:
	; PROLOGUE
	push	rbp
	mov	rbp, rsp
	; ------------------------

	xor	rcx, rcx
	xor	rax, rax

	loop:
		cmp	BYTE [rdi + rcx], 0
		je	quit
		cmp	BYTE [rsi + rcx], 0
		je	quit

		mov	al, BYTE[rsi + rcx]
		cmp	BYTE [rdi + rcx], al
		jne	quit

		inc	rcx
		jmp	loop
	quit:
		movzx	rax, BYTE [rdi + rcx]
		movzx	r8, BYTE [rsi + rcx]
		sub	rax, r8
	
	; EPILOGUE
	mov	rsp, rbp
	pop	rbp
	ret
	; ------------------------
