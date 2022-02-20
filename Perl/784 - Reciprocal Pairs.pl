#!/usr/bin/perl

# Reciprocal Pairs
# https://projecteuler.net/problem=784

# Runtime: 1 hour and 10 minutes.

# See version 2 for a faster method.

use 5.020;
use ntheory qw(:all);
use experimental qw(signatures);

local $| = 1;

sub F ($n) {
    my $total = 0;

    foreach my $a (1 .. $n) {

        if ($a % 1000 == 0) {
            printf("[%.2f%%] Processing...\r", $a / $n * 100);
        }

        my %seen;
        foreach my $d (divisors($a * $a - 1)) {
            $d > $a or next;

            foreach my $b (allsqrtmod(1, $d)) {

                $a < $b or next;

                my $inv = invmod($a, $b);
                if (defined($inv) and $inv == invmod($b, $a)) {
                    next if $seen{$b}++;
                    $total += $a + $b;
                }
            }
        }
    }

    print "\n";
    return $total;
}

say F(5);
say F(100);
say F(2 * 1e6);
