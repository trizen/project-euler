#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 18 August 2017
# https://github.com/trizen

# https://projecteuler.net/problem=545

# Runtime: 3 min, 38 sec

use 5.010;
use strict;
use warnings;

use ntheory qw(divisors vecprod is_prime);

sub F {
    my ($m) = @_;

    my $c = 308;
    my $n = 20010;

    for (my $k = 1 ; ; ++$k) {
        if (
            vecprod(
                    map  { $_ + 1           }
                    grep { is_prime($_ + 1) } divisors($c * $k)
            ) == $n
        ) {
            (return $c * $k) if (--$m <= 0);
        }
    }
}

say F(10**5);
