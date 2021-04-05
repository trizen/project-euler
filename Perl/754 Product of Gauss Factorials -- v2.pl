#!/usr/bin/perl

# Product of Gauss Factorials
# https://projecteuler.net/problem=754

# See also:
#   https://oeis.org/A001783

# Using the identity:
#   A001783(n) = A250269(n) / A193679(n)
#              = (Prod_{d|n} (d!)^mu(n/d)) / (Prod_{p|n} p^(phi(n) / (p-1)))

use 5.014;
use strict;
use warnings;

use integer;
use ntheory qw(:all);
use List::Util qw(reduce);
use experimental qw(signatures);

{
    my %cache;

    sub my_factorialmod ($n, $m) {
        $cache{$n} //= factorialmod($n, $m);
    }
}

sub F ($n, $m) {

    my $prod1 = 1;
    my $prod2 = 1;

    foreach my $k (2 .. $n) {
        if (is_prime($k)) {
            $prod1 = mulmod($prod1, my_factorialmod($k - 1, $m), $m);
        }
        else {
            my $phi     = euler_phi($k);
            my @factors = factor_exp($k);

            $prod1 = mulmod(
                $prod1,
                (
                 reduce { mulmod($a, $b, $m) }
                 map { powmod(my_factorialmod($k / $_, $m), moebius($_), $m) } divisors(vecprod(map { $_->[0] } @factors))
                ),
                $m
                           );

            $prod2 = mulmod(
                $prod2,
                (
                 reduce { mulmod($a, $b, $m) }
                 map { powmod($_->[0], $phi / ($_->[0] - 1), $m) } @factors
                ),
                $m
                           );
        }
    }

    return divmod($prod1, $prod2, $m);
}

F(10, next_prime(powint(10, 20))) == 23044331520000
  or die "error!";

#say F(1e3, 1000000007);      # takes 0.07s
#say F(1e4, 1000000007);      # takes 0.4s
#say F(1e5, 1000000007);      # takes 13s

say F(1e8, 1000000007);
