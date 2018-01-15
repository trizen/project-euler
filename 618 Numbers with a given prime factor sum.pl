#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 15 January 2018
# https://github.com/trizen

# https://projecteuler.net/problem=618

# See also:
#   https://oeis.org/A002098

# Runtime: ~3 minutes.

use 5.020;
use experimental qw(signatures);
use ntheory qw(primes mulmod addmod lucasu);

my $sum = 0;
my $mod = 10**9;

foreach my $k (2 .. 24) {

    my $n = lucasu(1, -1, $k);
    my @primes = @{primes($n)};

    my @cache;
    my $S = sub ($n, $k) {

        return 1 if ($n == 0);
        return 0 if ($k == 0);

        $cache[$n][$k] //=
            addmod(__SUB__->($n, $k - 1), ($n - $primes[$k - 1]) < 0 ? 0 :
                mulmod($primes[$k - 1], __SUB__->($n - $primes[$k - 1], $k), $mod), $mod);

    }->($n, scalar @primes);

    say "S(fib($k)) = $S";
    $sum = addmod($sum, $S, $mod);
}

say "Last nine digits: $sum";
