#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char	*ft_strdup(char *src);

int	main(int argc, char **argv)
{
	if (argc < 2)
		return (1);

	char *buf;

	buf = ft_strdup(argv[1]);
	printf("%s\n", buf);
	free(buf);

	return (0);
}

