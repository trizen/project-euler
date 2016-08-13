#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# usage: perl problem_081.pl < p081_matrix.txt

use 5.010;
use List::Util qw(min);
use Memoize qw(memoize);

memoize('path');

my @matrix;
while (<>) {
    push @matrix, [split /,/];
}

my $end = $#matrix;

sub path {
    my ($i, $j) = @_;

    my @paths;

    if ($i < $end) {
        push @paths, path($i + 1, $j);
    }

    if ($j < $end) {
        push @paths, path($i, $j + 1);
    }

    $matrix[$i][$j] + (min(@paths) || 0);
}

say path(0, 0);
