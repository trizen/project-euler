#!/usr/bin/perl

# Product of Gauss Factorials
# https://projecteuler.net/problem=754

# See also:
#   https://oeis.org/A001783

# Using the identity:
#   g(n) = Prod_{d|n} ((n/d)! * d^(n/d))^moebius(d)
#   G(n) = Prod_{d=1..n} Prod_{k=1..floor(n/d)} (k! * d^k)^moebius(d)

# Runtime: ~20 minutes.

use 5.020;
use strict;
use warnings;

use ntheory qw(:all);
use experimental qw(signatures);

sub F ($n, $m) {

    say ":: Computing the product of Gaussian factorials...";

    my $prod = 1;

    forsquarefree {
        my $k    = $_;
        my $nfac = 1;
        my $mu   = moebius($k);
        foreach my $j (1 .. divint($n, $k)) {
            $nfac = mulmod($nfac, $j,                                                     $m);
            $prod = mulmod($prod, powmod(mulmod($nfac, powmod($k, $j, $m), $m), $mu, $m), $m);
        }
    } $n;

    return $prod;
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
#say F(1e6, 1000000007);      # takes 12s
#say F(1e7, 1000000007);      # takes ~2 minutes

say "\n:: Computing: G(10^8)";

say F(1e8, 1000000007);
