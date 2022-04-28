let c = Array("+-.09Ee".utf8)
let (plus, minus, point, zero, nine, ucE, lcE) = (c[0], c[1], c[2], c[3], c[4], c[5], c[6])

func isFloat(_ s: String) -> Bool {
	var state: Int = 0
	for b in s.utf8 {
		if state == 0 {
			if b == plus || b == minus {
				state = 1
			} else if (b == point) {
				state = 2
			} else if zero <= b && b <= nine {
				state = 3
			} else {
				state = -1
			}
		} else if state == 1 {
			if (b == point) {
				state = 2
			} else if zero <= b && b <= nine {
				state = 3
			} else {
				state = -1
			}
		} else if state == 2 {
			if zero <= b && b <= nine {
				state = 4
			} else {
				state = -1
			}
		} else if state == 3 {
			if (b == point) {
				state = 4
			} else if zero <= b && b <= nine {
				state = 3
			} else if b == ucE || b == lcE {
				state = 5
			} else {
				state = -1
			}
		} else if state == 4 {
			if zero <= b && b <= nine {
				state = 4
			} else if b == ucE || b == lcE {
				state = 5
			} else {
				state = -1
			}
		} else if state == 5 {
			if b == plus || b == minus {
				state = 6
			} else if zero <= b && b <= nine {
				state = 7
			} else {
				state = -1
			}
		} else if state == 6 {
			if zero <= b && b <= nine {
				state = 7
			} else {
				state = -1
			}
		} else if state == 7 {
			if zero <= b && b <= nine {
				state = 7
			} else {
				state = -1
			}
		} 
		if state < 0 {
			break
		}
	}

	return state == 3 || state == 4 || state == 7;
}

for t in [
	("",false),
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
] {
	print("'\(t.0)'\t\(t.1 == isFloat(t.0) ? "OK" : "NG")")
}
