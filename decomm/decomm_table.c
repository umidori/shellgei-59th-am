#include <stdio.h>

int S0(int c)
{
	if (c == EOF) {
		return -1;
	} else if (c == '/') {
		return 1;
	} else {
		putchar(c);
		return 0;
	}
}

int S1(int c)
{
	if (c == EOF) {
		putchar('/');
		return -1;
	} else if (c == '/') {
		putchar('/');
		return 1;
	} else if (c == '*') {
		return 2;
	} else {
		putchar('/');
		putchar(c);
		return 0;
	}
}

int S2(int c)
{
	if (c == EOF) {
		return -1;
	} else if (c == '*') {
		return 3;
	} else {
		return 2;
	}
}

int S3(int c)
{
	if (c == EOF) {
		return -1;
	} else if (c == '/') {
		return 0;
	} else if (c == '*') {
		return 3;
	} else {
		return 2;
	}
}

int (*next_status[])(int c) = {
	S0, S1, S2, S3
};

int main(void)
{
	int state = 0;
	while (state >= 0) {
		state = next_status[state](getchar());
	}

	return 0;
}
