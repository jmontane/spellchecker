#!/usr/bin/perl

BEGIN { push @INC, './lib' }

use strict;
use warnings;
use utf8;

use ParsingTools qw(:DEFAULT);

binmode(STDOUT, ":utf8");

my $filename = '../data-sources/data.txt';

open(my $fh, '<:encoding(UTF-8)', $filename)
or die "Could not open file '$filename' $!";
 
chomp(my @lines = <$fh>);
close $fh;

my $count = $#lines +1;

print "$count\n";

foreach (@lines) {
	my @entry = split(/\|/,$_);
	if ($entry[1] =~ "VP")
	{
	 $entry[0] =~ s/(-se|'s)$//;
	 
	}
	if ($entry[2] !~ /500/) {
		print "$entry[0]\/$entry[2]\tpo:$entry[1]\n";
	} else {
		print "$entry[0]\tpo:$entry[1]\n";
	}
		
}


