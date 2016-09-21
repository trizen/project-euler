#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 21 September 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=346

# Runtime: 2.755s

use 5.010;
use strict;

use ntheory qw(fromdigits vecsum);

my %table;
my $limit = 10**12;

for (my $base = 2 ; ; ++$base) {

    my $continue;
    for (my $j = 3 ; ; ++$j) {
        my $n = fromdigits('1' x $j, $base);
        $n < $limit or last;
        $continue ||= 1;
        undef $table{$n};
    }

    $continue || last;
}

say 1+vecsum(keys %table);
