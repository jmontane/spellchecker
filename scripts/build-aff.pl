#!/usr/bin/perl

BEGIN { push @INC, './lib' }

use strict;
use warnings;
use utf8;

use ParsingTools qw(:DEFAULT);
binmode(STDOUT, ":utf8");

my @v_models= qw(26 59);
my @n_models=qw(201 202 203 204 205 206 207 208 209 210 211 212 213 214);
my @other_models= qw(999);

my @models= (@v_models, @n_models, @other_models);


my $models_dir = "../models/";

# Print header
print_header();

# Print encoding
print_encoding();

# Print block
print_block();

# Print verbal models
foreach (@v_models)
{
	my @rules= ParsingTools::createrule($_, $models_dir, "V");
	print @rules;
	print "\n";
}

# Print noun/adjective models
foreach (@n_models)
{
	my @rules= ParsingTools::createrule($_, $models_dir, "N");
	print @rules;
	print "\n";
}

# Print other models
foreach (@other_models)
{
	my @rules= ParsingTools::createrule($_, $models_dir, "O");
	print @rules;
	print "\n";
}

# end

sub print_header
{

print <<HEADER;
# =======================================================================================
#                              Corrector ortogràfic català
#                          Fitxer d'afixos i llista de paraules
# =======================================================================================
#                                Release 0.0.1 (7/5/2013)
# =======================================================================================
# Copyright (C) 2002-2008 
# =======================================================================================
# Fonts: 
# =======================================================================================

HEADER
}

sub print_encoding
{
print "SET UTF-8\n\n";
}

sub print_block
{

print <<BLOCK;

FLAG num

WORDCHARS ·-'

TRY easirtocnlumdpgvfbqjwxyzhàèéíïòóúüç·-'

REP 48
REP a à
REP e é
REP e è
REP é è
REP i í
REP i ï
REP í ï
REP o ó
REP o ò
REP ó ò
REP u ú
REP u ü
REP ú ü
REP l l·l
REP e E
REP a A
REP s S
REP i I
REP r R
REP t T
REP o O
REP c C
REP n N
REP l L
REP u U
REP m M
REP d D
REP p P
REP g G
REP v V
REP f F
REP b B
REP q Q
REP j J
REP w W
REP x X
REP y Y
REP z Z
REP h H
REP à À
REP è È
REP é É
REP í Í
REP ï Ï
REP ò Ò
REP ó Ó
REP ú Ú
REP ü Ü

# Patterns rules:
#

BLOCK
}

