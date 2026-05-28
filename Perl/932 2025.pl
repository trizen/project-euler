#!/usr/bin/perl

# 2025
# https://projecteuler.net/problem=932

# The key property is:
#   n^2 = a * 10^d + b with n = a+b, where b has exactly d decimal digits.

# Then, if we substitute n = a+b, we have:
#   n^2 - n = a*(10^d - 1)

# Thus, if we set M = 10^d - 1, then:
#   M | n*(n-1)

# By using the CRT, for the prime-powers p^e of M, we must have:
#   n == 0 (mod p^e)
#         or
#   n == 1 (mod p^e)

# Runtime: 0.047s

use 5.036;
use Math::GMPz;
use ntheory 0.74 qw(:all);
use Algorithm::Combinatorics qw(variations_with_repetition);

prime_set_config(bigint => 'Math::GMPz');

sub T($n) {

    my $total = 0;
    my $max   = powint(10, $n);

    for my $d (1 .. $n - 1) {

        my $M    = subint(powint(10, $d), 1);
        my @mods = map { powint($_->[0], $_->[1]) } factor_exp($M);
        my $iter = variations_with_repetition([0, 1], scalar(@mods));

        while (my $rems = $iter->next) {

            my $n = chinese(map { [$rems->[$_], $mods[$_]] } 0 .. $#mods);

            if ($n == 0) {
                $n = $M;
            }

            next if ($n <= 1);

            my $a = divint(mulint($n, subint($n, 1)), $M);
            my $b = subint($n, $a);

            my $t = mulint($n, $n);
            next if ($t > $max);

            if ("$a$b" eq join('', powint(addint($a, $b), 2))) {
                say "$t = ($a + $b)^2";
                $total = addint($total, $t);
            }
        }
    }

    return $total;
}

T(4) == 5131 or die "error";

say "Total: ", T(16);

__END__
T(60) = 1899130090715715515924210996258351134305594920596459799787735709  (2.4 seconds)
