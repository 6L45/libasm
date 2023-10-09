#include <stdlib.h>
#include <string.h>
#include <stdio.h>
/*
int	atoi_base(char *val, char *base)
{
	if (!val || !base)
		exit(1);

//PARSING	
	int	i = 0;
	int	j = 0;

	// doublon checker
	// pour chaque element dans base
	while (base[i])
	{
		j = i + 1;
		// on check tous les elements suivants
		// (si base[j] != '\0')
		if (base[j])
		{
			while (base[j])
			{
								// (32 = ' ')
				if (base[j] == base[i] || base [j] <= 32)
					exit(1);
				j++;
			}
		}
		else
			break;
		i++;
	}

//------------------------------------------------------------------------------------
	
	int	ret = 0;
	int	len_base = i + 1;
	int	pos;
	short	sign = 1;
	int	pow = 0;
	int	len_val = 0;
	bool	loop = true;

// PASS NON PRINTABLES
	i = 0;
	while (val[i] && val[i] <= ' ')
		i++;

// PASS + - char
	while (val[i] == '-' || val[i] == '+')
	{
		if (val[i] == '-')
			sign = -1;
		i++;
	}

// GET REAL LEN "[value (with char in base)]...bs (char not in base).."
	while (val[i + len_val])
	{
		loop = false;
		j = 0;
		while (base[j])
		{
			if (base[j] == val[i + len_val])
				loop = true;
			j++;
		}
		if (!loop)
			break;
		len_val++;
	}
	pos = len_val - 1;

// ATOI BASE
	while (val[i])
	{
		j = 0;
		while (base[j] && base[j] != val[i])
			j++;
		if (!base[j])
		{
			return ret * sign;
		}
		else
		{
			if (pos == 0)
				ret += j;
			else
			{
				pow = 1;
				for (int k = 0; k < pos; k++)
					pow *= len_base;
				ret += pow * j;
			}
		}

		i++;
		pos--;
	}

	return ret * sign;
}
*/

int	ft_atoi_base(char *val, char *base);

int	main(int argc, char **argv)
{
	if (argc < 3)
		return (2);
	int val = ft_atoi_base(argv[1], argv[2]);
	printf("%d\n", val);

	return (val);
}
