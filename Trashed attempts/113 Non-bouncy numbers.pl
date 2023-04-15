#!/usr/bin/perl

# Count of non-bouncy numbers <= limit.
# Works fast with small limits (say 10^10), but not with very large ones, like 10^100.

# TODO: find a faster approach.

# The count of increasing and decreasing numbers, have something to do with sums of triangular numbers.

# https://projecteuler.net/problem=113

use 5.036;

use ntheory qw(:all);
no warnings 'recursion';

#use Math::GMP qw(:constant);
#use Math::AnyNum qw(:overload);

sub increasing_numbers_count ($limit, $base = 10) {

    my sub f ($n, $min_d) {

        my $count = 1;

        foreach my $d ($min_d .. $base - 1) {
            my $v = ($n * $base + $d);
            $v <= $limit or last;
            $count += __SUB__->($v, $d);
        }

        return $count;
    }

    my $count = 0;
    foreach my $d (1 .. vecmin($limit, $base - 1)) {
        $count += f($d, $d);
    }
    return $count;
}

sub decreasing_numbers_count ($limit, $base = 10) {

    my sub f ($n, $max_d) {

        my $count = 1;

        foreach my $d (0 .. $max_d) {
            my $v = ($n * $base + $d);
            $v <= $limit or last;
            $count += __SUB__->($v, $d);
        }

        return $count;
    }

    my $count = 0;
    foreach my $d (1 .. vecmin($limit, $base - 1)) {
        $count += f($d, $d);
    }
    return $count;
}

sub non_bouncy_count ($limit, $base = 10) {

    if ($limit < $base) {
        return vecmax(0, $limit - 1);
    }

    my @D = todigits($limit, $base);
    my $t = (increasing_numbers_count($limit, $base) + decreasing_numbers_count($limit, $base));

    $t -= (($base - 1) * (scalar(@D) - 1));

    my $r = divint($base**scalar(@D) - 1, $base - 1);

    foreach my $d (1 .. $base - 1) {
        $r * $d > $limit and last;
        --$t;
    }

    return $t;
}

say non_bouncy_count(10**10 - 1);    # 277032
