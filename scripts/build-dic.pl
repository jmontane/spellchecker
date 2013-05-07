#!/usr/bin/perl

use strict;
use warnings;
use utf8;

binmode(STDOUT, ":utf8");

my $filename = '../data-sources/verbs.txt';

open(my $fh, '<:encoding(UTF-8)', $filename)
or die "Could not open file '$filename' $!";
 
chomp(my @lines = <$fh>);
close $fh;

my $count = $#lines +1;

print "$count\n";

foreach (@lines) {
	my @entry = split(/\|/,$_);
	print "$entry[0]\/$entry[2]\tpo:verb\n";
}


