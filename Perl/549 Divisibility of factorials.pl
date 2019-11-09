#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 17 September 2016
# Website: https://github.com/trizen

# https://projecteuler.net/problem=549

# Runtime: 6 min 33.61s

use utf8;
use 5.010;
use strict;
use integer;

use ntheory qw(
    vecmax
    vecsum
    is_prime
    factorial
    sum_primes
    factor_exp
    forcomposites
);

my $limit = 10**8;

my %cache;

sub smarandache {
    my ($n) = @_;

    return $n if is_prime($n);

    my @f = factor_exp($n);
    my $Ω = vecsum(map { $_->[1] } @f);

    (@f == $Ω)
      && return $f[-1][0];

    if (@f == 1) {

        my $ϕ = $f[0][0];

        ($Ω <= $ϕ)
          && return $ϕ * $Ω;

        exists($cache{$n})
          && return $cache{$n};

        my $m = $ϕ * $Ω;
        my $f = factorial($m - $ϕ);

        while ($f % $n == 0) {
            $m -= $ϕ;
            $f /= $m;
        }

        return ($cache{$n} = $m);
    }

    vecmax(map {
            $_->[1] == 1 ? $_->[0]
                         : smarandache($_->[0]**$_->[1])
    } @f);
}

my $sum = 0;

forcomposites {
    $sum += smarandache($_);
} $limit;

$sum += sum_primes($limit);

say $sum;
