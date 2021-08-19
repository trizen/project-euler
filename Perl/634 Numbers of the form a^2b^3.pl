#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 19 August 2021
# https://github.com/trizen

# Numbers of the form a^2 * b^3, where a,b > 1.
# https://projecteuler.net/problem=634

# Runtime: 5 minutes, 41 seconds.

use 5.020;
use strict;
use warnings;

use ntheory qw(:all);
use experimental qw(signatures);

sub power_divisors ($n, $k = 1) {

    my @d  = (1);
    my @pp = grep { $_->[1] >= $k } factor_exp($n);

    foreach my $pp (@pp) {

        my $p = $pp->[0];
        my $e = $pp->[1];

        my @t;
        for (my $i = $k ; $i <= $e ; $i += $k) {
            push @t, map { mulint($_, powint($p, $i)) } @d;
        }

        push @d, @t;
    }

    return @d;
}

sub p_634 ($n) {

    my $count = 0;

    foreach my $b (2 .. rootint($n, 3)) {

        my $b_cubed = powint($b, 3);
        my $a_limit = sqrtint(divint($n, $b_cubed));

        $count += $a_limit - 1;

        if (!is_square_free($b)) {

            next if ($a_limit <= 1);

            my $acc = 0;

            if ($b == 4) {
                $acc = 0;
            }
            elsif ($b == 9) {
                $acc = divint($a_limit, $b - 1);
            }
            elsif (is_powerful($b, 3)) {
                $acc = $a_limit - 1;
            }
            elsif (is_square($b)) {

                say "b = $b -- looping up to $a_limit (~10^", sprintf("%.2f", log($a_limit) / log(10)), ")";

                foreach my $a (2 .. $a_limit) {

                    my $powerful = mulint(mulint($a, $a), $b_cubed);

                    foreach my $d (power_divisors($powerful, 2 * 3)) {
                        my $w = rootint($d, 3);
                        if ($w >= 2 and $w < $b) {
                            ++$acc;
                            last;
                        }
                    }
                }
            }
            else {
                $acc = $a_limit - 1;
            }

            #say "f($b) = $acc with limit = $a_limit" if ($a_limit > 100);
            $count -= $acc;
        }
    }

    return $count;
}

p_634(2 * 1e4) == 130   or die "error";
p_634(3 * 1e6) == 2014  or die "error";
p_634(5 * 1e9) == 91255 or die "error";

say p_634(mulint(9, powint(10, 18)));
