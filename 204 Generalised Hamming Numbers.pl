#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 19 February 2017
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=204

# Runtime: 35.535s

use 5.010;
use strict;

use ntheory qw(primes);

my @primes = @{primes(100)};
my $limit  = 1e9;

my @letters = do {
    my $letter = 'a';
    map { $letter++ } 0 .. $#primes;
};

my $code = 'do { use integer; my $count = 0;' . join('',
    map {
            'foreach my $'
          . $letters[$_] . '(0..'
          . int(log($limit) / log($primes[$_])) . ') {'
          . join(' * ', map { $primes[$_] . '**$' . $letters[$_] } 0 .. $_) . ' <= '
          . $limit
          . ' or last;'
      } 0 .. $#primes
  )
  . join(' * ', map { $primes[$_] . '**$' . $letters[$_] } 0 .. $#primes) . ' <= '
  . $limit
  . '? ++$count : last'
  . ('}' x @primes)
  . '$count }';

say eval($code);
