#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 28 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# Simple minded solution.

# https://projecteuler.net/problem=347

use 5.010;
use strict;
use integer;

use List::Util qw(uniq);
use ntheory qw(factor forcomposites vecsum);

my (@f, %max);

forcomposites {
    if ((@f = uniq(factor($_))) == 2) {
        $max{"@f"} = $_;
    }
} 10_000_000;

say vecsum(values %max);
