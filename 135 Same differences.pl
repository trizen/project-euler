#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 12 August 2017
# https://github.com/trizen

# https://projecteuler.net/problem=135

# Runtime: 4.611s

use 5.010;
use strict;
use warnings;

use ntheory qw(divisors);

sub has_ten_solutions {
    my ($n) = @_;

    my @divisors = divisors($n);

    my $count = 0;
    foreach my $divisor (@divisors) {

        last if $divisor > sqrt($n);

        my $p = $divisor;
        my $q = $n / $divisor;
        my $k = $q + $p;

        ($k % 4 == 0) ? ($k >>= 2) : next;

        my $x1 = 3*$k - sqrt(4 * $k**2 - $n);
        my $x2 = 3*$k + sqrt(4 * $k**2 - $n);

        if (($x1 - 2*$k) > 0) {
            ++$count;
        }

        if ($x1 != $x2) {
            return 0 if ++$count > 10;
        }
    }

    return ($count == 10);
}

my $count = 0;
foreach my $n (1 .. 1e6 - 1) {
    ($n % 4 != 1)
        && has_ten_solutions($n)
        && $count++;
}
say $count;
