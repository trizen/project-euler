#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 30 January 2017
# https://github.com/trizen

# https://projecteuler.net/problem=96

# Runtime: 13.888s

use 5.016;
use strict;
use integer;

sub check {
    my ($i, $j) = @_;

    my ($id, $im) = ($i / 9, $i % 9);
    my ($jd, $jm) = ($j / 9, $j % 9);

    $jd == $id && return 1;
    $jm == $im && return 1;

    $id / 3 == $jd / 3 and
    $jm / 3 == $im / 3;
}

my @lookup;
foreach my $i (0 .. 80) {
    foreach my $j (0 .. 80) {
        $lookup[$i][$j] = check($i, $j);
    }
}

sub solve_sudoku {
    my ($callback, @grid) = @_;

    sub {
        foreach my $i (0 .. 80) {
            if (!$grid[$i]) {

                my %t;
                undef @t{@grid[grep { $lookup[$i][$_] } 0 .. 80]};

                foreach my $k (1 .. 9) {
                    if (not exists $t{$k}) {
                        $grid[$i] = $k;
                        __SUB__->();
                    }
                }

                $grid[$i] = 0;
                return;
            }
        }

        $callback->(@grid);
        goto SOLUTION_FOUND;
    }->();
    SOLUTION_FOUND: return;
}

open my $fh, '<', 'p096_sudoku.txt'
  or die "Can't open file `p096_sudoku.txt`: $!";
chomp(my @grids = grep { /^[0-9]+$/ } <$fh>);
close $fh;

my $sum = 0;

while (@grids) {
    my @grid = split(//, join('', splice(@grids, 0, 9)));
    solve_sudoku(sub { $sum += "$_[0]$_[1]$_[2]" }, @grid);
}

say $sum;
