#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

typedef uint32_t u32;

static u32 gate(char op, u32 a, u32 b)
{
	switch (op) {
	case '0': return 0;
	case 'A': return a;
	case 'B': return b;
	case '&': return a & b;
	case '<': return a < b;
	case '>': return a > b;
	case '^': return a ^ b;
	case '|': return a | b;
	default: printf("Unknown op %c\n", op); exit(1);
	}
}

int main(int argc, char **argv)
{
	FILE *script = fopen(argv[1], "r");
	char buf[32];
	u32 acc = 0;

	for (int i = 2; i < argc; ++i)
		acc |= (u32) atoi(argv[i]) << (8 * (i - 2));

	while (fgets(buf, sizeof(buf), script)) {
		if (buf[0] == '#')
			continue;

		for (int i = 0; buf[i] != '\n'; i += 2) {
			while (buf[i] == ' ')
				++i;
			
			u32 in_a = (acc >> (15 - i)) & 1;
			u32 in_b = (acc >> (14 - i)) & 1;
			u32 out = gate(buf[i], in_a, in_b) << 1 | gate(buf[i+1], in_a, in_b);
			acc &= ~(3u << (14 - i));
			acc |= (out << (14 - i));
		}
	}

	printf("%d\n", acc);
}
