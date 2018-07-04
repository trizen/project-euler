#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 04 July 2018
# https://github.com/trizen

# https://projecteuler.net/problem=565

# Runtime: ~4 minutes

use 5.010;
use strict;
use warnings;

use ntheory qw(is_prime divisor_sum logint sqrtint forprimes);

sub S {
    my ($n, $k) = @_;

    my %seen;
    my $sum = 0;

    my $process_term = sub {
        my ($t) = @_;

        for (my $s = $t ; $s <= $n ; $s += $t) {

            next if ($s % $t**2 == 0);

            if (divisor_sum($s / $t) % $k == 0) {
                next if (++$seen{$s} >= 2);
            }

            if (divisor_sum($s) % $k == 0) {
                $sum += $s;
            }
        }
    };

    forprimes {
        my $p = $_;
        foreach my $e (3 .. 1 + logint($n, $p)) {
            if (($p**$e - 1) % $k == 0) {
                $process_term->($p**($e - 1));
            }
        }
    } sqrtint($n);

    for (my $t = $k ; $t <= $n ; $t += $k) {
        if (is_prime($t - 1)) {
            $process_term->($t - 1);
        }
    }

    return $sum;
}

say S(1e6,  2017);
say S(1e9,  2017);
say S(1e11, 2017);
