#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# License: GPLv3
# Website: https://github.com/trizen

# Solved on paper:
#
#   (10^18 - 11235 - 37) / 104 * 12 + 868
#
# where 104 is the number of moves to complete a cycle and 12 is the number of new black squares per cycle.

# https://projecteuler.net/problem=349

use 5.010;
use Math::BigNum qw(:constant);

say ((10**18 - 11235 - 37) / 104 * 12 + 868);
