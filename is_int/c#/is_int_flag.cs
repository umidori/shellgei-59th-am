using System;

class is_int_flag {
	static bool IsInt(string s) {
		var state = 0;
		foreach (byte b in System.Text.Encoding.UTF8.GetBytes(s)) {
			if (state == 0) {
				if (b == '+' || b == '-') {
					state = 1;
				} else if ('0' <= b && b <= '9') {
					state = 2;
				} else {
					state = -1;
				}
			} else if (state == 1) {
				if ('0' <= b && b <= '9') {
					state = 2;
				} else {
					state = -1;
				}
			} else if (state == 2) {
				if ('0' <= b && b <= '9') {
					state = 2;
				} else {
					state = -1;
				}
			}
			if (state < 0) {
				break;
			}
		}
		return state == 2;
	}

	static void Main() {
		(string s, bool b)[] tests = {
			("", false),
			("+", false),
			("-", false),
			("++", false),
			("--", false),
			("+0+", false),
			("-0-", false),
			("+0123456789", true),
			("-0123456789", true),
			("0123456789", true),
		};

		foreach (var t in tests) {
			Console.WriteLine("'{0}'\t{1}", t.s, t.b == IsInt(t.s) ? "OK" : "NG");
		}

	}
}
