#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 20 August 2017
# https://github.com/trizen

# Algorithm due to Aleksey (https://projecteuler.net/thread=401).

# https://projecteuler.net/problem=401

# Runtime: 7 min, 33 sec

use 5.010;
use strict;
use warnings;

use Math::GMPz;
use ntheory qw(sqrtint mulmod addmod);

my $mod = 10**9;
my $lim = 10**15;

sub f {
    my ($n) = @_;
    $n * ($n + 1) * (2 * $n + 1) / 6;
}

sub sum_of_sum_of_squared_divisors {
    my ($n) = @_;

    my $s = sqrtint($n);
    my $u = int($n / ($s + 1));

    my $sum = 0;

    foreach my $k (1 .. $s) {
        $sum = addmod($sum,
                      mulmod($k, (
                                    f(Math::GMPz->new(int($n / $k)))
                                  - f(Math::GMPz->new(int($n / ($k + 1))))
                                 ) % $mod, $mod
                      ), $mod);
    }

    foreach my $k (1 .. $u) {
        $sum = addmod($sum, mulmod($k**2, int($n / $k), $mod), $mod);
    }

    return $sum;
}

say sum_of_sum_of_squared_divisors($lim);
