#!/usr/bin/perl

use strict;
use warnings;
use utf8;

binmode(STDOUT, ":utf8");

my $num_args = $#ARGV + 1;
if ($num_args != 1) {
  print "\nUsage: ./generate-model.pl number_of_model\n";
  exit;
}

my $model=$ARGV[0];
my $filename = "../models/$model.model";


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



print "# $code -- $sample\n";
print "$type $code $combinable $count\n";
foreach (@lines) {
	if ($_ =~ /^[^#]/)
	{
		my @rule = split(" ",$_);
		print "$type $code $rule[0] $rule[1] $rule[2] is:$rule[3]$rule[4]\n";
	}
	  
}


