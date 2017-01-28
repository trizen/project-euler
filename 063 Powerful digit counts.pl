#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 28 January 2017
# https://github.com/trizen

# https://projecteuler.net/problem=63

# Runtime: 0.026s

use 5.010;
use strict;

use Math::GMP qw(:constant);

my $count = 0;

for (my $n = 1 ; $n < 10 ; ++$n) {
    foreach my $m (1 .. 3*$n) {   # just works™
        ++$count if (length($n**$m) == $m);
    }
}

say $count;
