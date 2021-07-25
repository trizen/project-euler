#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 05 June 2021
# https://github.com/trizen

# Stealthy Numbers
# https://projecteuler.net/problem=757

# These are numbers of the form x*(x+1) * y*(y+1), where x and y are positive integers.
# Also known as bipronic numbers.

# See also:
#   https://oeis.org/A072389

# Runtime: ~2 minutes.

# WARNING: requires more than 4 GB of RAM!

# See the Julia version for a faster solution.

use 5.020;
use strict;
use warnings;

use ntheory qw(:all);
use experimental qw(signatures);

sub p757 ($n) {

    my %seen;
    my $count = 0;
    my $limit = rootint($n, 4);

    foreach my $x (1 .. $limit) {

        for (my $y = $x ; ; ++$y) {

            my $v = $x * ($x + 1) * $y * ($y + 1);

            last if ($v > $n);

            if (not exists $seen{$v}) {
                undef $seen{$v};
                ++$count;
            }
        }
    }

    return $count;
}

say p757(powint(10, 6));
say p757(powint(10, 14));
