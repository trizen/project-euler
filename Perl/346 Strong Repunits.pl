#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 21 September 2016
# Edit: 16 November 2023
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=346

# Runtime: 1.835s

use 5.010;
use strict;

use ntheory qw(fromdigits vecsum);

my %table;
my $limit = 10**12;

for (my $j = 3 ; ; ++$j) {

    my $continue;
    my $repunit = '1' x $j;

    for (my $base = 2 ; ; ++$base) {
        my $n = fromdigits($repunit, $base);
        $n < $limit or last;
        $continue ||= 1;
        undef $table{$n};
    }

    $continue || last;
}

say 1 + vecsum(keys %table);
