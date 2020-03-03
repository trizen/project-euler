#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 10 February 2020
# https://github.com/trizen

# See also:
#   https://oeis.org/A036966
#   THE DISTRIBUTION OF CUBE-FULL NUMBERS, by P. SHIU (1990).

# https://projecteuler.net/problem=694

# Runtime: 9.783s

use 5.020;
use integer;
use warnings;

use ntheory qw(:all);
use experimental qw(signatures);

sub bsearch_le ($left, $right, $callback) {

    my ($mid, $cmp);

    for (; ;) {

        $mid = ($left + $right) >> 1;
        $cmp = $callback->($mid) || return $mid;

        if ($cmp < 0) {
            $left = $mid + 1;
            $left > $right and last;
        }
        else {
            $right = $mid - 1;

            if ($left > $right) {
                $mid -= 1;
                last;
            }
        }
    }

    return $mid;
}

sub powerful_numbers ($n, $k) {    # k-powerful numbers <= n

    my @powerful;

    sub ($m, $r) {

        if ($r < $k) {
            push @powerful, $m;
            return;
        }

        for my $v (1 .. rootint(divint($n, $m), $r)) {

            if ($r > $k) {
                gcd($m, $v) == 1   or next;
                is_square_free($v) or next;
            }

            __SUB__->($m * powint($v, $r), $r - 1);
        }
    }->(1, 2 * $k - 1);

    sort { $a <=> $b } @powerful;
}

sub sum_of_cubefull_divisors_count($n) {

    my $t = 0;
    my $s = sqrtint($n);

    my @sqrt_cubefull = powerful_numbers($s, 3);

    foreach my $k (@sqrt_cubefull) {
        $t += $n / $k;
    }

    my @cubefull = powerful_numbers($n, 3);

    for (my $k = 1 ; $k <= $s ; ++$k) {

        my $w = $n / $k;
        my $i = bsearch_le(0, $#cubefull,
            sub ($j) {
                $cubefull[$j] <=> $w;
            }
        );

        my $r = $n / $cubefull[$i];
        $r = $s if ($r > $s);
        $t += (1 + $i) * ($r - $k + 1);
        $k = $r;
    }

    $t -= $s * scalar(@sqrt_cubefull);

    return $t;
}

foreach my $n (1..18) {
    say("S(10^$n) = ", sum_of_cubefull_divisors_count(powint(10, $n)));
}

__END__
S(10^1) = 11
S(10^2) = 126
S(10^3) = 1318
S(10^4) = 13344
S(10^5) = 133848
S(10^6) = 1339485
S(10^7) = 13397119
S(10^8) = 133976753
S(10^9) = 1339780424
S(10^10) = 13397833208
S(10^11) = 133978396859
S(10^12) = 1339784112539
S(10^13) = 13397841446161
S(10^14) = 133978415161307
S(10^15) = 1339784153146359
S(10^16) = 13397841534812404
S(10^17) = 133978415355411689
