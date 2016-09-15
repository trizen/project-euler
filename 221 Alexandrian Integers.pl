#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 18 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=221

# Runtime: 3.966s

use 5.010;
use strict;
use ntheory qw(divisors);

my %nums;
my $count = 0;

my $nth  = 150000;
my $prev = 6;

OUT: foreach my $n (1 .. $nth) {
    foreach my $d (divisors($n * $n + 1)) {

        my $q = $n + $d;
        my $r = ($n + ($n * $n + 1) / $d);

        last if $q > $r;

        my $A = $n * $q * $r;
        --$count if ($A < $prev);

        if (not exists $nums{$A}) {
            undef $nums{$A};
            $prev = $A;
            last OUT if (++$count == $nth);
        }
    }
}

say +(sort { $a <=> $b } keys %nums)[$nth - 1];
