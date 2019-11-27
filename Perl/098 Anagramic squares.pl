#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=98

use 5.010;
use strict;
use warnings;

# usage: perl script.pl < p098_words.txt

my @list = eval("(" . do { local $/; <> } . ")");

my %anagrams;
foreach my $word (@list) {
    push @{$anagrams{join '', sort split //, $word}}, $word;
}

my %squares;
foreach my $i (1 .. 1000) {    # first tried with 1..9999999
    my $s = $i**2;
    push @{$squares{length($s)}}, $s;
}

foreach my $key (
                 map  { $_->[1] }
                 sort { $b->[0] <=> $a->[0] }
                 map  { [length($_), $_] }
                 keys %anagrams
  ) {

    my $len   = length($key);
    my @words = @{$anagrams{$key}};

    foreach my $sq (@{$squares{$len}}) {
        for my $i (0 .. $#words - 1) {
            my $word = $words[$i];

            my %table;
            @table{split //, $word} = split(//, $sq);

            do {
                my %seen;
                grep { !$seen{$_}++ } values %table;
             } == $len or next;

            for my $j ($i + 1 .. $#words) {
                my @chars = split(//, $words[$j]);
                next if $table{$chars[0]} eq '0';
                my $n = join('', @table{@chars});
                if (index(sqrt($n), '.') == -1) {
                    say "$sq -- $n ($words[$i], $words[$j])";
                }
            }
        }
    }
}
