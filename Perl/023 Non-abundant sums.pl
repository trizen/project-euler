#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# https://github.com/trizen

# Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.

# https://projecteuler.net/problem=23

# Runtime: 4.463s

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
