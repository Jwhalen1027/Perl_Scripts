#!/opt/perl/bin/perl
use warnings;
#####Jeanne Whalen###
####Takes the blast2go text file and breaks down processes and functions and gives the count for each#####
die "usage: <annotation.pl>\n" unless @ARGV == 3;
$inputfile = $ARGV[0];
$fastafile = $ARGV[1];
$outputfile = $ARGV[2];

open(REPORT, $inputfile) or die "Cannot find the Annotation Report\n";
open(FASTA, $fastafile) or die "Fasta\n";

$line = <REPORT>; #skip the header
%Contig_hash = ();
while ($line = <REPORT>) {
	@annotation_array = split('\t', $line);
	$name = $annotation_array[0];
	($contig_name) = $name =~ /(c\d*_g\d*_i\d*)/; #adds the > so I didn't have to change anything using Linux.
	$Contig_hash{$contig_name} = 1; #doesn't matter just make a hash with any value
}

#print "$_ $Coverage_filter{$_}\n" for (keys %Coverage_filter);
close REPORT;


 
open (FASTA, $fastafile) or die "Cannot find the file $fastafile\n";
open (OUTPUT, ">$outputfile") or die "Cannot open output file $outputfile\n";
while ($sequence = <FASTA>) { #read through the Fasta file line by line
	if ($sequence =~ />/) { #Check for headers. Every time we reach a > it is a new contig
		($seq_name) = $sequence =~ />(c\d*_g\d*_i\d*)/;
		#print $seq_name;
		if (exists $Contig_hash{$seq_name}) { 
			push(@myseqs,$seq_name);
		}
	}
}
print scalar(@myseqs), "\n";
print OUTPUT "@myseqs\n";
close OUTPUT;
close FASTA;

