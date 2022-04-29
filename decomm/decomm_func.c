#include <stdio.h>

void *S0(int c);
void *S1(int c);
void *S2(int c);
void *S3(int c);

void *S0(int c)
{
	if (c == EOF) {
		return NULL;
	} else if (c == '/') {
		return S1;
	} else {
		putchar(c);
		return S0;
	}
}

void *S1(int c)
{
	if (c == EOF) {
		putchar('/');
		return NULL;
	} else if (c == '/') {
		putchar('/');
		return S1;
	} else if (c == '*') {
		return S2;
	} else {
		putchar('/');
		putchar(c);
		return S0;
	}
}

void *S2(int c)
{
	if (c == EOF) {
		return NULL;
	} else if (c == '*') {
		return S3;
	} else {
		return S2;
	}
}

void *S3(int c)
{
	if (c == EOF) {
		return NULL;
	} else if (c == '/') {
		return S0;
	} else if (c == '*') {
		return S3;
	} else {
		return S2;
	}
}

int main(void)
{
	void *(*f)(int) = S0;

	while (f != NULL) {
		f = f(getchar());
	}

	return 0;
}
