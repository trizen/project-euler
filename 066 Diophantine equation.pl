#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 31 August 2016
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=66

use 5.010;
use strict;
use warnings;

use Math::BigNum qw(:constant);
local $Math::BigNum::PREC = 10000;

use ntheory qw(is_power sqrtint);

sub quadratic_formula {
    my ($x, $y, $z) = @_;
    (-$y - sqrt($y**2 - 4 * $x * $z)) / (2 * $x);
}

sub sqrt_convergents {
    my ($n) = @_;

    my $x = sqrtint($n);
    my $y = $x;
    my $z = 1;

    my @convergents = ($x);

    do {
        $y = int(($x + $y) / $z) * $z - $y;
        $z = int(($n - $y * $y) / $z);
        push @convergents, int(($x + $y) / $z);
    } until (($y == $x) && ($z == 1));

    return @convergents;
}

sub continued_frac {
    my ($i, $c) = @_;
    $i == -1 ? 0 : 1 / ($c->[$i] + continued_frac($i - 1, $c));
}

sub solve {
    my ($d) = @_;

    my ($k, @c) = sqrt_convergents($d);

    my @period = @c;
    for (my ($i, $acc) = (0, 0) ; ; ++$i) {
        if ($i > $#c) { push @c, @period; $i = 2*$i-1 }
        my $x = continued_frac($i, [$k, @c])->denominator;
        my $y = quadratic_formula(-$d, 0, $x**2 - 1);
        return $x if $y->is_pos and $y->is_int;
    }
}

my %max = (x => 0, d => -1);

foreach my $i (2 .. 1000) {
    is_power($i, 2) && next;

    my $x = solve($i);

    if ($x > $max{x}) {
        $max{x} = $x;
        $max{d} = $i;
    }
}

say $max{d};
