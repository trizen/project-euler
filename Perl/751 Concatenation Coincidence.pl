#!/usr/bin/perl

# Author: Trizen
# Date: 23 March 2022
# https://github.com/trizen

# Concatenation Coincidence
# https://projecteuler.net/problem=751

# Runtime: 0.182s

use 5.020;
use warnings;

use Memoize qw(memoize);
use experimental qw(signatures);
use Math::AnyNum qw(:overload :all);

memoize('b');

sub b ($n, $t) {
    return $t if ($n == 1);
    floor(b($n - 1, $t)) * (b($n - 1, $t) - floor(b($n - 1, $t)) + 1);
}

(join(' ', map { floor(b($_, 2.956938891377988)) } 1 .. 10) eq join(' ', map { fibonacci($_) } 3 .. 12))
  or die "Error!";

my $PREC   = 24;
my $PREFIX = 2;

sub f ($t) {
    my @terms;

    for (my $k = 1 ; length(join('', @terms)) <= $PREC ; ++$k) {
        push @terms, floor(b($k, $t));
    }

    my $lead = shift(@terms);
    my $dec  = Math::AnyNum->new(join('', @terms));

    my $x = $lead + ($dec / 10**(ilog10($dec) + 1));
    say sprintf("%s <=> %s", float($t), float($x));
    return $x;
}

my $theta = bsearch_le(
    10**$PREC,
    10**($PREC + 1),
    sub ($k) {
        my $t = $PREFIX + ($k / 10**(ilog10($k) + 1));
        $t <=> f($t);
    }
);

say("Answer: ", Math::AnyNum->new("$PREFIX.$theta")->round(-$PREC));
