#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

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

    if ($i < $end and $j < $end) {
        return $matrix[$i][$j] + min(path($i + 1, $j), path($i, $j + 1));
    }

    if ($i < $end) {
        return $matrix[$i][$j] + path($i + 1, $j);
    }

    if ($j < $end) {
        return $matrix[$i][$j] + path($i, $j + 1);
    }

    $matrix[$i][$j];
}

say path(0, 0);
