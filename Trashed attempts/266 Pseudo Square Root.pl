#!/usr/bin/perl

# Find the greatest divisor of `n` that does not exceed the square root of `n`.

# See also:
#   https://projecteuler.net/problem=266

# Best lower-bound found so far:
#   2323218950482697766641170378640119830 <= PSR(primorial(190)) < 2323218950681478446587180516177954548

use 5.036;
use ntheory qw(:all);
use Math::GMPz;

sub squarefree_almost_primes_in_range ($A, $B, $k, $factors, $callback) {

    $A = Math::GMPz->new(vecmax($A, pn_primorial($k)));

    my $factors_end = $#{$factors};

    if ($k == 0) {
        return (($A > 1) ? () : 1);
    }

    my $z = Math::GMPz::Rmpz_init();

    sub ($m, $k, $i = 0) {

        Math::GMPz::Rmpz_div($z, $B, $m);
        Math::GMPz::Rmpz_root($z, $z, $k);

        my $lo = $factors->[$i];
        my $hi = Math::GMPz::Rmpz_get_ui($z);

        if ($lo > $hi) {
            return;
        }

        if ($k == 1) {

            Math::GMPz::Rmpz_cdiv_q($z, $A, $m);

            if ($z > $lo) {
                $lo = $z;
                $lo = Math::GMPz::Rmpz_get_ui($lo) if Math::GMPz::Rmpz_fits_ulong_p($lo);
            }

            if ($lo > $hi) {
                return;
            }

            foreach my $j ($i .. $factors_end) {
                my $q = $factors->[$j];
                last if ($q > $hi);
                next if ($q < $lo);
                my $t = $m * $q;
                $A = $t if ($t > $A);
                say "Found lower-bound: $t";
                $callback->($t);
            }

            return;
        }

        my $t = Math::GMPz::Rmpz_init();

        foreach my $j ($i .. $factors_end - 1) {
            my $q = $factors->[$j];
            last if ($q > $hi);
            next if ($q < $lo);
            Math::GMPz::Rmpz_mul_ui($t, $m, $q);
            if ($k == 2) {
                Math::GMPz::Rmpz_mul_ui($z, $t, $factors->[$j + 1]);
                $z <= $B or next;
            }
            __SUB__->($t, $k - 1, $j + 1);
        }
      }
      ->(Math::GMPz->new(1), $k);
}

my $n = 190;

my $upto    = Math::GMPz->new(sqrtint(primorial($n)));
my $from    = Math::GMPz->new($upto) >> 1;
my @factors = @{primes($n)};                             # prime list

foreach my $k (reverse(0 .. scalar(@factors))) {
    say "Checking: k = $k";
    my @divisors;
    squarefree_almost_primes_in_range(
        $from, $upto, $k,
        \@factors,
        sub ($n) {
            push @divisors, $n;
        }
    );
    if (@divisors) {
        $from = Math::GMPz->new(vecmax(@divisors));
        printf("%2d-squarefree almost primes <= %s: [%s]\n", $k, $upto, $from);
    }
}
