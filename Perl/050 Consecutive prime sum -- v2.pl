#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 25 July 2021
# https://github.com/trizen

# Which prime, below one-million, can be written as the sum of the most consecutive primes?

# https://projecteuler.net/problem=50

# Runtime: 0.033s

use 5.020;
use strict;
use warnings;

use ntheory qw(:all);
use experimental qw(signatures);

sub p50($limit) {

    my @prime_sum = (0);
    for (my $p = 2 ; ; $p = next_prime($p)) {
        my $sum = $prime_sum[-1] + $p;
        last if ($sum >= $limit);
        push @prime_sum, $sum;
    }

    my $terms         = 1;
    my $max_prime     = 2;
    my $start_p_index = 1;

    foreach my $i (0 .. $#prime_sum) {
        for (my $j = $#prime_sum ; $j >= $i + $terms ; --$j) {

            my $n = $prime_sum[$j] - $prime_sum[$i];

            if (($j - $i > $terms or $n > $max_prime) and $n < $limit and is_prime($n)) {
                ($terms, $max_prime, $start_p_index) = ($j - $i, $n, $i + 1);
                last;
            }
        }
    }

    say "$max_prime is the sum of $terms consecutive primes with first prime = ", nth_prime($start_p_index);
}

p50(1e6);
