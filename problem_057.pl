#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=57

use 5.020;
use Memoize qw(memoize);
use Math::BigNum qw(:constant);
use experimental qw(signatures);

memoize('kn');
memoize('kd');

sub a($n) { 1 }     # numerator
sub b($n) { 2 }     # denominator

sub kn($n) {
    $n < 2
      ? ($n == 0 ? 1 : 0)
      : b($n - 1) * kn($n - 1) + a($n - 1) * kn($n - 2);
}

sub kd($n) {
    $n < 2
      ? $n
      : b($n - 1) * kd($n - 1) + a($n - 1) * kd($n - 2);
}

my $count = 0;

for my $i(1..1000) {
    my $x = kn($i);
    my $y = kd($i);
    my $z = $x+$y;

    if (int(log($z)/log(10)) > int(log($y)/log(10))) {
        ++$count;
    }
}

say $count;
