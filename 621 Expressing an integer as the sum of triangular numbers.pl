#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 02 March 2018
# https://github.com/trizen

# https://projecteuler.net/problem=621

# Runtime: ~39 seconds.

use 5.020;
use strict;
use warnings;

use ntheory qw(factor_exp);
use experimental qw(signatures);

sub count_sums_of_two_squares ($n) {

    my $count = 4;

    foreach my $p (factor_exp($n)) {

        my $r = $p->[0] % 4;

        if ($r == 3) {
            $p->[1] % 2 == 0 or return 0;
        }

        if ($r == 1) {
            $count *= $p->[1] + 1;
        }
    }

    return $count;
}

sub count_triangular_sums ($n) {

    my $count = 0;
    my $limit = (sqrt(8 * $n + 1) - 1) / 2;

    for my $u (0 .. $limit) {
        my $z = ($n - $u * ($u + 1) / 2) * 8 + 1;
        $count += count_sums_of_two_squares($z + 1);
    }

    return $count / 4;
}

say count_triangular_sums(17526 * 10**9);
