#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# Find the smallest prime which, by replacing part of the number (not necessarily adjacent digits) with the same digit, is part of an eight prime value family.

# https://projecteuler.net/problem=51

# Runtime: 3.393s

use 5.014;
use ntheory qw(primes forcomb);

foreach my $n (1 .. 15) {

    my %table;
    foreach my $p (@{primes(10**($n - 1), 10**$n - 1)}) {
        my @s = split(//, $p);
        foreach my $i (1 .. $n - 1) {
            forcomb {
                if (length(join('', @s[@_]) =~ tr/0-9//sr) == 1) {
                    my %ind;
                    @ind{@_} = ();
                    push @{$table{join('', map { exists($ind{$_}) ? '*' : $s[$_] } 0 .. $#s)}}, $p;
                }
            } length($p)-1, $i;
        }
    }

    my $min = +'inf';

    foreach my $value (values %table) {
        if ($#{$value} == 7 and $value->[0] < $min) {
            say "Found prime group: [@{$value}]";
            $min = $value->[0];
        }
    }

    if ($min != +'inf') {
        say $min;
        last;
    }
}
