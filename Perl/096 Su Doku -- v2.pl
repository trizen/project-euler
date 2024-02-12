#!/usr/bin/perl

# Author: Trizen
# Date: 12 February 2024
# https://github.com/trizen

# https://projecteuler.net/problem=96

# Runtime: 0.607s

use 5.036;

sub is_valid ($board, $row, $col, $num) {

    # Check if the number is not present in the current row and column
    foreach my $i (0 .. 8) {
        if (($board->[$row][$i] == $num) || ($board->[$i][$col] == $num)) {
            return 0;
        }
    }

    # Check if the number is not present in the current 3x3 subgrid
    my ($start_row, $start_col) = (3 * int($row / 3), 3 * int($col / 3));

    foreach my $i (0 .. 2) {
        foreach my $j (0 .. 2) {
            if ($board->[$start_row + $i][$start_col + $j] == $num) {
                return 0;
            }
        }
    }

    return 1;
}

sub find_empty_locations ($board) {

    my @locations;

    # Find all empty positions (cells with 0)
    foreach my $i (0 .. 8) {
        foreach my $j (0 .. 8) {
            if ($board->[$i][$j] == 0) {
                push @locations, [$i, $j];
            }
        }
    }

    return @locations;
}

sub find_empty_location ($board) {

    # Find an empty position (cell with 0)
    foreach my $i (0 .. 8) {
        foreach my $j (0 .. 8) {
            if ($board->[$i][$j] == 0) {
                return ($i, $j);
            }
        }
    }

    return (undef, undef);    # If the board is filled
}

sub solve_sudoku_fallback ($board) {

    my ($row, $col) = find_empty_location($board);

    if (!defined($row) && !defined($col)) {
        return 1;    # Puzzle is solved
    }

    foreach my $num (1 .. 9) {
        if (is_valid($board, $row, $col, $num)) {

            # Try placing the number
            $board->[$row][$col] = $num;

            # Recursively try to solve the rest of the puzzle
            if (__SUB__->($board)) {
                return 1;
            }

            # If placing the current number doesn't lead to a solution, backtrack
            $board->[$row][$col] = 0;
        }
    }

    return 0;    # No solution found
}

sub solve_sudoku ($board) {

    while (1) {

        # Return early when the first 3 values are solved
        if ($board->[0][0] != 0 and $board->[0][1] != 0 and $board->[0][2] != 0) {
            return $board;
        }

        my @empty_locations = find_empty_locations($board);

        if (not @empty_locations) {
            last;    # solved
        }

        my $found = 0;

        # Solve easy cases
        foreach my $ij (@empty_locations) {
            my ($i,     $j)     = @$ij;
            my ($count, $value) = (0, 0);
            foreach my $n (1 .. 9) {
                is_valid($board, $i, $j, $n) || next;
                last if (++$count > 1);
                $value = $n;
            }
            if ($count == 1) {
                $board->[$i][$j] = $value;
                $found ||= 1;
            }
        }

        next if $found;

        # Solve more complex cases
        my @stats;
        foreach my $ij (@empty_locations) {
            my ($i, $j) = @$ij;
            $stats[$i][$j] = [grep { is_valid($board, $i, $j, $_) } 1 .. 9];
        }

        my (@rows, @cols);
        foreach my $ij (@empty_locations) {
            my ($i, $j) = @$ij;
            foreach my $v (@{$stats[$i][$j]}) {
                ++$cols[$j][$v];
                ++$rows[$i][$v];
            }
        }

        $found = 0;

        foreach my $ij (@empty_locations) {
            my ($i, $j) = @$ij;
            foreach my $v (@{$stats[$i][$j]}) {
                if ($cols[$j][$v] == 1) {
                    $board->[$i][$j] = $v;
                    $found ||= 1;
                }
                elsif ($rows[$i][$v] == 1) {
                    $board->[$i][$j] = $v;
                    $found ||= 1;
                }
            }
        }

        next if $found;

        say "Fallback: ", scalar(@empty_locations);
        solve_sudoku_fallback($board);
        return $board;
    }

    return $board;
}

open my $fh, '<:raw', ($ARGV[0] // 'p096_sudoku.txt')
  or die "Can't open file `p096_sudoku.txt`: $!";
chomp(my @grids = grep { /^[0-9]+$/ } <$fh>);
close $fh;

my $sum = 0;

while (@grids) {
    my @grid     = map { [split(//, $_)] } splice(@grids, 0, 9);
    my $solution = solve_sudoku(\@grid);
    $sum += "$solution->[0][0]$solution->[0][1]$solution->[0][2]";
}

say $sum;
