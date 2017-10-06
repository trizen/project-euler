#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 03 October 2017
# https://github.com/trizen

# https://projecteuler.net/problem=451

# Runtime: ~5 minutes

use 5.010;
use strict;
use warnings;

use ntheory qw(:all);
use Set::Product::XS qw(product);

sub l {
    my ($n) = @_;

    # Power of two (n > 4)
    if (not($n & ($n - 1)) and $n > 4) {
        return (($n >> 1) + 1);
    }

    # Prime power or twice a prime power
    if (is_prime_power($n) or ($n % 2 == 0 and is_prime_power($n >> 1))) {
        return 1;
    }

    my %table;
    foreach my $f (factor_exp($n)) {
        my $pp = $f->[0]**$f->[1];

        if ($pp == 2) {
            push(@{$table{$pp}}, [1, $pp]);
        }
        elsif ($pp == 4) {
            push(@{$table{$pp}}, [1, $pp], [3, $pp]);
        }
        elsif ($pp % 2 == 0) {    # 2^k, where k >= 3
            push(@{$table{$pp}},
                [$pp / 2 - 1, $pp], [$pp - 1, $pp],
                [$pp / 2 + 1, $pp], [$pp + 1, $pp]);
        }
        else {                    # odd prime power
            push(@{$table{$pp}}, [1, $pp], [$pp - 1, $pp]);
        }
    }

    my $solution = 1;

    # Generate the solutions and pick the largest one bellow n-1
    product {
        my $x = chinese(@_);
        if ($x > $solution and $x < $n - 1) {
            $solution = $x;
        }
    } values %table;

    return $solution;
}

my $sum = 0;
foreach my $d (3 .. 2e7) {
    $sum += l($d);
}
say $sum;
