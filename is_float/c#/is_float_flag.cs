using System;

class Program
{
	static bool IsFloat(string s)
	{
		int state = 0;
		foreach (byte b in System.Text.Encoding.UTF8.GetBytes(s)) {
			if (state == 0) {
				if (b == '+' || b == '-') {
					state = 1;
				} else if (b == '.') {
					state = 2;
				} else if ('0' <= b && b <= '9') {
					state = 3;
				} else {
					state = -1;
				}
			} else if (state == 1) {
				if (b == '.') {
					state = 2;
				} else if ('0' <= b && b <= '9') {
					state = 3;
				} else {
					state = -1;
				}
			} else if (state == 2) {
				if ('0' <= b && b <= '9') {
					state = 4;
				} else {
					state = -1;
				}
			} else if (state == 3) {
				if (b == '.') {
					state = 4;
				} else if ('0' <= b && b <= '9') {
					state = 3;
				} else if (b == 'E' || b == 'e') {
					state = 5;
				} else {
					state = -1;
				}
			} else if (state == 4) {
				if ('0' <= b && b <= '9') {
					state = 4;
				} else if (b == 'E' || b == 'e') {
					state = 5;
				} else {
					state = -1;
				}
			} else if (state == 5) {
				if (b == '+' || b == '-') {
					state = 6;
				} else if ('0' <= b && b <= '9') {
					state = 7;
				} else {
					state = -1;
				}
			} else if (state == 6) {
				if ('0' <= b && b <= '9') {
					state = 7;
				} else {
					state = -1;
				}
			} else if (state == 7) {
				if ('0' <= b && b <= '9') {
					state = 7;
				} else {
					state = -1;
				}
			}
			if (state < 0) {
				break;
			}
		}

		return state == 3 || state == 4 || state == 7;
	}

	static void Main(string[] args)
	{
		var tests = new [] {
			("", false),
			("+", false),
			("-", false),
			(".", false),
			("+.", false),
			("-.", false),
			("+1+", false),
			("-1-", false),
			("+1", true),
			("-1", true),
			("1", true),
			("+1.", true),
			("-1.", true),
			("1.", true),
			("+.1", true),
			("-.1", true),
			(".1", true),
			("+1.1", true),
			("-1.1", true),
			("1.1", true),
			("+1.1E", false),
			("+1.1E+", false),
			("+1.1E-", false),
			("+1.1E.", false),
			("+1.1E1", true),
			("+1.1E+1", true),
			("+1.1E-1", true),
			("+1.1E.1", false),
			("+1.1E1.", false),
			("+1.1e+1", true),
			("+1234567890.1234567890E+1234567890", true),
		};

		foreach (var t in tests) {
			Console.WriteLine("'{0}'\t{1}",t.Item1, t.Item2 == IsFloat(t.Item1) ? "OK" : "NG");
		}
	}
}
