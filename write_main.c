#include <stdio.h>
#include <string.h>

size_t	ft_write(int fd, char *str, size_t count);

int	main(int argc, char **argv)
{
	if (argc < 2)
		return (1);

	ft_write(1, argv[1], strlen(argv[1]));
	putchar('\n');

	return (0);
}
