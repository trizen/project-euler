#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 15 September 2016
# Website: https://github.com/trizen

# https://projecteuler.net/problem=288

# Runtime: 4.453s

use 5.010;
use strict;

use ntheory qw(powmod);

my $p   = 61;
my $q   = 10**7;
my $k   = 10;
my $mod = 61**$k;

my $s = 290797;

sub fpower {
    my ($n) = @_;
    return 0 if $n == 0;
    powmod($p, $n - 1, $mod) + fpower($n - 1);
}

my $sum = 0;
my $pow = 0;

foreach my $n (0 .. $q) {
    my $t = $s % $p;
    $s = powmod($s, 2, 50515093);

    if ($n <= $k) {
        $pow = fpower($n);
    }

    if ($t != 0) {
        $sum += $pow * $t;
        $sum %= $mod;
    }
}

say $sum;
