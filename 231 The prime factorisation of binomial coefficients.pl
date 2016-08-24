#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 25 August 2016
# Website: https://github.com/trizen

# https://projecteuler.net/problem=231

use 5.010;
use strict;
use integer;
use ntheory qw(forprimes);

sub power {
    my ($n, $p) = @_;

    my $s = 0;
    while ($n >= $p) {
        $s += int($n /= $p);
    }

    $s;
}

my $n = 20000000;
my $k = 15000000;
my $j = $n - $k;

my $sum = 0;

forprimes {
    my $p = power($n, $_);

    if ($_ <= $k) {
        $p -= power($k, $_);
    }

    if ($_ <= $j) {
        $p -= power($j, $_);
    }

    $sum += $p * $_;

} $n;

say $sum;
