#!/usr/bin/perl

# Product of Gauss Factorials
# https://projecteuler.net/problem=754

# See also:
#   https://oeis.org/A001783

# WARNING: requires ~3 GB of RAM.

# Somehow, this approach seems to be incorrect...

use 5.020;
use strict;
use warnings;

use experimental qw(signatures);
use ntheory qw(:all);
use List::Util qw(uniq);

sub g ($n, $m) {
    my $r = 0;

    foreach my $pp (factor_exp($n)) {
        my $p   = $pp->[0];
        my $ndp = divint($n, $p);
        $r = gcd($r, divmod(factorialmod($n, $m), mulmod(powmod($p, $ndp, $m), factorialmod($ndp, $m), $m), $m));
        return $r if ($r == 1);
    }

    return $r;
}

sub G ($n, $m) {
    my $r = 1;
    foreach my $k (2 .. $n) {
        $r = mulmod($r, g($k, $m), $m);
    }
    return $r;
}

sub G2 ($N, $m) {

    my $r    = 1;
    my $nfac = 1;

    my @facmod = (1);

    foreach my $k (1 .. $N) {
        $nfac = mulmod($nfac, $k, $m);
        push @facmod, $nfac;
    }

    forfactored {

        my $n = $_;
        my $g = 0;

        foreach my $p (uniq(@_)) {
            if ($p == $n) {
                $g = $facmod[$p-1];
            }
            else {
                my $ndp = divint($n, $p);
                $g = gcd($g, divmod($facmod[$n], mulmod(powmod($p, $ndp, $m), $facmod[$ndp], $m), $m));
                last if ($g == 1);
            }
        }

        $r = mulmod($r, $g, $m);
    } 2, $N;

    return $r;
}

use Test::More tests => 6;

is(g(10, 1_000_000_007),   189);
is(G(10, 1_000_000_007),   331358692);
is(G2(10, 1_000_000_007),  331358692);
is(G2(1e2, 1_000_000_007), 777776709);
is(G2(1e3, 1_000_000_007), 297877340);
is(G2(1e4, 1_000_000_007), 517055464);
is(G2(1e5, 1_000_000_007), 516871211);

#say G2(1e4, 1_000_000_007);     # takes 0.1 seconds
#say G2(1e5, 1_000_000_007);     # takes 0.6 seconds
#say G2(1e6, 1_000_000_007);     # takes 5 seconds
#say G2(1e7, 1_000_000_007);     # takes 53 seconds

say "\n:: Computing: G(10^8)";

say G2(1e8, 1_000_000_007);
