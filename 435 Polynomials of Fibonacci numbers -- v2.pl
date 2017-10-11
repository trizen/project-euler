#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 11 October 2017
# https://github.com/trizen

# https://projecteuler.net/problem=435

# Runtime: 0.990s

use 5.020;
use strict;
use warnings;

use ntheory qw(addmod mulmod powmod factor_exp factorial chinese);

my @chinese;
foreach my $p (factor_exp(factorial(15))) {

    my $n  = 10**15;
    my $pp = $p->[0]**$p->[1];

    my $sum = 0;
    my ($f1, $f2) = (0, 1);

    my @array;
    foreach my $k (1 .. $n) {

        my $power_sum = 0;
        foreach my $x (1 .. 100) {
            $power_sum = addmod($power_sum, powmod($x, $k, $pp), $pp);
        }

        $sum = addmod($sum, mulmod($f2, $power_sum, $pp), $pp);
        ($f1, $f2) = ($f2, addmod($f1, $f2, $pp));

        push @array, $sum;

        if ($k > 20 and join(' ', @array[9              .. $#array/2])
                     eq join(' ', @array[$#array/2 + 10 .. $#array])
        ) {
            $sum = $array[($n % $k) - 1];
            last;
        }
    }

    push @chinese, [$sum, $pp];
}

say chinese(@chinese);
