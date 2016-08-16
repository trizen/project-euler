#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 16 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=60

use 5.010;
use strict;

use ntheory qw(primes is_prime);

my @primes = @{primes(10000)};
my $end = $#primes;

for my $i (0 .. $end-4) {
    my $p1 = $primes[$i];

    for my $j ($i+1 .. $end-3) {
        my $p2 = $primes[$j];

        (   is_prime("$p1$p2")
        and is_prime("$p2$p1"))
         || next;

        for my $k ($j+1 .. $end-2) {
            my $p3 = $primes[$k];

            (   is_prime("$p1$p3")
            and is_prime("$p3$p1")
            and is_prime("$p2$p3")
            and is_prime("$p3$p2"))
             || next;

            for my $l ($k+1 .. $end-1) {
                my $p4 = $primes[$l];

                (    is_prime("$p1$p4")
                 and is_prime("$p4$p1")
                 and is_prime("$p2$p4")
                 and is_prime("$p4$p2")
                 and is_prime("$p3$p4")
                 and is_prime("$p4$p3"))
                  || next;

                foreach my $m ($l+1 .. $end) {
                    my $p5 = $primes[$m];

                    (    is_prime("$p1$p5")
                     and is_prime("$p5$p1")
                     and is_prime("$p2$p5")
                     and is_prime("$p5$p2")
                     and is_prime("$p3$p5")
                     and is_prime("$p5$p3")
                     and is_prime("$p4$p5")
                     and is_prime("$p5$p4"))
                      || next;

                    say "sum($p1, $p2, $p3, $p4, $p5) = ", $p1 + $p2 + $p3 + $p4 + $p5;
                    exit;
                }
            }
        }
    }
}
