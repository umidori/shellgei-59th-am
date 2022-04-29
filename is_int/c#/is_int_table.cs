using System;

class is_int_table {
	static int[][] nextState = new int[][] {
		new [] {-1,  1, 2},
		new [] {-1, -1, 2},
		new [] {-1, -1, 2},
	};

	static int charKind(byte b) {
		if (b == '+' || b == '-') {
			return 1;
		} else if ('0' <= b && b <= '9') {
			return 2;
		} else {
			return 0;
		}
	}

	static bool IsInt(string s) {
		var state = 0;
		foreach (byte b in System.Text.Encoding.UTF8.GetBytes(s)) {
			state = nextState[state][charKind(b)];
			if (state < 0) break;
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
