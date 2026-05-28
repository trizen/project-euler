#!/usr/bin/perl

# Order Modulo Factorial
# https://projecteuler.net/problem=952

# Runtime: 3.660s

use 5.036;
use ntheory qw(:all);
use Math::GMPz;

sub factorial_valuation ($n, $q) {
    my $sum = 0;
    while ($n > 0) {
        $n = divint($n, $q);
        $sum += $n;
    }
    return $sum;
}

sub R ($p, $n) {
    my %max_v;
    my $primes_ref = primes($n);

    for my $q (@$primes_ref) {

        my $rq = znorder($p, $q);

        my @f = factor_exp($rq);
        for my $pair (@f) {
            my ($g, $v) = @$pair;
            $max_v{$g} = $v if $v > ($max_v{$g} // 0);
        }

        my $lifting = 0;
        if ($q == 2) {
            my $v2 = factorial_valuation($n, 2);
            if ($v2 <= 1) {
                $lifting = 0;
            }
            else {
                $lifting = $v2 - 3;
                $lifting = 1 if $lifting < 1;
            }
        }
        else {
            my $vq = factorial_valuation($n, $q);

            if ($vq > 1) {
                my $kg = 1;
                my $qq = mulint($q, $q);

                if (powmod($p, $rq, $qq) == 1) {
                    $kg = 2;
                    my $qpow = Math::GMPz->new($q)**3;
                    while (powmod($p, $rq, $qpow) == 1) {
                        $kg++;
                        $qpow *= $q;
                    }
                }
                $lifting = $vq - $kg;
                $lifting = 0 if $lifting < 0;
            }
        }
        $max_v{$q} = $lifting if $lifting > ($max_v{$q} // 0);
    }

    my $ans = 1;
    while (my ($g, $v) = each %max_v) {
        if ($v > 0) {
            my $term = powmod($g, $v, $p);
            $ans = mulmod($ans, $term, $p);
        }
    }
    return $ans;
}

my $p = 10**9 + 7;

# Verification checks
say "R(p, 12)  = " . R($p, 12);     # Expected: 17280
say "R(p, 100) = " . R($p, 100);    # Expected: 613101161

# Target computation
say "R(p, 10^7) = " . R($p, 10**7);
