#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 07 June 2019
# https://github.com/trizen

# https://projecteuler.net/problem=668

# Runtime: 0.330s

# Formula:
#   R(n) = Sum_{sqrt(n) < p <= n} floor(n/p)
#
#   S(n) = n - R(n) - Sum_{p <= sqrt(n)} (p-1) - pi(sqrt(n))
#        = n - R(n) - Sum_{p <= sqrt(n)} p
#
# where p runs over the prime numbers.

# The interesting part is computing R(n) efficiently.

# See also:
#   https://oeis.org/A064775 -- Card{ k<=n, k such that all prime divisors of k are <= sqrt(k) }.

use 5.020;
use ntheory qw(:all);
use experimental qw(signatures);

prime_precalc(1e8);

sub R($n) {

    my $p = next_prime(sqrtint($n));
    my $t = divint($n, $p);

    my $sum = 0;

    while ($p <= $n) {

        my $u = divint($n, $p);

        if ($u == $t) {
            my $q = next_prime(divint($n, $u));
            $sum += $u * prime_count($p, $q - 1);
            $u = divint($n, $q);
            $p = $q;
        }

        $sum += $u;

        $t = $u;
        $p = next_prime($p);
    }

    $sum;
}

sub square_root_smooth_count ($n) {
    $n - sum_primes(sqrtint($n)) - R($n);
}

foreach my $n (1 .. 10) {
    say "S(10^$n) = ", square_root_smooth_count(powint(10, $n));
}

__END__
S(10^1)  = 2
S(10^2)  = 29
S(10^3)  = 274
S(10^4)  = 2656
S(10^5)  = 26613
S(10^6)  = 268172
S(10^7)  = 2719288
S(10^8)  = 27531694
S(10^9)  = 278418003
S(10^10) = ----------
S(10^11) = 28338707429
S(10^12) = 285345025938
S(10^13) = 2870132239073
S(10^14) = 28845432950896
S(10^15) = 289704698437217
