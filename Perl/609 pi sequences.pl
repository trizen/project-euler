#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 14 September 2017
# https://github.com/trizen

# https://projecteuler.net/problem=609

# Runtime: ~4 minutes

use 5.010;
use strict;
use warnings;

use ntheory qw(primes);

sub p_609 {
    my ($n, $mod) = @_;

    my %primes;
    @primes{@{primes($n)}} = ();

    my @pc;
    my $pc = 0;

    my %table;
    foreach my $i (1 .. $n) {

        $pc++ if exists($primes{$i});
        $pc[$i] = $pc;

        my $u = $pc;
        my $c = exists($primes{$i}) ? 0 : 1;

        while ($u >= 1) {
            ++$c if !exists($primes{$u});
            ++$table{$c};
            $u = $pc[$u];
        }
    }

    my $prod = 1;
    foreach my $key (keys %table) {
        my $val = $table{$key};

        if ($val > 0) {
            $prod *= $val % $mod;
            $prod %= $mod;
        }
    }

    return $prod;
}

say p_609(1e8, 1000000007);
