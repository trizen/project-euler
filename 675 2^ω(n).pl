#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 27 June 2019
# https://github.com/trizen

# Based on the identity:
#   Sum_{d|n} 2^omega(d) = sigma_0(n^2)

# The algorithm iteraters over each number in k = 1..N,
# and computes sigma_0(k^2) = Prod_{p^e | k} (2*e + 1).

# By keeping track of the partial products, we find sigma_0(k!^2).

# Runtime: ~48.085s

# https://projecteuler.net/problem=675

use 5.020;
use strict;
use warnings;

use ntheory qw(:all);
use experimental qw(signatures declared_refs);

sub F ($N, $mod) {

    my %table;
    my $total = 0;
    my $partial = 1;

    foreach my $k (2 .. $N) {

        my $old = 1;   # old product

        foreach my \@pp (factor_exp($k)) {
            my ($p, $e) = @pp;
            $old = mulmod($old, 2 * $table{$p} + 1, $mod) if exists($table{$p});
            $table{$p} += $e;
            $partial = mulmod($partial, 2 * $table{$p} + 1, $mod);
        }

        $partial = divmod($partial, $old, $mod);    # remove the old product
        $total += $partial;
        $total %= $mod;
    }

    return $total;
}

my $MOD = 1000000087;

foreach my $n (1 .. 7) {
    printf("F(10^%d) = %*s (mod %s)\n", $n, length($MOD) - 1, F(10**$n, $MOD), $MOD);
}

__END__
F(10^1) =      4821 (mod 1000000087)
F(10^2) = 930751395 (mod 1000000087)
F(10^3) = 822391759 (mod 1000000087)
F(10^4) = 979435692 (mod 1000000087)
F(10^5) = 476618093 (mod 1000000087)
F(10^6) = 420600586 (mod 1000000087)
F(10^7) = --------- (mod 1000000087)
