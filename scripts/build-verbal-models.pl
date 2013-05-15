#!/usr/bin/perl

BEGIN { push @INC, './lib' }

use strict;
use warnings;
use utf8;

use ParsingTools qw(:DEFAULT);

binmode(STDOUT, ":utf8");

my $filename = '../models/models_flexio_verbal.txt';
my $path = '../models/';

open(my $fh, '<:encoding(UTF-8)', $filename)
or die "Could not open file '$filename' $!";
 
chomp(my @lines = <$fh>);
close $fh;

my $count = $#lines +1;

my @current=();

my $last_model = "0";
my $new_model = "0";

foreach (@lines) {
	my $line =$_;
	if ($line =~ /^#[ ]MODEL:[ ]/) {
		$new_model =$line;
		$new_model =~ s/^#[ ]MODEL:[ ]//;
		my $sample = $new_model;
		$sample =~ s/^\d*[^a-zA-Z]*//;
		$sample =~ s/[^a-zA-Z]*$//;
		$new_model =~ s/[ ].*$//;

		if ($new_model ne $last_model)
		{	
			if ($last_model ne "0"){
				open (my $fh2,'>:encoding(UTF-8)', "$path$last_model.model")
				or die "Could not open file $path$last_model.model $!";
				
				print $fh2 join("\n", @current);
				print $fh2 "\n";
				print $fh2 "\n";
				close ($fh2);
				
				undef @current;
			}
		
			$last_model = $new_model;	
		}
		
		push(@current, "# $sample");
		push(@current, "# $new_model");
		push(@current, "# SFX");
		push(@current, "# Y");
		push(@current, "");

	}
	else {
		$line =~ s/#.*$//;
		if ($line !~ /^$/) {
			my @pattern = split(" ",$line);
			$pattern[3] =~ s/^VM//;
			
			my $variant = $pattern[3];
			$pattern[3] =~ s/.$//;
			
			$variant =~ s/^.....//;
			
			my $formal =0;

			push(@current, "$pattern[0] $pattern[1] $pattern[2] $pattern[3] $variant $formal");
		}
		
	}
		
}

open (my $fh2,'>:encoding(UTF-8)', "$path$last_model.model")
or die "Could not open file $path$last_model.model $!";
				
print $fh2 join("\n", @current);
print $fh2 "\n";
close ($fh2);
				
undef @current;


