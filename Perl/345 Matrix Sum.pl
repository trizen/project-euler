#!/usr/bin/perl

# Author: Trizen
# Date: 24 March 2022
# https://github.com/trizen

# Matrix Sum
# https://projecteuler.net/problem=345

# Idea: when selecting an entry inside the matrix, remove its row and its
#       column from the matrix, resizing the matrix by one, then recurse.

# Runtime: 10.428s.

use 5.020;
use warnings;

use ntheory qw(divint sqrtint);
use experimental qw(signatures);

sub resize_arr ($arr, $size, $i, $j) {

    # Removes row i and column j, returning a new matrix
    [map { $arr->[$_] } grep { ($_ % $size != $j) && (divint($_, $size) != $i) } 0 .. $#$arr];
}

my %cache;

sub matrix_sum ($arr, $callback = sub { }, $size = sqrtint(scalar @$arr)) {

    if ($size == 1) {
        return $arr->[0];
    }

    my $key = "$size -- " . join(' ', @$arr);

    if (exists $cache{$key}) {
        return $cache{$key};
    }

    my $best = 0;

    foreach my $k (0 .. $size - 1) {
        my $curr = $arr->[$k] + matrix_sum(resize_arr($arr, $size, 0, $k), $callback, $size - 1);
        $best = $curr if ($curr > $best);
    }

    $callback->($best);
    $cache{$key} = $best;
    return $best;
}

#<<<
my @arr = (
           qw(  7  53 183 439 863),
           qw(497 383 563  79 973),
           qw(287  63 343 169 583),
           qw(627 343 773 959 943),
           qw(767 473 103 699 303),
          );
#>>>

matrix_sum(\@arr) == 3315
  or die "Error for the small matrix";

@arr = map { split(' ') } split(/\R/, <<'EOT');
  7  53 183 439 863 497 383 563  79 973 287  63 343 169 583
627 343 773 959 943 767 473 103 699 303 957 703 583 639 913
447 283 463  29  23 487 463 993 119 883 327 493 423 159 743
217 623   3 399 853 407 103 983  89 463 290 516 212 462 350
960 376 682 962 300 780 486 502 912 800 250 346 172 812 350
870 456 192 162 593 473 915  45 989 873 823 965 425 329 803
973 965 905 919 133 673 665 235 509 613 673 815 165 992 326
322 148 972 962 286 255 941 541 265 323 925 281 601  95 973
445 721  11 525 473  65 511 164 138 672  18 428 154 448 848
414 456 310 312 798 104 566 520 302 248 694 976 430 392 198
184 829 373 181 631 101 969 613 840 740 778 458 284 760 390
821 461 843 513  17 901 711 993 293 157 274  94 192 156 574
 34 124   4 878 450 476 712 914 838 669 875 299 823 329 699
815 559 813 459 522 788 168 586 966 232 308 833 251 631 107
813 883 451 509 615  77 281 613 459 205 380 274 302  35 805
EOT

my $max = 0;

matrix_sum(
    \@arr,
    sub ($sum) {
        if ($sum > $max) {
            $max = $sum;
            say "Best sum so far: $sum";
        }
    }
);

say "Best sum: $max";
