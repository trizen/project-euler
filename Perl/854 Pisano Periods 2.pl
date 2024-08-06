#!/usr/bin/perl

# Pisano Periods 2
# https://projecteuler.net/problem=854

# See also:
#   https://oeis.org/A005013

# Runtime: 0.405s

use 5.036;
use ntheory qw(:all);

sub P($n, $m = 1_234_567_891) {

    my $v = 2;

    my ($a, $b) = (0, 1);
    my ($c, $d) = (2, 1);

    for (my $k = 2 ; $k <= $n ; $k += 2) {
        $v = mulmod($v, ($k % 4 == 0 ? $b : $d), $m);
        ($a, $b) = ($b, addmod($a, $b, $m));
        ($c, $d) = ($d, addmod($c, $d, $m));
    }

    return $v;
}

P(10) == 264 or die "error";

say P(1e6);
