#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 04 February 2019
# https://github.com/trizen

# A sublinear algorithm for computing the partial sums of the gcd-sum function, using Dirichlet's hyperbola method.

# The partial sums of the gcd-sum function is defined as:
#
#   a(n) = Sum_{k=1..n} Sum_{d|k} d*phi(k/d)
#
# where phi(k) is the Euler totient function.

# Also equivalent with:
#   a(n) = Sum_{j=1..n} Sum_{i=1..j} gcd(i, j)

# Based on the formula:
#   a(n) = (1/2)*Sum_{k=1..n} phi(k) * floor(n/k) * floor(1+n/k)

# Example:
#   a(10^1) = 122
#   a(10^2) = 18065
#   a(10^3) = 2475190
#   a(10^4) = 317257140
#   a(10^5) = 38717197452
#   a(10^6) = 4571629173912
#   a(10^7) = 527148712519016
#   a(10^8) = 59713873168012716
#   a(10^9) = 6671288261316915052

# OEIS sequences:
#   https://oeis.org/A272718 -- Partial sums of gcd-sum sequence A018804.
#   https://oeis.org/A018804 -- Pillai's arithmetical function: Sum_{k=1..n} gcd(k, n).

# See also:
#   https://en.wikipedia.org/wiki/Dirichlet_hyperbola_method
#   https://trizenx.blogspot.com/2018/11/partial-sums-of-arithmetical-functions.html

# https://projecteuler.net/problem=625

# WARNING: this program uses more than 3 GB of memory!

use 5.020;
use strict;
use warnings;

use experimental qw(signatures);
use ntheory qw(euler_phi sqrtint rootint addmod mulmod invmod);

sub partial_sums_of_gcd_sum_function ($n, $mod) {
    my $s = sqrtint($n);

    my @euler_sum_lookup = (0);

    my $lookup_size = 2 + 2 * rootint($n, 3)**2;
    my @euler_phi   = euler_phi(0, $lookup_size);

    foreach my $i (1 .. $lookup_size) {
        $euler_sum_lookup[$i] = addmod($euler_sum_lookup[$i - 1], $euler_phi[$i], $mod);
    }

    my $two_invmod = invmod(2, $mod);

    my %seen;

    my sub euler_phi_partial_sum($n) {

        if ($n <= $lookup_size) {
            return $euler_sum_lookup[$n];
        }

        if (exists $seen{$n}) {
            return $seen{$n};
        }

        my $s = sqrtint($n);
        my $T = mulmod(mulmod($n, $n + 1, $mod), $two_invmod, $mod);

        my $A = 0;
        foreach my $k (2 .. $s) {
            $A = addmod($A, __SUB__->(int($n / $k)), $mod);
        }

        my $B = 0;
        foreach my $k (1 .. int($n / $s) - 1) {
            $B = addmod($B, mulmod((int($n / $k) - int($n / ($k + 1))), __SUB__->($k), $mod), $mod);
        }

        $seen{$n} = addmod(addmod($T, -$A, $mod), -$B, $mod);
    }

    my $A = 0;

    foreach my $k (1 .. $s) {
        my $t = int($n / $k);
        my $z = mulmod(mulmod($t, ($t + 1), $mod), $two_invmod, $mod);
        $A = addmod($A, addmod(mulmod($k, euler_phi_partial_sum($t), $mod), mulmod($euler_phi[$k], $z, $mod), $mod), $mod);
    }

    my $T = mulmod(mulmod($s, $s + 1, $mod), $two_invmod, $mod);
    my $C = euler_phi_partial_sum($s);

    return addmod($A, -mulmod($T, $C, $mod), $mod);
}

my $n = 11;
my $mod = 998244353;

say "a(10^$n) = ", partial_sums_of_gcd_sum_function(10**$n, $mod);
