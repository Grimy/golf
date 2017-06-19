#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <time.h>

typedef struct roll {
	int proba;
	int dice;
	int score;
	int mdice;
	int mscore;
} roll;

#include "probas.c"

int d() {
	return rand() % 6;
}

int simul() {
	int score = 0;
	return score;
}

int main(void) {
	srand(time(NULL));
	int total = 0;
	for (int i = 0; i < 1E6; ++i)
		total += simul();
	printf("%d\n", total);
	return 0;
}
