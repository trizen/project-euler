#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 21 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=303

# Runtime: 1 min 17.65s

use 5.014;
use ntheory qw(todigitstring fromdigits);

my @big;
foreach my $i (1 .. 5) {
    push @{$big[9]}, join('', '1' x ($i + 1), '2' x (4 * ($i + 1)));
    push @{$big[8]}, join('', '1' x $i, '2' x (4 * $i));
    push @{$big[5]}, join('', '1' x $i, '2' x (4 * $i), '0');
}

sub lsd_multiple {
    my ($n) = @_;

    return $n if $n =~ /^[120]+\z/;

    if (    $n > 10
        and ($n % 9 == 0)
        and defined($big[$n % 10])
        and ($n / 9) =~ /^(.)\1*+\z/) {
        return $big[$n % 10][length($n) - 2];
    }

    my $k = (
             $n =~ /^[12]/
             ? fromdigits($n =~ s/(.)/$1 > 2 ? 2 : $1/ger, 3)
             : 3**length($n)
            );

    while (1) {
        my $x = todigitstring($k, 3);
        return $x if ($x % $n == 0);
        ++$k;
    }
}

my $sum = 0;
foreach my $x (1 .. 10_000) {
    $sum += lsd_multiple($x) / $x;
}
say $sum;
