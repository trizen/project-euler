#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 05 May 2017
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=118

# Runtime: 17.289s

use 5.010;
use strict;
use integer;

use ntheory qw(is_prime);
use Algorithm::Combinatorics qw(variations);

my @primes;
foreach my $i (1 .. 8) {
    my $iter = variations([1 .. 9], $i);
    while (defined(my $arr = $iter->next)) {
        my $n = join('', @$arr);
        if (is_prime($n)) {
            push @primes, $n;
        }
    }
}

my $count = 0;
my $limit = $#primes;

sub p_118 {
    my ($pos, $root) = @_;

    if (length($root) == 9) {
        return ++$count;
    }

    if ($root !~ /[$primes[$pos]]/) {
        p_118($pos, $root . $primes[$pos]);
    }

    if ($pos < $limit
        and length($root)
          + length($primes[$pos + 1]) <= 9
    ) {
        p_118($pos + 1, $root);
    }
}

p_118(0, '');

say $count;
