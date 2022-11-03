#!/usr/bin/perl

# Author: Trizen
# Date: 03 November 2022
# https://github.com/trizen

# Hybrid Integers
# https://projecteuler.net/problem=800

# Runtime: 2 seconds.

use 5.020;
use warnings;

use ntheory      qw(:all);
use experimental qw(signatures);

sub bsearch_le ($left, $right, $callback) {

    my ($mid, $cmp);

    for (; ;) {

        $mid = int(($left + $right) / 2);
        $cmp = $callback->($mid) || return $mid;

        if ($cmp < 0) {
            $left = $mid + 1;
            $left > $right and last;
        }
        else {
            $right = $mid - 1;

            if ($left > $right) {
                $mid -= 1;
                last;
            }
        }
    }

    return $mid;
}

sub C ($n, $e) {

    my $limit = log($n) * $e;
    my $count = 0;

    for (my $p = 2 ; ; $p = next_prime($p)) {

        my $p_log = log($p);
        my $k = bsearch_le($p + 1, int($limit / $p_log), sub ($q) {
            $p_log * $q + log($q) * $p <=> $limit;
        });

        $count += (prime_count($p + 1, $k) || last);
    }

    return $count;
}

say C(800,    1);        #=> 2
say C(163,    165);      #=> 1000
say C(800,    800);      #=> 10790
say C(800800, 800800);
