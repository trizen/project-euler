#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 19 October 2017
# https://github.com/trizen

# Runtime: 0.019s

# https://projecteuler.net/problem=191

use 5.022;
use strict;
use warnings;

use experimental qw(signatures);

sub p_191($days) {

    my %cache;
    sub ($len, $hasL, $hasA1, $hasA2) {

        exists($cache{"@_"})
            and return $cache{"@_"};

        my $count = ($len == $days) ? 1 : 0;

        if ($len < $days) {

            if (!$hasA1 || !$hasA2) {
                $count += __SUB__->($len + 1, $hasL, $hasA2, 1);
            }

            $count += __SUB__->($len + 1, $hasL, $hasA2, 0);

            if (!$hasL) {
                $count += __SUB__->($len + 1, 1, $hasA2, 0);
            }
        }

        return ($cache{"@_"} = $count);
    }->(0, 0, 0, 0);
}

say p_191(30);
