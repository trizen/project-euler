#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 05 November 2019
# https://github.com/trizen

# The first few exponents are: 90, 379, 575, 864, 1060, 1545, 1741, 2030, 2226, 2515, 2711, 3000, 3196, 3681, 3877, 4166, 4362, 4651, 4847, 5136, ...
# The set of differences between consecutive exponents is: {196, 289, 485}.

# Can also be solved by using the denominators of semiconvergents of log_10(2).

# https://projecteuler.net/problem=686

# Runtime: 0.787s

use 5.020;
use experimental qw(signatures);

my $ln2  = log(2);
my $ln5  = log(5);
my $ln10 = log(10);

sub isok($n) {
    int(exp($ln2 * ($n - int(($n * $ln2) / $ln10) + 2) + $ln5 * (2 - int(($n * $ln2) / $ln10)))) == 123;
}

my $count = 1;
my $k     = do { my $n = 1; ++$n while (!isok($n)); $n };
my $nth   = 678910;

while (1) {

    if (isok($k + 196)) {
        ++$count;
        $k += 196;
    }
    elsif (isok($k + 289)) {
        ++$count;
        $k += 289;
    }
    elsif (isok($k + 485)) {
        ++$count;
        $k += 485;
    }

    #say "#{count} out of #{nth} with k = #{k}"

    if ($count == $nth) {
        say "Final result: $k";
        last;
    }
}
