#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 15 November 2019
# https://github.com/trizen

# Solution to the "Piles of Plates" problem.
# https://projecteuler.net/problem=688

# Let:
#   g(k) = k mod 2
#   f(k) = Sum_{d|k} g(d) = Sum_{d|k, d is odd} 1

# Then:
#   F(n) = Sum_{k=1..n} f(k)
#   F(n) = Sum_{k=1..n} g(k) * floor(n/k)

#   S(n) = Sum_{k=1..n} (n-k+1) * Sum_{d|k, d is odd} 1
#   S(n) = Sum_{k=1..n} Sum_{j=1..k} f(j)
#   S(n) = Sum_{k=1..n} f(k) * (n - k + 1)

# By splitting the last sum into two sums, we get:
#   S(n) = (n+1)*Sum_{k=1..n} f(k) - Sum_{k=1..n} f(k)*k

# In order to compute S(10^16), we need a sub-linear formula for computing:
#   A(n) = Sum_{k=1..n} f(k)
#   B(n) = Sum_{k=1..n} k*f(k)

# Then:
#   S(n) = (n+1)*A(n) - B(n)

# OEIS sequences:
#   A(n) = A060831(n)
#   B(n) = A285900(n)

# Formulas:
#   A(n) = Sum_{k=1..floor((n+1)/2)} floor(n/(2*k-1))
#   B(n) = Sum_{k=1..floor((n+1)/2)} (2*k-1)/2 * floor(n/(2*k-1)) * floor(1 + n/(2*k-1))

# A(n) can be computed in sub-linear time as:
#   A(n) = H(n) - H(floor(n/2))

# where:
#   H(n) = Sum_{k=1..n} floor(n/k)
#   H(n) = 2*Sum_{k=1..floor(sqrt(n))} floor(n/k) - floor(sqrt(n))^2

# Alternatively:
#   A(n) = Sum_{k=1..floor(sqrt(n))} (V(floor(n/k)) + g(k)*floor(n/k)) - V(floor(sqrt(n)))*floor(sqrt(n))

# where:
#   V(n) = floor((n+1)/2)

# B(n) can be computed in sub-linear time as:
#   B(n) = Sum_{k=1..floor(sqrt(n))} k * (G(floor(n/k)) + g(k) * F_1(floor(n/k))) - F_1(floor(sqrt(n))) * G(floor(sqrt(n)))

# where:
#   G(n) = floor((n+1)/2)^2
#   F_1(n) = n*(n+1)/2

# Runtime: 1 min, 21 sec.

use 5.020;
use strict;
use warnings;

use integer;
use ntheory qw(:all);
use experimental qw(signatures);

my $mod = 1000000007;

sub G($n) {
    my $t = ($n + 1) >> 1;
    mulmod($t, $t, $mod);
}

sub H($n) {
    my $A = 0;
    my $s = sqrtint($n);

    foreach my $k (1 .. $s) {
        $A += int($n / $k);
        $A %= $mod;
    }

    $A = mulmod($A, 2, $mod);
    $A = addmod($A, -mulmod($s, $s, $mod), $mod);
    return $A;
}

sub A($n) {
    addmod(H($n), -H($n >> 1), $mod);
}

sub B($n) {

    my $s = sqrtint($n);

    my $A = 0;
    foreach my $k (1 .. $s) {
        my $t = int($n / $k);
        $A += ($k * G($t)) % $mod;
        $A %= $mod;
    }

    my $B = 0;
    for (my $k = 1 ; $k <= $s ; $k += 2) {
        my $t = int($n / $k);
        $B += ($k * mulmod($t, $t + 1, $mod)) % $mod;
        $B %= $mod;
    }

    $B = divmod($B, 2, $mod);

    my $C = divmod(mulmod(G($s), mulmod($s, $s + 1, $mod), $mod), 2, $mod);

    my $total = 0;    # A + B - C
    $total = addmod($A,     $B,  $mod);
    $total = addmod($total, -$C, $mod);

    return $total;
}

sub S($n) {
    addmod(mulmod($n + 1, A($n), $mod), -(B($n)), $mod);
}

S(100) == 12656 or die "error";

foreach my $n (1..16) {
    say "S(10^$n) = ", S(powint(10, $n));
}
