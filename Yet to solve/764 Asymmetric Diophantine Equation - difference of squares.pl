#!/usr/bin/perl

# Asymmetric Diophantine Equation
# https://projecteuler.net/problem=764

use 5.014;
use warnings;
use ntheory qw(:all);

sub divisors_le {
    my ($n, $k) = @_;

    my @d  = (1);
    my @pp = grep { $_->[0] <= $k } factor_exp($n);

    foreach my $pp (@pp) {

        my $p = $pp->[0];
        my $e = $pp->[1];

        my @t;
        my $r = 1;

        for my $i (1 .. $e) {
            $r = mulint($r, $p);
            foreach my $u (@d) {
                my $t = mulint($u, $r);
                push(@t, $t) if ($t <= $k);
            }
        }

        push @d, @t;
    }

    @d;
}

sub udivisors {
    my ($n) = @_;

    my @d  = (1);
    my @pp = map { powint($_->[0], $_->[1]) } factor_exp($n);

    foreach my $p (@pp) {
        push @d, map { mulint($_, $p) } @d;
    }

    return sort { $a <=> $b } @d;
}

my $N   = powint(10, 16);
my $MOD = powint(10, 9);

sub difference_of_two_squares_solutions {
    my ($n) = @_;

    my @solutions;
    my $limit = sqrtint($n);

    foreach my $d (divisors_le($n, $limit)) {
    #foreach my $d (divisors($n)) {
        #last if $d > $limit;

        my $p = $d;
        my $q = divint($n, $d);

        ($p + $q) % 2 == 0 or next;

        my $x = ($q + $p) >> 1;
        my $y = ($q - $p) >> 1;

        if ($y%4 == 0  and $y >= 1 and $x <= $N and ($y >> 2) <= $N and gcd($x, $y >> 2) == 1) {
            push @solutions, [$x, $y];
        }
    }

    return @solutions;
}

my $sum = 0;

foreach my $y(1..sqrtint($N)) {

    if ($y % 1e4 == 0) {
        say "y = $y out of ", sqrtint($N), " (", sprintf("%.2f", $y / sqrtint($N) * 100), "%)";
        say "Sum = $sum";
    }

    #~ if ($y*$y*$y*$y > $N*$N) {
        #~ say "Last: $y";
        #~ last;
    #~ }

    my @d = difference_of_two_squares_solutions(powint($y, 4));

    foreach my $pair (@d) {
            #if ($pair->[1] % 4 == 0 and $pair->[1] <= $N and $pair->[0] <= $N and $pair->[0] >= 1 and $pair->[1] >= 1) {
                if (gcd($y, $pair->[0], $pair->[1] >> 2) == 1) {
                    $sum = addmod($sum, addmod(addmod($pair->[0], ($pair->[1] >> 2), $MOD), $y, $MOD), $MOD);
                }
            #}
    }

    #foreach my $x(1..$N) {
    #~ for(my $x = 4; $x <= $N; $x += 4) {

        #~ ++$count;
        #~ my $z2 = $x*$x + $y*$y*$y*$y;

        #~ if ($z2 > $N*$N) {
            #~ say "Last x: $x";
            #~ last;
        #~ }

        #~ if (is_square($z2)) {
            #~ my $z = sqrtint($z2);
            #~ if (gcd($x>>2, $y, $z) == 1) {
                #~ say "[$x, $y, $z]";
                #~ $sum += ($x>>2) + $y + $z;
            #~ }
        #~ }
    #~ }
}

say "N = $N";
say "Sum: $sum";

__END__
N = 10000000
Sum: 248876211
perl 764\ Asymmetric\ Diophantine\ Equation\ -\ difference\ of\ squares.pl  0.19s user 0.01s system 97% cpu 0.201 total

y = 10000 out of 31622 (31.62%)
y = 20000 out of 31622 (63.25%)
y = 30000 out of 31622 (94.87%)
N = 1000000000
Sum: 258133745
perl 764\ Asymmetric\ Diophantine\ Equation\ -\ difference\ of\ squares.pl  3.34s user 0.01s system 99% cpu 3.372 total
