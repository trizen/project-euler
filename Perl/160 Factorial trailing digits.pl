#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 17 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=160

use 5.010;
use strict;
use warnings;

use integer;
use ntheory qw(forprimes powmod);

sub power {
    my ($n, $p) = @_;

    my $s = 0;
    while ($n >= $p) {
        $s += int($n /= $p);
    }

    $s;
}

#my $k = 1_000_000_000_000;      # 2560000 yields the same answer

my $k = 2560000;
my $t = power($k, 5);

sub f {
    my ($n) = @_;

    my $p    = 0;
    my $prod = 1;

    forprimes {
        if ($p == 1) {
            $prod *= $_ % 10**5;
            $prod %= 10**5;
        }
        else {
            $p = power($n, $_);

            if ($_ != 5) {
                $prod *= powmod($_ % 10**5, ($_ == 2 ? $p - $t : $p), 10**5);
                $prod %= 10**5;
            }
        }

    } $k;

    $prod;
}

say f($k);
