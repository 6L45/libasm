SECTION	.text
	GLOBAL	ft_list_push_front
	extern	malloc
	extern __errno_location


ft_create_elem:
	push	rdi			; rdi = data
	mov	rdi, 0x10		; sizeof(t_list) = 16
	call	malloc	WRT ..plt	
	test	rax, rax		; if (!malloc(16))
	je	mem_fail		;	goto(mem_fail)

	pop	rdi
	mov	[rax], rdi		; rax->data = rdi
	mov	QWORD [rax + 0x8], 0x0	; rax->ptr = NULL -> (sizeof ptr = 0x8)
					; so to skip data and access next => +0x8
	jmp	return
	
	mem_fail:
		neg	rax				; rax *= -1
		mov	rdi, rax
		call __errno_location	WRT ..plt	; return a pointer to errno in rax
		mov	qword [rax], 0xc		; *rax = 12	=> code errno = 12 = ENOMEM
		mov	rax, 0x0			; rax = 0

	return:
		ret


ft_list_push_front:
	cmp	rdi, 0			; if (!rdi || !rsi)
	je	err			;	goto(err)
	cmp	rsi, 0
	je	err

	push	rdi			; rdi -> stack
	mov	rdi, rsi		; rdi = rsi
	call	ft_create_elem		; call ft_create_elem above
	pop	rdi			; rdi (on stack) -> back to rdi
	cmp	rax, 0			; if (!ft_create_elem)
	je	err			;	goto(err)

	; INIT LIST -------
	cmp	QWORD [rdi], 0		; if (!rdi)
	je	init			;	goto(init)

	; ADD ELEMENT -----
	add_elem:
	mov	rdx, [rdi]		; rdx = *rdi
	mov	[rax + 0x8], rdx	; rax->next = rdx

	init:
		mov [rdi], rax		; *rdi = rax
		jmp	quit

	err:
		mov	rax, 0x0

	quit:
		ret
