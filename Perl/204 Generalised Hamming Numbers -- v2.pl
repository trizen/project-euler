#!/usr/bin/perl

# Daniel "Trizen" Șuteu
# Date: 25 July 2021
# https://github.com/trizen

# How many generalised Hamming numbers of type 100 are there which don't exceed 10^9?

# https://projecteuler.net/problem=204

# Runtime: 0.031s

use 5.010;
use strict;
use warnings;

use ntheory qw(smooth_count);

say smooth_count(1e9, 100);
