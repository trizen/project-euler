#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 16 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=61

use 5.010;
use strict;
use warnings;

use ntheory qw(forperm);
use List::Util qw(sum);

sub quadratic_formula {
    my ($x, $y, $z) = @_;
    (-$y + sqrt($y**2 - 4 * $x * $z)) / (2 * $x);
}

#
## Generation
#

sub triangle {
    $_[0] * ($_[0] + 1) / 2;
}

sub square {
    $_[0] * $_[0];
}

sub pentagon {
    $_[0] * (3 * $_[0] - 1) / 2;
}

sub hexagon {
    $_[0] * (2 * $_[0] - 1);
}

sub heptagon {
    $_[0] * (5 * $_[0] - 3) / 2;
}

sub octagon {
    $_[0] * (3 * $_[0] - 2);
}

#
## Roots
#

sub triangle_root {
    quadratic_formula(1 / 2, 1 / 2, -$_[0]);
}

sub square_root {
    quadratic_formula(1, 0, -$_[0]);
}

sub pentagon_root {
    quadratic_formula(3 / 2, -1, -$_[0]);
}

sub hexagon_root {
    quadratic_formula(2, -1, -$_[0]);
}

sub heptagon_root {
    quadratic_formula(5 / 2, -3 / 2, -$_[0]);
}

sub octagon_root {
    quadratic_formula(3, -2, -$_[0]);
}

#
## Validation
#

sub is_triangle {
    triangle(int(triangle_root($_[0]))) == $_[0];
}

sub is_square {
    square(int(square_root($_[0]))) == $_[0];
}

sub is_pentagon {
    pentagon(int(pentagon_root($_[0]))) == $_[0];
}

sub is_hexagon {
    hexagon(int(hexagon_root($_[0]))) == $_[0];
}

sub is_heptagon {
    heptagon(int(heptagon_root($_[0]))) == $_[0];
}

sub is_octagon {
    octagon(int(octagon_root($_[0]))) == $_[0];
}

my @range = grep { substr($_, 2, 1) ne '0' } 1000 .. 9999;

my (%trig, %square, %penta, %hexa, %hepta, %octa);

foreach my $n (@range) {
    my ($h, $t) = (substr($n, 0, 2), substr($n, -2));
    is_triangle($n) && undef $trig{$h}{$t};
    is_square($n)   && undef $square{$h}{$t};
    is_pentagon($n) && undef $penta{$h}{$t};
    is_hexagon($n)  && undef $hexa{$h}{$t};
    is_heptagon($n) && undef $hepta{$h}{$t};
    is_octagon($n)  && undef $octa{$h}{$t};
}

my (@a) = (\%trig, \%square, \%penta, \%hexa, \%hepta, \%octa);

forperm {
    my @h = @a[@_];

    foreach my $ah (keys %{$h[0]}) {
        foreach my $at (keys %{$h[0]{$ah}}) {
            if (exists $h[1]{$at}) {
                foreach my $bt (keys %{$h[1]{$at}}) {
                    if (exists $h[2]{$bt}) {
                        foreach my $ct (keys %{$h[2]{$bt}}) {
                            if (exists $h[3]{$ct}) {
                                foreach my $dt (keys %{$h[3]{$ct}}) {
                                    if (exists $h[4]{$dt}) {
                                        foreach my $et (keys %{$h[4]{$dt}}) {
                                            if (exists $h[5]{$et}) {
                                                if (exists $h[5]{$et}{$ah}) {
                                                    my @nums = split(' ', "$ah$at $at$bt $bt$ct $ct$dt $dt$et $et$ah");
                                                    say "sum(@nums) = ", sum(@nums);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

} scalar(@a);
