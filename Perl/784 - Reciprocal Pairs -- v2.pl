#!/usr/bin/perl

# Reciprocal Pairs
# https://projecteuler.net/problem=784

# Runtime: 1 minute and 3 seconds.

use 5.020;
use ntheory qw(:all);
use experimental qw(signatures);

local $| = 1;

sub F ($n) {
    my $total = 0;

    foreach my $a (2 .. $n) {

        my $v = $a * $a - 1;

        foreach my $d (divisors($v)) {

            $d <= $a or last;

            my $p = $a + $d;
            my $q = $a + divint($v, $d);

            if ($p <= $n) {
                $total += $p + $q;
            }
            else {
                last;
            }
        }
    }

    return $total;
}

say F(5);
say F(100);
say F(2 * 1e6);
