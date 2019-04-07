#!/usr/bin/perl

# Using the Brahmagupta–Fibonacci identity
#   https://en.wikipedia.org/wiki/Brahmagupta%E2%80%93Fibonacci_identity

# https://projecteuler.net/problem=273

# Runtime: 27.214s

use 5.020;
use warnings;

use ntheory qw(:all);
use experimental qw(signatures);
use Memoize qw(memoize);

my @primes = grep { $_ % 4 == 1 } @{primes(150)};
my $plen   = scalar(@primes);

my @solutions;

foreach my $p (@primes) {
    foreach my $x (1 .. $p) {

        my $y = sqrtint($p - $x * $x);

        if ($x * $x + $y * $y == $p) {
            push @solutions, [$x, $y];
            last;
        }
    }
}

my $sum = 0;

sub problem_273 ($i, $prev) {

    if ($i < $plen) {
        __SUB__->($i + 1, $prev);

        my ($aa, $bb) = @{$solutions[$i]};
        my @partial = ([$aa, $bb]);

        if (@$prev) {
            @partial =
              map {
                [sort { $a <=> $b } map { abs($_) } @$_]
              }
              map {
                (
                 [$_->[0] * $aa - $_->[1] * $bb, $_->[1] * $aa + $_->[0] * $bb],
                 [$_->[0] * $aa + $_->[1] * $bb, $_->[1] * $aa - $_->[0] * $bb]
                )
              } @$prev;
        }

        foreach my $solution (@partial) {
            $sum += $solution->[0];
        }

        if (@partial) {
            __SUB__->($i + 1, \@partial);
        }
    }
}

problem_273(0, []);

say $sum;
