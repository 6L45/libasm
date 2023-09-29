SECTION .text
	GLOBAL ft_strcpy

ft_strcpy:
	; PROLOGUE
	push	rbp
	mov	rbp, rsp
	; ------------------------

	xor	rcx, rcx

	loop:
		cmp	BYTE [rsi + rcx], 0
		je	exit

		mov	al, BYTE [rsi + rcx]
		mov	BYTE [rdi + rcx], al

		inc rcx
		jmp loop

	exit:
		mov	BYTE [rdi + rcx], 0
		mov	rax, rdi

	; EPILOGUE
	mov	rsp, rbp
	pop	rbp
	ret
	; ------------------------
