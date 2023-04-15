#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=112

# Runtime: 2.340s

use strict;
use ntheory qw(todigits);
use List::Util qw(all);

sub is_bouncy {
    !(
          (all { $_[$_ - 1] <= $_[$_] } 1 .. $#_)
       || (all { $_[$_ - 1] >= $_[$_] } 1 .. $#_)
    );
}

my $n = 1;
my $count = 0;

while (1) {
    is_bouncy(todigits($n)) && ++$count;

    if ($count / $n * 100 == 99) {
        print "$n\n";
        last;
    }

    ++$n;
}
