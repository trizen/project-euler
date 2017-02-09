#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 09 February 2016
# Website: https://github.com/trizen

# https://projecteuler.net/problem=111

# Runtime: 0.065s

use 5.010;
use strict;

use ntheory qw(is_prime);

my $len = 10;

my %table = (
             0 => 8,
             1 => 9,
             2 => 8,
             3 => 9,
             4 => 9,
             5 => 9,
             6 => 9,
             7 => 9,
             8 => 8,
             9 => 9,
            );

sub comb_1 {
    my ($digit) = @_;

    my $r = $len - 1;
    my @p = ($digit) x $r;

    my $sum = 0;
    foreach my $i (0 .. $r) {
        foreach my $d (0 .. 9) {
            my @a = @p;
            splice(@a, $i, 0, $d);
            my $n = join('', @a);
            $sum += $n if $a[0] && is_prime($n);
        }
    }

    return $sum;
}

sub comb_2 {
    my ($digit) = @_;

    my $r = $len - 2;
    my @p = ($digit) x $r;

    my $sum = 0;
    foreach my $i (0 .. $r) {
        foreach my $d1 (0 .. 9) {
            foreach my $j (0 .. $r) {
                foreach my $d2 (0 .. 9) {
                    my @a = @p;
                    splice(@a, $i, 0, $d1);
                    splice(@a, $j, 0, $d2);
                    my $n = join('', @a);
                    $sum += $n if $a[0] && is_prime($n);
                }
            }
        }
    }

    return $sum;
}

my $total = 0;
foreach my $d (keys %table) {
    my $max = $table{$d};
    if ($max == 8) {
        $total += comb_2($d);
    }
    elsif ($max == 9) {
        $total += comb_1($d);
    }
}

say $total;
