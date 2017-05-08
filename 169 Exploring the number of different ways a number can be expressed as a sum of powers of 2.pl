#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 20 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=169

# Runtime: 0.091s

use 5.010;
use strict;
use warnings;

use Memoize qw(memoize);
use Math::AnyNum qw(:overload);

memoize('f');

sub f {
    my ($n) = @_;

    return 0         if $n == 0;
    return 1         if $n == 1;
    return f($n / 2) if $n % 2 == 0;

    f(($n - 1) / 2) + f(($n - 1) / 2 + 1);
}

say f(10**25 + 1);
