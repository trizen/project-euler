#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 21 September 2016
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=500

# Runtime: 0.168s

use 5.010;
use strict;
use ntheory qw(forprimes primes logint);

sub first_n_factors {
    my ($num) = @_;

    my $limit   = logint($num, 2) * $num;     # overshoots a little bit
    my @factors = @{primes($limit)};

    forprimes {
        my $t = $_;
        while (($t **= 2) <= $limit) {
            push @factors, $t;
        }
    } $num;

    @factors = sort { $a <=> $b } @factors;
    $#factors = $num - 1;
    @factors;
}

my $p   = 1;
my $mod = 500500507;
my $pow = 500500;

foreach my $f (first_n_factors($pow)) {
    $p *= $f;
    $p %= $mod;
}

say $p;
