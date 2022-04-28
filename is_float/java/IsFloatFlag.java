import java.nio.charset.StandardCharsets;

class Test {
	String s;
	boolean b;
	Test(String s, boolean b) {
		this.s = s;
		this.b = b;
	}
}

public class IsFloatFlag {
	static final int plus, minus, point, zero, nine, ucE, lcE;
	static {
		plus  = "+".getBytes(StandardCharsets.UTF_8)[0] & 0xFF;
		minus = "-".getBytes(StandardCharsets.UTF_8)[0] & 0xFF;
		point = ".".getBytes(StandardCharsets.UTF_8)[0] & 0xFF;
		zero  = "0".getBytes(StandardCharsets.UTF_8)[0] & 0xFF;
		nine  = "9".getBytes(StandardCharsets.UTF_8)[0] & 0xFF;
		ucE   = "E".getBytes(StandardCharsets.UTF_8)[0] & 0xFF;
		lcE   = "e".getBytes(StandardCharsets.UTF_8)[0] & 0xFF;
	}

	public static boolean isFloat(String s) {
		int state = 0;
		for (byte bt : s.getBytes(StandardCharsets.UTF_8)) {
			int b = bt & 0xFF;
			if (state == 0) {
				if (b == plus || b == minus) {
					state = 1;
				} else if (b == point) {
					state = 2;
				} else if (zero <= b && b <= nine) {
					state = 3;
				} else {
					state = -1;
				}
			} else if (state == 1) {
				if (b == point) {
					state = 2;
				} else if (zero <= b && b <= nine) {
					state = 3;
				} else {
					state = -1;
				}
			} else if (state == 2) {
				if (zero <= b && b <= nine) {
					state = 4;
				} else {
					state = -1;
				}
			} else if (state == 3) {
				if (b == point) {
					state = 4;
				} else if (zero <= b && b <= nine) {
					state = 3;
				} else if (b == ucE || b == lcE) {
					state = 5;
				} else {
					state = -1;
				}
			} else if (state == 4) {
				if (zero <= b && b <= nine) {
					state = 4;
				} else if (b == ucE || b == lcE) {
					state = 5;
				} else {
					state = -1;
				}
			} else if (state == 5) {
				if (b == plus || b == minus) {
					state = 6;
				} else if (zero <= b && b <= nine) {
					state = 7;
				} else {
					state = -1;
				}
			} else if (state == 6) {
				if (zero <= b && b <= nine) {
					state = 7;
				} else {
					state = -1;
				}
			} else if (state == 7) {
				if (zero <= b && b <= nine) {
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

	public static void main(String[] args) {
		var tests = new Test[] {
			new Test("", false),
			new Test("+", false),
			new Test("-", false),
			new Test(".", false),
			new Test("+.", false),
			new Test("-.", false),
			new Test("+1+", false),
			new Test("-1-", false),
			new Test("+1", true),
			new Test("-1", true),
			new Test("1", true),
			new Test("+1.", true),
			new Test("-1.", true),
			new Test("1.", true),
			new Test("+.1", true),
			new Test("-.1", true),
			new Test(".1", true),
			new Test("+1.1", true),
			new Test("-1.1", true),
			new Test("1.1", true),
			new Test("+1.1E", false),
			new Test("+1.1E+", false),
			new Test("+1.1E-", false),
			new Test("+1.1E.", false),
			new Test("+1.1E1", true),
			new Test("+1.1E+1", true),
			new Test("+1.1E-1", true),
			new Test("+1.1E.1", false),
			new Test("+1.1E1.", false),
			new Test("+1.1e+1", true),
			new Test("+1234567890.1234567890E+1234567890", true),
		};
		for (var t : tests) {
			System.out.printf("'%s'\t%s\n", t.s, t.b == isFloat(t.s) ? "OK" : "NG");
		}
	}
}
