#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# Which prime, below one-million, can be written as the sum of the most consecutive primes?

# https://projecteuler.net/problem=50

# Runtime: 0.064s

use 5.010;
use strict;
use integer;

use List::UtilsBy qw(max_by);
use ntheory qw(is_prime nth_prime);

my $limit = 1e6;

my $sum = 0;
my @primes;

for (my $i = 1 ; ; ++$i) {
    my $p = nth_prime($i);
    $sum += $p;
    if ($sum / 2 > $limit) {
        last;
    }
    push @primes, $p;
}

my @arr;
my $l = scalar(@primes) - 1;

for (my $i = 0 ; $i <= $l ; ++$i) {
    my $sum = $primes[$i];
    for (my $j = $i + 1 ; ($j <= $l - $i) && (($sum += $primes[$j]) < $limit) ; ++$j) {
        is_prime($sum) && push @arr, [$j - $i + 1, $sum];
    }
}

my $p = max_by { $_->[0] } @arr;
say "$p->[1] is the sum of $p->[0] consecutive primes.";
