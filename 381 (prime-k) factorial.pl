#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 21 August 2016
# Website: https://github.com/trizen

# https://projecteuler.net/problem=381

# Runtime: 7.220s

# Based on the following relations:
#
#   (p-1)! mod p = p-1
#   (p-2)! mod p = 1
#   (p-3)! mod p = (p-1)/2
#
# (p-4)! mod p has two paths:
#
# If (p+1) is     divisible by 6, then: (p-4)! mod p = (p+1)/6
# If (p+1) is not divisible by 6, then: (p-4)! mod p = p-floor(p/6)
#
# (p-5)! mod p has about 7 paths, which only two I analyzed:
#
# If (p-1) is divisible by 24, then (p-5)! mod p =     (p-1)/24
# If (p+1) is divisible by 24, then (p-5)! mod p = p - (p+1)/24
#
# In all other cases of (p-5)! mod p, it uses a specialized algorithm for computing factorial(p-5) mod p.

use 5.010;
use strict;
use integer;
use ntheory qw(forprimes invmod);

sub facmod {
    my ($n, $mod) = @_;

    my $f = 1;
    foreach my $k ($n + 1 .. $mod - 1) {
       $f *= $k;
       $f %= $mod;
    }

    (-1 * invmod($f, $mod) + $mod) % $mod
}

sub S {
    my ($p) = @_;

    (         1
     +  ($p - 1)
     + (($p - 1) /  2)
     + (($p + 1) %  6 == 0 ? ($p + 1) / 6 : $p - ($p / 6))
     + (($p - 1) % 24 == 0 ? ($p - 1) / 24
     :  ($p + 1) % 24 == 0 ? ($p - (($p + 1) / 24))
     :  facmod($p - 5, $p)
     )
    ) % $p;
}

my $sum = 0;
forprimes { $sum += S($_) } 5, 10**8;
say $sum;
