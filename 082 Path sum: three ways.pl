#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 08 August 2016
# Website: https://github.com/trizen

# The minimal path sum in the 5 by 5 matrix below, by starting in any cell
# in the left column and finishing in any cell in the right column, and only
# moving up, down, and right; the sum is equal to 994.

# Find the minimal path sum, in a 31K text file containing a 80 by 80 matrix,
# from the left column to the right column.

# https://projecteuler.net/problem=82

# usage: perl script.pl < p082_matrix.txt

use 5.010;
use Memoize qw(memoize);

my @matrix;
while (<>) {
    push @matrix, [split(/,/)];
}

memoize('path');
my $end = $#matrix;

sub path {
    my ($i, $j, $last) = @_;

    $j >= $end && return $matrix[$i][$j];

    my @paths;
    if ($i > 0 and $last ne 'down') {
        push @paths, path($i - 1, $j, 'up');
    }

    push @paths, path($i, $j + 1, 'ok');

    if ($i < $end and $last ne 'up') {
        push @paths, path($i + 1, $j, 'down');
    }

    my $min = 'inf';

    foreach my $sum (@paths) {
        $min = $sum if $sum < $min;
    }

    $min + $matrix[$i][$j];
}

my $min = 'inf';
foreach my $i (0 .. $end) {
    my $sum = path($i, 0, 'ok');
    $min = $sum if $sum < $min;
}

say $min;
