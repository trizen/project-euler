#!/usr/bin/perl

# Author: Trizen
# Date: 18 March 2022
# https://github.com/trizen

# Perfect Square Collection
# https://projecteuler.net/problem=142

# Find the smallest x + y + z with integers x > y > z > 0 such that x + y, x − y, x + z, x − z, y + z, y − z are all perfect squares.

# Solution based on the following idea:
#   (x+y)*(x-y) = x^2 - y^2

# Since x+y and x-y must be squares, their product is also a square: (x+y)*(x-y) = n^2
# Iterate over n=1..Inf and find the (x,y) solutions to the equation n^2 = x^2 - y^2.
# Then, for each solution (x,y), try to find z, iterating from k=1 to sqrt(y), setting z = y - k^2 and checking if it satisfies the conditions.

# Runtime: ~11 minutes.

use 5.020;
use strict;
use warnings;

use ntheory qw(divisors is_square sqrtint);
use experimental qw(signatures);

sub difference_of_two_squares_solutions ($n) {

    my @solutions;
    foreach my $divisor (divisors($n)) {

        last if $divisor * $divisor >= $n;

        my $p = $divisor;
        my $q = $n / $divisor;

        ($p + $q) % 2 == 0 or next;

        my $x = ($q + $p) >> 1;
        my $y = ($q - $p) >> 1;

        unshift @solutions, [$x, $y];
    }

    return @solutions;
}

foreach my $k (1 .. 1e9) {

    say "Checking: $k";

    foreach my $pair (difference_of_two_squares_solutions($k * $k)) {

        my ($x, $y) = @$pair;

        is_square($x - $y) || next;
        is_square($x + $y) || next;

        foreach my $n (1 .. sqrtint($y)) {

            my $z = ($y - $n * $n);

            if (is_square($x + $z) && is_square($x - $z) && is_square($y + $z) && is_square($y - $z)) {
                die "Found: sum($x,$y,$z) = ", $x + $y + $z;
            }
        }
    }
}
