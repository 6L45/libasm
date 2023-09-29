global ft_strdup
extern malloc
extern ft_strlen
extern ft_strcpy
extern __errno_location

ft_strdup:
	call ft_strlen

	push	rdi			; copy rdi value on the stack
	lea	rdi, [rax + 0x1]	; lea = Load Effective Address -> rdi = *rax + 1 / = inc rax + mov rdi, rax
	call malloc	WRT ..plt
	test	rax, rax		; Binary AND
	; a and b => res
	;-----------------
	; 0  -  0 =>  0
	; 0  -  1 =>  0		used to test if register tested is null
	; 1  -  0 =>  0
	; 1  -  1 =>  1
	je	err			; je = Jump if Equal => after test jump is zero (could also use jz (Jump if Zero))

	mov	rdi, rax
	pop	rsi			; get back rdi value from stack
	call ft_strcpy

	ret

	err:
		neg	rax				; rax *= -1
		mov	rdi, rax
		call __errno_location	WRT ..plt	; return a pointer to errno in rax
		mov	[rax], 0xc			; *rax = 12	=> code errno = 12 = ENOMEM
		mov	rax, 0x0			; rax = 0

		ret
