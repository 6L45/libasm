#include <stdio.h>
#include <string.h>

char	*ft_strcpy(char *dest, char *src);

int	main(int argc, char **argv)
{
	if (argc < 3)
		return (1);

	printf("before : %s\n", argv[1]);
	printf("return : %s\n", ft_strcpy(argv[1], argv[2]));
	printf("after : %s\n", argv[1]);

	return (0);
}

