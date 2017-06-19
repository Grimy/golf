#include <stdio.h>
#include <assert.h>

typedef struct roll {
	int proba;
	int dice;
	int score;
	int mdice;
	int mscore;
} roll;

#include "probas.c"

static const int powers[] = {6, 36, 216, 1296, 7776, 46656};
static double cache[6][100] = {{0}};

static const int stop[] = {10, 10, 10, 20, 55, 100};
static const double mult[] = {0, 0, 0, 5.0/6.0, 11.0/12.0, 0};
static const double add[] = {0, 0, 0, 3.1, 4.5, 0};

static double expected(int dice, int score) {
	if (score >= stop[dice])
		return score;
	if (cache[dice][score])
		return cache[dice][score];

	double total = 0;
	for (const roll *p = rolls[dice]; p->proba; ++p) {
		int prediction = score + p->score >= stop[p->dice]
			&& score + p->score >= (score + p->mscore)
			* mult[p->mdice] + add[p->mdice];
		prediction |= p->dice == 5;
		prediction |= p->dice == 0 && p->mdice == 3 && score + p->score < 9;

		double best = prediction ?
			expected(p->dice, score + p->score) :
			expected(p->mdice, score + p->mscore);

		if (expected(p->dice, score + p->score) > best) {
			printf("%dd, %d points > %dd, %d points (%f!)\n",
				p->dice + 1, 50 * (score + p->score),
				p->mdice + 1, 50 * (score + p->mscore),
				expected(p->dice, score + p->score) - best);
		}
		if (expected(p->mdice, score + p->mscore) > best) {
			printf("%dd, %d points < %dd, %d points (%f!)\n",
					p->dice + 1, 50 * (score + p->score),
					p->mdice + 1, 50 * (score + p->mscore),
					expected(p->mdice, score + p->mscore) - best);

		}

		total += p->proba * best;
	}

	return cache[dice][score] = total / powers[dice];
}

int main(void) {
	for (int d = 0; d < 6; ++d) {
		int score;
		for (score = 10; expected(d, score) != score; ++score);
		printf("Avec %d dés, relancer en-dessous de %d points\n", d + 1, score * 50);
	}
	int t = 0;
	for (int i = 0; i < 58; ++i) {
		t += rolls[3][i].proba;
	}
	printf("Probas: %d\n", t);

	printf("Points moyens par coup : %f\n", 50 * expected(5, 0));
	printf("Points moyens par coup : %f\n", 50 * expected(3, 43));
	printf("Points moyens par coup : %f\n", 50 * expected(4, 42));
}
