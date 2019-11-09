#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 24 August 2016
# Website: https://github.com/trizen

# https://projecteuler.net/problem=206

# Runtime: 0.012s

use 5.010;
use strict;
use warnings;

my $n = int sqrt(1020304050607080900);    # lower-limit
my $m = int sqrt(1929394959697989990);    # upper-limit

for (my $i = $m + (10 - ($m % 10)) ; $i >= $n ; $i -= 10) {
    if (($i**2) =~ /^1.2.3.4.5.6.7.8.9.0\z/) {
        say $i;
        last;
    }
}
