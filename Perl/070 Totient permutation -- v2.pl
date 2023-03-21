#!/usr/bin/perl

# Author: Trizen
# Date: 21 March 2023
# https://github.com/trizen

# https://projecteuler.net/problem=70

# Runtime: 0.068s

use 5.036;
use ntheory qw(:all);

my %min = (ratio => 'inf');

for (my $p = prev_prime(sqrtint(1e7) + 1) ; $p > 2 ; $p = prev_prime($p)) {
    for (my $q = prev_prime(int(1e7 / $p) + 1) ; $q > $p ; $q = prev_prime($q)) {

        my $n   = $p * $q;
        my $phi = ($p - 1) * ($q - 1);
        my $r   = $n / $phi;

        $r < $min{ratio} or last;

        if (join('', sort split(//, $n)) eq join('', sort split(//, $phi))) {
            say "Found ratio: $r for n = $n";
            $min{ratio} = $r;
            $min{value} = $n;
        }
    }
}

say "$min{value} with ratio $min{ratio}";
