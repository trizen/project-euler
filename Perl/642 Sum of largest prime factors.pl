#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 20 July 2020
# https://github.com/trizen

# Sum of largest prime factors
# https://projecteuler.net/problem=642

# Let G(n,p) be the number of integers k in 1..n such that gpf(k) = p.
# Equivalently, G(n,p) is the number of p-smooth numbers <= floor(n/p).

# Then we have:
#   S(n) = Sum_{k=2..n} gpf(k)
#   S(n) = A(n) + B(n)

# where:
#   A(n) = Sum_{p <= sqrt(n)} p * G(n,p)
#   B(n) = Sum_{k=1..sqrt(n)} W(floor(n/k)) - floor(sqrt(n))*W(floor(sqrt(n)))

# where:
#   W(n) = Sum_{p <= n} p.

# Runtime: 1 min, 36 sec

use 5.020;
use integer;
use ntheory qw(:all);
use experimental qw(signatures);

my $MOD = 1e9;

sub S($n) {
    my $t = 0;
    my $s = sqrtint($n);

    forprimes {
        $t = addint($t, mulint($_, smooth_count($n/$_, $_)));
    } $s;

    for (my $p = next_prime($s); $p <= $n; $p = next_prime($p)) {

        my $u = $n/$p;
        my $r = $n/$u;

        $t = addint($t, mulint($u, sum_primes($p, $r)));
        $p = $r;
    }

    return $t;
}

sub S_mod($n) {

    my $t = 0;
    my $s = sqrtint($n);

    forprimes {
        $t += mulmod($_, smooth_count($n/$_, $_), $MOD);
    } $s;

    for (my $p = next_prime($s); $p <= $n; $p = next_prime($p)) {

        my $u = $n/$p;
        my $r = $n/$u;

        $t += mulmod($u, sum_primes($p, $r), $MOD);
        $p = $r;
    }

    $t % $MOD;
}

say S_mod(201820182018);

__END__
S(10^1)  = 32
S(10^2)  = 1915
S(10^3)  = 135946
S(10^4)  = 10118280
S(10^5)  = 793111753
S(10^6)  = 64937323262
S(10^7)  = 5494366736156
S(10^8)  = 476001412898167
S(10^9)  = 41985754895017934
S(10^10) = 3755757137823525252
S(10^11) = 339760245382396733607
