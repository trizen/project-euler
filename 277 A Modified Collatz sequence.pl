#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 25 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=277

use 5.010;
use strict;

sub collatz {
    my ($n) = @_;

    my $acc = '';

    while (1) {
        last if $n == 1;

        if ($n % 3 == 0) {
            $n /= 3;
            $acc .= 'D';
        }
        elsif ($n % 3 == 1) {
            $n = (4 * $n + 2) / 3;
            $acc .= 'U';
        }
        elsif ($n % 3 == 2) {
            $n = (2 * $n - 1) / 3;
            $acc .= 'd';
        }
    }

    $acc;
}

my $step = 1;
my $from = 10**15;

my $j = 1;
my $s = 'UDDDUdddDDUDDddDdDddDDUDDdUUDd';
my $l = length($s);

for (my $i = $from ; ; $i += $step) {

    my $c = collatz($i);
    if (substr($c, 0, $j) eq substr($s, 0, $j)) {

        if ($j == $l) {
            say $i;
            last;
        }

        $step *= 3;
        $j += 1;
    }
}
