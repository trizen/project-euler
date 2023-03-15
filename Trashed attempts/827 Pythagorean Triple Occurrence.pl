#!/usr/bin/perl

# Pythagorean Triple Occurrence
# https://projecteuler.net/problem=827

# For a given number n, the number of Pythagorean triples in which the number n occurs, is equivalent with:
#   (number of solutions to x^2 - y^2 = n^2, with x,y > 0) + (number of solutions to x^2 + y^2 = n^2, with x,y > 0).

use 5.020;
use strict;
use warnings;

use ntheory      qw(:all);
use experimental qw(signatures);

use Math::GMPz;

sub count_of_pythagorean_triples ($n) {

    # Translation of the PARI/GP program by Michel Marcus, Mar 07 2016.
    # https://oeis.org/A046081

    my $n0_sigma0 = 1;
    my $n1_sigma0 = 1;

    foreach my $pp (factor_exp($n)) {
        my ($p, $e) = @$pp;
        if ($p == 2) {
            $n0_sigma0 *= (2 * $e - 1);
        }
        else {
            $n0_sigma0 *= (2 * $e + 1);
            if ($p % 4 == 1) {
                $n1_sigma0 *= (2 * $e + 1);
            }
        }
    }

    divint(addint($n0_sigma0, $n1_sigma0), 2) - 1;
}

sub smallest_number_with_n_divisors (
                                     $threshold,
                                     $upperbound     = 0,
                                     $least_solution = 'inf',
                                     $k              = 1,
                                     $max_a          = 'inf',
                                     $max_b          = 'inf',
                                     $sol_a          = 1,
                                     $sol_b          = 1,
                                     $n              = Math::GMPz->new(1)
  ) {

    if ((($sol_a + $sol_b) >> 1) - 1 == $threshold) {
        return $n;
    }

    if ((($sol_a + $sol_b) >> 1) - 1 > $threshold) {
        return $least_solution;
    }

    my $p = nth_prime($k);

    if ($p == 2 or $p % 4 == 3) {
        for (my $e = 1 ; $e <= $max_a ; ++$e) {
            $n *= $p;
            last if ($n > $least_solution);
            $least_solution =
              __SUB__->(
                        $threshold, $upperbound, $least_solution, $k + 1, $e,
                        ($upperbound ? 0 : $max_b),
                        $sol_a * ($p == 2 ? (2 * $e - 1) : (2 * $e + 1)),
                        $sol_b, $n
                       );
        }
    }
    else {
        for (my $e = 1 ; $e <= $max_b ; ++$e) {
            $n *= $p;
            last if ($n > $least_solution);
            $least_solution =
              __SUB__->(
                        $threshold, $upperbound, $least_solution, $k + 1, ($upperbound ? 0 : $max_a),
                        $e,
                        $sol_a * (2 * $e + 1),
                        $sol_b * (2 * $e + 1), $n
                       );
        }
    }

    return $least_solution;
}

sub p827 ($n) {

    my $sum = 0;

    foreach my $k (1 .. $n) {
        say "Computing upper-bound for k = $k";
        my $upperbound = smallest_number_with_n_divisors(powint(10, $k), 1);
        say "Upper-bound: $upperbound";
        my $value = smallest_number_with_n_divisors(powint(10, $k), 0, $upperbound);
        say "Exact value: $value\n";
        $sum = addmod($sum, $value, 409120391);
    }

    return $sum;
}

count_of_pythagorean_triples(48) == 10        or die "error";
count_of_pythagorean_triples(8064000) == 1000 or die "error";

say p827(18);

__END__
Computing upper-bound for k = 1
Upper-bound: 48
Exact value: 48

Computing upper-bound for k = 2
Upper-bound: 51539607552
Exact value: 51539607552

Computing upper-bound for k = 3
Upper-bound: 279936000
Exact value: 8064000

Computing upper-bound for k = 4
Upper-bound: 323936494694900741443154768834215373577729211317092352
Exact value: 352039933204650878906250000000

Computing upper-bound for k = 5
Upper-bound: 1216423776811610842465814209161697337224368319788498338966103771825434751935052774229283362057403149142800669446206368901298211803369795583729399752920557463200093691707392
Exact value: 1216423776811610842465814209161697337224368319788498338966103771825434751935052774229283362057403149142800669446206368901298211803369795583729399752920557463200093691707392
