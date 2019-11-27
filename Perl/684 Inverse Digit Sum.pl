#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 27 November 2019
# https://github.com/trizen

# See OEIS sequence:
#   https://oeis.org/A051885

# The smallest numbers whose sum of digits is n, are numbers of the form r*10^j-1, with r=1..9 and j >= 0.

# This solution uses the following formula:
#   Sum_{j=0..n} (r*10^j-1) = (r * 10^(n+1) - r - 9*n - 9)/9

# By letting r=1..9, we get:
#   Sum_{r=1..9} Sum_{j=0..n} (r*10^j-1) = 2*(2^n * 5^(n+2) - 7) - 9*n

# By simplifying the formula further, we get:
#   S(k) = (((r-1)*r + 10) * 10^n - 2*(r + 9*n + 4))/2
#
# where:
#   n = floor(k/9)
#   r = 2+(k mod 9)

# https://projecteuler.net/problem=686

# Runtime: 0.031s

use 5.020;
use warnings;
use ntheory qw(:all);
use experimental qw(signatures);

my $MOD = 1000000007;

sub fib ($n) {
    lucasu(1, -1, $n);
}

sub S($k) {

    my $n = divint($k, 9);
    my $r = divrem($k, 9) + 2;

    my $x = mulmod(mulmod($r-1, $r, $MOD) + 10, powmod(10, $n, $MOD), $MOD);
    my $y = mulmod(2, 4 + $r + mulmod(9, $n, $MOD), $MOD);
    my $z = invmod(2, $MOD);

    mulmod($x-$y, $z, $MOD);
}

S(20) == 1074    or die "error";
S(49) == 1999945 or die "error";

my $sum = 0;

foreach my $k (2 .. 90) {
    $sum = addmod($sum, S(fib($k)), $MOD);
}

say $sum;
