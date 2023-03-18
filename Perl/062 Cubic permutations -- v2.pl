#!/usr/bin/perl

# Author: Trizen
# Date: 18 March 2023
# https://github.com/trizen

# https://projecteuler.net/problem=62

# Runtime: 0.030s

use 5.036;

my %table;
for (my $i = 1 ; ; ++$i) {

    my $key = join('', sort split(//, $i**3));
    push @{$table{$key}}, $i**3;

    if (scalar(@{$table{$key}}) == 5) {
        say((sort { $a <=> $b } @{$table{$key}})[0]);
        last;
    }
}
