#!/usr/bin/perl

# Author: Trizen
# Date: 24 March 2022
# https://github.com/trizen

# Passcode derivation
# https://projecteuler.net/problem=79

# General recursive solution.

# Runtime: 0.158s

use 5.020;
use warnings;

use List::Util qw(min);
use experimental qw(signatures);

sub find_candidates ($callback, $a, $b, $re_a = join('.*?', @$a), $re_b = join('.*?', @$b), $a_i = 0, $b_i = 0, $solution = [])
{

    if (join('', @$solution) =~ $re_a and join('', @$solution) =~ $re_b) {
        $callback->($solution);
        return $solution;
    }

    if (($a_i <= $#$a) && ($b_i <= $#$b) && ($a->[$a_i] == $b->[$b_i])) {
        __SUB__->($callback, $a, $b, $re_a, $re_b, $a_i + 1, $b_i + 1, [@$solution, $a->[$a_i]]);
    }

    __SUB__->($callback, $a, $b, $re_a, $re_b, $a_i + 1, $b_i,     [@$solution, $a->[$a_i]]) if ($a_i <= $#$a);
    __SUB__->($callback, $a, $b, $re_a, $re_b, $a_i,     $b_i + 1, [@$solution, $b->[$b_i]]) if ($b_i <= $#$b);
}

my @passcodes = sort { $a <=> $b } qw(
  319 680 180 690 129 620 762 689 318 368 710 720 629 168 160 716
  731 736 729 316 769 290 719 389 162 289 718 790 890 362 760 380 728
);

my @candidates = [split(//, shift(@passcodes))];

while (@passcodes) {

    my $b = [split(//, shift(@passcodes))];

    my @new_candidates;
    foreach my $a (@candidates) {
        find_candidates(
            sub ($solution) {
                push @new_candidates, $solution;
            },
            $a, $b
        );
    }

    @new_candidates = do {    # remove duplicates
        my %seen;
        grep { !$seen{join('', @$_)}++ } @new_candidates;
    };

    my $min_len = min(map { $#$_ } @new_candidates);
    @candidates = grep { $#$_ == $min_len } @new_candidates;

    say sprintf("Found: %s candidates (best: %s)", scalar(@candidates), join('', @{$candidates[0]}));
}

say "Final candidates: ", join(', ', map { join('', @$_) } @candidates);
