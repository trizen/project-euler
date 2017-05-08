#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 31 August 2016
# License: GPLv3
# https://github.com/trizen

# https://projecteuler.net/problem=66

# Runtime: 1.673s

use 5.010;
use strict;
use warnings;

use Math::AnyNum qw(isqrt is_square);

sub sqrt_convergents {
    my ($n) = @_;

    my $x = isqrt($n);
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
    $i < 0 ? 0 : ($c->[$i] + continued_frac($i - 1, $c))->inv;
}

sub solve {
    my ($d) = @_;

    my ($k, @c) = sqrt_convergents($d);

    my @period = @c;
    for (my $i = 0 ; ; ++$i) {
        if ($i > $#c) { push @c, @period; $i = 2 * $i - 1 }
        my $x = continued_frac($i, [$k, (@c) x ($i + 1)])->denominator;
        return $x if is_square(4 * $d * ($x*$x - 1));
    }
}

my %max = (x => 0, d => -1);

foreach my $i (2 .. 1000) {
    is_square($i) && next;

    my $x = solve($i);

    if ($x > $max{x}) {
        $max{x} = $x;
        $max{d} = $i;
    }
}

say $max{d};
