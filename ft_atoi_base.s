SECTION	.text
	GLOBAL	ft_atoi_base

ft_atoi_base:
	; PROLOGUE
	push	rbp
	mov	rbp, rsp
	;-------------------------------

	sub	rsp, 0x40					; add space on stack for variables

; EMPTY CHECKER ------------------------------------
	test	rdi, rdi					; if (!rdi || !rsi)
	je	err						;	goto(err)
	test	rsi, rsi
	je	err

; DUPLICATE CHECKER --------------------------------
	xor	r10, r10					; r10 = 0

	; Looping into base (rsi)
	; For every charac in rsi we compare it
	; with every remaining charac
	str2_parsing_loop:
		cmp	BYTE [rsi + r10], 0			; while (rsi[r10])
		je	out_str2_parsing			; {

		mov	al, BYTE [rsi, r10]			;	al = rsi[r10]
		lea	r12, [r10 + 0x1]			;	r12 = r10 + 1

		charac_check:
			cmp	BYTE [rsi + r12], 0		;	while  (rsi[r12])
			je	inc_reloop			;	{

			cmp	al, BYTE [rsi + r12]		;		if (al == rsi[r12])
			je	err				;			goto(err)

			cmp	BYTE [rsi + r12], 0x20		;		if (rsi[r12] <= ' ')
			jle	err				;			goto(err)

			cmp BYTE [rsi + r12], 0x2B		;		if (rsi[r12] == '+')
			je	err				;			goto(err)

			cmp	BYTE [rsi + r12], 0x2D		;		if (rsi[r12] == '-')
			je	err				;			goto(err)

			inc	r12				;		r12++
			jmp	charac_check			;		goto(charac_check)

		inc_reloop:					;	r10++
			inc r10
			jmp	str2_parsing_loop		; }
	
	out_str2_parsing:
		cmp	r10, 0x1				; if (r10 <= 1)
		jle	err					;	goto(err)
; ------------------------------------------------------------------------------------


; PARSING ------------------------------------------
	mov	DWORD [rbp - 0x40], r10d			; int	len_base = r10
	mov	DWORD [rbp - 0x38], 0x0				; int	pos = 0
	mov	DWORD [rbp - 0x30], 0x0				; int	pow = 0
	mov	DWORD [rbp - 0x28], 0x0				; int	len_val = 0
	mov	BYTE [rbp - 0x24], 0x1				; short	sign = 1
	mov	BYTE [rbp - 0x20], 0x1				; bool	loop = true


	; NON PRINTABLE ---------------------------
	; We skip non printable character
	xor	r10, r10					; r10 = 0
	non_printable_loop:
		cmp	BYTE [rdi + r10], 0x20			; while (rdi[r10]) // rdi = base
		jg	non_printable_out			;	i++
		
		inc r10
		jmp non_printable_loop
	non_printable_out:
		nop
	; NON PRINTABLE ---------------------------


	; SIGN CHECKER ----------------------------
	; we advance through all '+'and '-'
	; and we init sign to -1 if there is a '-'
	sign_checker:						; while (rdi[r10] == '-' || rdi[r10] == '+') {
		cmp	BYTE [rdi + r10], 0x2D			;	if (rdi[r10] == '-')
		je	negatif					;		goto(negatif)

		cmp	BYTE [rdi + r10], 0x2B			;	if (rdi[r10] != '+')
		jne	sign_checker_out			;		goto(sign_checker_out)
		jmp	sign_check_loop				;	else
								;		r10++
								; }
	negatif:
		mov	BYTE [rbp - 0x24], -0x1			; sign = -1

	sign_check_loop:
		inc	r10					; r10++
		jmp	sign_checker

	sign_checker_out:
		nop
	; SIGN CHECKER ----------------------------


	; GET REAL LEN ----------------------------
	; check len of val
	; ex : "...++--[val (with char in base)]...(other char not in base)"
	;              |<    what we want.    >|
	mov	r12, r10
	real_val_len_loop:
		cmp	BYTE [rdi + r12], 0x0			; while (rdi[r12])
		je	real_val_len_loop_end			; {

		xor	r13, r13				;	r13 = 0
		movzx	rdx, BYTE [rdi + r12]			;	rdx = rdi[r12]
		is_in_base_loop:				;	while (true) {
			cmp	BYTE [rsi + r13], dl		;		if (rsi[r13] == rdi[r12])
			je	its_in				;			goto(its_in)

			inc	r13				;		r13++
			cmp	BYTE [rsi + r13], 0x0		;		if (rsi[r13] == '\0')
			je	real_val_len_loop_end		;			goto(real_val_len_loop) // break

			jmp	is_in_base_loop			;	}
		
			its_in:
				inc r12				;	r12++
				jmp	 real_val_len_loop	; }
	real_val_len_loop_end:
		dec	r12					; r12--
		sub	r12, r10				; r12 = r12 - r10
	; GET REAL LEN ----------------------------


; ------------------------------------------------------------------------------------


; FT_ATOI_BASE -------------------------------------
	; We loop in rdi
	; for each char we got the numéric equivalent in base

	; we multiply the position of the char by the len of the base
	; ex in hex 4cd3a -> for [4] = 16^4
	;                    for [c] = 16^3
	;                    for [d] = 16^2
	;                    for [3] = 16^1
	;                    for the last one we just add the number to the value
	; and finaly for every each one of those values but the last
	; we multiply by the associated valor in base before adding it to the final value to return


	; RECAP VARS: register / stack
	;
	; rax				; return value
	; DWORD [rbp - 0x40]		; len_base
	; DWORD [rbp - 0x38]		; pos (not used)
	; DWORD [rbp - 0x30]		; pow (not used yet)
	; DWORD [rbp - 0x28]		; len_val (not used)
	; BYTE [rbp - 0x24]		; sign
	; BYTE [rbp - 0x20]		; loop (not used)

	; rdi				; val
	; rsi				; base
	; r10				; pos in rdi (i)
	; r12				; len_val


	;NEW
	; r13				; itérator (j)
	; r14				; itérator for pow (k)
	; rdx				; char from val to compare
	; rbx				; final value to transfert to rax before leaving

	xor	rbx, rbx
	ft_atoi_base_loop:
		cmp	BYTE [rdi + r10], 0x0				; while (rdi[r10])
		je	return						; {

		movzx	rdx, BYTE [rdi + r10]				;	rdx = rdi[r10]
		xor	r13, r13					;	r13 = 0
		get_val_in_base:					;	while (rsi[r13) {
			cmp	[rsi + r13], dl				;		if (rsi[r13] == rdx) (dl is BYTE of rdx)
			je	pow					;			goto(pow)

			inc	r13					;		else r13++
			cmp	DWORD [rsi + r13], 0x0			;		if (!rdi[r13])
			je	return					;			return
									;	}
			jmp	get_val_in_base				;

		pow:
			cmp	r12, 0x0				; 	if (r12 == 0)
			jle	last_nbr				; 		goto(last_nbr)

			xor	rax, rax
			mov	DWORD [rbp - 0x30], 0x1			; 	pow = 1
			mov	eax, DWORD [rbp - 0x30]			;	rax = pow
			xor	r14, r14				; 	r14 = 0
			pow_loop:					; 	while (r14 < r12) {
				cmp	r14, r12			; 		if (r14 >= r12)
				jge	loop_inc			;			goto(loop_inc)

				mul	DWORD [rbp - 0x40]		; 		pow *= len_base
				inc	r14				;		r14++
				jmp	pow_loop			; 	}

		loop_inc:
			mul	r13					;	pow *= r13
			add	rbx, rax				; 	rbx += pow
			dec	r12					; 	r12--
			inc	r10					; 	r10++
			jmp	ft_atoi_base_loop			; }
		
	last_nbr:
		add	rbx, r13					; rax += r13
		jmp	return						; return (rax)
; ------------------------------------------------------------------------------------

	err:
		mov	rax, 0x0	; return (0)
		jmp	quit

	return:
		mov	rax, rbx	; return (rbx)

	movsx	rbx, BYTE [rbp -0x24]	; (movsx = mov to dest from src while conserving negative sign)
	mul	rbx			; rax *= sign

	quit:
		leave  			; EPILOGUE => mov	rsp, rbp
					;             pop	rbp
 	ret
