#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 03 October 2017
# https://github.com/trizen

# https://projecteuler.net/problem=516

# Runtime: ~9 minutes.

# Based on Dana Jacobsen's code from Math::Prime::Util,
# which in turn is based on invphi.gp v1.3 by Max Alekseyev.

# See also:
#   https://en.wikipedia.org/wiki/Euler%27s_totient_function
#   https://github.com/danaj/Math-Prime-Util/blob/master/examples/inverse_totient.pl

use 5.010;
use strict;
use warnings;

use ntheory qw(is_prime divisors valuation addmod);

use constant LIMIT => 1e12;
use constant MOD   => 2**32;

sub inverse_euler_phi {
    my ($n) = @_;

    my %r = (1 => [1]);

    foreach my $d (divisors($n)) {
        if (is_prime($d + 1)) {

            my %temp;
            foreach my $k (1 .. (valuation($n, $d + 1) + 1)) {

                my $u = $d * ($d + 1)**($k - 1);
                my $v = ($d + 1)**$k;

                foreach my $f (divisors($n / $u)) {
                    if (exists $r{$f}) {
                        push @{$temp{$f * $u}}, grep { $_ <= LIMIT } map { $v * $_ } @{$r{$f}};
                    }
                }
            }

            while (my ($i, $v) = each(%temp)) {
                push @{$r{$i}}, @$v;
            }
        }
    }

    return if not exists $r{$n};
    return @{$r{$n}};
}

my @smooth = (1);

foreach my $n (2, 3, 5) {
    foreach my $k (@smooth) {
        if ($n * $k <= LIMIT) {
            push @smooth, $n * $k;
        }
    }
}

my $sum = 0;
foreach my $k (@smooth) {
    foreach my $n (inverse_euler_phi($k)) {
        $sum = addmod($sum, $n, MOD);
    }
}

say $sum;
