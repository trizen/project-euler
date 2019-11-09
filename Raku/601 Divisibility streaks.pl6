#!/usr/bin/perl6

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 30 April 2017
# https://github.com/trizen

# https://projecteuler.net/problem=601

# Runtime: 0.232s

sub count($n, $k) {
    my $lcm = [lcm] 1..$n;
    my $period = ([lcm] ($lcm, $n+1)) / $lcm;
    my $count = floor(($k-2) / $lcm);
    $count - floor($count / $period);
}

say [+] (1..31).map: { count($_, 4**$_) };
