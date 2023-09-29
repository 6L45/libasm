SECTION .text
	GLOBAL ft_strcpy

ft_strcpy:
	; PROLOGUE
	push	rbp
	mov	rbp, rsp
	; ------------------------

	xor	rcx, rcx	; xor => eXclusif OR 
	; a xor b => res
	;-----------------
	; 0  -  0 =>  0
	; 0  -  1 =>  1		so xor on itself => rcx = 0
	; 1  -  0 =>  1
	; 1  -  1 =>  0

	loop:
		cmp	BYTE [rsi + rcx], 0	; if (str2[rcx] == '\0')
		je	exit				;	goto(exit)

		; str1[rcx] = str2[rcx]
		mov	al, BYTE [rsi + rcx]	; mov BYTE [rdi + rcx], BYTE [rsi + rcx] doesn't work
		mov	BYTE [rdi + rcx], al	; so al extra-step

		inc rcx		; rcx++
		jmp loop	; goto(loop)

	exit:
		mov	BYTE [rdi + rcx], 0
		mov	rax, rdi

	; EPILOGUE
	mov	rsp, rbp
	pop	rbp
	ret
	; ------------------------
