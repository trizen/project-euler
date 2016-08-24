#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 24 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=207

# A naive approach; almost brute-force.

use 5.010;
use strict;
use warnings;

my %table;

sub pp_ratio {
    my ($n) = @_;

    my $perfect     = 0;
    my $non_perfect = 0;

    for (my $i = 1 ; ; ++$i) {
        my $k = $i * ($i + 1);
        last if $k > $n;
        exists($table{$k}) ? ++$perfect : ++$non_perfect;
    }

    $perfect / ($perfect + $non_perfect);
}

my $ratio = 1 / 12345;

foreach my $i (1 .. 30) {
    undef $table{4**$i - 2**$i};
}

my $k = 1;
my $j = 2;

my $upper_bound;

for (my $i = 1 ; ; $i += $k) {
    if (pp_ratio($i * ($i + 1)) < $ratio) {
        $upper_bound = $i * ($i + 1);
        last;
    }

    if ($i % $j == 0) {
        ++$k;
        ++$j;
    }
}

for (my $i = int sqrt($upper_bound) - 2 * $k ; ; ++$i) {
    if (pp_ratio($i * ($i + 1)) < $ratio) {
        say $i* ($i + 1);
        last;
    }
}
