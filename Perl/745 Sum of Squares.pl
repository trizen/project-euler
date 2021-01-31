#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 31 January 2021
# https://github.com/trizen

# Sum of Squares
# https://projecteuler.net/problem=745

# Formula:
#   S(n) = Sum_{k=1..floor(sqrt(n))} k^2 * R(floor(n/k^2))

# Where R(n) is the number of squarefree numbers <= n:
#   R(n) = Sum_{k=1..floor(sqrt(n))} moebius(k) * floor(n/k^2)

# S(10^1)  = 24
# S(10^2)  = 767
# S(10^3)  = 22606
# S(10^4)  = 722592
# S(10^5)  = 22910120
# S(10^6)  = 725086120
# S(10^7)  = 22910324448
# S(10^8)  = 724475280152
# S(10^9)  = 22907428923832
# S(10^10) = 724420596049320
# S(10^11) = 22908061437420776
# S(10^12) = 724418227020757048
# S(10^13) = 22908104289912800016

# Runtime: ~36 seconds.

use 5.020;
use warnings;

use ntheory qw(:all);
use experimental qw(signatures);

sub S ($n, $MOD) {

    my @mu = moebius(0, sqrtint($n));

    my sub squarefree_count ($n) {
        my $total = 0;
        foreach my $k (1 .. sqrtint($n)) {
            $total += $mu[$k] * divint($n, $k * $k) if $mu[$k];
        }
        $total;
    }

    my $total = 0;

    foreach my $k (1 .. sqrtint($n)) {
        $total += mulmod($k * $k, squarefree_count(divint($n, $k * $k)), $MOD);
    }

    $total % $MOD;
}

say S(10**14, 1_000_000_007);
