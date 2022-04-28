use strict;
use warnings;

my ($plus, $minus, $point, $zero, $nine, $uc_e, $lc_e) = unpack("C*", "+-.09Ee");

sub is_float {
	my $s = shift;
	my $state = 0;
	for my $b (unpack("C*", $s)) {
		if ($state == 0) {
			if ($b == $plus || $b == $minus) {
				$state = 1;
			} elsif ($b == $point) {
				$state = 2;
			} elsif ($zero <= $b && $b <= $nine) {
				$state = 3;
			} else {
				$state = -1;
			}
		} elsif ($state == 1) {
			if ($b == $point) {
				$state = 2;
			} elsif ($zero <= $b && $b <= $nine) {
				$state = 3;
			} else {
				$state = -1;
			}
		} elsif ($state == 2) {
			if ($zero <= $b && $b <= $nine) {
				$state = 4;
			} else {
				$state = -1;
			}
		} elsif ($state == 3) {
			if ($b == $point) {
				$state = 4;
			} elsif ($zero <= $b && $b <= $nine) {
				$state = 3;
			} elsif ($b == $uc_e || $b == $lc_e) {
				$state = 5;
			} else {
				$state = -1;
			}
		} elsif ($state == 4) {
			if ($zero <= $b && $b <= $nine) {
				$state = 4;
			} elsif ($b == $uc_e || $b == $lc_e) {
				$state = 5;
			} else {
				$state = -1;
			}
		} elsif ($state == 5) {
			if ($b == $plus || $b == $minus) {
				$state = 6;
			} elsif ($zero <= $b && $b <= $nine) {
				$state = 7;
			} else {
				$state = -1;
			}
		} elsif ($state == 6) {
			if ($zero <= $b && $b <= $nine) {
				$state = 7;
			} else {
				$state = -1;
			}
		} elsif ($state == 7) {
			if ($zero <= $b && $b <= $nine) {
				$state = 7;
			} else {
				$state = -1;
			}
		}
		if ($state < 0) {
			next;
		}
	}

	return $state == 3 || $state == 4 || $state == 7;
}

my @tests = (
	["", 0],
	["+", 0],
	["-", 0],
	[".", 0],
	["+.", 0],
	["-.", 0],
	["+1+", 0],
	["-1-", 0],
	["+1", 1],
	["-1", 1],
	["1", 1],
	["+1.", 1],
	["-1.", 1],
	["1.", 1],
	["+.1", 1],
	["-.1", 1],
	[".1", 1],
	["+1.1", 1],
	["-1.1", 1],
	["1.1", 1],
	["+1.1E", 0],
	["+1.1E+", 0],
	["+1.1E-", 0],
	["+1.1E.", 0],
	["+1.1E1", 1],
	["+1.1E+1", 1],
	["+1.1E-1", 1],
	["+1.1E.1", 0],
	["+1.1E1.", 0],
	["+1.1e+1", 1],
	["+1234567890.1234567890E+1234567890", 1],
);

for my $t (@tests) {
	print "'$t->[0]'\t", $t->[1] == is_float($t->[0]) ? "OK" : "NG", "\n";
}
