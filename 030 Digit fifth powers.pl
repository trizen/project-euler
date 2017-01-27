#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 27 January 2017
# https://github.com/trizen

# https://projecteuler.net/problem=30

# Runtime: 1.763

use 5.010;
use strict;
use warnings;

use ntheory qw(forperm vecsum);
use Algorithm::Combinatorics qw(combinations_with_repetition);

my $pow = 5;
my $sum = 0;

foreach my $k (2 .. $pow + 1) {
    my %seen;
    my $iter = combinations_with_repetition([0 .. 9], $k);

    while (my $p = $iter->next) {
        my @digits = @$p;
        my $sum = vecsum(map { $_**$pow } @digits);

        local $" = '';
        forperm {
            if ($digits[$_[0]] != 0 and $sum == "@digits[@_]") {
                $seen{"@digits[@_]"} = 1;
            }
        } $k;
    }

    say "$k -> (", join(', ', keys %seen), ')';
    $sum += vecsum(keys %seen);
}

say "\nSum: $sum";
