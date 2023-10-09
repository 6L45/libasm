SECTION	.text
	GLOBAL	ft_list_push_front

ft_list_push_front:
	push	rbp
	mov	rbp, rsp

	mov	QWORD [rbp - 0x18], rdi
	mov	QWORD [rbp - 0x20], rsi

	mov    rax, QWORD [rbp - 0x18]
	mov    rax, QWORD [rax]
	mov    QWORD [rbp - 0x8], rax
	mov    rax, QWORD [rbp - 0x20]
	mov    rdx, QWORD [rbp - 0x8]
	mov    QWORD [rax + 0x8], rdx
	mov    rax, QWORD [rbp - 0x18]
	mov    rdx, QWORD [rbp - 0x20]
	mov    QWORD [rax], rdx
	nop
	
	mov	rsp, rbp
	pop	rbp
