#!/usr/bin/perl

use strict;
use warnings;
use utf8;

binmode(STDOUT, ":utf8");

my $filename = '../models/26.model';

open(my $fh, '<:encoding(UTF-8)', $filename)
or die "Could not open file '$filename' $!";
 
chomp(my @lines = <$fh>);
close $fh;

my $sample ="";
my $code ="";
my $type = "";
my $combinable ="";
my $count = 0;


if ( ($lines[0] !~ /^# /) || ($lines[1] !~ /^# /) || ($lines[2] !~ /^# /) || ($lines[3] !~ /^# /)) {
	die "Model data file '$filename' is invalid";
} else {
	$sample = substr($lines[0], 2);
	$code = substr($lines[1], 2);
	$type = substr($lines[2], 2);
	$combinable = substr($lines[3], 2);
	
	shift(@lines);
	shift(@lines);
	shift(@lines);
	shift(@lines);
	
	my @patterns = grep(/^[^#]/,@lines);
	$count = scalar(@patterns),
}



print "# $sample\n";
print "$type $code $combinable $count\n";
foreach (@lines) {
	if ($_ =~ /^[^#]/)
	{
		print "$type $code $_\n";
	}
	  
}


