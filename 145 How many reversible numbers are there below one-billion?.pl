#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 17 February 2017
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=145

# Runtime: 6 min 49s

use 5.014;
use strict;
use integer;

my $count = 0;

foreach my $n (1 .. 10**9) {
    if ($n % 10 != 0 and (($n + reverse($n)) =~ tr/13579//dsr) eq '') {
        ++$count;
    }
}

say $count;
