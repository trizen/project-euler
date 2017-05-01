#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 30 April 2017
# https://github.com/trizen

# https://projecteuler.net/problem=601

# Runtime: 0.619s

use 5.010;
use strict;
use ntheory qw(lcm);

sub count {
    my ($n, $m) = @_;
    my $L = lcm(1..$n);

    my $formula =
        ($n % 2 == 0)
            ? sub {   $L*$_[0] + 1 }
            : sub { 2*$L*$_[0] - $L + 1 };

    my $count  = 0;
    my $period = 0;
    my $next_L = lcm($L, $n + 1);

    for (my $k = 1 ; ; ++$k) {
        my $p = $formula->($k);

        if ($period == 0 and $p-1 == $next_L) {
            $period = $k;
        }

        $p < $m ? ++$count : last;
    }

    ($period == 0) ? $count
                   : ($count - int($count/$period));
}

my $sum = 0;
for my $n (1..31) {
    $sum += count($n, 4**$n);
}
say $sum;
