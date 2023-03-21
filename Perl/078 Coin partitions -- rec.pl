#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 15 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=78

# Runtime: 33.910s

use 5.010;
use strict;

use POSIX qw(ceil);
use Memoize qw(memoize);

memoize('partitions_count');

sub partitions_count {
    my ($n) = @_;

    return $n if ($n <= 1);

    my $sum_1 = 0;
    foreach my $i (1 .. (sqrt(24 * $n + 1) + 1) / 6) {
        $sum_1 += ((-1)**($i - 1) * partitions_count($n - $i * (3 * $i - 1) / 2)) % 1e6;
    }

    my $sum_2 = 0;
    foreach my $i (1 .. ceil((sqrt(24 * $n + 1) - 7) / 6)) {
        $sum_2 += ((-1)**($i - 1) * partitions_count($n - (-$i) * (-3 * $i - 1) / 2)) % 1e6;
    }

    ($sum_1 + $sum_2) % 1e6;
}

my $n = 1;

while (1) {
    if (partitions_count($n) == 0) {
        say ($n - 1);
        last;
    }
    ++$n;
}
