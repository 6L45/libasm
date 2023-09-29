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
		; BYTE technically useless that's mostly for reader| Byte -> 0000 0000 = 0 - 256 = char
		cmp	BYTE [rdi + rcx], 0	; if (str1[rcx]  == '\0')
		je	quit				;	goto(quit)
		cmp	BYTE [rsi + rcx], 0	; if (str2[rcx]  == '\0')
		je	quit				;	goto(quit)

		mov	al, BYTE[rsi + rcx]		; can't directly
		cmp	BYTE [rdi + rcx], al	; cmp BYTE [rsi + rcx], BYTE [rdi + rcx] so 'al' register extra-step
		jne	quit	; jne = Jump Not Equal, so => if (cmp !=) goto(quit)

		inc	rcx		; rcx++
		jmp	loop	; goto(loop)
	quit:
		movzx	rax, BYTE [rdi + rcx]	; rax/r8 = 0000 0000 0000 0000 0000 0000 0000 0000 BYTE =  0000 0000 
		movzx	r8, BYTE [rsi + rcx]	; so to copy byte in rax and being sure we got no issue movzx fill every bit ober BYTE (8bit) wit 0
		sub	rax, r8
	
	; EPILOGUE
	mov	rsp, rbp
	pop	rbp
	ret
	; ------------------------
