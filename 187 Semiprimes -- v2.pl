#!/usr/bin/perl

# Derived from a method posted by Dana Jacobsen.
# Date: 22 August 2016

# https://projecteuler.net/problem=187

# Runtime: 0.051s

use strict;
use integer;

use ntheory qw(prime_count forprimes);

my $limit = 10**8-1;
my $count = 0;

forprimes {
    $count += prime_count($_, $limit/$_);
} int(sqrt($limit));

print "$count\n";
