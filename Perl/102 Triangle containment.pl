#!/usr/bin/perl

# Author: Daniel "Trizen" Șuteu
# Date: 28 August 2016
# License: GPLv3
# Website: https://github.com/trizen

# https://projecteuler.net/problem=102

use 5.010;
use strict;
use warnings;

require Imager;

my $count = 0;
my $green = Imager::Color->new(0, 255, 0);

while (<>) {
    chomp;
    my @triangles = split(/,/);

    my @x = @triangles[0,2,4];
    my @y = @triangles[1,3,5];

    my ($width, $height) = (2000, 2000);
    my $img = Imager->new(xsize => $width, ysize => $height);

    $img->polygon(
        points => [
            [$x[0]+$width/2, $y[0]+$height/2],
            [$x[1]+$width/2, $y[1]+$height/2],
            [$x[2]+$width/2, $y[2]+$height/2],
        ],
        color => $green,
    );

    ($img->getpixel(x => $width/2, y => $height/2)->rgba)[1] == 255
        && ++$count;
}

say $count;
