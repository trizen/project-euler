#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 09 February 2017
# Website: https://github.com/trizen

# https://projecteuler.net/problem=111

# Runtime: 31.57 min

# For a faster approach, see version 2.

use 5.010;
use strict;

use ntheory qw(forprimes vecsum);

my %max;
my %sums;

my $p;
my %table;

forprimes {
    $p = $_;

    undef %table;
    ++$table{$_} for split(//, $p);

    foreach my $i(keys %table) {

        my $count = $table{$i};

        if (exists $max{$i}) {
            if ($max{$i} < $count) {
                $max{$i} = $count;
                $sums{$i} = $p;
            }
            elsif ($count == $max{$i}) {
                $sums{$i} += $p;
            }
        }
        else {
            $max{$i} = $count;
            $sums{$i} = $p;
        }
    }

} 1000000000, 9999999999;

say vecsum(values %sums);
