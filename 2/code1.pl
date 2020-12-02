#!/usr/bin/perl
use strict;
use warnings;

open(my $file, "<", "input.txt");

my $valid = 0;
while (<$file>) {
    if (/^(\d+)-(\d+)\ (.):\ (\w+)$/) {
        my $min = int($1);
        my $max = int($2);
        my $password = $4;
        $password =~ s/[^$3]//g;
        my $count = length($password);
        if ($min <= $count <= $max) {
            $valid++;
        }
    }
}

close $file;

print $valid . "\n"
