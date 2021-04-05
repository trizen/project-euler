#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 14 March 2020
# https://github.com/trizen

# Smallest prime factor
# https://projecteuler.net/problem=521

# For each prime p < sqrt(n), we count how many integers k <= n have lpf(k) = p.

# We have G(n,p) = number of integers k <= n such that lpf(k) = p.
# G(n,p) can be evaluated recursively over primes q < p.
# There are t = floor(n/p) integers <= n that are divisible by p.
# From t we subtract the number integers that are divisible by smaller primes than p.

# The sum of the primes is p * G(n,p).
# When G(n,p) = 1, then G(n,p+r) = 1 for all r >= 1.

# Runtime: 6 min, 24 sec

use 5.020;
use integer;

use ntheory qw(:all);
use experimental qw(signatures);

my %cache;
my $MOD = 1e9;

sub G ($n, $p) {

    if ($p > sqrt($n)) {
        return 1;
    }

    if ($p == 2) {
        return ($n >> 1);
    }

    if ($p == 3) {
        my $t = $n / 3;
        return ($t - ($t >> 1));
    }

    my $key = "$n $p";

    if (exists $cache{$key}) {
        return $cache{$key};
    }

    my $u = 0;
    my $t = $n / $p;

    for (my $q = 2 ; $q < $p ; $q = next_prime($q)) {

        my $v = __SUB__->($t - ($t % $q), $q);

        if ($v == 1) {
            $u += prime_count($q, $p - 1);
            last;
        }
        else {
            $u += $v;
        }
    }

    if ($n < 1e7) {
        $cache{$key} = $t - $u;
    }

    $t - $u;
}

sub S($n) {

    my $sum = 0;
    my $s = sqrtint($n);

    forprimes {
        $sum += mulmod($_, G($n, $_), $MOD);
    } $s;

    addmod($sum, sum_primes(next_prime($s), $n) % $MOD, $MOD);
}

say S(1e12);

__END__
S(10^1)  = 28
S(10^2)  = 1257
S(10^3)  = 79189
S(10^4)  = 5786451
S(10^5)  = 455298741
S(10^6)  = 37568404989
S(10^7)  = 3203714961609
S(10^8)  = 279218813374515
S(10^9)  = 24739731010688477
S(10^10) = 2220827932427240957
S(10^11) = 201467219561892846337
