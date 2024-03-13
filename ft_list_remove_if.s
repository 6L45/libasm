SECTION	.text
	GLOBAL	ft_list_remove_if

; rdi => 1rst arg	rdi => **t_list
; rsi => 2nd arg	rsi => *data_ref
; rdx => 3rd arg	rdx => (*cmp)()
; rcx => 4th arg	rcx => (*free)()
ft_list_remove_if:
	cmp	rdi, 0x0	;	|
	je	quit		;	|
				;	|
	mov	r15, [rdi]	;	|
	cmp	r15, 0x0	;	|
	je	quit		;	|
				;	|
	cmp	rsi, 0x0	;	| if (!begin_list || !(*begin_list)
	je	quit		;	|	 || !data_ref || !cmp || !free_fct)
				;	|	goto(quit)
	cmp	rdx, 0x0	;	|
	je	quit		;	|
				;	|
	cmp	rcx, 0x0	;	|
	je	quit		;	|

	sub	rsp, 0x10

	mov	[rbp - 0x10], rdi	; rbp - 0x10 = **rdi
	mov	[rbp - 0x08], rsi	; rbp - 0x8 = *data_ref

	mov	r15, [rdi]	; r15 = *rdi		// iterator
	mov	r14, 0x0	; r14 = NULL		// prev
	mov	r13, rcx	; r13 = free()
	mov	r12, rdx	; r12 = cmp
	mov	r11, [rdi]	; r11 = *rdi		// begining of the list pointer

	loop:
		cmp	r15, 0x0			; while (r15)
		je	quit				; {

		mov	rdi, [r15]			;	|
		mov	rsi, QWORD [rbp - 0x8]		;	| eax = cmp(r15->data, data_ref)
		call	r12				;	|
		cmp	eax, 0x0			;	if (!eax)
		je	remove				;		goto(remove)
							;	else {
		mov	r14, r15			;		r14 = r15
		mov	r15, [r15 + 0x8]		;		r15 = r15->next 
							;	}
		jmp	loop				; }

		remove:					;---REMOVE			
			cmp	r14, 0X0
			je	no_prev

			mov	r8, [r15 + 0x8]		; r8 = r15->next
			mov	[r14 + 0x8], r8		; prev->next = r15->next

			mov	rdi, r15		;
			call	r13			; free(r15)

			mov	r8, [r14 + 0x8]		; r8 = r14->next
			mov	r15, r8			; r15 = prev->next

			jmp	loop

			no_prev:				;--- NO PREV
				mov	r15, [r15 + 0x8]	; r15 = r15->next
				cmp	r15, 0x0		; if (!r15)
				je	only_node		;	goto(only_node)

				mov	rdi, r11		; rdi = r11	// *rdi[0]
				call	r13			; free(r12)
				mov	r11, r15		; r11 = r15	// reinit pointer[0]
				mov	r8, [rbp - 0x10]
				mov	[r8], r11
				jmp	loop

				only_node:
					mov	rdi, r11		;
					call	r13			; free(r15)
					mov	r11, [rbp - 0x10]	; r11 = **rdi
					mov	QWORD [r11], 0x0

	quit:
		add	rsp, 0x10
		ret
