#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 04 May 2017
# https://github.com/trizen

# https://projecteuler.net/problem=516

# Not a very good solution: requires over 6 GB of RAM.

# Runtime: 2 min, 57 sec.

use 5.010;
use strict;

use ntheory qw(
  factor
  euler_phi
  is_prime
  );

my @smooth = (1);
my $limit  = 1e12;
my $mod    = 1 << 32;

foreach my $p (2, 3, 5) {
    foreach my $n (@smooth) {
        if ($n * $p <= $limit) {
            push @smooth, $n * $p;
        }
    }
}

@smooth =
  sort { $b <=> $a }
  grep { is_prime($_) }
  map { $_ + 1 } @smooth;

my @h = (1);
my $sum = 1;

foreach my $p (@smooth) {
    foreach my $n (@h) {
        if (
                $p * $n <= $limit
            and (factor(euler_phi($n * $p)))[-1] <= 5
        ) {
            if ($p == 2) { # optional optimization
                foreach my $n (@h) {
                    while ($n * $p <= $limit) {
                        $sum += ($n * $p) % $mod;
                        $sum %= $mod;
                        $n *= $p;
                    }
                }
                last;
            }
            else {
                $sum += ($n * $p) % $mod;
                $sum %= $mod;
                push @h, $n * $p;
            }
        }
    }

    say "$p -> $sum ($#h)";
}

say "Final answer: $sum";
