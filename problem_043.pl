#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

use 5.010;
use ntheory qw(forperm);

my $sum    = 0;
my @digits = 0 .. 9;

forperm {
    my ($d1, $d2, $d3, $d4, $d5, $d6, $d7, $d8, $d9, $d10) = @digits[@_];

    if (    $d1 != 0
        and "$d2$d3$d4"  %  2 == 0
        and "$d3$d4$d5"  %  3 == 0
        and "$d4$d5$d6"  %  5 == 0
        and "$d5$d6$d7"  %  7 == 0
        and "$d6$d7$d8"  % 11 == 0
        and "$d7$d8$d9"  % 13 == 0
        and "$d8$d9$d10" % 17 == 0) {
        $sum += "$d1$d2$d3$d4$d5$d6$d7$d8$d9$d10";
    }

} scalar(@digits);

say $sum;
