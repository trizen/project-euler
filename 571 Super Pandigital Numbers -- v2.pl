#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 20 August 2017
# https://github.com/trizen

# https://projecteuler.net/problem=571

# Brute-force solution, with some optimizations.

# Runtime: ~12 minutes.

use 5.010;
use strict;
use warnings;

use List::Util qw(all);
use ntheory qw(fromdigits);
use experimental qw(signatures);
use Algorithm::Combinatorics qw(variations);

my $base  = shift(@ARGV) // 12;    # pandigital in all bases 2..$base
my $first = 10;                    # generate first n numbers

my @digits = (1, 0, 2 .. $base - 1);
my @bases  = reverse(2 .. $base - 1);

my $sum  = 0;
my $iter = variations(\@digits, $base);

sub is_8_pandigital ($n) {
    my $found = 0;
    while ($n > 0) {
        $found |= 1 << ($n & 7);
        $n >>= 3;
    }
    $found == (1 << 8) - 1;
}

sub is_pandigital ($n, $base) {
    my $found = 0;
    while ($n > 0) {
        $found |= 1 << ($n % $base);
        $n = int($n / $base);
    }
    $found == (1 << $base) - 1;
}

while (defined(my $t = $iter->next)) {

    if ($t->[0]) {
        my $v = fromdigits($t, $base);

        if (is_8_pandigital($v) and all { is_pandigital($v, $_) } @bases) {
            say "Found: $v";
            $sum += $v;
            last if --$first == 0;
        }
    }
}

say "Sum: $sum";
