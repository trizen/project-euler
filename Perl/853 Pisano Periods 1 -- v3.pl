#!/usr/bin/perl

# Pisano Periods 1
# https://projecteuler.net/problem=853

# Runtime: 1.017s

use 5.036;
use Math::Sidef qw(fibonacci pisano_period sum divisors);

my $n     = 120;
my $limit = 1e9;

say sum(grep { pisano_period($_) == $n } divisors(fibonacci($n), $limit));
