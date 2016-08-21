#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

my $max_p = 0;
my $max_l = 0;

while (<>) {
    my ($base, $exp) = split /,/;
    my $p = log($base) * $exp;

    if ($p > $max_p) {
        $max_p = $p;
        $max_l = $.;
    }
}

print "$max_l\n";
