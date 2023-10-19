#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <iostream>
#include <vector>
#include <cstring>

typedef struct	s_list
{
	void *data;
	struct s_list *next;
}		t_list;

extern	"C" {
	int	ft_atoi_base(char *str, char *base);
	void    ft_list_push_front(t_list **alst, void *data);
	int     ft_list_size(t_list *lst);
	int     ft_list_sort(t_list **begin_list, int (*cmp)(const char *str1, const char *s2));
	void    ft_list_remove_if(t_list **begin_list, void *data_ref,
					int (*cmp)(const char *s1, const char *s2),
					void (*free_fct)(void *));
}

int	main(int argc, char **argv)
{
	std::string	input1;
	std::string	input2;

	if (argc > 1)
	{
		if (!strcmp(argv[1], "list"))
			goto here;
	}

	std::cout << "ATOI" << std::endl
		<< "enter : [value], [base]" << std::endl
		<< "or enter \"next\" for next test" << std::endl;
	while (true)
	{
		std::cout << "--- ATOI ---" << std::endl
			<< "enter value to convert: ";
		std::cin >> input1;
		if (std::cin.eof())
			exit(0);
		if (!input1.compare("next"))
			break;

		std::cout << "enter base : ";
		std::cin >> input2;
		std::cout << std::endl;

		printf("\nresult: %d\n\n",ft_atoi_base(const_cast<char *>(input1.c_str()),
					const_cast<char *>(input2.c_str())));
		std::cout << std::endl;

		input1.clear();
		input2.clear();
	}
	input1.clear();
	input2.clear();

here:

	std::cout << std::endl<< std::endl << "--- LISTS ---" << std::endl;
	std::cout << "enter : words" << std::endl
		<< "enter \"ok\" to launch the test"
		<< "or enter \"next\" to leave" << std::endl
		<< std::endl
		<< "KEY word for erase if is : \"math\"" << std::endl;

	std::vector<std::string>	word_list;
	while (true)
	{
		std::cin >> input1;

		if (std::cin.eof())
			exit(0);
		if (!input1.compare("next"))
			break;
		if (!input1.compare("ok"))
		{
			std::cout << std::endl;
			std::cout << "**[List by entry order]**" << std::endl;
			t_list	*lst = NULL;
			for (std::vector<std::string>::iterator it = word_list.begin();
					it != word_list.end(); it++)
			{
				std::cout << *it << std::endl;

				ft_list_push_front(&lst,
						static_cast<void *>
							(const_cast<char *>
							 	((*it).c_str())));
			}

			// PUSH FRONT
			std::cout << std::endl << std::endl
				<< "**[Init list with push front result]**" << std::endl;
			{
				t_list  *tmp = lst;
				while (tmp)
				{
					printf("%s\n", (char *)tmp->data);
					tmp = tmp->next;
				}
			}

			// LIST_SIZE
			printf("\nft_list_size = [%d]\n", ft_list_size(lst));
			std::cout << std::endl << std::endl;

			// LIST REMOVE IF
			ft_list_remove_if(&lst, static_cast<void *>(const_cast<char *>("math")),
				strcmp, free);
			if (!lst)
			{
				std::cout << "List empty" << std::endl;
			}
			else
			{
				std::cout << "**[List after remove_if]**" << std::endl;
				{
					t_list  *tmp = lst;
					while (tmp)
					{
						printf("%s\n", (char *)tmp->data);
						tmp = tmp->next;
					}
				}
				std::cout << std::endl << std::endl;
				// LIST SORT
				ft_list_sort(&lst, strcmp);
				std::cout << "**[List after sort]**" << std::endl;
				{
					t_list  *tmp = lst;
					while (lst)
					{
						printf("%s\n", (char *)lst->data);
						tmp = lst->next;
						free(lst);
						lst = tmp;
					}
				}
			}
			std::cout << std::endl << std::endl << std::endl;
			std::cout << "--- LISTS ---" << std::endl;
			word_list.clear();
		}
		else
		{
			std::cout << "added  -> " << '[' << input1 << ']' << std::endl;
			word_list.push_back(input1);
		}

		input1.clear();
	}

	return (0);
}
