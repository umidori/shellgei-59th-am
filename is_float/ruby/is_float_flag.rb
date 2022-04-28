$plus, $minus, $point, $zero, $nine, $uc_e, $lc_e = "+-.09Ee".bytes

def is_float(s)
	state = 0;
	s.each_byte do |b|
		if state == 0 then
			if b == $plus || b == $minus then
				state = 1
			elsif b == $point then
				state = 2
			elsif $zero <= b && b <= $nine then
				state = 3
			else
				state = -1
			end
		elsif state == 1 then
			if b == $point then
				state = 2
			elsif $zero <= b && b <= $nine then
				state = 3
			else
				state = -1
			end
		elsif state == 2 then
			if $zero <= b && b <= $nine then
				state = 4
			else
				state = -1
			end
		elsif state == 3 then
			if b == $point then
				state = 4
			elsif $zero <= b && b <= $nine then
				state = 3
			elsif b == $uc_e || b == $lc_e then
				state = 5
			else
				state = -1
			end
		elsif state == 4 then
			if $zero <= b && b <= $nine then
				state = 4
			elsif b == $uc_e || b == $lc_e then
				state = 5
			else
				state = -1
			end
		elsif state == 5 then
			if b == $plus || b == $minus then
				state = 6
			elsif $zero <= b && b <= $nine then
				state = 7
			else
				state = -1
			end
		elsif state == 6 then
			if $zero <= b && b <= $nine then
				state = 7
			else
				state = -1
			end
		elsif state == 7 then
			if $zero <= b && b <= $nine then
				state = 7
			else
				state = -1
			end
		end
		if state < 0 then
			break
		end
	end

	state == 3 || state == 4 || state == 7
end

[
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
].each do |t|
	printf("'%s'\t%s\n", t[:s], t[:b] == is_float(t[:s]) ? "OK" : "NG")
end
