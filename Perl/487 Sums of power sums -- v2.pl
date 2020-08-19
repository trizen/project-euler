#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 19 August 2020
# https://github.com/trizen

# https://projecteuler.net/problem=487

# Runtime: 47.519s

use 5.020;
use strict;
use warnings;
use experimental qw(signatures);

use Math::GMPz;

use ntheory qw(forprimes submod addmod divmod mulmod powmod);
use Math::Prime::Util::GMP qw(bernvec modint);

say ":: Computing Bernoulli numbers...";

my $power = 2e3;
my @bernoulli = bernvec(($power+1)>>1);

splice(@bernoulli, 1, 0, [1, 2]);

say ":: Applying Faulhaber's formula...";

my $B0 = [1, 1];
my $B1 = [1, 2];

@bernoulli = map { [map{Math::GMPz->new($_)} @$_] } @bernoulli;

{
    my @cache;
    my $t = Math::GMPz::Rmpz_init_nobless();

    sub binomialmod ($n, $k, $m) {
        my $bin = (
            $cache[$n][$k] //= do {
                my $z = Math::GMPz::Rmpz_init_nobless();
                Math::GMPz::Rmpz_bin_uiui($z, $n, $k);
                $z;
            }
        );
        Math::GMPz::Rmpz_mod_ui($t, $bin, $m);
    }
}

# Faulhaber's formula (modulo some m)
# See: https://en.wikipedia.org/wiki/Faulhaber%27s_formula
sub faulhabermod ($n, $p, $m) {

    my $sum = 0;

    for my $k (0 .. $p) {

        $k % 2 == 0 or $k == 1 or next;

        my $B =
            ($k == 0) ? $B0
          : ($k == 1) ? $B1
          :             $bernoulli[($k >> 1) + 1];

        $sum += mulmod(divmod(mulmod(binomialmod($p + 1, $k, $m), $B->[0] % $m, $m), $B->[1] % $m, $m),
                       powmod($n, $p - $k + 1, $m), $m);
        $sum %= $m;
    }

    divmod($sum, $p + 1, $m);
}

# Efficient formula for computing:
#   S_p(n) = Sum_{k=1..n} Sum_{j=1..k} j^p
# for some positive integer p.

# The formula is:
#   S_p(n) = (n+1) * F_p(n) - F_(p+1)(n)
# where F_n(x) are the Faulhaber polynomials.

sub S ($n, $p, $m) {
    submod(mulmod($n + 1, faulhabermod($n, $p, $m), $m), faulhabermod($n, $p + 1, $m), $m);
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
