#include <stdio.h>
#include <stdint.h>

typedef enum { false, true } bool;
static int64_t d[1<<10];
static int64_t j[1<<10];
static int64_t count[1<<10];

int main(void)
{
	int64_t n = 0;

	for (int64_t h = 1; h; ++h) {
		j[h] = ++n;
		d[h] = 1;

		while (n < 200) {
			++count[n];
			for (int64_t k = h - 2; k > 0; --k)
				if (j[k] == n && d[k] % d[k+1] == 0)
					goto valid;
			j[h] += 2;
			d[h] += 1;
			n++;
			for (int64_t k = h - 1; k > 0; --k)
				if (j[k] == n - 2)
					goto valid;
		}

		valid:
		while (h >= 0 && j[h] == n--)
			--h;
		j[h] -= 2;
		d[h] -= 1;

		while (j[h-1] == n && d[h] == 1) {
			while (h >= 0 && j[h] == n--)
				--h;
			j[h] -= 2;
			d[h] -= 1;
		}
	}

	for (int64_t i = 1; i < 200; ++i)
		printf("%ld\n", count[i]);
}
