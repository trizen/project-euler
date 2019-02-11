#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 11 February 2019
# https://github.com/trizen

# https://projecteuler.net/problem=66

# Runtime: 0.151s

use 5.010;
use strict;
use warnings;

use Math::GMPz;
use ntheory qw(sqrtint is_square);
use experimental qw(signatures);

use constant {
              ONE  => Math::GMPz->new(1),
              ZERO => Math::GMPz->new(0),
             };

sub solve_pell ($n, $w = 1) {

    return () if is_square($n);

    my $x = sqrtint($n);
    my $y = $x;
    my $z = 1;
    my $r = 2 * $x;

    my ($e1, $e2) = (ONE,  ZERO);
    my ($f1, $f2) = (ZERO, ONE);

    for (1 .. $n) {

        $y = $r * $z - $y;
        $z = ($n - $y * $y) / $z;
        $r = int(($x + $y) / $z);

        my $A = $e2 + $x * $f2;
        my $B = $f2;

        if ($z == 1 and $A**2 - $n * $B**2 == 1) {
            return ($A, $B);
        }

        ($e1, $e2) = ($e2, $r * $e2 + $e1);
        ($f1, $f2) = ($f2, $r * $f2 + $f1);
    }

    return ();
}

my %max = (x => 0, d => -1);

foreach my $i (2 .. 1000) {
    is_square($i) && next;

    my $x = solve_pell($i);

    if ($x > $max{x}) {
        $max{x} = $x;
        $max{d} = $i;
    }
}

say $max{d};
