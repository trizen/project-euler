#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 19 September 2020
# https://github.com/trizen

# https://projecteuler.net/problem=365

# See also:
#   https://en.wikipedia.org/wiki/Lucas%27s_theorem

# Runtime: ~7 minutes.

use 5.020;
use strict;
use warnings;

use experimental qw(signatures);
use ntheory qw(:all);

sub modular_binomial {
    my ($n, $k, $m) = @_;
    divmod(divmod(factorialmod($n, $m), factorialmod($k, $m), $m), factorialmod($n - $k, $m), $m);
}

sub lucas_theorem ($n, $k, $p) {

    if ($n < $k) {
        return 0;
    }

    my $prod = 1;

    while ($k > 0) {
        my ($Nr, $Kr) = ($n % $p, $k % $p);

        if ($Nr < $Kr) {
            return 0;
        }

        ($n, $k) = (divint($n, $p), divint($k, $p));
        $prod = mulmod($prod, modular_binomial($Nr, $Kr, $p), $p);
    }

    return $prod;
}

my @primes = @{primes(1000, 5000)};
my $end = $#primes;

my $N = 1000000000000000000;
my $K = 1000000000;

my $sum = 0;

foreach my $i (0 .. $end - 2) {
    my $first = [lucas_theorem($N, $K, $primes[$i]), $primes[$i]];
    foreach my $j ($i + 1 .. $end - 1) {
        my $second = [lucas_theorem($N, $K, $primes[$j]), $primes[$j]];
        foreach my $k ($j + 1 .. $end) {
            my $third = [lucas_theorem($N, $K, $primes[$k]), $primes[$k]];
            $sum += chinese($first, $second, $third);
        }
    }
    say "$i -> $sum";
}

say "Total: $sum";
