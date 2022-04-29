#include <stdio.h>

int main(void)
{
	int c;

	int state = 0;
	while (state >= 0) {
		if (state == 0) {
			if ((c = getchar()) == EOF) {
				state = -1;
			} else if (c == '/') {
				state = 1;
			} else {
				putchar(c);
				state = 0;
			}
		} else if (state == 1) {
			if ((c = getchar()) == EOF) {
				putchar('/');
				state = -1;
			} else if (c == '/') {
				putchar('/');
				state = 1;
			} else if (c == '*') {
				state = 2;
			} else {
				putchar('/');
				putchar(c);
				state = 0;
			}
		} else if (state == 2) {
			if ((c = getchar()) == EOF) {
				state = -1;
			} else if (c == '*') {
				state = 3;
			} else {
				state = 2;
			}
		} else if (state == 3) {
			if ((c = getchar()) == EOF) {
				state = -1;
			} else if (c == '*') {
				state = 3;
			} else if (c == '/') {
				state = 0;
			} else {
				state = 2;
			}
		}
	}

	return 0;
}
