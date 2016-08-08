#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

my %table;
my $i = 1;

OUTER: while (1) {
    push @{$table{join '', sort split //, $i**3}}, $i++**3;
    foreach my $value (values %table) {
        if (@$value == 5) {
            print +((sort { $a <=> $b } @$value)[0]), "\n";
            last OUTER;
        }
    }
}
