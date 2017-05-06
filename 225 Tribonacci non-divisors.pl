#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 06 May 2017
# https://github.com/trizen

# https://projecteuler.net/problem=225

# Runtime: 9.636s

use 5.010;
use strict;
use warnings;

use Math::GMPz;
use List::Util qw(all);
use Memoize qw(memoize);

my $one = Math::GMPz->new(1);

sub tribonacci {
    my ($n) = @_;
    $n <= 3 ? $one : (
          tribonacci($n-1)
        + tribonacci($n-2)
        + tribonacci($n-3)
    );
}

memoize('tribonacci');

my @tribs;
foreach my $n (1 .. 30000) {
    push @tribs, tribonacci($n);
}

for (my ($c, $n) = (1, 1); ; $n += 2) {
    if (all { ($_ % $n) != 0 } @tribs) {
        say "$c -> $n";
        last if 124 == $c++;
    }
}
