#include <stdio.h>
#include <stdint.h>
#include <string.h>

typedef uint16_t u16;
typedef uint64_t u64;

static u64 map[1<<16];

int main(void)
{
	for (u64 n = 1; n < 32; ++n) {
		u64 result = 1;
		u64 mask = (1ul << n) - 1;
		memset(map, 0, sizeof(map));

		#pragma omp parallel
		#pragma omp for
		for (u64 x = 1ul << (n - 1); x < 1ul << n; ++x) {

			u64 r = 0;
			for (u64 i = 1; i < n; ++i)
				r |= (u64) (x >> i == (x & (mask >> i))) << i;
			if (!r)
				continue;

			u16 h = (u16) (r ^ r >> 13 ^ r >> 27);
			while (map[h] && map[h] != r)
				++h;

			if (!map[h]) {
				#pragma omp critical
				if (!map[h]) {
					map[h] = r;
					++result;
				}
			}
		}

		printf("%ld\n", result);
	}
}
