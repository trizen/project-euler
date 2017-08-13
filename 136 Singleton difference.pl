#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 12 August 2017
# https://github.com/trizen

# https://projecteuler.net/problem=136

# Runtime: 1 min, 25 sec

use 5.010;
use strict;
use warnings;

use ntheory qw(divisors forprimes);

sub has_unique_solution {
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
            return 0 if ++$count > 1;
        }
    }

    return ($count == 1);
}

my $count = 0;
my $limit = 50e6 - 1;

forprimes {
    if ($_ % 4 == 3) {
        ++$count;
    }
} $limit;

foreach my $n (1 .. $limit>>2) {
    has_unique_solution(4*$n) && ++$count;
}

say $count;
