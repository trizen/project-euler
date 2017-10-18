#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 18 October 2017
# https://github.com/trizen

# https://projecteuler.net/problem=183

# Runtime: 14.560s

use 5.010;
use strict;
use warnings;

use ntheory qw(gcd valuation);

sub maximum_split {
    my ($n) = @_;

    my $min = 1;
    my $max = $n;

    while ($min < $max) {
        my $mid = ($min + $max) >> 1;

        my $x_prev = ($mid - 1) * log($n) - ($mid - 1) * log($mid - 1);
        my $x_curr = ($mid + 0) * log($n) - ($mid + 0) * log($mid + 0);
        my $x_next = ($mid + 1) * log($n) - ($mid + 1) * log($mid + 1);

        if ($x_prev < $x_curr and $x_curr > $x_next) {
            return $mid;
        }

        if ($x_prev < $x_curr and $x_curr < $x_next) {
            ++$min;
        }
        else {
            --$max;
        }
    }

    return $min;
}

my $sum = 0;

foreach my $n (5 .. 10000) {
    my $M = maximum_split($n);
    my $r = $M / gcd($n, $M);

    $r /= 2**valuation($r, 2) if ($r % 2 == 0);
    $r /= 5**valuation($r, 5) if ($r % 5 == 0);

    ($r == 1) ? ($sum -= $n) : ($sum += $n);
}

say $sum;
