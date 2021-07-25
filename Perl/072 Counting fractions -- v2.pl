#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 25 July 2021
# https://github.com/trizen

# Sum of Euler phi function phi(k) for 2 <= k <= 10^6.

# https://projecteuler.net/problem=72

# Runtime: 0.119s

use 5.020;
use strict;
use warnings;

use ntheory qw(moebius mertens);
use Math::AnyNum qw(dirichlet_sum);
#use Math::Sidef qw(:all);
use experimental qw(signatures);

say dirichlet_sum(1e6, sub ($n) { moebius($n) }, sub ($n) { $n },
                       sub ($n) { mertens($n) }, sub ($n) { ($n*($n+1))>>1 })-1;
