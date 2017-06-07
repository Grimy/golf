all: nines Z

nines: nines.c
	clang -Weverything -O3 $^ -o $@

Z: Z.c
	clang -Weverything -O3 $^ -o $@
