BASICNAME = libasm
BONUSNAME = libasm_bonus

# LIBS
NAME	= $(BASICNAME).a
BONUSN	= $(BONUSNAME).a

# COMPILER
CC	= gcc
CPP	= c++
ASM	= nasm

# FLAGS
ASMFLG	= -f elf64
LINK	= -L. -lasm
LINKB	= -L. -lasm_bonus
FLAGS	= -Wall -Werror -Wextra -z noexecstack

# SRCS FILES
SRCS	= ft_strlen.s\
	  ft_strcpy.s\
	  ft_strcmp.s\
	  ft_write.s\
	  ft_read.s\
	  ft_strdup.s
SRCPLUS	= ft_list_push_front.s\
	  ft_list_remove_if.s\
	  ft_list_size.s\
	  ft_list_sort.s\
	  ft_atoi_base.s

# OBJECT RULES
OBJS    = ${SRCS:.s=.o}
BONUS	= ${SRCPLUS:.s=.o}

# COMPILATION NAMES AND MAIN
TSTNAME	= $(BASICNAME)
TSTB	= $(BONUSNAME)
MAIN	= main.c
MAINB	= main_bonus.cpp


# BUILD RULES #
############################################
%.o:  %.s
	$(ASM) $(ASMFLG) $< -o $(<:.s=.o)

$(NAME): $(OBJS)
	ar rc $(NAME) $(OBJS)

$(BONUSN): $(BONUS) $(OBJS)
	ar rc $(BONUSN) $(BONUS) $(OBJS)
# ---------------------------------------------


# COMPILATION / DELETE RULES #
############################################
all: $(NAME)

bonus: $(BONUSN)

clean:
	rm -f $(OBJS) $(BONUS)

fclean: clean
	rm -f $(NAME) $(BONUSN) $(TSTNAME) $(TSTB)

re: fclean all
# ---------------------------------------------


# TESTS #
############################################
t1: all
	$(CC) $(FLAGS) $(MAIN) $(LINK) -o $(TSTNAME)

t2: bonus
	$(CPP) $(FLAGS) $(MAINB) $(LINKB) -o $(TSTB)
# ---------------------------------------------

.PHONY: all clean fclean re test bonus
