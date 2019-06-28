#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 01 May 2017
# Edit: 28 June 2019
# https://github.com/trizen

# https://projecteuler.net/problem=581

# Runtime: 13.415s.

=for comment

Maximum value of n in the p-smooth T(n), is given by A002072(π(p)).

For p=47, the maximum value of n is 1109496723125.

Using the same idea from problem 204, we generate 47-smooth numbers not exceeding this limit.
Then for each 47-smooth number n, we check n+1 to see if it is also 47-smooth.

=cut

use 5.020;
use strict;
use warnings;

use ntheory qw(:all);
use experimental qw(signatures);

my $smooth      = 47;
my $limit       = 1109496723125;        # A002072(π(47)) = A002072(15)
my @primes      = @{primes($smooth)};
my $smooth_prod = vecprod(@primes);

sub is_smooth_over_prod ($n, $k) {

    my $g = gcd($n, $k);

    while ($g > 1) {
        $n /= $g while ($n % $g == 0);
        return 1 if ($n == 1);
        $g = gcd($n, $k);
    }

    $n == 1;
}

my @smooth = (1);

foreach my $p (@primes) {
    foreach my $n (@smooth) {
        if ($n * $p <= $limit) {
            push @smooth, $n * $p;
        }
    }
}

my $sum = 0;

foreach my $n (@smooth) {
    if (is_smooth_over_prod($n+1, $smooth_prod)) {
        $sum += $n;
    }
}

say $sum;
