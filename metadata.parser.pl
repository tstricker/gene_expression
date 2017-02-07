#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;
use LWP::Simple;
#use JSON qw( decode_json ); 
use JSON::XS qw( decode_json); 

#my $rna = "/Users/tstricker/Dropbox/ovarian_proj/metadata.cart.2017-02-01T22-41-51.985089.json";
#my @decoded_json = decode_json( "/Users/tstricker/Dropbox/ovarian_proj/test.json" );

open FILE, '/Users/tstricker/Dropbox/ovarian_proj/metadata.cart.2017-02-01T22-41-51.985089.json' or die "Could not open file inputfile: $!";
#open FILE, '/Users/tstricker/Dropbox/ovarian_proj/test.json' or die "Could not open file inputfile: $!";


my $out_file = "/Users/tstricker/Dropbox/ovarian_proj/tcga.2.file.txt";
open(OUT, ">$out_file")||die "Can't open $out_file!"; 
sysread(FILE, my $result, -s FILE);
close FILE or die "Could not close file: $!"; 
#print Dumper \$result;
my $objs = JSON::XS->new->incr_parse($result);
my @objs = @$objs;
foreach my $i (0..$#objs){
    if($objs[$i]{file_name} =~ /FPKM-UQ/){
	print OUT "$objs[$i]{file_name}\t$objs[$i]{cases}[0]{submitter_id}\n";

    }
}

#print Dumper \@objs;
