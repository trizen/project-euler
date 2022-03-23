#!/usr/bin/perl

# Check that every solution has the correct link to the problem.

use 5.020;
use File::Find;
use File::Slurper qw(read_text);

find {
    wanted => sub {
        if (/^(\d{3}) /) {
            my $d       = $1 =~ s/^0+//r;
            my $content = read_text($_);
            if (not $content =~ /problem=$d\b/) {
                say "$File::Find::dir/$_";
            }
        }
    }
} => '.';
