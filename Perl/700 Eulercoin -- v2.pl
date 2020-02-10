#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 10 February 2020
# https://github.com/trizen

# https://projecteuler.net/problem=700

# Runtime: 0.059s

# Using the denominators of Farey approximations of 1504170715041707 / 4503599627370517.

# See also:
#   https://en.wikipedia.org/wiki/Farey_sequence

use 5.020;
use warnings;

use ntheory qw(:all);
use experimental qw(signatures);

sub farey_approximations($nu, $de, $callback) {

    my $a1 = divint($nu, $de);
    my $b1 = 1;

    my $a2 = $a1+1;
    my $b2 = 1;

    for (;;) {

        my $a3 = $a1+$a2;
        my $b3 = $b1+$b2;

        if (mulint($de, $a3) < mulint($nu, $b3)) {
            ($a1, $b1) = ($a3, $b3);
        }
        else {
            ($a2, $b2) = ($a3, $b3);
        }

        $callback->($a3, $b3) || last;
    }
}

my $a = 1504170715041707;
my $b = 4503599627370517;

my $min = $a;
my $sum = $min;

farey_approximations($a, $b, sub ($n, $d) {
    my $t = mulmod($a, $d, $b);
    if ($t < $min) {
        $sum += $t;
        return $t > 0;
    }
    return 1;
});

say $sum;
