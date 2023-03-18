#!/usr/bin/perl

# Author: Trizen
# Date: 18 March 2023
# https://github.com/trizen

# https://projecteuler.net/problem=60

# Generic solution.

# Runtime: 4.837s

use 5.036;
use ntheory qw(:all);

for (my @primes = @{primes(2)} ; ; @primes = @{primes($primes[-1] * 2)}) {

    say "Checking primes <= $primes[-1]";

    foreach my $i (0 .. $#primes) {

        my $p = $primes[$i];

        my @indx = ();
        my @good = ($p);

        for (my $j = $i + 1 ; ; ++$j) {

            my $q = $primes[$j] // do {
                @indx or last;
                shift @good;
                $j = shift @indx;
                next;
            };

            my $ok = 1;
            unshift @good, $q;

          OUTER: for my $k (0 .. $#good) {
                for my $l ($k + 1 .. $#good) {
                    (is_prime("$good[$k]$good[$l]") and is_prime("$good[$l]$good[$k]")) || do {
                        $ok = 0;
                        last OUTER;
                    }
                }
            }

            if ($ok) {
                unshift @indx, $j;
                if (scalar(@good) == 5) {
                    say "sum(@good) = ", vecsum(@good);
                    exit(0);
                }
            }
            else {
                shift @good;
            }
        }
    }
}
