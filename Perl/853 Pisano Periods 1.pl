#!/usr/bin/perl

# Pisano Periods 1
# https://projecteuler.net/problem=853

# Runtime: 0.364s

use 5.036;
use List::Util qw(first);
use ntheory    qw(:all);

sub fibonacci ($n) {
    lucasu(1, -1, $n);
}

sub fibmod ($d, $n) {
    (lucas_sequence($n, 1, -1, $d))[0];
}

sub pisano_period_pp ($p, $k = 1) {
    $p**($k - 1) * first { fibmod($_, $p) == 0 } divisors($p - kronecker($p, 5));
}

sub pisano_period ($n) {

    return 0 if ($n <= 0);
    return 1 if ($n == 1);

    my $d = lcm(map { pisano_period_pp($_->[0], $_->[1]) } factor_exp($n));

    foreach my $k (0 .. 2) {
        my $t = $d << $k;

        if ((fibmod($t, $n) == 0) and (fibmod($t + 1, $n) == 1)) {
            return $t;
        }
    }

    die "Conjecture disproved for n=$n";
}

my $n     = 120;
my $limit = 1e9;

say vecsum(grep { pisano_period($_) == $n } grep { $_ <= $limit } divisors(fibonacci($n)));
