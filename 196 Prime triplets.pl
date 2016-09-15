#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 20 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=196

# Runtime: 8.838s

use 5.010;
use strict;
use integer;
use ntheory qw(is_prime);

sub vertical {
    ($_[0]**2 - $_[0] + 2) / 2;
}

sub prime_triples {
    my ($n) = @_;

    my $up       = vertical($n - 1);
    my $down     = vertical($n + 1);
    my $me       = vertical($n);
    my $upup     = vertical($n - 2);
    my $downdown = vertical($n + 2);

    my @valid = (
                 [\$me,       $me,       $me + $n],
                 [\$up,       $up,       $up + $n - 1],
                 [\$down,     $down,     $down + $n + 1],
                 [\$upup,     $upup,     $upup + $n - 2],
                 [\$downdown, $downdown, $downdown + $n - 2],
                );

    my @moves = (
                 [[1, -1], [3, -1]],
                 [[2, -1], [4, -1]],
                 [[1, +0], [3, +1]],
                 [[2, +0], [4, +1]],
                 [[1, +0], [2, +1]],
                 [[2, +0], [1, +1]],
                 [[1, +1], [3, +1]],
                 [[2, +1], [4, +1]],
                 [[2, +0], [4, -1]],
                 [[1, +0], [3, -1]],
                 [[1, +0], [2, -1]],
                 [[1, -1], [0, -2]],
                 [[2, -1], [0, -2]],
                 [[1, +1], [0, +2]],
                 [[2, +1], [0, +2]],
                 [[2, +0], [1, -1]],
                 [[2, -1], [2, +1]],
                 [[1, -1], [1, +1]],
                 [[1, +0], [3, +0]],
                 [[2, +1], [4, +0]],    # this happens only once
                );

    my $sum = 0;
    foreach my $i (1 .. $n) {

        if (is_prime($me)) {
          OUTER: foreach my $move (@moves) {
                foreach my $group (@$move) {
                    my ($n, $n_min, $n_max) = @{$valid[$group->[0]]};

                    my $v = $group->[1] + $$n;
                    if ($v < $n_min or $v > $n_max or not is_prime($v)) {
                        next OUTER;
                    }
                }
                $sum += $me;
                last;
            }
        }

        ++$up;
        ++$down;
        ++$me;
        ++$upup;
        ++$downdown;
    }

    $sum;
}

my $x = prime_triples(5678027);
my $y = prime_triples(7208785);

say "$x + $y = ", $x + $y;
