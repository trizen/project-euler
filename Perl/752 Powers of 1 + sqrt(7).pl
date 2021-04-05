#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 05 April 2021
# https://github.com/trizen

# Powers of 1+sqrt(7)
# https://projecteuler.net/problem=752

# Runtime: 1 min, 42 sec

use 5.020;
use warnings;

use ntheory qw(:all);
use List::Util qw(first);
use experimental qw(signatures);

my $Q_a = 1;
my $Q_b = 1;
my $Q_w = 7;

sub quadratic_powmod ($a, $b, $w, $n, $m) {

    my ($x, $y) = (1, 0);

    do {
        ($x, $y) = (($a * $x + $b * $y * $w) % $m, ($a * $y + $b * $x) % $m) if ($n & 1);
        ($a, $b) = (($a * $a + $b * $b * $w) % $m, (2 * $a * $b) % $m);
    } while ($n >>= 1);

    ($x, $y);
}

sub quadratic_prime_order ($p) {

    if ($p == $Q_w) {
        return $p;
    }

    state %cache;

    if (exists $cache{$p}) {
        return $cache{$p};
    }

    my $n = 1;

    if (kronecker($Q_w, $p) == 1) {
        $n = $p - 1;
    }
    else {
        $n = ($p - 1) * ($p + 1);
    }

    $cache{$p} = first { join(' ', quadratic_powmod($Q_a, $Q_b, $Q_w, $_, $p)) eq '1 0' } divisors($n);
}

sub quadratic_order ($n) {
    lcm(map { mulint(quadratic_prime_order($_->[0]), powint($_->[0], $_->[1] - 1)) } factor_exp($n));
}

sub G ($n) {

    my $total = 0;

    foreach my $k (2 .. $n) {
        if ($k % 6 == 1 or $k % 6 == 5) {
            $total += quadratic_order($k);
        }
    }

    return $total;
}

G(1e2) == 28891    or die "error for n = 10^2";
G(1e3) == 13131583 or die "error for n = 10^3";

say G(1e6);
