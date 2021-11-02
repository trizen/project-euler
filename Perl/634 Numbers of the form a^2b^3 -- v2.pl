#!/usr/bin/perl

# Numbers of the form a^2 * b^3, where a,b > 1.
# https://projecteuler.net/problem=634

# Using the method posted by al13n.

# Runtime: 0.603s

use 5.020;
use strict;
use warnings;

use ntheory qw(:all);
use experimental qw(signatures);

sub my_powerfree_count ($n, $k = 2) {
    my $count = 0;
    forsquarefree {
        $count += ((scalar(@_) & 1) ? -1 : 1) * divint($n, powint($_, $k));
    } rootint($n, $k);
    return $count;
}

sub p_634 ($n) {
    my $count = 0;

    forsquarefree {
        $count += sqrtint(divint($n, $_*$_*$_)) - 1;
    } 2, rootint($n, 3);

    foreach my $k (2..rootint($n, 6)) {
        $count += powerfree_count(sqrtint(divint($n, powint($k, 6))), 3);
    }

    $count -= prime_count(rootint($n, 6));
    $count;
}

p_634(2 * 1e4) == 130   or die "error";
p_634(3 * 1e6) == 2014  or die "error";
p_634(5 * 1e9) == 91255 or die "error";

say p_634(mulint(9, powint(10, 18)));
