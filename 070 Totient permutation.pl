#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

use ntheory qw(euler_phi);
my %min = (ratio => 'inf');

foreach my $n (2 .. 1e7-1) {
    my $phi = euler_phi($n);

    if (length($phi) == length($n)
        and join('', sort split(//, $phi)) eq
            join('', sort split(//, $n))
    ) {
        my $ratio = $n / $phi;
        if ($ratio < $min{ratio}) {
            $min{ratio} = $ratio;
            $min{num}   = $n;
        }
    }
}

print "$min{num} -> $min{ratio}\n";