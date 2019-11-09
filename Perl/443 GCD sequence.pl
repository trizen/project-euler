#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 03 September 2019
# https://github.com/trizen

# https://projecteuler.net/problem=443

# Runtime: 4.988s

use 5.020;
use ntheory qw(:all);
use experimental qw(signatures);

sub GCD_sequence ($upto) {

    my $sum = 13;

    for (my $n = 5 ; $n <= $upto ; ++$n) {
        if ($n >= 100 and gcd($n, $sum) > 1) {

            my $k = $n + ($n - 1);
            $sum += gcd($n, $sum);

            if (is_prime($k)) {

                if ($k >= $upto) {
                    $sum += $upto - $n;
                    last;
                }

                $sum += $k - ($n - 1);
                $n = $k;
            }
        }
        else {
            $sum += gcd($n, $sum);
        }
    }

    return $sum;
}

say GCD_sequence(1000);       #=> 2524
say GCD_sequence(1000000);    #=> 2624152
say GCD_sequence(1000000000000000);
