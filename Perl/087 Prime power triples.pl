#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=87

# Runtime: 1.536s

use 5.010;
use ntheory qw(primes);

my @primes = @{primes(int(sqrt(50e6)))};

my %seen;
my $end   = $#primes;
my $count = 0;

foreach my $i (0 .. $end) {
    foreach my $j (0 .. $end) {
        $primes[$i]**2 + $primes[$j]**3 < 50e6 or last;
        foreach my $k (0 .. $end) {
            (my $n = $primes[$i]**2 + $primes[$j]**3 + $primes[$k]**4) < 50e6 or last;
            ++$count if !$seen{$n}++;
        }
    }
}

say $count;
