SECTION	.text
	GLOBAL	ft_list_size

ft_list_size:
	push	rbp
	mov	rbp, rsp

	xor	rax, rax			; rax = 0
	loop:					; while (rdi) {
		cmp	rdi, 0x0		; 	if (!rid)
		je	return			;		return (rax)
						; 	else
		mov	rdi, [rdi + 0x8]	;		rdi = rdi->(+0x8)	// (pointer size = 0x8) to access next pointer after data (void *) +0x8
		add	rax, 0x1			; 	rax++
		jmp	loop			; }

	return:
	mov	rsp,  rbp
	pop	rbp

	ret
