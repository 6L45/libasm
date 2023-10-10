SECTION	.text
	GLOBAL	ft_list_sort

ft_list_sort:
	cmp	rdi, 0x0			;
	je	quit				; if (!rdi || !rsi)
	cmp	rsi, 0x0			;	goto(quit)
	je	quit				;

	mov	r10, rsi			; r10 = rsi	// function pointer
	mov	r8, [rdi]			; r8 = *rdi	// *t_list
	mov	r14, [rdi]			; r14 = *rdi	// idem

	cmp	r8, 0x0				; if (!(*rdi))
	je	quit				;	goto(quit)

	; RECAP VARS
	; r8			=>	*rdi ->	iterator
	; r14			=>	*rdi ->	reminder
	; r10			=>	rsi	
	; r12	rdi->next
	loop:
		mov	r12, [r8 + 0x8]			; while (list->next)
		cmp	r12, 0x0			; {
		je	quit				;

		mov	rdi, [r8]			;	|
		mov	rsi, [r12]			;	| rax = strcmp(*r8, *r12)
		call	r10				;	|	// strcmp(list->data, list->next->data)
		cmp	eax, 0x0			;	if (rax < 0)
		jg	swap_data			;

		mov	r8, [r8 + 0x8]			;		r8 = r8->next
		jmp	loop

		swap_data:				;	  else {
			mov	rax, [r8]		;		tmp = r8->data
			mov	rcx, [r12]		;
			mov	[r8], rcx		;		r8->data = r12->data
			mov	[r12], rax		;		r12->data = tmp

			mov	r8, r14			;
							;	  }
			jmp	loop			; }

	quit:
		leave
		ret
