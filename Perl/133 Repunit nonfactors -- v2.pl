#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 21 September 2019
# https://github.com/trizen

# https://projecteuler.net/problem=133

# Runtime: 0.042s

# See also:
#   https://oeis.org/A178070

use 5.010;
use strict;
use warnings;

use ntheory qw(:all);

my $limit = 100_000;

my %factors;
my $N = powint(10, logint($limit, 2));

forprimes {
    if ($N % znorder(10, $_) == 0) {
        $factors{$_} = 1;
    }
} 7, $limit;

say vecsum(grep { !$factors{$_} } @{primes($limit)});
