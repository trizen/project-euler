#!/usr/bin/perl

# Product of Gauss Factorials
# https://projecteuler.net/problem=754

# See also:
#   https://oeis.org/A001783

use 5.014;
use strict;
use warnings;

use ntheory qw(:all);
use List::Util qw(reduce);
use experimental qw(signatures);

sub squarefree_divisors {
    my ($n) = @_;

    my @d  = (1);
    my @pp = map { $_->[0] } factor_exp($n);

    foreach my $p (@pp) {
        push @d, map { $_ * $p } @d;
    }

    @d;
}

sub F ($n, $m) {

    my $prod = 1;

    foreach my $k (1 .. $n) {
        if (is_prime($k)) {
            $prod = mulmod($prod, factorialmod($k - 1, $m), $m);
        }
        else {
            $prod = mulmod(
                           mulmod($prod, powmod($k, euler_phi($k), $m), $m),
                           (
                            reduce { mulmod($a, $b, $m) }
                              map { powmod(divmod(factorialmod($k / $_, $m), powmod($k / $_, $k / $_, $m), $m), moebius($_), $m) }
                              squarefree_divisors($k)
                           ),
                           $m
                          );
        }
    }

    return $prod;
}

F(10, next_prime(powint(10, 20))) == 23044331520000
  or die "error!";

#say F(1e3, 1000000007);      # takes 0.09s
#say F(1e4, 1000000007);      # takes 0.6s
#say F(1e5, 1000000007);      # takes 24s

say F(1e8, 1000000007);
