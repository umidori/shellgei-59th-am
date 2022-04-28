function is_float(s)
	state = 0

	for b in transcode(UInt8, s) 
		if state == 0
			if b == UInt8('+') || b == UInt8('-')
				state = 1
			elseif b == UInt8('.')
				state = 2
			elseif UInt8('0') <= b && b <= UInt8('9')
				state = 3
			else
				state = -1;
			end
		elseif state == 1
			if b == UInt8('.')
				state = 2
			elseif UInt8('0') <= b && b <= UInt8('9')
				state = 3
			else
				state = -1;
			end
		elseif state == 2
			if UInt8('0') <= b && b <= UInt8('9')
				state = 4
			else
				state = -1
			end
		elseif state == 3
			if b == UInt8('.')
				state = 4
			elseif UInt8('0') <= b && b <= UInt8('9')
				state = 3
			elseif b == UInt8('E') || b == UInt8('e')
				state = 5
			else
				state = -1
			end
		elseif state == 4
			if UInt8('0') <= b && b <= UInt8('9')
				state = 4
			elseif b == UInt8('E') || b == UInt8('e')
				state = 5
			else
				state = -1
			end
		elseif state == 5
			if b == UInt8('+') || b == UInt8('-')
				state = 6
			elseif UInt8('0') <= b && b <= UInt8('9')
				state = 7
			else
				state = -1
			end
		elseif state == 6
			if UInt8('0') <= b && b <= UInt8('9')
				state = 7
			else
				state = -1
			end
		elseif state == 7
			if UInt8('0') <= b && b <= UInt8('9')
				state = 7
			else
				state = -1
			end
		end
		if state < 0
			break
        end
	end

	state == 3 || state == 4 || state == 7
end 

tests = [
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
]

for t in tests
	println("'$(t[1])'\t", t[2] == is_float(t[1]) ? "OK" : "NG")
end
