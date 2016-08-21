#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# Find the maximum total from top to bottom in triangle.txt, a 15K text file containing a triangle with one-hundred rows.

# https://projecteuler.net/problem=67

use 5.010;
use List::Util qw(max);

# usage: perl problem_067.pl < p067_triangle.txt

my @triangle;

while (<>) {
    push @triangle, [split(' ')];
}

foreach my $i (reverse(0 .. $#triangle - 1)) {
    foreach my $j (0 .. $#{$triangle[$i]}) {
        $triangle[$i][$j] = $triangle[$i][$j] + max($triangle[$i+1][$j], $triangle[$i+1][$j+1]);
    }
}

say $triangle[0][0];
