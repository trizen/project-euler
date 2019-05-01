#!/usr/bin/perl

# Using Farey approximations (Mediants and binary search).

# See also:
#   https://en.wikipedia.org/wiki/Stern%E2%80%93Brocot_tree

# Runtime: ~2 minutes.

# https://projecteuler.net/problem=192

use 5.020;
use warnings;

use Math::GMPz;
use experimental qw(signatures);
use ntheory qw(is_square sqrtint);

sub best_approximation($n, $lim) {

    my $x = Math::GMPz->new(sqrtint($n));

    my $a1 = $x;
    my $b1 = Math::GMPz->new(1);

    my $a2 = $x + 1;
    my $b2 = Math::GMPz->new(1);

    while ($b1 + $b2 <= $lim) {

        my $a3 = $a1 + $a2;
        my $b3 = $b1 + $b2;

        if ($a3 * $a3 < $n * $b3 * $b3) {
            ($a1, $b1) = ($a3, $b3);
        }
        else {
            ($a2, $b2) = ($a3, $b3);
        }
    }

    if (($a1 * $b2 + $a2 * $b1)**2 > $n * (2 * $b1 * $b2)**2) {
        return $b1;
    }

    return $b2;
}

my $sum = 0;
foreach my $n (1 .. 100_000) {
    next if is_square($n);
    $sum += best_approximation($n, 1e12);
}

say $sum;
