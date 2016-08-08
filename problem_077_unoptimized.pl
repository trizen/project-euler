#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

use 5.010;
use strict;
use warnings;
use ntheory qw(primes);
use List::Util qw(sum0);

sub count {
    my ($n, $primes, $solution) = @_;
    my $sum = sum0(@$solution);

    ($sum == $n)                 ? 1
    : ($sum > $n || !@{$primes}) ? 0
    : (count($n, $primes, [@{$solution}, $primes->[0]]) +
       count($n, [@{$primes}[1 .. $#{$primes}]], $solution));
}

foreach my $i (4 .. 1e6) {
    if (count($i, primes(1, $i - 2), []) > 5000) {
        say $i; last;
    }
}
