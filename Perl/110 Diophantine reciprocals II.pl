#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 15 May 2021
# https://github.com/trizen

# Diophantine reciprocals II
# https://projecteuler.net/problem=110

# See also:
#   https://oeis.org/A018892

# Runtime: 0.550s

use 5.020;
use warnings;
use experimental qw(signatures);

use ntheory qw(nth_prime);
use Math::AnyNum qw(:overload);

sub solve ($threshold, $least_solution = Inf, $k = 1, $max_a = Inf, $solutions = 1, $n = 1) {

    if ($solutions > $threshold) {
        return $n;
    }

    my $p = nth_prime($k);

    for (my $a = 1 ; $a <= $max_a ; ++$a) {
        $n *= $p;
        last if ($n > $least_solution);
        $least_solution = __SUB__->($threshold, $least_solution, $k + 1, $a, $solutions * (2 * $a + 1), $n);
    }

    return $least_solution;
}

my $LIMIT = 4 * 10**6;
say solve(2 * $LIMIT + 1);
