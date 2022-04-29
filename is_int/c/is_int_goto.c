#include <stdio.h>

int is_int(char *s)
{
	goto S0;
S0:
	if (*s == '+' || *s == '-') {
		s++;
		goto S1;
	} else if ('0' <= *s && *s <= '9') {
		s++;
		goto S2;
	} else {
		goto S4;
	}
S1:
	if ('0' <= *s && *s <= '9') {
		s++;
		goto S2;
	} else {
		goto S4;
	}
S2:
	if (*s == '\0') {
		goto S3;
	} else if ('0' <= *s && *s <= '9') {
		s++;
		goto S2;
	} else {
		goto S4;
	}
S3:
	return 1;
S4:
	return 0;
}

int main(void)
{
	struct {
		char *s;
		int b;
	} tests[] = {
		{ "", 0 },
		{ " ", 0 },
		{ "+", 0 },
		{ "-", 0 },
		{ "++", 0 },
		{ "--", 0 },
		{ "+0+", 0 },
		{ "-0-", 0 },
		{ "+0123456789", 1 },
		{ "-0123456789", 1 },
		{ "0123456789", 1 }
	};
	int i;

	for (i = 0; i < sizeof(tests)/sizeof(*tests); i++) {
		printf("'%s'\t%s\n", tests[i].s, tests[i].b == is_int(tests[i].s) ? "OK" : "NG"); 
	}

	return 0;
}
