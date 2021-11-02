#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 27 February 2021
# https://github.com/trizen

# Upside down Diophantine equation
# https://projecteuler.net/problem=748

# The problem asks for integer solutions to:
#   1/x^2 + 1/y^2 = 13/z^2

# It is easy to see that:
#   (x^2 + y^2)/13 = v^4, for some integer v.

# Multiplying both sides by 13, we have:
#   x^2 + y^2 = v^4 * 13

# By finding integer solutions (x,y) to the above equation, we can then compute `z` as:
#   z = sqrt((x^2 * y^2 * 13)/(x^2 + y^2))
#   z = sqrt((x^2 * y^2) / v^4)

# We need to iterate over 1 <= v <= sqrt(N/3).

use 5.020;
use strict;
use warnings;

use ntheory qw(:all);
use experimental qw(signatures);
use Set::Product::XS qw(product);
use Math::Sidef qw();

my %cache;

sub sum_of_two_squares_solutions ($n) {

    $n == 0 and return [0, 0];

    if (exists $cache{$n}) {
        return @{$cache{$n}};
    }

    my $prod1 = 1;
    my $prod2 = 1;

    my @prime_powers;

    foreach my $f (factor_exp($n)) {
        if ($f->[0] % 4 == 3) {    # p = 3 (mod 4)
            $f->[1] % 2 == 0 or return;    # power must be even
            $prod2 = mulint($prod2, powint($f->[0], $f->[1] >> 1));
        }
        elsif ($f->[0] == 2) {             # p = 2
            if ($f->[1] % 2 == 0) {        # power is even
                $prod2 = mulint($prod2, powint($f->[0], $f->[1] >> 1));
            }
            else {                         # power is odd
                $prod1 = mulint($prod1,  $f->[0]);
                $prod2 = mulint($prod2, powint($f->[0], ($f->[1] - 1) >> 1));
                push @prime_powers, [$f->[0], 1];
            }
        }
        else {                             # p = 1 (mod 4)
            $prod1 = mulint($prod1, powint($f->[0], $f->[1]));
            push @prime_powers, $f;
        }
    }

    $prod1 == 1 and return [$prod2, 0];
    $prod1 == 2 and return [$prod2, $prod2];

    my %table;
    foreach my $f (@prime_powers) {

        my $pp = powint($f->[0], $f->[1]);
        my $r = sqrtmod(-1, $pp);

        if (not defined($r)) {
            $r = Math::Sidef::sqrtmod(-1, $pp);
        }

        push @{$table{$pp}}, [$r, $pp], [subint($pp, $r), $pp];
    }

    my @square_roots;

    product {
        push @square_roots, chinese(@_);
    } values %table;

    my @solutions;

    foreach my $r (@square_roots) {

        my $s = $r;
        my $q = $prod1;

        while (mulint($s, $s) > $prod1) {
            ($s, $q) = (modint($q, $s), $s);
        }

        push @solutions, [mulint($prod2, $s), mulint($prod2, modint($q, $s))];
    }

    foreach my $f (@prime_powers) {
        for (my $i = $f->[1] % 2; $i < $f->[1]; $i += 2) {

            my $sq = powint($f->[0], ($f->[1] - $i) >> 1);
            my $pp = powint($f->[0], $f->[1] - $i);

            push @solutions, map {
                [map { vecprod($sq, $prod2, $_) } @$_]
            } __SUB__->(divint($prod1, $pp));
        }
    }

    @{$cache{$n} = [do {
        my %seen;
        grep { !$seen{$_->[0]}++ } map {
            [sort { $a <=> $b } @$_]
        } @solutions;
    }]};
}

sub S($N) {

    my $total = 0;
    my $limit = int(sqrt($N/3));

    for(my $v = 1; $v <= $limit; $v += 2) {

        kronecker(-1, $v) == 1 or next;

        my $w = powint($v, 4);
        my @solutions = sum_of_two_squares_solutions(mulint(13, $w));

        @solutions || next;

        foreach my $pair(@solutions) {

            my ($x, $y) = @$pair;

            $y <= $N or next;

            my $t = vecprod($x, $x, $y, $y);

            modint($t, $w) == 0 or next;

            my $z = divint($t, $w);

            if (is_square($z)) {

                $z = sqrtint($z);
                $z <= $N or next;

                if (gcd($x,$y,$z) == 1) {
                    say "($x, $y, $z, $v)";
                    $total += $x+$y+$z;
                }
            }
        }
    }

    return $total;
}

sub assert_eq ($x, $y) {
    $x == $y
        or die "error: $x != $y";
}

assert_eq(S(1e2), 124);
assert_eq(S(1e3), 1470);
assert_eq(S(1e5), 2340084);
assert_eq(S(1e6), 85126107);
assert_eq(S(1e7), 2639502562);
assert_eq(S(1e8), 84023225394);

my $total = S(1e16);
say "Total: $total -> ", $total % 1e9;
