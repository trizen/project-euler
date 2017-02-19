#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 20 February 2017
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=387

# Runtime: 0.095s

use 5.010;
use strict;
use warnings;

use ntheory qw(:all);

my @valid;
my $limit = 10**14;

sub recurse {
    my ($num, $sum) = @_;

    if (($num . '01') >= $limit) {
        return;
    }

    foreach my $n (0 .. 9) {

        my $x = $num . $n;
        my $y = $sum + $n;

        if ($x % $y == 0) {
            foreach my $i (1, 3, 7, 9) {
                if (    ($x . $i) < $limit
                    and is_prime($x . $i)
                    and is_prime($x / $y)) {
                    push(@valid, $x . $i);
                }
            }

            recurse($x, $y);
        }
    }
}

recurse($_, $_) for (1, 2, 4, 6, 8);

say vecsum(@valid);
