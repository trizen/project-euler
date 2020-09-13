#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 04 September 2020
# https://github.com/trizen

# https://projecteuler.net/problem=365

# See also:
#   https://en.wikipedia.org/wiki/Lucas%27s_theorem

# Runtime: ~6 minutes.

use 5.020;
use strict;
use warnings;

use experimental qw(signatures);
use ntheory qw(primes chinese binomialmod);

my @primes = @{primes(1000, 5000)};
my $end = $#primes;

my $N = 1000000000000000000;
my $K = 1000000000;

my $sum = 0;

foreach my $i (0 .. $end - 2) {
    my $first = [binomialmod($N, $K, $primes[$i]), $primes[$i]];
    foreach my $j ($i + 1 .. $end - 1) {
        my $second = [binomialmod($N, $K, $primes[$j]), $primes[$j]];
        foreach my $k ($j + 1 .. $end) {
            my $third = [binomialmod($N, $K, $primes[$k]), $primes[$k]];
            $sum += chinese($first, $second, $third);
        }
    }
    say "$i -> $sum";
}

say "Total: $sum";
