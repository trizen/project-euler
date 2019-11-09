#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 20 August 2017
# https://github.com/trizen

# https://projecteuler.net/problem=425

# Runtime: 8 min, 23 sec

use 5.010;
use strict;

use ntheory qw(primes);
use List::Util qw(shuffle);

my $limit = 10**7;

# Array of primes up to limit
my @primes = @{primes($limit)};

# Table of primes up to limit
my %h;
@h{@primes} = ();

my %seen;
my %lens;

# Group by length
foreach my $p (@primes) {
    push @{$lens{length($p)}}, $p;
}

# Group by difference of one digit
my %table;
foreach my $len (sort { $b <=> $a } keys %lens) {
    foreach my $p (@{$lens{$len}}) {
        foreach my $i (0 .. $len - 1) {
            my $t = $p;
            substr($t, $i, 1, 'x');
            push @{$table{$t}}, $p;
        }
    }
}

sub is_twos_relative {
    my ($n, $m) = @_;

    # If we reach `n=2`, then `m` is a 2's relative
    return 1 if $n == 2;

    # If `n` was already seen, then `m` is not a 2's relative
    if (exists $seen{$n}) {
        return 0;
    }

    undef $seen{$n};    # mark `n` as seen

    # If removing one digit from the left is still a prime
    if (exists($h{substr($n, 1)})) {

        # Is this prime connected to `m` via 2? Great! We're done!
        if (is_twos_relative(substr($n, 1), $m)) {
            return 1;
        }
    }

    # Create the keys that differ in exactly one digit from n
    my @comb;
    foreach my $i (0 .. length($n) - 1) {
        my $t = $n;
        substr($t, $i, 1, 'x');
        push @comb, $t;
    }

    # For each key, iterate over the corresponding primes
    foreach my $c (shuffle(@comb)) {
        foreach my $p (@{$table{$c}}) {

            # We're not interested in p > m
            if ($p > $m) {
                last;
            }

            # Is `p` connected to `m` via 2? Great! We're done!
            if (is_twos_relative($p, $m)) {
                return 1;
            }
        }
    }

    return 0;
}

# Sum the primes which are not 2's relatives.
my $sum = 0;
foreach my $p (@primes) {
    if (not is_twos_relative($p, $p)) {
        $sum += $p;
    }
    undef %seen;    # reset the `seen` table
}

say $sum;
