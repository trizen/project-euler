#!/usr/bin/perl

# N-th digit of reciprocals
# https://projecteuler.net/problem=820

# Naive approach.

use 5.020;
use warnings;

use ntheory      qw(:all);
use experimental qw(signatures);

use Math::GMPz;

sub S ($n) {
    my $m = Math::GMPz::Rmpz_init();
    my $t = Math::GMPz::Rmpz_init();

    Math::GMPz::Rmpz_ui_pow_ui($m, 10, $n);

    my $sum = 0;

    foreach my $k (1 .. $n) {
        Math::GMPz::Rmpz_tdiv_q_ui($t, $m, $k);
        $sum += Math::GMPz::Rmpz_mod_ui($t, $t, 10);
    }

    return $sum;
}

say S(7);
say S(100);
say S(1e7);
