#!/usr/bin/perl

# Author: Trizen
# Date: 28 March 2023
# https://github.com/trizen

# Find the sum of the only eleven primes that are both truncatable from left to right and right to left.

# NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

# https://projecteuler.net/problem=37

# Runtime: 0.027s

use 5.036;
use ntheory                qw(primes vecmax is_prime vecsum);
use Math::Prime::Util::GMP qw(divint mulint addint subint);

sub is_left_truncatable ($n, $base) {

    for (my $r = $base ; $r < $n ; $r = mulint($r, $base)) {
        is_prime(subint($n, mulint($r, divint($n, $r)))) || return 0;
    }

    return 1;
}

sub generate_from_prefix ($p, $base) {

    my @seq = ($p);

    foreach my $d (1 .. $base - 1) {
        my $n = addint(mulint($p, $base), $d);
        if (is_prime($n)) {
            push @seq, grep { is_left_truncatable($_, $base) } generate_from_prefix($n, $base);
        }
    }

    return @seq;
}

sub both_truncatable_primes_in_base ($base) {

    return if $base <= 2;

    my @truncatable;
    foreach my $p (@{primes(2, $base - 1)}) {
        push @truncatable, generate_from_prefix($p, $base);
    }
    return @truncatable;
}

my $base = 10;
my @T = both_truncatable_primes_in_base($base);
say vecsum(grep { $_ >= $base } @T);
