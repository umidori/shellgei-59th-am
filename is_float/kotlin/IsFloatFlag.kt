@kotlin.ExperimentalUnsignedTypes operator fun UByteArray.component7(): UByte = get(6)
@kotlin.ExperimentalUnsignedTypes operator fun UByteArray.component6(): UByte = get(5)

@kotlin.ExperimentalUnsignedTypes fun isFloat(s: String): Boolean {
	val (plus, minus, point, zero, nine, ucE, lcE) = "+-.09Ee".toByteArray(Charsets.UTF_8).toUByteArray()

	var state = 0
	for (b in s.toByteArray(Charsets.UTF_8).toUByteArray()) {
		if (state == 0) {
			if (b == plus || b == minus) {
				state = 1
			} else if (b == point) {
				state = 2
			} else if (zero <= b && b <= nine) {
				state = 3
			} else {
				state = -1
			}
		} else if (state == 1) {
			if (b == point) {
				state = 2
			} else if (zero <= b && b <= nine) {
				state = 3
			} else {
				state = -1
			}
		} else if (state == 2) {
			if (zero <= b && b <= nine) {
				state = 4
			} else {
				state = -1
			}
		} else if (state == 3) {
			if (b == point) {
				state = 4
			} else if (zero <= b && b <= nine) {
				state = 3
			} else if (b == ucE || b == lcE) {
				state = 5
			} else {
				state = -1
			}
		} else if (state == 4) {
			if (zero <= b && b <= nine) {
				state = 4
			} else if (b == ucE || b == lcE) {
				state = 5
			} else {
				state = -1
			}
		} else if (state == 5) {
			if (b == plus || b == minus) {
				state = 6
			} else if (zero <= b && b <= nine) {
				state = 7
			} else {
				state = -1
			}
		} else if (state == 6) {
			if (zero <= b && b <= nine) {
				state = 7
			} else {
				state = -1
			}
		} else if (state == 7) {
			if (zero <= b && b <= nine) {
				state = 7
			} else {
				state = -1
			}
		}
		if (state < 0) {
			break
		}
	}

	return state == 3 || state == 4 || state ==7
}

@kotlin.ExperimentalUnsignedTypes fun main() {
	val tests = arrayOf(
		Pair("", false),
		Pair("+", false),
		Pair("-", false),
		Pair(".", false),
		Pair("+.", false),
		Pair("-.", false),
		Pair("+1+", false),
		Pair("-1-", false),
		Pair("+1", true),
		Pair("-1", true),
		Pair("1", true),
		Pair("+1.", true),
		Pair("-1.", true),
		Pair("1.", true),
		Pair("+.1", true),
		Pair("-.1", true),
		Pair(".1", true),
		Pair("+1.1", true),
		Pair("-1.1", true),
		Pair("1.1", true),
		Pair("+1.1E", false),
		Pair("+1.1E+", false),
		Pair("+1.1E-", false),
		Pair("+1.1E.", false),
		Pair("+1.1E1", true),
		Pair("+1.1E+1", true),
		Pair("+1.1E-1", true),
		Pair("+1.1E.1", false),
		Pair("+1.1E1.", false),
		Pair("+1.1e+1", true),
		Pair("+1234567890.1234567890E+1234567890", true),
	)
	for (t in tests) {
		println("'%s'\t%s".format(t.first, if (t.second == isFloat(t.first)) "OK" else "NG"))
	}
}
