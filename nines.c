#include <string.h>
#include <stdlib.h>
#include <stdio.h>

enum { INVALID, DIV, MINUS, XOR, LSH, RSH, MULT };
typedef enum { false, true } bool;

static char chars[8] = "09/-";
static char code[32] = { 0, 0, 0, 0, 0 };
static char found[128];
static long stack[32];
static char *p;

static long parse_num()
{
	long result = 1;
	
	if (*p == 3) {
		if (p > code && p[-1] == 3)
			return INVALID;
		++p;
		result = -1;
	}

	if (*p == 2 && p[1] == 2) {
		p += 2;
		return result;
	}

	if (*p != 1)
		return INVALID;

	while (*p == 1) {
		result *= 10;
		++p;
	}

	return result - (result > 0 ? 1 : -1);
}

static long parse_op()
{
	switch (*p++) {
	default: return INVALID;
	case 2: return DIV;
	case 3: return MINUS;
	case 4: return XOR;
	case 5: return *p++ == 5 ? LSH : INVALID;
	case 6: return *p++ == 6 ? RSH : INVALID;
	case 7: return MULT;
	}
}

static long eval()
{
	long i = 0, j = 0, length;

	for (p = code; *p; ++j) {
		stack[j] = (j&1) ? parse_op() : parse_num();
		if (stack[j] == INVALID)
			return INVALID;
	}
	
	if (!(j&1))
		return INVALID;

	for (length = j, i = 1, j = 1; i < length; i += 2) {
		if (stack[i] == DIV) {
			if (stack[j-1] % stack[i+1])
				return INVALID;
			stack[j-1] /= stack[i+1];
		} else if (stack[i] == MULT) {
			stack[j-1] *= stack[i+1];
		} else {
			stack[j++] = stack[i];
			stack[j++] = stack[i+1];
		}
	}

	for (length = j, i = 1, j = 1; i < length; i += 2) {
		if (stack[i] == MINUS) {
			stack[j-1] -= stack[i+1];
		} else {
			stack[j++] = stack[i];
			stack[j++] = stack[i+1];
		}
	}

	for (length = j, i = 1, j = 1; i < length; i += 2) {
		if (stack[i] == LSH) {
			if (stack[i+1] < 0 || stack[i+1] > 63)
				return INVALID;
			stack[j-1] <<= stack[i+1];
		} else if (stack[i] == RSH) {
			if (stack[i+1] < 0 || stack[i+1] > 63)
				return INVALID;
			stack[j-1] >>= stack[i+1];
		} else {
			stack[j++] = stack[i];
			stack[j++] = stack[i+1];
		}
	}

	for (length = j, i = 1, j = 1; i < length; i += 2) {
		if (stack[i] == XOR) {
			stack[j-1] ^= (unsigned long) stack[i+1];
		} else {
			stack[j++] = stack[i];
			stack[j++] = stack[i+1];
		}
	}

	return stack[0];
}

int main(void)
{
	for (;;) {
		for (p = code; *p == 3; ++p)
			*p = 1;
		++*p;
		long result = eval();
		if (result <= INVALID || result > 127 || found[result])
			continue;
		found[result] = true;
		printf("%-3ld: ", result);
		for (p = code; *p; ++p)
			putchar(chars[*p]);
		putchar('\n');
	}
}
