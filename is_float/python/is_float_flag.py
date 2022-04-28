[plus, minus, point, zero, nine, uc_e, lc_e] = "+-.09Ee".encode() 

def is_float(s):
	state = 0
	for b in s.encode():
		if state == 0:
			if b == plus or b == minus:
				state = 1
			elif b == point:
				state = 2
			elif zero <= b and b <= nine:
				state = 3
			else:
				state = -1
		elif state == 1:
			if (b == point):
				state = 2
			elif zero <= b and b <= nine:
				state = 3
			else:
				state = -1
		elif state == 2:
			if zero <= b and b <= nine:
				state = 4
			else:
				state = -1
		elif state == 3:
			if b == point:
				state = 4
			elif zero <= b and b <= nine:
				state = 3
			elif b == uc_e or b == lc_e:
				state = 5
			else:
				state = -1
		elif state == 4:
			if zero <= b and b <= nine:
				state = 4
			elif b == uc_e or b == lc_e:
				state = 5
			else:
				state = -1
		elif state == 5:
			if b == plus or b == minus:
				state = 6
			elif zero <= b and b <= nine:
				state = 7
			else:
				state = -1
		elif state == 6:
			if zero <= b and b <= nine:
				state = 7
			else:
				state = -1
		elif state == 7:
			if zero <= b and b <= nine:
				state = 7
			else:
				state = -1
		if state < 0:
			break

	return state == 3 or state == 4 or state == 7

tests = [
	("", False),
	("+", False),
	("-", False),
	(".", False),
	("+.", False),
	("-.", False),
	("+1+", False),
	("-1-", False),
	("+1", True),
	("-1", True),
	("1", True),
	("+1.", True),
	("-1.", True),
	("1.", True),
	("+.1", True),
	("-.1", True),
	(".1", True),
	("+1.1", True),
	("-1.1", True),
	("1.1", True),
	("+1.1E", False),
	("+1.1E+", False),
	("+1.1E-", False),
	("+1.1E.", False),
	("+1.1E1", True),
	("+1.1E+1", True),
	("+1.1E-1", True),
	("+1.1E.1", False),
	("+1.1E1.", False),
	("+1.1e+1", True),
	("+1234567890.1234567890E+1234567890", True),
]

for t in tests:
	print("'%s'\t%s" % (t[0], "OK" if t[1] == is_float(t[0]) else "NG"))
