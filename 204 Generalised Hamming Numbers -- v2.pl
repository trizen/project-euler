#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 19 February 2017
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=204

# Runtime: 22.493s

use 5.010;
use strict;

use ntheory qw(primes);

my @primes = @{primes(100)};
my $limit  = 1e9;

my @letters = do {
    my $letter = 'a';
    map { $letter++ } 0 .. $#primes;
};

my $code = "function solve()\ncount = 0\n" . join('',
    map {
            'for ' . $letters[$_] . ' in 0:'
          . int(log($limit) / log($primes[$_])) . "\n"
          . join(' * ', map { $primes[$_] . '^' . $letters[$_] } 0 .. $_) . ' <= '
          . $limit . " || break\n"
      } 0 .. $#primes
  )
  . join(' * ', map { $primes[$_] . '^' . $letters[$_] } 0 .. $#primes) . ' <= '
  . $limit
  . " ? (count += 1) : break\n"
  . ("end\n" x @primes)
  . "count\nend\nprintln(solve())";

exec('julia', '--math-mode=fast', '--optimize=3', '-e', $code);
