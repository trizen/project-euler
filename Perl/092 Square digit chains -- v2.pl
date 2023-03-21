#!/usr/bin/perl

# Author: Trizen
# Date: 21 March 2023
# https://github.com/trizen

# https://projecteuler.net/problem=92

# Runtime: 11.245s

use 5.010;
use strict;

use ntheory qw(todigits);
use List::Util qw(sum);

my @squares = map { $_ * $_ } 0 .. 9;
my @cache; $cache[1] = 1; $cache[89] = 89;

my $count = 0;
foreach my $k (1 .. 1e7) {

    my $n = $k;

    while (1) {
        $n = ($cache[$n] //= sum(@squares[todigits($n)]));
        if ($n == 1 or $n == 89) {
            last;
        }
    }

    if ($n == 89) {
        ++$count;
    }
}

say $count;
