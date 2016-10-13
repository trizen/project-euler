#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=70

# Runtime: 6.563s

use strict;
use ntheory qw(euler_phi forcomposites);

my %min = (ratio => 'inf');

forcomposites {
    my $phi = euler_phi($_);
    my $ratio = $_ / $phi;

    if ($ratio < $min{ratio}
        and length($phi) == length($_)
        and join('', sort split(//, $phi)) eq
            join('', sort split(//, $_))
    ) {
        $min{ratio} = $ratio;
        $min{num}   = $_;
    }
} 1e7-1;

print "$min{num} -> $min{ratio}\n";
