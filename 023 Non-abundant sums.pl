#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=23

# Runtime: 5.372s

use 5.010;
use integer;
use ntheory qw(divisor_sum);

my @abundants;
foreach my $i (1 .. 28123) {
    if (divisor_sum($i) - $i > $i) {
        push @abundants, $i;
    }
}

my %seen;
foreach my $i (@abundants) {
    foreach my $j (@abundants) {
        last if $i + $j > 28123;
        undef $seen{$i + $j};
    }
}

my $sum = 0;
foreach my $i (1 .. 28123) {
    if (not exists $seen{$i}) {
        $sum += $i;
    }
}

say $sum;
