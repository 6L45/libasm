#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

size_t	ft_strlen(char *str);
char	*ft_strcpy(char *dest, char *src);
int	ft_strcmp(char *str1, char *str2);
size_t	ft_write(int fd, char *str, size_t count);
ssize_t	ft_read(int fd, char *buffer, size_t count);
char	*ft_strdup(char *src);

int	main(int argc, char **argv)
{
	if (argc < 3) {
		printf("please provide 2 arguments (len argv[1] larger or equal than len argv[2])\n");
		return (1);
	}
	
	printf("STRLEN argv[1] ------------\n");
	printf("%ld\n", ft_strlen(argv[1]));
	printf("---------------------------\n\n");
 
	printf("WRITE argv[1] -------------\n");
	ft_write(1, argv[1], strlen(argv[1]));
	putchar('\n');
	printf("---------------------------\n\n");

	if (ft_strlen(argv[1]) < ft_strlen(argv[2])){
		printf("the size doesn't matter, it s about the quality of the text... BUT! argv[1] si shorter than argv[2]\n");
		return (1);
	}

	printf("STRCMP(argv[1], argv[2]) --\n");
	printf("ft_strcmp = %d\n", ft_strcmp(argv[1], argv[2]));
	printf("strcmp    = %d\n", strcmp(argv[1], argv[2]));
	printf("---------------------------\n\n");


	printf("STRCPY(argv[1], argv[2]) --\n");
	printf("before : %s\n", argv[1]);
	printf("return : %s\n", ft_strcpy(argv[1], argv[2]));
	printf("after : %s\n", argv[1]);
	printf("---------------------------\n\n");


	int fd = open("ft_read.s", O_RDONLY);
	if (fd < 0){
		perror("open failed");
		return (1);
	}

	printf("READ  ---------------------\n");
	char	buffer[4096];
	int	len = ft_read(fd, buffer, 4096);
	printf("len = %d\n\n", len);
	buffer[len] = 0;
	printf("%s\n", buffer);

	len = ft_read(7, buffer, 4096);
	if (len < 0) {
		printf("wrong fd:\n");
		printf("return = %d\n", len);
		printf("errno = %d\n", errno);
	}

	close(fd);
	printf("---------------------------\n\n");
	
	printf("STRDUP ARGV[1] -------------\n");
	char *buf;

	buf = ft_strdup(argv[1]);
	printf("%s\n", buf);
	free(buf);
	printf("---------------------------\n\n");

	return (0);
}
