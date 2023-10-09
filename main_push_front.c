#include <stdio.h>
#include <stdlib.h>
#include "../libft/libft.h"

/*
typedef struct s_list
{
	void *data;
	struct s_list *next;
}	t_list;
*/

int	ft_list_push_front(t_list **alst, t_list *new);
int	ft_list_size(t_list *lst);

int	main(int argc, char **argv)
{
	t_list	*lst = NULL;

	for (int i = 1; i < argc; i++)
	{
		ft_list_push_front(&lst, ft_lstnew(argv[i]));
	}


	t_list	*tmp = lst;
	while (lst)
	{
		printf("%s\n", (char *)lst->content);
		tmp = lst->next;
		free(lst);
		lst = tmp;
	}

	return (0);
}

