#include <stdio.h>

int next_state[][4] = {
	{-2,  1,  2, -2},
	{-2, -2,  2, -2},
	{-2, -2,  2, -1},
};

int char_kind(char c)
{
	if (c == '+' || c == '-') {
		return 1;
	} else if ('0' <= c && c <= '9') {
		return 2;
	} else if (c == '\0') {
		return 3;
	} else {
		return 0;
	}
}

int is_int(char *s)
{
	int state = 0;
	while (state >= 0) {
		state = next_state[state][char_kind(*s)];
		s++;
	}

	return state == -1;
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
