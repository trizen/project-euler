#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 13 October 2017
# https://github.com/trizen

# https://projecteuler.net/problem=271

# Runtime: 0.170s

use 5.010;
use strict;
use warnings;

use ntheory qw(chinese powmod factor_exp forsetproduct);

sub modular_cubes {
    my ($n) = @_;

    my %table;
    foreach my $p (factor_exp($n)) {
        my $pp = $p->[0]**$p->[1];

        push @{$table{$pp}}, [1, $pp];

        foreach my $x (2 .. $pp - 1) {
            if (powmod($x, 3, $pp) == 1) {
                push @{$table{$pp}}, [$x, $pp];
            }
        }
    }

    my $sum = 0;

    forsetproduct {
        my $x = chinese(@_);
        if ($x > 1 and powmod($x, 3, $n) == 1) {
            $sum += $x;
        }
    } values %table;

    return $sum;
}

modular_cubes(91) == 363 or die "error";

say modular_cubes(13082761331670030);
