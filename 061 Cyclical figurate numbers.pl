#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 16 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=61

# Runtime: 0.087s

use 5.010;
use strict;
use warnings;

use ntheory qw(forperm is_square sqrtint vecsum);

sub is_polygonal {
    my ($n, $k) = @_;

    my $s = 8 * ($k - 2) * $n + ($k - 4) * ($k - 4);

    is_square($s)
      && ((sqrtint($s) + $k - 4) % (2 * ($k - 2)) == 0);
}

my (%trig, %square, %penta, %hexa, %hepta, %octa);

foreach my $n (1000 .. 9999) {
    my ($h, $t) = (substr($n, 0, 2), substr($n, -2));
    is_polygonal($n, 3) && undef $trig{$h}{$t};
    is_polygonal($n, 4) && undef $square{$h}{$t};
    is_polygonal($n, 5) && undef $penta{$h}{$t};
    is_polygonal($n, 6) && undef $hexa{$h}{$t};
    is_polygonal($n, 7) && undef $hepta{$h}{$t};
    is_polygonal($n, 8) && undef $octa{$h}{$t};
}

my (@a) = (\%trig, \%square, \%penta, \%hexa, \%hepta, \%octa);

forperm {
    my @h = @a[@_];

    foreach my $ah (keys %{$h[0]}) {
        foreach my $at (keys %{$h[0]{$ah}}) {
            foreach my $bt (keys %{$h[1]{$at}}) {
                foreach my $ct (keys %{$h[2]{$bt}}) {
                    foreach my $dt (keys %{$h[3]{$ct}}) {
                        foreach my $et (keys %{$h[4]{$dt}}) {
                            if (exists $h[5]{$et}{$ah}) {
                                my @nums = split(' ', "$ah$at $at$bt $bt$ct $ct$dt $dt$et $et$ah");
                                say "sum(@nums) = ", vecsum(@nums);
                            }
                        }
                    }
                }
            }
        }
    }

} scalar(@a);
