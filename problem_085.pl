#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 20 August 2016
# Website: https://github.com/trizen

# https://projecteuler.net/problem=85

use 5.010;
use strict;
use warnings;

use ntheory qw(binomial);

my $t = 2_000_000;
my $m = 'inf';
my $v = [0, 0];

my ($x, $y) = (int(sqrt($t)), 1);

while (1) {
    my $p = binomial($x + 1, 2) * binomial($y + 1, 2);
    my $d = abs($p - $t);

    if ($d < $m) {
        $v = [$x, $y];
        $m = $d;
    }

    $x >= $y ? ($p > $t ? --$x : ++$y) : last;
}

say "(@{$v}) = ", $v->[0] * $v->[1];
