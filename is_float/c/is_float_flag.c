#include <stdio.h>

int is_float(char *s)
{
	int state;

	state = 0;
	while (state >= 0) {
		if (state == 0) {
			if (*s == '+' || *s == '-') {
				s++;
				state = 1;
			} else if (*s == '.') {
				s++;
				state = 2;
			} else if ('0' <= *s && *s <= '9') {
				s++;
				state = 3;
			} else {
				state = -2;
			}
		} else if (state == 1) {
			if (*s == '.') {
				s++;
				state = 2;
			} else if ('0' <= *s && *s <= '9') {
				s++;
				state = 3;
			} else {
				state = -2;
			}
		} else if (state == 2) {
			if ('0' <= *s && *s <= '9') {
				s++;
				state = 4;
			} else {
				state = -2;
			}
		} else if (state == 3) {
			if (*s == '.') {
				s++;
				state = 4;
			} else if ('0' <= *s && *s <= '9') {
				s++;
				state = 3;
			} else if (*s == 'E' || *s == 'e') {
				s++;
				state = 5;
			} else if (*s == '\0') {
				state = -1;
			} else {
				state = -2;
			}
		} else if (state == 4) {
			if ('0' <= *s && *s <= '9') {
				s++;
				state = 4;
			} else if (*s == 'E' || *s == 'e') {
				s++;
				state = 5;
			} else if (*s == '\0') {
				state = -1;
			} else {
				state = -2;
			}
		} else if (state == 5) {
			if (*s == '+' || *s == '-') {
				s++;
				state = 6;
			} else if ('0' <= *s && *s <= '9') {
				s++;
				state = 7;
			} else {
				state = -2;
			}
		} else if (state == 6) {
			if ('0' <= *s && *s <= '9') {
				s++;
				state = 7;
			} else {
				state = -2;
			}
		} else if (state == 7) {
			if ('0' <= *s && *s <= '9') {
				s++;
				state = 7;
			} else if (*s == '\0') {
				state = -1;
			} else {
				state = -2;
			}
		}
	}

	return state == -1;
}

int main(void)
{
	struct {
		char *s;
		int b;
	} tests[] = {
		{"", 0},
		{"+", 0},
		{"-", 0},
		{".", 0},
		{"+.", 0},
		{"-.", 0},
		{"+1+", 0},
		{"-1-", 0},
		{"+1", 1},
		{"-1", 1},
		{"1", 1},
		{"+1.", 1},
		{"-1.", 1},
		{"1.", 1},
		{"+.1", 1},
		{"-.1", 1},
		{".1", 1},
		{"+1.1", 1},
		{"-1.1", 1},
		{"1.1", 1},
		{"+1.1E", 0},
		{"+1.1E+", 0},
		{"+1.1E-", 0},
		{"+1.1E.", 0},
		{"+1.1E1", 1},
		{"+1.1E+1", 1},
		{"+1.1E-1", 1},
		{"+1.1E.1", 0},
		{"+1.1E1.", 0},
		{"+1.1e+1", 1},
		{"+1234567890.1234567890E+1234567890", 1},
	};
	int i;

	for (i = 0; i < sizeof(tests)/sizeof(*tests); i++) {
		printf("'%s'\t%s\n", tests[i].s, tests[i].b == is_float(tests[i].s) ? "OK" : "NG"); 
	}

	return 0;
}
