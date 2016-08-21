#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 21 August 2016
# Website: https://github.com/trizen

# # https://projecteuler.net/problem=381

# Based on the following relations:
#
#   (p-1)! mod p = p-1
#   (p-2)! mod p = 1
#   (p-3)! mod p = (p-1)/2
#   (p-5)! mod p = (p^2 -1)/24
#
# (p-4)! mod p has two paths:
#
# If (p+1) is     divisible by 6, then: (p-4)! mod p = (p+1)/6
# If (p+1) is not divisible by 6, then: (p-4)! mod p = p-floor(p/6)

use 5.010;
use strict;
use integer;
use ntheory qw(forprimes);

sub S {
    my ($p) = @_;
    (            1
     +  ($p    - 1)
     + (($p    - 1) /  2)
     + (($p    + 1) %  6 == 0 ? ($p + 1) / 6 : $p - ($p / 6))
     + (($p*$p - 1) / 24)
    ) % $p;
}

my $sum = 0;
forprimes { $sum += S($_) } 5, 10**8;
say $sum;
