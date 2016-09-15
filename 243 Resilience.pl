#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=243

use List::Util qw(product);
use ntheory qw(euler_phi next_prime);

sub p {
    $_[0]
      ? map p($_[0] - 1, [@{$_[1]}, $_[$_]], @_[$_ .. $#_]), 2 .. $#_
      : $_[1];
}

my @primes = (2);
my $min    = 'inf';

for (; ;) {

    push @primes, next_prime($primes[-1]);

    foreach my $i (2 .. @primes) {
        foreach my $comb (p($i, [], @primes)) {
            my $prod = product(@$comb);
            if ($prod < $min and euler_phi($prod)/($prod - 1) < 15499/94744) {
                $min = $prod;
            }
        }
    }

    if ($min < 'inf') {
        print "Candidate: $min\n";
    }
}
