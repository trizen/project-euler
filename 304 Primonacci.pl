#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 20 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=304

# Runtime: 31.959s

use 5.010;
use strict;
use warnings;

use ntheory qw(next_prime);
use Memoize qw(memoize);
use Math::GMP qw(:constant);

memoize('a');
memoize('f');

my $mod = 1234567891011;

sub f {
    my ($n) = @_;

    return 1 if $n == 0;
    return 1 if $n == 1;

    my $k = int($n / 2);

    ($n % 2 == 0)
      ? (f($k) * f($k) + f($k - 1) * f($k - 1)) % $mod
      : (f($k) * f($k + 1) + f($k - 1) * f($k)) % $mod;
}

sub a {
    my ($n) = @_;
    $n == 1
      ? next_prime(10**14)
      : next_prime(a($n - 1));
}

my $sum = 0;
for my $i (1 .. 100_000) {
    $sum += f(a($i) - 1);
    $sum %= $mod;
}

say $sum;
