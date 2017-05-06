#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 06 May 2017
# https://github.com/trizen

# https://projecteuler.net/problem=225

# Runtime: 11.433s

use 5.010;
use strict;
use integer;

sub tribonacci {
    my ($n, $k, $c) = @_;
    $c->{$n} //= $n <= 3 ? 1 : (
        tribonacci($n - 1, $k, $c) % $k
      + tribonacci($n - 2, $k, $c) % $k
      + tribonacci($n - 3, $k, $c) % $k
    ) % $k;
}

my $num = 0;
my $nth = 124;

for (my ($c, $k) = (1, 1) ; $c <= $nth ; $k += 2) {
    my %cache;
    for (my $n = 4 ; ; $n += 3) {
        my $t1 = tribonacci($n,     $k, \%cache) || last;
        my $t2 = tribonacci($n + 1, $k, \%cache) || last;
        my $t3 = tribonacci($n + 2, $k, \%cache) || last;

        if ($t1 == 1 and $t2 == 1 and $t3 == 1) {
            say "$c -> $k";
            $num = $k;
            $c += 1;
            last;
        }
    }
}

say "Final answer: $num";
