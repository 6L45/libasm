global ft_strdup
extern malloc
extern ft_strlen
extern ft_strcpy
extern __errno_location

ft_strdup:
	call ft_strlen

	push	rdi
	lea	rdi, [rax + 0x1]
	call malloc	WRT ..plt
	test	rax, rax
	je	err

	mov	rdi, rax
	pop	rsi
	call ft_strcpy

	ret

	err:
		neg	rax
		mov	rdi, rax
		call __errno_location	WRT ..plt
		mov	[rax], rdi
		mov	rax, 0xc

		ret
