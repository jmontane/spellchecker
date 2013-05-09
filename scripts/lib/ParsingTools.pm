package ParsingTools;

use strict;
use warnings;

use Data::Dumper;

use utf8;
use Unicode::Normalize;
use open qw(:std :utf8);

use Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS %toplain %tovisual);

$VERSION     = 1.00;
@ISA         = qw(Exporter);
@EXPORT      = qw(createdic createrule);
@EXPORT_OK   = qw(createdic createrule);

## createdic
#
#
sub createdic {

binmode(STDOUT, ":utf8");

my $filename = '$_[0]';

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
	print "$entry[0]\/$entry[2]\tpo:$entry[1]\n";
}

}

## createrule
#
#
sub createrule {

binmode(STDOUT, ":utf8");

my $model=$_[0];
my $models_dir=$_[1];
my $mtype =$_[2];

my $filename = "$models_dir$model.model";


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
}

my @result=();
foreach (@lines) {
	if ($_ =~ /^[^#]/)
	{
		my @rule = split(" ",$_);
		my $rule="";
		if ($mtype =~ /^[VN]$/)
		{
			$rule="$type $code $rule[0] $rule[1] $rule[2] is:$rule[3]$rule[5]\n"
		} elsif ($mtype =~ /"O"/) {
			$rule="$type $code $rule[0] $rule[1] $rule[2] is:$rule[3]\n"
		} else {
			$rule="$type $code $rule[0] $rule[1] $rule[2]\n"
		}
		push(@result, $rule); 
	}
  
}
$count = scalar(@result);
unshift(@result, "$type $code $combinable $count\n");
unshift(@result, "# $code -- $sample\n");

return @result;
}
