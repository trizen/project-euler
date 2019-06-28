#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 28 June 2019
# https://github.com/trizen

# https://projecteuler.net/problem=487

# Runtime: 44.486s

use 5.020;
use strict;
use warnings;
use experimental qw(signatures);

use Math::GMPz;
use Math::GMPq;

use ntheory qw(forprimes addmod divmod mulmod powmod);

sub tangent_numbers ($n) {

    my @T = (Math::GMPz::Rmpz_init_set_ui(1));

    foreach my $k (1 .. $n) {
        Math::GMPz::Rmpz_mul_ui($T[$k] = Math::GMPz::Rmpz_init(), $T[$k - 1], $k);
    }

    foreach my $k (1 .. $n) {
        foreach my $j ($k .. $n) {
            Math::GMPz::Rmpz_mul_ui($T[$j], $T[$j], $j - $k + 2);
            Math::GMPz::Rmpz_addmul_ui($T[$j], $T[$j - 1], $j - $k);
        }
    }

    return @T;
}

sub bernoulli_numbers ($n) {

    $n = ($n >> 1) + 1;

    my @B;
    my @T = tangent_numbers($n);

    my $t = Math::GMPz::Rmpz_init();

    foreach my $k (0 .. 2 * @T) {

        $k % 2 == 0 or $k == 1 or next;

        my $q = Math::GMPq::Rmpq_init();

        if ($k == 0) {
            Math::GMPq::Rmpq_set_ui($q, 1, 1);
            $B[$k] = $q;
            next;
        }

        if ($k == 1) {
            Math::GMPq::Rmpq_set_si($q, -1, 2);
            $B[$k] = $q;
            next;
        }

        # T_k
        Math::GMPz::Rmpz_mul_ui($t, $T[($k >> 1) - 1], $k);
        Math::GMPz::Rmpz_neg($t, $t) if ((($k >> 1) - 1) & 1);
        Math::GMPq::Rmpq_set_z($q, $t);

        # (2^k - 1) * 2^k
        Math::GMPz::Rmpz_set_ui($t, 0);
        Math::GMPz::Rmpz_setbit($t, $k);
        Math::GMPz::Rmpz_sub_ui($t, $t, 1);
        Math::GMPz::Rmpz_mul_2exp($t, $t, $k);

        # B_k = q
        Math::GMPq::Rmpq_div_z($q, $q, $t);

        $B[($k >> 1) + 1] = $q;
    }

    return @B;
}

say ":: Computing Bernoulli numbers...";

my $power = 10000;

my @bernoulli = map {
    my $num = Math::GMPz->new(0);
    my $den = Math::GMPz->new(0);
    Math::GMPq::Rmpq_get_num($num, $_);
    Math::GMPq::Rmpq_get_den($den, $_);
    [$num, $den];
} bernoulli_numbers($power + 1);

say ":: Applying Faulhaber's formula...";

my $B0 = [map { Math::GMPz->new($_) } (1, 1)];
my $B1 = [map { Math::GMPz->new($_) } (1, 2)];

{
    my @cache;
    my $t = Math::GMPz::Rmpz_init_nobless();

    sub binomialmod ($n, $k, $m) {
        my $bin = ($cache[$n][$k] //= do {
            my $z = Math::GMPz::Rmpz_init_nobless();
            Math::GMPz::Rmpz_bin_uiui($z, $n, $k);
            $z;
        });
        Math::GMPz::Rmpz_mod_ui($t, $bin, $m);
    }
}

# Faulhaber's formula (modulo some m)
# See: https://en.wikipedia.org/wiki/Faulhaber%27s_formula
sub faulhabermod ($n, $p, $m) {

    my $sum = 0;

    for my $k (0 .. $p) {

        if ($k % 2 == 1 and $k > 1) {
            next;
        }

        my $B;

        if ($k == 0) {
            $B = $B0;
        }
        elsif ($k == 1) {
            $B = $B1;
        }
        else {
            $B = $bernoulli[($k >> 1) + 1];
        }

        $sum += mulmod(divmod(mulmod(binomialmod($p + 1, $k, $m), $B->[0] % $m, $m), $B->[1] % $m, $m),
                       powmod($n, $p - $k + 1, $m), $m);

        $sum %= $m;

        ## $sum += Math::AnyNum::binomial($p + 1, $k) * Math::AnyNum::bernfrac($k) * ipow($n, $p - $k + 1);
    }

    ## return $sum / ($p + 1);
    divmod($sum, $p + 1, $m);
}

# Efficient formula for computing:
#
#   S_p(n) = Sum_{k=1..n} Sum_{j=1..k} j^p
#
# for some positive integer p.

# The formula is:
#   S_p(n) = (n+1) * F_p(n) - F_(p+1)(n)

# where F_n(x) are the Faulhaber polynomials, defined as:
#
#   F_n(x) = (Bernoulli(n+1, x+1) - Bernoulli(n+1, 1)) / (n+1)
#
# where Bernoulli(n,x) are the Bernoulli polynomials.

sub S ($n, $p, $mod) {
    ## (($n+1) * Math::AnyNum::faulhaber_sum($n, $p) - Math::AnyNum::faulhaber_sum($n, $p+1))  % $mod;
    addmod(mulmod($n + 1, faulhabermod($n, $p, $mod), $mod), -faulhabermod($n, $p + 1, $mod), $mod);
}

# Sanity check
if (S(100, 4, 1e9 + 1) != (35375333830 % (1e9 + 1))) {
    die "Error for S_4(100)";
}

my $sum = 0;

forprimes {    # there are only 100 primes in this range
    $sum += S(1e12, $power, $_);
} 2e9, 2e9 + 2000;

say ":: Total: $sum";
