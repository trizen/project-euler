#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 03 October 2017
# https://github.com/trizen

# https://projecteuler.net/problem=214

# Runtime: 14.080s

use 5.010;
use strict;
use warnings;

use ntheory qw(euler_phi forprimes);

my $sum = 0;
my $chain_len = 25;

forprimes {

    my $len = 1;

    for (my $n = euler_phi($_); ; $n = euler_phi($n)) {
        last if ++$len > $chain_len;
        last if $n == 1;
    }

    if ($len == $chain_len) {
        $sum += $_;
    }

} 40000000;

say $sum;
