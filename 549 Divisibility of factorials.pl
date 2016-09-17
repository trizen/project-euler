#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 17 September 2016
# Website: https://github.com/trizen

# https://projecteuler.net/problem=549

# Runtime: 8 min 10.49s

use 5.010;
use strict;
use integer;

use List::Util qw(uniq max);
use ntheory qw(factor factorial forcomposites sum_primes vecprod);

my $limit = 10**8;

my %cache;

sub smarandache {
    my ($f, $u) = @_;

    ((my $x = @$u) == (my $y = @$f))
      && return $f->[-1];

    if ($x == 1) {

        my $k = $u->[0];

        ($y <= $k)
          && return $k * $y;

        my $key = "@$f";

        exists($cache{$key})
          && return $cache{$key};

        my $n = vecprod(@$f);

        my $max = $k * $y;
        my $f   = factorial($max - $k);

        while ($f % $n == 0) {
            $max -= $k;
            $f /= $max;
        }

        return ($cache{$key} = $max);
    }

    my %count;
    ++$count{$_} for @$f;

    max(map {
            $count{$_} == 1
                ? $_
                : smarandache([($_) x $count{$_}], [$_])
    } @$u);
}

my $sum = 0;

forcomposites {
    my @f = factor($_);
    $sum += smarandache(\@f, [uniq(@f)]);
} $limit;

$sum += sum_primes($limit);

say $sum;
