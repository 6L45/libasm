#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

typedef struct	s_list
{
	void *data;
	struct s_list *next;
}		t_list;

int	ft_atoi_base(char *str, char *base);

int	main(int argc, char **argv)
{
	printf("%d\n", ft_atoi_base("dsfgsdfg", "acvedf"));

	return (0);
}

