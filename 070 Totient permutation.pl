#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# https://github.com/trizen

# https://projecteuler.net/problem=70

# Runtime: 2.228s

use strict;
use ntheory qw(euler_phi forsemiprimes);

my %min = (ratio => 'inf');

forsemiprimes {
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
