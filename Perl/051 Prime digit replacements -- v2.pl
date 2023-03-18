#!/usr/bin/perl

# Author: Trizen
# Date: 18 March 2023
# https://github.com/trizen

# Find the smallest prime which, by replacing part of the number (not necessarily adjacent digits) with the same digit, is part of an eight prime value family.

# https://projecteuler.net/problem=51

# Runtime: 2.179s

use 5.036;
use ntheory    qw(:all);
use List::Util qw(uniq);

foreach my $n (1 .. 15) {

    my %table;
    foreach my $p (@{primes(10**($n - 1), 10**$n - 1)}) {
        my @s = split(//, $p);

        my %indices;
        foreach my $i (0 .. $#s) {
            push @{$indices{$s[$i]}}, $i;
        }

        foreach my $idx (values %indices) {
            foreach my $i (1 .. scalar(@$idx)) {
                forcomb {
                    my $key = $p;
                    foreach my $i (@{$idx}[@_]) {
                        substr($key, $i, 1, '*');
                    }
                    push @{$table{$key}}, $p;
                } scalar(@$idx), $i;
            }
        }
    }

    my $min = +'inf';

    foreach my $value (values %table) {
        if (scalar(@$value) == 8 and $value->[0] < $min) {
            say "Found prime group: [@{$value}]";
            $min = $value->[0];
        }
    }

    if ($min != +'inf') {
        say $min;
        last;
    }
}
