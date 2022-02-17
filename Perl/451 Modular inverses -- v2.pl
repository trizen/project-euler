#!/usr/bin/perl

# Author: Trizen
# 17 February 2022
# https://github.com/trizen

# https://projecteuler.net/problem=451

# Runtime: 55 seconds.

use 5.010;
use strict;
use warnings;
use ntheory qw(:all);

sub l {
    (allsqrtmod(1, $_[0]))[-2];
}

my $sum = 0;
foreach my $d (3 .. 2e7) {
    $sum += l($d);
}
say $sum;
