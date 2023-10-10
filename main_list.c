#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct	s_list
{
	void		*data;
	struct s_list	*next;
}		t_list;

void	ft_list_push_front(t_list **alst, void *data);
int	ft_list_size(t_list *lst);
int	ft_list_sort(t_list **begin_list, int (*cmp)());
//void	ft_list_remove_if(t_list **begin_list, void *data_ref,
				//int (*cmp)(), void (*free_fct)(void *));

int	main(int argc, char **argv)
{
	t_list	*lst = NULL;

	for (int i = 1; i < argc; i++)
	{
		ft_list_push_front(&lst, argv[i]);
	}

	int	len = ft_list_size(lst);
	printf("len = %d\n\n", len);

	{
		t_list	*tmp = lst;
		while (tmp)
		{
			printf("%s\n", (char *)tmp->data);
			tmp = tmp->next;
		}
	}

	ft_list_sort(&lst, strcmp);
	printf("\n");

	{
		t_list	*tmp = lst;
		while (lst)
		{
			printf("%s\n", (char *)lst->data);
			tmp = lst->next;
			free(lst);
			lst = tmp;
		}
	}

	return (0);
}

