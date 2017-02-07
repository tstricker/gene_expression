#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;

my @ID;
my %ID;
my $rna_file = "/Users/tstricker/Dropbox/ovarian_proj/tcga.2.file.txt";
open(AA, "$rna_file")||die "Can't open $rna_file!";
while(<AA>){
    chomp $_;
    my @temp = split(/\t/, $_);
    if ($temp[0] =~ /FPKM-UQ/){
	push (@ID, $temp[1]);
	my @name = split(/\./, $temp[0]);
	$ID{$temp[1]}=$name[0];
    }
}

my %clinical;
my $clinical="/Users/tstricker/Dropbox/ovarian_proj/ovarian.clinical.txt";
open(BB, "$clinical")||die "Can't open $clinical!";
while(<BB>){
    chomp $_;
    my @temp = split(/\t/, $_);
    $clinical{$temp[0]}++;
}

print Dumper \%clinical;
print Dumper \@ID;
print Dumper \%ID;

my @files = `find /Users/tstricker/Dropbox/ovarian_proj/ovarian_RNAseq/ -name "*FPKM-UQ*"`;

my %expression;
my @samples;
foreach my $i(0..$#files){
    chomp $files[$i];
    unless ($files[$i] =~ /logs/){
	my @temp = split(/\//, $files[$i]);
	my @name = split(/\./, $temp[$#temp]);
	push @samples, $name[0];
	open(AA, "$files[$i]")||die "Can't open $files[$i]!";
	while(<AA>){
	    chomp $_;
	    my @genes = split(/\t/, $_);
	    $expression{$genes[0]}{$name[0]}=$genes[1];
	}    
    }
}

#print Dumper \%expression;


my $out_file = "/Users/tstricker/Dropbox/ovarian_proj/ovarian_RNAseq/all.FPKM.UQ.expression.txt";
open(OUT, ">$out_file")||die "Can't open $out_file!";

print OUT "genes\t";
foreach my $i (0..$#ID){
    print OUT "$ID[$i]\t";
}
print OUT "\n";


foreach my $foo (keys %expression){
    print OUT "$foo\t";
    foreach my $i (0..$#ID){
	if ($clinical{$ID[$i]}){
	    
	    if ($expression{$foo}{$ID{$ID[$i]}}){
		print "$ID[$i]\n";
		print OUT "$expression{$foo}{$ID{$ID[$i]}}\t"
	    }
	    else{
		print OUT "NA\t";
	    }
	}
    }
    print OUT "\n";
}
