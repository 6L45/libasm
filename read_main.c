#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>

ssize_t	ft_read(int fd, char *buffer, size_t count);

int	main()
{
	int fd = open("ft_write.s", O_RDONLY);
	if (fd < 0){
		perror("open failed");
		return (1);
	}

	char	buffer[4096];
	int	len = ft_read(fd, buffer, 4096);
	printf("len = %d\n\n", len);
	buffer[len] = 0;
	printf("%s\n", buffer);

	len = ft_read(7, buffer, 4096);
	if (len < 0)
	{
		printf("errno = %d\n", errno);
		return (1);
	}

	return (0);
}

