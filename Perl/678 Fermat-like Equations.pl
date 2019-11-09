#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 24 September 2019
# https://github.com/trizen

# https://projecteuler.net/problem=678

# Runtime: ~6 minutes.

use 5.020;
use strict;
use warnings;

use experimental qw(signatures);

use ntheory qw(:all);
use List::Util qw(uniq);

# Number of solutions to `n = a^2 + b^2, with 0 < a < b.
# OEIS: https://oeis.org/A025441
sub r2 ($n) {

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

# Returns true if n can be represented as a sum of two cubes.
sub is_sum_of_two_cubes ($n) {

    my $L = rootint($n - 1, 3) + 1;
    my $U = rootint(4 * $n, 3);

    foreach my $m (divisors($n)) {
        if ($L <= $m and $m <= $U) {
            my $l = $m * $m - $n / $m;
            $l % 3 == 0 or next;
            is_square($m * $m - 4 * ($l / 3)) && return 1;
        }
    }

    return;
}

# Count the number of representations as sums of two squares.
sub count_sum_of_squares ($N) {

    my $count = 0;
    my $root  = rootint($N, 3);

    say ":: First stage...";

    foreach my $k (2 .. $root) {

        my $t = $k * $k * $k;

        while ($t <= $N) {
            $count += r2($t);
            $t     *= $k;
        }
    }

    say ":: There are $count solutions to `n^k = a^2 + b^2`, with k >= 3.";

    return $count;
}

sub generate_other_powers ($N, $k) {

    # Generate all numbers of the form n^k with k >= 4 and n^k <= N.
    my @nums;
    foreach my $n (2 .. rootint($N, $k)) {

        my $t = powint($n, $k);

        while ($t <= $N) {
            push @nums, $t;
            $t *= $n;
        }
    }

    return uniq(@nums);
}

# Count the number of representations as sums of two cubes.
sub count_sum_of_cubes ($N) {

    my @nums = generate_other_powers($N, 4);

    say ":: There are ", scalar(@nums), " numbers of the form n^k <= $N, with k >= 4.";

    my $count = 0;

    # Count the number of representations as sums of two cubes.
    foreach my $n (@nums) {

        is_sum_of_two_cubes($n) || next;

        foreach my $k (1 .. rootint($n, 3)) {

            my $r = $k * $k * $k;
            my $t = $n - $r;

            last if ($t < $r);

            if (is_power($t, 3) and $t > $r) {
                my $pow = is_power($n);
                $count += divisor_sum($pow, 0) - ($pow % 2 == 0) - 1;
            }
        }
    }

    say ":: There are $count solutions to `n^k = a^3 + b^3`, with k >= 4.";

    return $count;
}

# Count the number of representations as sums of two cubes (faster solution).
sub count_sum_of_cubes_fast ($N) {

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

sub count_other_powers ($N) {

    # The first part of this function is very fast, but misses some solutions, like:
    #   264^5 + 528^5 = 34848^3

    my $count = 0;
    my @nums  = generate_other_powers($N, 4);

    # Count the number of representations as sums of two powers n^k with k >= 4.
    foreach my $n (@nums) {
        foreach my $p (4 .. logint($n, 2)) {

            next if is_power($n, $p);    # Fermat's last theorem

            foreach my $k (1 .. rootint($n, $p)) {

                my $r = powint($k, $p);
                my $t = $n - $r;

                last if ($t < $r);

                if (is_power($t, $p) and $t > $r) {
                    my $pow = is_power($n);
                    $count += divisor_sum($pow, 0) - ($pow % 2 == 0) - 1;
                }
            }
        }
    }

    # Count the missed solutions of the form: n^3 = a^e + b^e, for e >= 4.
    foreach my $u (1 .. rootint($N >> 1, 4)) {
        foreach my $v ($u + 1 .. $N) {

            my $x = $u * $u * $u * $u;
            my $y = $v * $v * $v * $v;

            last if ($x + $y > $N);

            while ($x + $y <= $N) {
                my $pow = is_power($x + $y);
                $count += 1 if ($pow == 3);
                $x     *= $u;
                $y     *= $v;
            }
        }
    }

    return $count;
}

# Count the number of representations as sums of powers a^e with e >= 4.
sub count_other_powers_fast ($N) {

    say ":: Third stage...";    # most of the time is spent here

    my $count = 0;

    foreach my $u (1 .. rootint($N >> 1, 4)) {
        foreach my $v ($u + 1 .. $N) {

            my $x = $u * $u * $u * $u;
            my $y = $v * $v * $v * $v;

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

    say ":: There are $count solutions to `n^k = a^e + b^e`, with k >= 3 and e >= 4.";

    return $count;
}

sub F ($N) {

    my $x = count_sum_of_squares($N);

    #my $y = count_sum_of_cubes($N);
    my $y = count_sum_of_cubes_fast($N);

    #my $z = count_other_powers($N);
    my $z = count_other_powers_fast($N);

    my $total = $x + $y + $z;

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
