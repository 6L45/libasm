#include <stdio.h>
#include <string.h>

int	ft_strcmp(char *str1, char *str2);

int	main(int argc, char **argv)
{
	if (argc < 3)
		return (1);

	printf("%d\n", ft_strcmp(argv[1], argv[2]));
	printf("%d\n", strcmp(argv[1], argv[2]));

	return (0);
}

