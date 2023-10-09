SECTION	.text
	GLOBAL	ft_list_push_front

ft_list_push_front:
	push	rbp
	mov	rbp, rsp
	
	mov	rsp, rbp
	pop	rbp
