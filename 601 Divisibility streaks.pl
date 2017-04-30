#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 27 January 2017
# https://github.com/trizen

# https://projecteuler.net/problem=601

# Runtime: 0.028s

use 5.010;
use strict;
use ntheory qw(lcm);

sub count {
    my ($n, $k) = @_;
    my $lcm    = lcm(1 .. $n);
    my $period = lcm($lcm, $n + 1) / $lcm;
    my $count  = int(($k - 2) / $lcm);
    $count - int($count / $period);
}

my $sum = 0;
foreach my $n (1 .. 31) {
    $sum += count($n, 4**$n);
}

say $sum;
