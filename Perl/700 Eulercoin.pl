#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 10 February 2020
# https://github.com/trizen

# https://projecteuler.net/problem=700

# Runtime: 0.094s

# Using the denominators of Farey approximations of 1504170715041707 / 4503599627370517.

# See also:
#   https://en.wikipedia.org/wiki/Farey_sequence

use 5.020;
use warnings;

use experimental qw(signatures);
use Math::AnyNum qw(:overload);

sub farey_approximations($r, $callback) {

    my $a1 = int($r);
    my $b1 = 1;

    my $a2 = $a1+1;
    my $b2 = 1;

    for (;;) {

        my $a3 = $a1+$a2;
        my $b3 = $b1+$b2;

        if ($a3 < $r*$b3) {
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

farey_approximations($a/$b, sub ($n, $d) {
    my $t = ($a*$d) % $b;
    if ($t < $min) {
        $sum += $t;
        $min = $t;
        return $t > 1;
    }
    return 1;
});

say $sum;
