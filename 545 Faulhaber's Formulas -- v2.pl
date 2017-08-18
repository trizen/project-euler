#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 18 August 2017
# https://github.com/trizen

# https://projecteuler.net/problem=545

# Runtime: 1 min, 15 sec

use 5.010;
use strict;
use integer;
use warnings;

use List::Util qw(product);
use ntheory qw(divisors is_prime factor);

sub F {
    my ($m) = @_;

    my $c = 308;
    my $n = 20010;
    my $t = product(map { $_ - 1 } factor($n));

    for (my $k = 1 ; ; ++$k) {
        if (product(grep { is_prime($_ + 1) } divisors($c * $k)) == $t) {
            (return $c * $k) if (--$m <= 0);
        }
    }
}

say F(10**5);
