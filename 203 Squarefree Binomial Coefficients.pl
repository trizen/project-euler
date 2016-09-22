#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 22 September 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=203

# Runtime: 0.019s

use 5.010;
use strict;

use ntheory qw(binomial vecsum is_square_free);

sub pascal {
    my ($rows) = @_;
    my %table;
    for my $n (0 .. $rows - 1) {
        undef @table{map { binomial($n, $_) } 0 .. $n};
    }
    vecsum(grep { is_square_free($_) } keys %table);
}

say pascal(51);
