#!/usr/bin/perl

# Stealthy Numbers
# https://projecteuler.net/problem=757

# These are numbers of the form x*(x+1) * y*(y+1), where x and y are positive integers.
# Also known as bipronic numbers.

# See also:
#   https://oeis.org/A072389

# Runtime: ~1 hour.

# See the Julia version for a faster solution.

use 5.020;
use strict;
use warnings;

use ntheory qw(:all);
use experimental qw(signatures);

sub get_representations($v) {

    my @representations;

    foreach my $a (divisors($v)) {
        my $b = divint($v, $a);

        last if ($b <= $a);

        my $s = mulint($a, $a) - vecprod(2, $a, $b) - 2 * $a + mulint($b, $b) - 2 * $b + 1;

        $s < 0 and next;

        my $d = (sqrtint($s) + $a + $b - 1);
        $d % 2 == 0 or next;
        $d >>= 1;

        if ($v % $d == 0) {
            my $c = divint($v, $d);
            push @representations, [$a, $b, $c, $d];
        }
    }

    return @representations;
}

use Data::Dump qw(pp);

pp [get_representations(36)];
pp [get_representations(570024)];

my $n = powint(10, 14);

my %seen;
my $count = 0;

my $limit = rootint($n, 4);
my @range = 1 .. $limit;

foreach my $x (1 .. $limit) {

    for (my $y = $x ; ; ++$y) {

        my $v = $x * ($x + 1) * $y * ($y + 1);

        last if ($v > $n);

        my $duplicate = 0;

        foreach my $d ((divisors($v) < $limit) ? divisors($v) : @range) {

            last if ($d > $limit);
            $v % $d == 0 or next;

            if ($v % ($d * ($d + 1)) == 0) {

                my $q = divint($v, $d * ($d + 1));
                my $a = (sqrtint(4 * $q + 1) - 1) >> 1;

                next if ($d > $a);

                if ($v == $d * ($d + 1) * $a * ($a + 1)) {
                    ++$duplicate;
                }
            }
        }

        if ($duplicate > 1) {
            $seen{$v} = $duplicate - 1;
        }

        ++$count;
    }
}

say $count;
say scalar keys %seen;
say $count - vecsum(values %seen);
