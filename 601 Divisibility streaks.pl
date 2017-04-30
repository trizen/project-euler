#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 27 January 2017
# https://github.com/trizen

# https://projecteuler.net/problem=601

# Runtime: 0.028s

use 5.010;
use strict;
use ntheory qw(lcm);

sub count {
    my ($n, $l, $k) = @_;

    if ($n % 2 == 0) {
        my $period = lcm($l, $n+1)/$l;
        my $count  = int(($k - 2) / $l);
        $count - int($count / $period);
    }
    else {
        int(($k - 2) / (2*$l) + 1/2);
    }
}

my @lcm;
foreach my $n (1 .. 31) {
    my $lcm = lcm(1 .. $n);
    push @lcm, [$n, $lcm] if lcm($lcm, $n + 1) != $lcm;
}

my $sum = 0;
foreach my $g (@lcm) {
    $sum += count($g->[0], $g->[1], 4**$g->[0]);
}

say $sum;
