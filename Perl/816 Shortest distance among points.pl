#!/usr/bin/perl

# Author: Trizen
# Date: 26 November 2023
# https://github.com/trizen

# Shortest Distance Among Points
# https://projecteuler.net/problem=816

# Runtime: 25.038s

use 5.036;
use ntheory qw(powmod);

{
    my @cache;

    sub rng ($n) {
        $n == 0 && return 290797;
        $cache[$n] //= powmod(rng($n - 1), 2, 50515093);
    }
}

sub hypot ($a, $b) {
    sqrt($a**2 + $b**2);
}

sub d ($k) {

    my @P = map { [rng(2 * $_), rng(2 * $_ + 1)] } (1 .. $k);

    my @C1 = sort { $a->[0] <=> $b->[0] } @P;
    my @C2 = sort { $a->[1] <=> $b->[1] } @P;

    my $min_dist = 1e9**1e9;

    foreach my $i (0 .. $#C1 - 1) {
        my $p1   = $C1[$i];
        my $p2   = $C1[$i + 1];
        my $dist = hypot($p1->[0] - $p2->[0], $p1->[1] - $p2->[1]);

        if ($dist < $min_dist) {
            $min_dist = $dist;
        }
    }

    foreach my $i (0 .. $#C2 - 1) {
        my $p1   = $C2[$i];
        my $p2   = $C2[$i + 1];
        my $dist = hypot($p1->[0] - $p2->[0], $p1->[1] - $p2->[1]);

        if ($dist < $min_dist) {
            $min_dist = $dist;
        }
    }

    sprintf('%.9f', $min_dist);
}

d(14) eq '546446.466846479'  or die "error";
d(1000) eq '14759.650571745' or die "error";
d(2000) eq '16462.444107726' or die "error";

say d(2000000);
