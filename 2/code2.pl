#!/usr/bin/perl
use strict;
use warnings;

open(my $file, "<", "input.txt");

my $valid = 0;
while (<$file>) {
    if (/^(\d+)-(\d+)\ (.):\ (\w+)$/) {
        my $idx1 = int($1) - 1;
        my $idx2 = int($2) - 1;
        if (substr($4, $idx1, 1) eq $3 xor substr($4, $idx2, 1) eq $3) {
            $valid++;
        }
    }
}

close $file;

print $valid . "\n"
