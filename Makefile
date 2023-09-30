NAME	= libasm.a

CC	= gcc

ASM	= nasm

FLAGS	= -Wall -Werror -Wextra

LINK	= -L. -lasm

ASMFLG	= -f elf64

SRCS	= ft_strlen.s\
	  ft_strcpy.s\
	  ft_strcmp.s\
	  ft_write.s\
	  ft_read.s\
	  ft_strdup.s\

OBJS    = ${SRCS:.s=.o}


TSTNAME	= try
MAIN	= main.c


%.o:  %.s
	$(ASM) $(ASMFLG) $< -o $(<:.s=.o)

$(NAME): $(OBJS)
	ar rc $(NAME) $(OBJS)

all: $(NAME)

clean:
	rm -f $(OBJS)

fclean: clean
	rm -f $(NAME)
	rm -f $(TSTNAME)

re: fclean all

test: all
	$(CC) $(FLAGS) $(MAIN) $(LINK) -o $(TSTNAME)

.PHONY: all clean fclean re test
