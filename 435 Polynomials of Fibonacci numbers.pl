#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 11 October 2017
# https://github.com/trizen

# https://projecteuler.net/problem=435

# Runtime: ~1 minute, 33 seconds.

use 5.026;
use strict;
use warnings;

use experimental qw(signatures);
use ntheory qw(addmod mulmod powmod lcm factor_exp factorial);

sub pisano_period($mod) {

    my sub find_period($mod) {
        my ($x, $y) = (0, 1);

        for (my $n = 1 ; ; ++$n) {
            ($x, $y) = ($y, addmod($x, $y, $mod));

            if ($x == 0 and $y == 1) {
                return $n;
            }
        }
    }

    my @prime_powers  = map { $_->[0]**$_->[1] } factor_exp($mod);
    my @power_periods = map { find_period($_) } @prime_powers;

    return lcm(@power_periods);
}

my $mod = factorial(15);
my $n = powmod(10, 15, pisano_period(factorial(14)));    # 870400

my $sum = 0;
my ($f1, $f2) = (0, 1);

foreach my $k (1 .. $n) {

    my $power_sum = 0;
    foreach my $x (1 .. 100) {
        $power_sum = addmod($power_sum, powmod($x, $k, $mod), $mod);
    }

    $sum = addmod($sum, mulmod($f2, $power_sum, $mod), $mod);
    ($f1, $f2) = ($f2, addmod($f1, $f2, $mod));
}

say $sum;
