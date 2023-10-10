SECTION	.text
	GLOBAL	ft_list_sort
	extern	ft_list_size

get_node:
	push	rbp
	mov	rbp, rsp

	xor	r13, r13			; r13 = 0
	mov	rcx, rdi			; rcx = rdi // (lst)

	while_i_less_than:			; while (r13 < rsi)
		cmp	r13, rsi		; {
		jge	get_Node_Quit

		mov	rcx, [rcx + 0x8]	;	rcx = rcx->next
		inc	r13			;	r13++
		jmp	while_i_less_than	; }
	
	get_Node_Quit:
		mov	rax, rcx		; rax = r13
		mov	rsp, rbp
		pop	rbp

	ret					; quit (rax)

ft_list_sort:

	; RECAP VARS ---------------------
	;
	; iterators:
	; r8
	; r10
	; r13
	;
	; other:
	; rbx	=>	list copy from 1rst param // (simple pointer)
	; rdx	=>	function pointer
	; r12	=>	len(list) - 1
	; r14	=>	index node placeholder
	; r15	=>	tmp swap

	mov	r8, 0x1					; r8			// = i
	xor	r10, r10				; r10 			// = j

	mov	rdx, rsi				; rdx = *(cmp)()
	mov	rbx, rdi					; rbx = rdi
	cmp	QWORD [rbx], 0				; if (!rbx)		// **t_list
	je	quit					; 	goto(quit)
	mov	rbx, [rbx]				; rbx = *rbx
	cmp	QWORD [rbx], 0				; if (!rbx)		// *t_list
	je	quit					; 	quit

	push	rdi
	mov	rdi, rbx

	call ft_list_size
	lea	r12, [rax - 0x1]			; r12 = len(lst)

	loop_1:
		cmp	r8, r12				; while (r8 < r12)
		jge	quit				; {
	
		mov	r10, r8				; 	r10 = r8	// j = i
		loop_2:					;	while (r10 > 0 && strcmp(list[j - 1]->data, list[j]->data) > 0)
			cmp	r10, 0x1		;	{                 \_____________________________________________
			jl	loop_1_inc		;									|
							;									|
			xor	r14, r14		;		r14 = 0							|
			mov	rdi, rbx		;		rdi = rbx // (list)					|
							;									|
			lea	r14, [r10 - 0x1]	;		r14 = r10 - 1	|					|
			mov	rsi, r14		;		rsi = r14	| rdi = get_node(rbx, r14)		| that condition
			call	get_node		;				|					| correspond
			mov	rdi, rax		;		rdi = [rax]	|					| to that part
							;									|
			mov	rdi, rbx		;		rdi = rbx // (list)					|
			mov	rsi, r10		;		rsi = r10	|					|
			call	get_node		;				| rsi = get_node(rbx, r10)		|
			mov	rsi, rax		;		rsi = [rax]	|					|
							;									|
			push	rdx			;									|
			call	rdx			;		rax = int (*cmp)(rdi, rsi) 				|
			pop	rdx			;									|
							;									|
			cmp	rax, 0x0		;		if (rax <= 0)			<-----------------------| here
			jle	loop_1_inc		;		      goto(loop_1_inc)
	
			; swap shenaningan
			mov	r15, [rsi + 0x8]	;		r15 = rsi->next		// tmp = list[j]->next
			mov	[rsi + 0x8], rdi	;		rsi->next = rdi		// list[j]->next = list[j - 1]
			mov	[rdi + 0x8], r15	;		rdi->next = r15		// list[j - 1]->next = tmp 	// (list[j]->next)
	
			cmp	r14, 0x0		;		if (r10 == 1)
			jne	loop2_inc		;			*rbx = rsi	// lst = list[j]
			mov	[rbx], rdi		;
			loop2_inc:			;		r10--
				dec	r10		;	}
							; }
	loop_1_inc:
		inc	r8
		jmp	loop_1
			
	quit:
		pop	rdi
		mov	rax, [rdi]			; rax = rdi
		mov	rax, rbx			; *rax = rbx

	leave	
	ret
