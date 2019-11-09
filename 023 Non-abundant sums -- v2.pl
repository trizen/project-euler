#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 07 November 2019
# https://github.com/trizen

# Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.

# https://projecteuler.net/problem=23

# Runtime: 0.524s

use 5.010;
use integer;
use ntheory qw(divisor_sum);
use experimental qw(signatures);

sub is_abundant ($n) {
    (divisor_sum($n) >> 1) > $n;
}

my $total = 0;
my @abundant;
my %abundant;

OUTER: foreach my $n (1 .. 28123) {

    if (is_abundant($n)) {
        $abundant{$n} = 1;
        push @abundant, $n;
    }

    foreach my $k (@abundant) {
        if (exists $abundant{$n - $k}) {
            next OUTER;
        }
    }

    $total += $n;
}

say $total;
