#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 31 August 2016
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=66

# Runtime: 0.501s

use 5.010;
use strict;
use warnings;

use Math::AnyNum qw(isqrt is_square);

sub sqrt_convergents {
    my ($n) = @_;

    my $x = isqrt($n);
    my $y = $x;
    my $z = 1;

    my @convergents = ($x);

    do {
        $y = int(($x + $y) / $z) * $z - $y;
        $z = int(($n - $y * $y) / $z);
        push @convergents, int(($x + $y) / $z);
    } until (($y == $x) && ($z == 1));

    return @convergents;
}

sub cfrac_denominator {
    my (@cfrac) = @_;

    my ($f1, $f2) = (0, 1);

    foreach my $n (@cfrac) {
        ($f1, $f2) = ($f2, $n * $f2 + $f1);
    }

    return $f1;
}

sub solve_pell {
    my ($d) = @_;

    my ($k, @period) = sqrt_convergents($d);

    {
        my $x = cfrac_denominator($k, @period);
        my $p = 4 * $d * ($x * $x - 1);

        if (is_square($p)) {
            return ($x, isqrt($p) / (2 * $d));
        }

        push @period, @period;
        redo;
    }
}

my %max = (x => 0, d => -1);

foreach my $i (2 .. 1000) {
    is_square($i) && next;

    my $x = solve_pell($i);

    if ($x > $max{x}) {
        $max{x} = $x;
        $max{d} = $i;
    }
}

say $max{d};
