#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 30 January 2017
# https://github.com/trizen

# https://projecteuler.net/problem=92

# Runtime: 22.566s

use 5.010;
use strict;
use integer;

use List::Util qw(sum);

my @cache;
my @squares = map { $_ * $_ } 0 .. 9;

sub chain {
    my ($n) = @_;

    $n == 1  && return 1;
    $n == 89 && return 89;

    $cache[$n] //= chain(sum(@squares[split(//, $n)]));
}

my $count = 0;

foreach my $n (1 .. 1e7) {
    ++$count if chain($n) == 89;
}

say $count;
