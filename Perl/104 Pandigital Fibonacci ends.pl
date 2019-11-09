#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=104

# Runtime: 1.681s

use 5.010;
use strict;
use integer;

use Math::GMPz qw(:mpz);

my $k = 2749;

my $x = Rmpz_init();
my $y = Rmpz_init();
my $t = Rmpz_init();

Rmpz_fib2_ui($x, $y, $k);

while (1) {
    Rmpz_set($t, $x);
    Rmpz_set($x, ($x + $y) % 10**10);
    Rmpz_set($y, $t);
    ++$k;
    join('', sort split //, substr $x,   -9) eq '123456789' && !Rmpz_fib_ui($t, $k) &&
    join('', sort split //, substr $t, 0, 9) eq '123456789' && do {
        say $k;
        last;
    };
}
