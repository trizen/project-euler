#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 27 January 2017
# https://github.com/trizen

# https://projecteuler.net/problem=27

# Runtime: 0.063s

use 5.010;
use strict;
use warnings;

use ntheory qw(is_prime forprimes);

my $limit = 1000;

my $max = 0;
my $p   = 0;
my $q   = 0;

forprimes {
    my $a = $_;

    forprimes {
        my $b = $_;

        my $n;
        for ($n = 0 ; is_prime($n**2 + $a * $n + $b) ; ++$n) { }

        if ($n > $max) {
            ($max, $p, $q) = ($n, $a, $b);
        }

        for ($n = 0 ; is_prime($n**2 - $a * $n + $b) ; ++$n) { }

        if ($n > $max) {
            ($max, $p, $q) = ($n, -$a, $b);
        }

    } $limit;
} $limit;

say "n^2 + $p*n + $q for 0 <= n < $max";
say "$p * $q = ", $p * $q;
