#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 30 April 2017
# https://github.com/trizen

# https://projecteuler.net/problem=601

# Runtime: 0.028s

=for comment

The numbers n in the range [1..31] with non-zero values for P(n, 4^n), are:

    [1, 2, 3, 4, 6, 7, 8, 10, 12, 15, 16, 18, 22, 24, 26, 28, 30, 31]

All this numbers satisfy the following inequality:

    lcm(1..n) != lcm(1..(n+1)).

For this numbers, P(n, 4^n) can be efficiently computed as follows:

    a = floor((4^n - 2) / lcm(1..n))
    b = lcm(1..(n+1)) / lcm(1..n)

    P(n, 4^n) = a - floor(a/b)

=cut

use 5.010;
use strict;
use ntheory qw(lcm);

sub count {
    my ($n, $k) = @_;
    my $lcm    = lcm(1 .. $n);
    my $period = lcm($lcm, $n + 1) / $lcm;
    my $count  = int(($k - 2) / $lcm);
    $count - int($count / $period);
}

my $sum = 0;
foreach my $n (1 .. 31) {
    $sum += count($n, 4**$n);
}

say $sum;
