#!/usr/bin/perl

# Pisano Periods 1
# https://projecteuler.net/problem=853

# Runtime: 0.345s

use 5.036;
use List::Util qw(first);
use ntheory    qw(:all);

sub fibonacci ($n) {
    lucasu(1, -1, $n);
}

sub fibmod ($d, $n) {
    (lucas_sequence($n, 1, -1, $d))[0];
}

sub divisors_le ($n, $k) {

    my @d  = (1);
    my @pp = grep { $_->[0] <= $k } factor_exp($n);

    foreach my $pp (@pp) {

        my ($p, $e) = @$pp;

        my @t;
        my $r = 1;

        for my $i (1 .. $e) {
            $r *= $p;
            foreach my $u (@d) {
                push(@t, $u * $r) if ($u * $r <= $k);
            }
        }

        push @d, @t;
    }

    return @d;
}

sub pisano_period_pp ($p, $k = 1) {
    $p**($k - 1) * first { fibmod($_, $p) == 0 } divisors($p - kronecker($p, 5));
}

sub my_pisano_period ($n) {

    return 0 if ($n <= 0);
    return 1 if ($n == 1);

    my $d = lcm(map { pisano_period_pp($_->[0], $_->[1]) } factor_exp($n));

    foreach my $k (0 .. 2) {
        my $t = $d << $k;

        if (fibmod($t + 1, $n) == 1) {
            return $t;
        }
    }

    die "Error for n = $n";
}

my $n     = 120;
my $limit = 1e9;

say vecsum(grep { my_pisano_period($_) == $n } divisors_le(fibonacci($n), $limit));
