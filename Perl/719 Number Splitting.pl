#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 01 July 2020
# https://github.com/trizen

# Number Splitting
# https://projecteuler.net/problem=719

# Runtime: 8 min, 14 sec

use 5.020;
use warnings;

use ntheory qw(:all);
use experimental qw(signatures);

sub isok ($i, $j, $d, $e, $n, $sum = 0) {

    if ($sum + join('', @{$d}[$i .. $e]) < $n) {
        return 0;
    }

    my $new_sum = $sum + join('', @{$d}[$i .. $j]);

    if ($new_sum > $n) {
        return 0;
    }

    if ($new_sum == $n and $j >= $e) {
        return 1;
    }

    if ($j + 1 <= $e) {
        isok($j + 1, $j + 1, $d, $e, $n, $new_sum) && return 1;
        isok($i,     $j + 1, $d, $e, $n, $sum)     && return 1;
    }

    return 0;
}

my $sum = 0;

foreach my $n (2 .. 1e6) {
    my @d = todigits($n * $n);
    if (isok(0, 0, \@d, $#d, $n)) {
        say $n * $n;
        $sum += $n * $n;
    }
}

say "Total: $sum";
