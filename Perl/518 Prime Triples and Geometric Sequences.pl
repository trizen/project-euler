#!/usr/bin/perl

# Author: Trizen
# Date: 11 September 2023
# https://github.com/trizen

# Prime Triples and Geometric Sequences
# https://projecteuler.net/problem=518

# Solution:
#    `(p+1, q+1, r+1)` must form a geometric progression and `p < q < r`.
#
# This means that there is a positive rational value `r` such that:
#    (p+1)*r   = q+1
#    (p+1)*r^2 = r+1
#
# Since `r` can be rational, the denominator of the reduced fraction `r` must be a divisor of `p+1`.
#
# Furthermore, the denominator `j` must divide `p+1` twice, since we have, with `gcd(k,j) = 1`:
#    (p+1)*k/j     = q+1
#    (p+1)*k^2/j^2 = r+1
#
# Therefore, we iterate over the primes p <= N, then we iterate over the square-divisors j^2 of p+1,
# and for each k in the range `2 .. sqrt(n/((p+1)/j^2))` we compute:
#    q = (p+1)*k/j - 1
#    r = (p+1)*k^2/j^2 - 1

# Runtime: 1 minute and 30 seconds.

use 5.036;
use ntheory qw(:all);

sub square_divisors ($n) {

    my @d  = (1);
    my @pp = grep { $_->[1] > 1 } factor_exp($n);

    foreach my $pp (@pp) {
        my ($p, $e) = @$pp;

        my @t;
        for (my $i = 2 ; $i <= $e ; $i += 2) {
            my $u = powint($p, $i);
            push @t, map { $_ * $u } @d;
        }

        push @d, @t;
    }

    return @d;
}

sub problem_518 ($n) {

    my $sum   = 0;
    my $count = 0;

    forprimes {

        my $p = $_;

        foreach my $jj (square_divisors($p + 1)) {

            my $j  = sqrtint($jj);
            my $d1 = divint($p + 1, $j);
            my $d2 = divint($d1,    $j);

            foreach my $k (2 .. sqrtint(divint($n, $d2))) {

                gcd($k, $j) == 1 or next;

                my $q = $k * $d1;
                my $r = $k * $k * $d2;

                $p < $q or next;
                $q < $r or next;

                is_prime($q - 1) or next;
                is_prime($r - 1) or next;

                ++$count;
                $sum += ($p + $q + $r - 2);
            }
        }
    } $n;

    return ($count, $sum);
}

my ($count, $sum) = problem_518(1e8);
say "Count = $count";
say "Sum = $sum";

__END__
S(10^2) = 1035
S(10^3) = 75019
S(10^4) = 4225228
S(10^5) = 249551109     (takes 0.1 seconds)
S(10^6) = 17822459735   (takes 0.9 seconds)
S(10^7) = 1316768308545 (takes 9.2 seconds)
