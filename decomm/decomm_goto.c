#include <stdio.h>

int main(void)
{
	int c;

	goto S0;
S0:
	if ((c = getchar()) == EOF) {
		goto S4;
	} else if (c == '/') {
		goto S1;
	} else {
		putchar(c);
		goto S0;
	}
S1:
	if ((c = getchar()) == EOF) {
		putchar('/');
		goto S4;
	} else if (c == '/') {
		putchar('/');
		goto S1;
	} else if (c == '*') {
		goto S2;
	} else {
		putchar('/');
		putchar(c);
		goto S0;
	}
S2:
	if ((c = getchar()) == EOF) {
		goto S4;
	} else if (c == '*') {
		goto S3;
	} else {
		goto S2;
	}
S3:
	if ((c = getchar()) == EOF) {
		goto S4;
	} else if (c == '*') {
		goto S3;
	} else if (c == '/') {
		goto S0;
	} else {
		goto S2;
	}
S4:
	return 0;
}
