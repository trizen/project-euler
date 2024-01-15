#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 28 August 2016
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=211

use 5.010;
use strict;

use LWP::Simple qw(get);

my $url   = 'https://oeis.org/A046655/b046655.txt';
my $limit = 64_000_000;

my $sum = 0;

foreach my $term (split(/\R/, get($url))) {
    my (undef, $n) = split(' ', $term);
    last if $n >= $limit;
    $sum += $n;
}

say $sum;
