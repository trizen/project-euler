#!/usr/bin/perl

# Author: Trizen
# Date: 23 March 2022
# https://github.com/trizen

# Near Power Sums
# https://projecteuler.net/problem=749

# See also:
#   https://oeis.org/A300160

# Runtime: 3 minutes, 50 seconds.

use 5.020;
use warnings;

use ntheory qw(:all);
use experimental qw(signatures);
use Algorithm::Combinatorics qw(combinations_with_repetition);

sub S ($n) {

    my $sum = 0;

    foreach my $k (1 .. $n) {

        #for(my $j = 1; ; ++$j) {
        foreach my $j (vecmax(1, $k - 2) .. $k + 2) {

            my $min = vecprod(powint(2, $j), $k);
            my $max = vecprod(powint(9, $j), $k);

            length($min) <= $k or last;
            length($max) >= $k or next;

            say ":: Trying: j = $j and k = $k";

            my @powers = map { [$_, powint($_, $j)] } 0 .. 9;
            my $iter   = combinations_with_repetition(\@powers, $k);

            while (my $arr = $iter->next) {

                my $t = vecsum(map { $_->[1] } @$arr);
                my $r = fromdigits([sort { $b <=> $a } map { $_->[0] } @$arr]);

                if ($t > 0 and fromdigits([sort { $b <=> $a } todigits(subint($t, 1))]) == $r) {
                    say "[-1] Found: ", $t - 1;
                    $sum += $t - 1;
                }

                if (fromdigits([sort { $b <=> $a } todigits(addint($t, 1))]) == $r) {
                    say "[+1] Found: ", $t + 1;
                    $sum += $t + 1;
                }
            }
        }
    }

    return $sum;
}

S(2) == 110     or die "Error for S(2)";
S(6) == 2562701 or die "Error for S(6)";

say("Answer: ", S(16));
