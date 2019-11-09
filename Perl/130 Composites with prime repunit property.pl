#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 12 May 2017
# https://github.com/trizen

# https://projecteuler.net/problem=130

# Runtime: 0.315s

use 5.010;
use strict;
use warnings;

use Math::GMPz;
use ntheory qw(gcd is_prime);

my $sum   = 0;
my $count = 0;

for (my $n = 2; ; ++$n) {

    is_prime($n)     && next;
    gcd($n, 10) != 1 && next;

    Math::GMPz->new('1' x ($n-1)) % $n == 0 or next;

    $sum += $n;
    last if ++$count == 25;
}

say $sum;
