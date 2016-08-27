#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 28 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# Lazy, ugly and very rough implementation.

# https://projecteuler.net/problem=54

#~ In the card game poker, a hand consists of five cards and are ranked, from lowest to highest, in the following way:

#~ High Card: Highest value card.
#~ One Pair: Two cards of the same value.
#~ Two Pairs: Two different pairs.
#~ Three of a Kind: Three cards of the same value.
#~ Straight: All cards are consecutive values.
#~ Flush: All cards of the same suit.
#~ Full House: Three of a kind and a pair.
#~ Four of a Kind: Four cards of the same value.
#~ Straight Flush: All cards are consecutive values of same suit.
#~ Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.

#~ The cards are valued in the order:
#~ 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.

use 5.014;
use warnings;
use List::Util qw(uniq max all);

my %convert = (
               'T' => '10',
               'J' => '11',
               'Q' => '12',
               'K' => '13',
               'A' => '14',
              );

my @keys = keys %convert;

sub numify {
    my ($card) = @_;
    [$card->[0] =~ s/^([@keys])/$convert{$1}/r, $card->[1]];
}

#<<<
sub split_hand {
    my ($hand) = @_;
    [sort {
            ($a->[0] <=> $b->[0])
         || ($a->[1] cmp $b->[1])
    } map { numify($_) }
      map { [split(//, $_, 2)] } split(' ', $hand)];
}
#>>>

sub royal_flush {
    my ($hand) = @_;
          $hand->[0][0] == 10
      and $hand->[1][0] == 11
      and $hand->[2][0] == 12
      and $hand->[3][0] == 13
      and $hand->[4][0] == 14;
}

sub straight {
    my ($hand) = @_;
    all { $hand->[$_][0] - $hand->[$_ - 1][0] == 1 } 1 .. $#{$hand};
}

sub straight_flush {
    my ($hand) = @_;
    my @suits = map { $_->[1] } @{$hand};
    uniq(@suits) == 1 or return;
    straight($hand);
}

sub n_pairs {
    my ($n, %h) = @_;
    (grep { $_ == 2 } values %h) == $n;
}

sub decide_winner {
    my ($h1, $h2) = @_;

    $h1 = split_hand($h1);
    $h2 = split_hand($h2);

    royal_flush($h1) && return 1;
    royal_flush($h2) && return 2;

    my (%t1, %t2);
    my (%u1, %u2);

    for (@$h1) {
        ++$u1{$_->[1]};
        ++$t1{$_->[0]};
    }

    for (@$h2) {
        ++$u2{$_->[1]};
        ++$t2{$_->[0]};
    }

    my %r1 = reverse(%t1);
    my %r2 = reverse(%t2);

    my %s1 = reverse(%u1);
    my %s2 = reverse(%u2);

    if (straight_flush($h1)) {
        if (straight_flush($h2)) {
            return ($h1->[-1] > $h2->[-1] ? 1 : 2);
        }
        return 1;
    }
    elsif (straight_flush($h2)) {
        return 2;
    }

  FOUR_OF_A_KIND:
    if (exists $r1{4}) {
        if (exists $r2{4}) {
            if ($r1{4} == $r2{4}) {
                $r1{1} == $r2{1} && goto FULL_HOUSE;
                return ($r1{1} > $r2{1} ? 1 : 2);
            }
            return ($r1{4} > $r2{4} ? 1 : 2);
        }
        return 1;
    }
    elsif (exists $r2{4}) {
        return 2;
    }

  FULL_HOUSE:
    if (exists($r1{3}) and exists($r1{2})) {
        if (exists($r2{3}) and exists($r2{2})) {
            if ($r1{3} == $r2{3}) {
                $r1{2} == $r2{2} && goto FLUSH;
                return ($r1{2} > $r2{2} ? 1 : 2);
            }
            return ($r1{3} > $r2{3} ? 1 : 2);
        }
        return 1;
    }
    elsif (exists($r2{3}) and exists($r2{2})) {
        return 2;
    }

  FLUSH:
    if (exists $s1{5}) {
        if (exists $s2{5}) {
            goto STRAIGHT;
        }
        return 1;
    }
    elsif (exists $s2{5}) {
        return 2;
    }

  STRAIGHT:
    if (straight($h1)) {
        if (straight($h2)) {
            return ($h1->[-1] > $h2->[-1] ? 1 : 2);
        }
        return 1;
    }
    elsif (straight($h2)) {
        return 2;
    }

  THREE_OF_A_KIND:
    if (exists $r1{3}) {
        if (exists $r2{3}) {
            $r1{3} == $r2{3} && goto TWO_PAIRS;
            return ($r1{3} > $r2{3} ? 1 : 2);
        }
        return 1;
    }
    elsif (exists $r2{3}) {
        return 2;
    }

  TWO_PAIRS:
    if (n_pairs(2, %t1)) {
        if (n_pairs(2, %t2)) {

            my @p1 = sort { $b <=> $a } grep { $t1{$_} == 2 } keys %t1;
            my @p2 = sort { $b <=> $a } grep { $t2{$_} == 2 } keys %t2;

            foreach my $i (0 .. $#p1) {
                if ($p1[$i] > $p2[$i]) {
                    return 1;
                }
                elsif ($p2[$i] > $p1[$i]) {
                    return 2;
                }
            }

            foreach my $i (reverse(1 .. 14)) {
                if (exists $t1{$i}) {
                    if (not exists $t2{$i}) {
                        return 1;
                    }
                }
                elsif (exists $t2{$i}) {
                    return 2;
                }
            }
        }
        return 1;
    }
    elsif (n_pairs(2, %t2)) {
        return 2;
    }

  ONE_PAIR:
    if (n_pairs(1, %t1)) {
        if (n_pairs(1, %t2)) {

            my $cmp = $r1{2} <=> $r2{2};

            if ($cmp > 0) {
                return 1;
            }
            elsif ($cmp < 0) {
                return 2;
            }
            else {
                delete $t1{$r1{2}};
                delete $t2{$r2{2}};
                goto HIGHEST_CARD;
            }
        }
        return 1;
    }
    elsif (n_pairs(1, %t2)) {
        return 2;
    }

  HIGHEST_CARD:
    (max(keys %t1) > max(keys %t2) ? 1 : 2);
}

my $count = 0;

while (<>) {
    my (@game) = split(' ');
    my ($hand1, $hand2) = (join(' ', @game[0 .. 4]), join(' ', @game[5 .. 9]));
    my $winner = decide_winner($hand1, $hand2);
    ++$count if ($winner == 1);
}

say $count;
