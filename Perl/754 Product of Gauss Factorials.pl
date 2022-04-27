#!/usr/bin/perl

# Product of Gauss Factorials
# https://projecteuler.net/problem=754

# See also:
#   https://oeis.org/A001783

# Using the identity:
#   A001783(n) = A250269(n) / A193679(n)
#              = (Prod_{d|n} (d!)^mu(n/d)) / (Prod_{p|n} p^(phi(n) / (p-1)))

# WARNING: requires about 5.2 GB of RAM!

# Runtime: ~25 minutes.

use 5.020;
use strict;
use warnings;

use ntheory qw(:all);
use List::Util qw(reduce uniq);
use experimental qw(signatures);

sub F ($n, $m) {

    my $prod1 = 1;
    my $prod2 = 1;

    my $nfac   = 1;
    my @facmod = (1);

    say ":: Building factorial table for n = $n";

    foreach my $k (1 .. $n) {
        $nfac = mulmod($nfac, $k, $m);
        push @facmod, $nfac;
    }

    say ":: Computing the product of Gaussian factorials...";

    forfactored {
        my $k = $_;

        if (is_prime($k)) {
            $prod1 = mulmod($prod1, $facmod[$k - 1], $m);
        }
        else {
            my $phi = euler_phi($k);

            $prod1 = mulmod(
                            $prod1,
                            (
                             reduce { mulmod($a, $b, $m) }
                             map { powmod($facmod[divint($k, $_)], moebius($_), $m) } divisors(vecprod(uniq(@_)))
                            ),
                            $m
                           );

            $prod2 = mulmod(
                            $prod2,
                            (
                             reduce { mulmod($a, $b, $m) }
                             map { powmod($_, divint($phi, $_ - 1), $m) } uniq(@_)
                            ),
                            $m
                           );
        }
    } 2, $n;

    return divmod($prod1, $prod2, $m);
}

use Test::More tests => 6;

is(F(10,  next_prime(powint(10, 20))), 23044331520000);
is(F(10,  1_000_000_007),              331358692);
is(F(1e2, 1_000_000_007),              777776709);
is(F(1e3, 1_000_000_007),              297877340);
is(F(1e4, 1_000_000_007),              517055464);
is(F(1e5, 1_000_000_007),              516871211);

#say F(1e3, 1000000007);      # takes 0.07s
#say F(1e4, 1000000007);      # takes 0.4s
#say F(1e5, 1000000007);      # takes 2s
#say F(1e6, 1000000007);      # takes 15s
#say F(1e7, 1000000007);      # takes 2.5 minutes

say "\n:: Computing: G(10^8)";

say F(1e8, 1000000007);
