#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# License: GPLv3
# Date: 28 January 2017
# https://github.com/trizen

# https://projecteuler.net/problem=49

# Runtime: 0.024s

use 5.010;
use strict;
use integer;

use ntheory qw(forprimes);
use List::Util qw(uniq);

my %perms;

forprimes {
    push @{$perms{join '', sort split //}}, $_;
} 1000, 9999;

foreach my $perm (values %perms) {
    (my @p = @$perm) >= 3 or next;

    my %diffs;
    foreach my $i (0 .. $#p) {
        foreach my $j ($i + 1 .. $#p) {
            push @{$diffs{$p[$j] - $p[$i]}}, $p[$i], $p[$j];
        }
    }

    foreach my $diff (keys %diffs) {
        if ((my @d = uniq(@{$diffs{$diff}})) == 3) {
            say "$diff: [@d]";
        }
    }
}
