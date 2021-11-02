#!/usr/bin/perl

# Asymmetric Diophantine Equation
# https://projecteuler.net/problem=764

use 5.014;
use warnings;
use ntheory qw(:all);

my $N   = powint(10, 7);
my $MOD = powint(10, 9);

sub pythagorean_triples {
    my ($limit) = @_;

    my @triples;
    my $end = sqrtint($limit);

    my $sum = 0;

    foreach my $n (1 .. $end - 1) {
        for (my $m = $n + 1 ; $m <= $end ; $m += 2) {

            my $x = ($m*$m - $n*$n);
            my $y = ($m * $n) << 1;
            my $z = ($m*$m + $n*$n);

            last if $x > $limit;
            last if $y > $limit;
            last if $z > $limit;

            gcd($x, $y) == 1 or next;
            gcd($x, $z) == 1 or next;
            gcd($y, $z) == 1 or next;

            if (gcd($n, $m) == 1) {    # n and m coprime
                foreach my $k(1, 4) {

                    my $x = $k * $x;
                    my $y = $k * $y;
                    my $z = $k * $z;

                    last if $x > $limit;
                    last if $y > $limit;
                    last if $z > $limit;

                    if (is_square($y) and $x %4 == 0 and gcd($x >> 2, $y, $z) == 1) {
                        #push @triples, [$x >> 2, sqrtint($y), $z];
                        $sum = addmod($sum, addmod(addmod(sqrtint($y), ($x >> 2), $MOD), $z, $MOD), $MOD);
                    }
                    if (is_square($x) and $y %4 == 0 and gcd($y>>2, $x, $z) == 1) {
                        #push @triples, [$y>>2, sqrtint($x), $z];
                        $sum = addmod($sum, addmod(addmod(sqrtint($x), ($y >> 2), $MOD), $z, $MOD), $MOD);
                    }
                }
            }
        }
    }

    $sum;
}

say pythagorean_triples(1e4);
say pythagorean_triples(1e7);

__END__
112851
248876211
perl 764\ Asymmetric\ Diophantine\ Equation\ -\ pythagorean\ triples.pl  3.56s user 0.01s system 98% cpu 3.612 total
