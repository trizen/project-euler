#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=93

# Runtime: 13.819s

use 5.010;
use strict;
use warnings;

use ntheory qw(forperm);

my @op = ('+', '-', '*', '/');

my @expr = (
            "%d %s %d %s %d %s %d",
            "%d %s (%d %s (%d %s %d))",
            "%d %s ((%d %s %d) %s %d)",
            "(%d %s (%d %s %d)) %s %d",
            "%d %s (%d %s %d %s %d)",
            "%d %s (%d %s %d) %s %d",
            "%d %s %d %s (%d %s %d)",
            "((%d %s %d) %s %d) %s %d",
            "(%d %s %d) %s (%d %s %d)",
           );

sub evaluate {
    my ($nums, $ops, $table) = @_;
    foreach my $expr (@expr) {

        my $n = eval sprintf($expr,
            $nums->[0], $ops->[0],
            $nums->[1], $ops->[1],
            $nums->[2], $ops->[2],
            $nums->[3]
        );

        if (not $@
            and $n > 0
            and int($n) eq $n
            and not exists $table->{$n}) {
            undef $table->{$n};
        }
    }
}

sub compute {
    my ($set, $table) = @_;

    forperm {
        my @nums = @{$set}[@_];

        foreach my $i (0 .. 3) {
            foreach my $j (0 .. 3) {
                foreach my $k (0 .. 3) {
                    my @ops = @op[$i, $j, $k];
                    evaluate(\@nums, \@ops, $table);
                }
            }
        }

    } scalar(@$set);
}

my %max;

foreach my $i (1 .. 9) {
    foreach my $j ($i + 1 .. 9) {
        foreach my $k ($j + 1 .. 9) {
            foreach my $l ($k + 1 .. 9) {
                compute([$i, $j, $k, $l], \my %table);

                my ($n, $c) = (0, 0);
                my @keys = sort { $a <=> $b } keys %table;

                while (@keys) {
                    shift(@keys) == ++$n ? ++$c : last;
                }

                if ($c > ($max{max} || 0)) {
                    $max{max} = $c;
                    $max{set} = [$i, $j, $k, $l];
                }
            }
        }
    }
}

print "$max{max}: [@{$max{set}}]\n";
