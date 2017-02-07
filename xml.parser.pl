#!/usr/bin/perl
use strict;
use warnings;
use XML::Simple;
use Data::Dumper;


my @samples;
my $rna_file = "/Users/tstricker/Dropbox/ovarian_proj/tcga.2.file.txt ";
open(AA, "$rna_file")||die "Can't open $rna_file!";
while(<AA>){
    chomp $_;
    my @temp = split(/\t/, $_);
    push (@samples, $temp[1])

}

my %clinical;
my %fields;
my @files = `find /Users/tstricker/Dropbox/ovarian_proj/ovarian/ -name "*xml"`;
print Dumper \@files;



foreach my $i (0..$#files){
    chomp $files[$i];
    my @temp = split(/\//, $files[$i]);
    my @name = split(/\./, $temp[$#temp]);
    my $rna = XMLin($files[$i], ForceArray => 1);
    my %rna = %$rna;
    foreach my $foo(keys %rna){
	if ($foo =~ /patient/){
	    foreach my $bar (keys %{$rna{$foo}[0]}){
		#print "$rna{$foo}[0]{$bar}[0]\n";
		foreach my $spam (keys %{$rna{$foo}[0]{$bar}[0]}){
		    if ($spam =~ /content/){
			#print "$bar\t$rna{$foo}[0]{$bar}[0]{$spam}\n";
			$clinical{$name[2]}{$bar}=$rna{$foo}[0]{$bar}[0]{$spam};
			$fields{$bar}++;
		    }
		    elsif ($spam =~ /drug/){
			foreach my $i (0..$#{$rna{$foo}[0]{$bar}[0]{$spam}}){
			    foreach my $fu (keys %{$rna{$foo}[0]{$bar}[0]{$spam}[$i]}){
				if ($fu =~ /name/){
				    #print "$fu\t$rna{$foo}[0]{$bar}[0]{$spam}[$i]{$fu}[0]{content}\n";
				    push @{$clinical{$name[2]}{$bar}},$rna{$foo}[0]{$bar}[0]{$spam}[$i]{$fu}[0]{content};
				    $fields{$fu}++;
				}
				
			    }
			}
		    }
		}
	    }
	}
    }
}


#print Dumper \%clinical;

my @fields = keys(%fields);
print Dumper \@fields;
my $out = "/Users/tstricker/Dropbox/ovarian_proj/ovarian.clinical.txt";
open(OUT, ">$out")||die "Can't open $out!";


print OUT"Sample\t";

foreach my $i (0..$#fields){
    print OUT"$fields[$i]\t";
}
print OUT "\n";


foreach my $k (0..$#samples){
    my $foo = $samples[$k];
    print "$foo\n";
    print OUT "$foo\t";
    foreach my $i(0..$#fields){
	#print Dumper \%{$fields{$foo}};
	#print "$fields[$i]\n";
	if ($clinical{$foo}{$fields[$i]}){
	    print OUT "$clinical{$foo}{$fields[$i]}\t";
	}
				   
	else{
	    print OUT "NA\t";
	}
    }
       my $blah = "rx:drugs";
       foreach my $j (0..$#{$clinical{$foo}{$blah}}){
	   print OUT "$clinical{$foo}{$blah}[$j],";
           print "$clinical{$foo}{$blah}[$j],";
       }
    
    print OUT "\n"; 
}


    



