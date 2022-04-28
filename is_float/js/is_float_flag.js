let [plus, minus, point, zero, nine, ucE, lcE] = new TextEncoder().encode("+-.09Ee")

function isFloat(s) {
	let state = 0
	for (let b of new TextEncoder().encode(s)) {
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

	return state == 3 || state == 4 || state == 7
}

tests = [
	{s: "", b: false},
	{s: "+", b: false},
	{s: "-", b: false},
	{s: ".", b: false},
	{s: "+.", b: false},
	{s: "-.", b: false},
	{s: "+1+", b: false},
	{s: "-1-", b: false},
	{s: "+1", b: true},
	{s: "-1", b: true},
	{s: "1", b: true},
	{s: "+1.", b: true},
	{s: "-1.", b: true},
	{s: "1.", b: true},
	{s: "+.1", b: true},
	{s: "-.1", b: true},
	{s: ".1", b: true},
	{s: "+1.1", b: true},
	{s: "-1.1", b: true},
	{s: "1.1", b: true},
	{s: "+1.1E", b: false},
	{s: "+1.1E+", b: false},
	{s: "+1.1E-", b: false},
	{s: "+1.1E.", b: false},
	{s: "+1.1E1", b: true},
	{s: "+1.1E+1", b: true},
	{s: "+1.1E-1", b: true},
	{s: "+1.1E.1", b: false},
	{s: "+1.1E1.", b: false},
	{s: "+1.1e+1", b: true},
	{s: "+1234567890.1234567890E+1234567890", b: true},
]

for (let t of tests) {
	console.log("'" + t.s + "'\t" + (t.b === isFloat(t.s) ? "OK" : "NG"))
}
