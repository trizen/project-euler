#!/usr/bin/perl

# 2025
# https://projecteuler.net/problem=932

# Bruteforce solution. Slow.

# Runtime: 3 minutes, 35 seconds

use 5.036;
use ntheory qw(:all);

sub T($n) {

    my $sum = 0;

    foreach my $k (1 .. powint(10, $n >> 1)) {

        my $t   = powint($k, 2);
        my $len = length($t);

        foreach my $i (0, 1, -1) {

            my $j = ($len >> 1) + $i;

            my $prefix = substr($t, 0, $j);
            my $suffix = substr($t, $j);

            if (    $prefix
                and $suffix
                and substr($prefix, 0, 1) ne '0'
                and substr($suffix, 0, 1) ne '0'
                and powint(addint($prefix, $suffix), 2) == $t) {
                say "$t = $prefix + $suffix";
                $sum = addint($sum, $t);
            }
        }
    }

    return $sum;
}

T(4) == 5131         or die "error";
T(10) == 13852403215 or die "error";

my $sum = T(16);
say "Total: $sum";
