#!/usr/bin/perl

# Efficient algorithm for computing `binomial(n, k) mod m`, based on the factorization of `m`.

# Algorithm by Andrew Granville:
#     https://www.scribd.com/document/344759427/BinCoeff-pdf

# Algorithm translated from:
#   https://github.com/hellman/libnum/blob/master/libnum/modular.py

# Translated by: Daniel "Trizen" Șuteu
# Date: 29 September 2017
# https://github.com/trizen

# https://projecteuler.net/problem=365

# Runtime: ~1 hour.

use 5.020;
use strict;
use warnings;

use experimental qw(signatures);
use ntheory qw(factor_exp chinese invmod mulmod primes powmod);

use integer;

sub factorial_prime_pow ($n, $p) {

    my $count = 0;
    my $ppow  = $p;

    while ($ppow <= $n) {
        $count += $n / $ppow;
        $ppow *= $p;
    }

    return $count;
}

sub binomial_prime_pow ($n, $k, $p) {
#<<<
      factorial_prime_pow($n,      $p)
    - factorial_prime_pow($k,      $p)
    - factorial_prime_pow($n - $k, $p);
#>>>
}

sub binomial_non_prime_part ($n, $k, $p, $e) {
    my $pe = $p**$e;
    my $r  = $n - $k;

    my $acc     = 1;
    my @fact_pe = (1);

    foreach my $x (1 .. $pe - 1) {
        if ($x % $p == 0) {
            $x = 1;
        }
        $acc = ($acc * $x) % $pe;
        push @fact_pe, $acc;
    }

    my $top         = 1;
    my $bottom      = 1;
    my $is_negative = 0;
    my $digits      = 0;

    while ($n) {

        if ($acc != 1 and $digits >= $e) {
            $is_negative ^= $n & 1;
            $is_negative ^= $r & 1;
            $is_negative ^= $k & 1;
        }

#<<<
        $top    = ($top    * $fact_pe[$n % $pe]) % $pe;
        $bottom = ($bottom * $fact_pe[$r % $pe]) % $pe;
        $bottom = ($bottom * $fact_pe[$k % $pe]) % $pe;
#>>>

        $n = $n / $p;
        $r = $r / $p;
        $k = $k / $p;

        ++$digits;
    }

    my $res = ($top * invmod($bottom, $pe)) % $pe;

    if ($is_negative and ($p != 2 or $e < 3)) {
        $res = $pe - $res;
    }

    return $res;
}

sub modular_binomial_prime_power ($n, $k, $p, $e) {
    my $pow = binomial_prime_pow($n, $k, $p);

    if ($pow >= $e) {
        return 0;
    }

    my $modpow = $e - $pow;
    my $r = binomial_non_prime_part($n, $k, $p, $modpow) % $p**$modpow;

    if ($pow == 0) {
        return ($r % $p**$e);
    }

    return mulmod(powmod($p, $pow, $p**$e), $r, $p**$e);
}

my @primes = @{primes(1000, 5000)};
my $end = $#primes;

my $N = 1000000000000000000;
my $K = 1000000000;

my $sum = 0;

foreach my $i (0 .. $end - 2) {
    my $first = [modular_binomial_prime_power($N, $K, $primes[$i], 1), $primes[$i]];
    foreach my $j ($i + 1 .. $end - 1) {
        my $second = [modular_binomial_prime_power($N, $K, $primes[$j], 1), $primes[$j]];
        foreach my $k ($j + 1 .. $end) {
            my $third = [modular_binomial_prime_power($N, $K, $primes[$k], 1), $primes[$k]];
            $sum += chinese($first, $second, $third);
        }
    }
    say "$i -> $sum";
}

say $sum;
