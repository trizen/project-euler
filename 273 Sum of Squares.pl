#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 16 March 2019
# https://github.com/trizen

# https://projecteuler.net/problem=273

# Runtime: ~33 minutes.

use 5.020;
use strict;
use warnings;

use experimental qw(signatures);

use Math::GMPz;
use ntheory qw(:all);
use Set::Product::XS qw(product);
use Math::Prime::Util::GMP;

sub sum_of_two_squares_solutions ($n) {

    $n == 0 and return [0, 0];

    my $S = (($n >= (~0)) ? Math::GMPz->new(1) : 1);

    my @prime_powers;

    foreach my $f (factor_exp($n)) {
        $S *= $f->[0];
        push @prime_powers, $f;
    }

    $S == 1 and return [0, 0];

    my %table;
    foreach my $f (@prime_powers) {
        my $pp = $f->[0];
        my $r  = sqrtmod($pp - 1, $pp);
        push @{$table{$pp}}, [$r, $pp], [$pp - $r, $pp];
    }

    my @square_roots;

    product {
        push @square_roots, Math::GMPz->new(Math::Prime::Util::GMP::chinese(@_));
    } values %table;

    my @solutions;

    foreach my $r (@square_roots) {

        my $s = $r;
        my $q = $S;

        while ($s * $s > $S) {
            ($s, $q) = ($q % $s, $s);
        }

        push @solutions, [$s, $q % $s];
    }

    my %seen;
    grep { !$seen{$_->[0]}++ } map {
        [sort { $a <=> $b } @$_]
    } @solutions;
}

sub check_valuation ($n, $p) {
    ($n % $p) != 0;
}

sub smooth_numbers ($limit, $primes) {

    my @h = (Math::GMPz->new(1));
    foreach my $p (@$primes) {

        say "Prime: $p";

        foreach my $n (@h) {
            if ($n * $p <= $limit and check_valuation($n, $p)) {
                push @h, $n * $p;
            }
        }
    }

    return \@h;
}

sub sum_of_a_values ($n) {
    vecsum(map { $_->[0] } sum_of_two_squares_solutions($n));
}

my $h = smooth_numbers(Math::GMPz->new(10)**100, [grep { $_ % 4 == 1 } @{primes(150)}]);

say "\nFound: ", scalar(@$h), " terms";

my $sum = Math::GMPz->new(0);

my $k   = 1;
my $len = scalar(@$h);
my $max = vecmax(@$h);
my $log = logint($max, 10);

foreach my $n (sort { $b <=> $a } @$h) {

    say "[$k of $len -- ", logint($n, 10), " of $log] Processing: $n";
    ++$k;

    $sum += sum_of_a_values($n);
}

say $sum;
