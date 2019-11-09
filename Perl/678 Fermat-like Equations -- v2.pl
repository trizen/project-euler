#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 25 September 2019
# https://github.com/trizen

# https://projecteuler.net/problem=678

# Runtime: 53.885s

use 5.020;
use strict;
use warnings;

use experimental qw(signatures);

use ntheory qw(:all);
use Set::Product::XS qw(product);

my %cache;

# All solutions to `n = a^2 + b^2`, with 0 < a <= b
sub sum_of_two_squares_solutions ($n) {

    if (exists $cache{$n}) {
        return $cache{$n};
    }

    $n == 0 and return [];

    my $prod1 = 1;
    my $prod2 = 1;

    my @prime_powers;

    foreach my $f (factor_exp($n)) {
        if ($f->[0] % 4 == 3) {    # p = 3 (mod 4)
            $f->[1] % 2 == 0 or return [];    # power must be even
            $prod2 *= powint($f->[0], $f->[1] >> 1);
        }
        elsif ($f->[0] == 2) {                # p = 2
            if ($f->[1] % 2 == 0) {           # power is even
                $prod2 *= powint($f->[0], $f->[1] >> 1);
            }
            else {                            # power is odd
                $prod1 *= $f->[0];
                $prod2 *= powint($f->[0], ($f->[1] - 1) >> 1);
                push @prime_powers, [$f->[0], 1];
            }
        }
        else {                                # p = 1 (mod 4)
            $prod1 *= powint($f->[0], $f->[1]);
            push @prime_powers, $f;
        }
    }

    $prod1 == 1 and return [];
    $prod1 == 2 and return [];

    my %table;
    foreach my $f (@prime_powers) {
        my $pp = powint($f->[0], $f->[1]);
        my $r  = sqrtmod($pp - 1, $pp);
        push @{$table{$pp}}, [$r, $pp], [$pp - $r, $pp];
    }

    my @square_roots;

    product {
        push @square_roots, chinese(@_);
    } values %table;

    my @solutions;

    foreach my $r (@square_roots) {

        my $s = $r;
        my $q = $prod1;

        while ($s * $s > $prod1) {
            ($s, $q) = ($q % $s, $s);
        }

        push @solutions, [$prod2 * $s, $prod2 * ($q % $s)];
    }

    foreach my $f (@prime_powers) {
        for (my $i = $f->[1] % 2 ; $i < $f->[1] ; $i += 2) {

            my $sq = powint($f->[0], ($f->[1] - $i) >> 1);
            my $pp = powint($f->[0], $f->[1] - $i);

            push @solutions, map {
                [map { $sq * $prod2 * $_ } @$_]
            } @{sum_of_two_squares_solutions($prod1 / $pp)};
        }
    }

    @solutions = do {
        my %seen;
        grep { !$seen{$_->[0]}++ } map {
            [sort { $a <=> $b } @$_]
        } @solutions;
    };

    return ($cache{$n} = \@solutions);
}

# Number of solutions to `n = a^2 + b^2, with 0 < a < b.
# OEIS: https://oeis.org/A025441
sub r2_squares ($n) {

    my $B = 1;

    foreach my $p (factor_exp($n)) {

        my $r = $p->[0] % 4;

        if ($r == 3) {
            $p->[1] % 2 == 0 or return 0;
        }

        if ($r == 1) {
            $B *= $p->[1] + 1;
        }
    }

    return ($B >> 1);
}

# Number of solutions to `n = a^3 + b^3, with 0 < a < b.
# OEIS: https://oeis.org/A025468
sub r2_cubes ($n) {

    my $count = 0;

    foreach my $d (divisors($n)) {

        my $l = $d * $d - $n / $d;
        ($l % 3 == 0) || next;
        my $t = $d * $d - 4 * ($l / 3);

        if ($d * $d * $d >= $n and $d * $d * $d <= 4 * $n and $l >= 3 and $t > 0 and is_square($t)) {
            ++$count;
        }
    }

    return $count;
}

# Number of solutions to `n = (a^2)^2 + (b^2)^2, with 0 < a < b.
sub r2_fourth_powers ($n) {
    scalar grep { $_->[0] > 0 and $_->[1] > 0 and $_->[0] != $_->[1] and is_square($_->[0]) and is_square($_->[1]) }
      @{sum_of_two_squares_solutions($n)};
}

# Count the number of representations as sums of two squares.
sub count_sum_of_squares ($N) {

    say ":: First stage...";

    my $count = 0;

    foreach my $f (3 .. logint($N, 2)) {
        foreach my $c (2 .. rootint($N, $f)) {
            $count += r2_squares(powint($c, $f));
        }
    }

    say ":: There are $count solutions to `n^k = a^2 + b^2`, with k >= 3.";

    return $count;
}

# Count the number of representations as sums of two cubes (faster solution).
sub count_sum_of_cubes ($N) {

    say ":: Second stage...";

    my $count = 0;
    foreach my $f (4 .. logint($N, 2)) {
        foreach my $c (2 .. rootint($N, $f)) {
            $count += r2_cubes(powint($c, $f));
        }
    }

    say ":: There are $count solutions to `n^k = a^3 + b^3`, with k >= 4.";

    return $count;
}

sub count_sum_of_fourth_powers ($N) {

    say ":: Third stage...";

    my $count = 0;

    foreach my $f (3, 5 .. logint($N, 2)) {
        foreach my $c (2 .. rootint($N, $f)) {
            $count += r2_fourth_powers(powint($c, $f));
        }
    }

    say ":: There are $count solutions to `n^k = a^4 + b^4`, with k >= 3.";

    return $count;
}

# Count the number of representations as sums of powers a^e with e >= 5.
sub count_other_powers ($N) {

    say ":: Fourth stage...";

    my $count = 0;

    foreach my $u (1 .. rootint($N >> 1, 5)) {
        foreach my $v ($u + 1 .. $N) {

            my $x = $u * $u * $u * $u * $u;
            my $y = $v * $v * $v * $v * $v;

            last if ($x + $y > $N);

            while ($x + $y <= $N) {
                my $pow = is_power($x + $y);
                if ($pow > 2) {
                    $count += divisor_sum($pow, 0) - ($pow % 2 == 0) - 1;
                }
                $x *= $u;
                $y *= $v;
            }
        }
    }

    say ":: There are $count solutions to `n^k = a^e + b^e`, with k >= 3 and e >= 5";

    return $count;
}

sub F ($N) {

    my $x = count_sum_of_squares($N);
    my $y = count_sum_of_cubes($N);
    my $f = count_sum_of_fourth_powers($N);
    my $z = count_other_powers($N);

    my $total = $x + $y + $z + $f;

    return $total;
}

say F(powint(10, 18));

__END__
# F(10^10) = 3231
# F(10^11) = 7212
# F(10^12) = 16066
# F(10^13) = 35816
# F(10^14) = 80056
# F(10^15) = 178578

## For n^k <= 10^18:
:: There are 1985353 solutions to `n^k = a^2 + b^2`, with k >= 3.
:: There are 669 solutions to `n^k = a^3 + b^3`, with k >= 4.
:: There are 30 solutions to `n^k = a^4 + b^4`, with k >= 3.
:: There are 13 solutions to `n^k = a^e + b^e`, with k >= 3 and e >= 5
