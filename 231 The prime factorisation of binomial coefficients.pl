#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 25 August 2016
# Website: https://github.com/trizen

# https://projecteuler.net/problem=231

# Runtime: 1.583s

use 5.020;
use strict;
use warnings;

use experimental qw(signatures);
use ntheory qw(forprimes vecsum todigits);

sub factorial_power ($n, $p) {
    ($n - vecsum(todigits($n, $p))) / ($p - 1);
}

my $n = 20000000;
my $k = 15000000;
my $j = $n - $k;

my $sum = 0;

forprimes {
    my $p = factorial_power($n, $_);

    if ($_ <= $k) {
        $p -= factorial_power($k, $_);
    }

    if ($_ <= $j) {
        $p -= factorial_power($j, $_);
    }

    $sum += $p * $_;

} $n;

say $sum;
