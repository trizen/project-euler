#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 06 May 2017
# https://github.com/trizen

# https://projecteuler.net/problem=225

# Runtime: 40.531s

use 5.010;
use strict;
use integer;

use Memoize qw(memoize);

sub tribonacci {
    my ($n, $k) = @_;
    $n <= 3 ? 1 : (
        tribonacci($n - 1, $k) % $k
      + tribonacci($n - 2, $k) % $k
      + tribonacci($n - 3, $k) % $k
    ) % $k;
}

memoize('tribonacci');

my $num = 0;
my $nth = 124;

OUTER:
for (my ($c, $k) = (1, 1) ; ; $k += 2) {
    for (my $n = 4 ; ; $n += 3) {
        my $t1 = tribonacci($n,     $k);
        my $t2 = tribonacci($n + 1, $k);
        my $t3 = tribonacci($n + 2, $k);

        if ($t1 == 1 and $t2 == 1 and $t3 == 1) {
            say "$c -> $k";
            $num = $k;
            last OUTER if ($c++ == $nth);
            last;
        }

        if ($t1 == 0 or $t2 == 0 or $t3 == 0) {
            last;
        }
    }
}

say "Final answer: $num";
