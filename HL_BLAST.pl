#!/opt/perl/bin/perl
use warnings;
#####Jeanne Whalen###
####Takes the blast2go text file and breaks down processes and functions and gives the count for each#####
die "usage: <annotation.pl>\n" unless @ARGV == 3;
$inputfile = $ARGV[0];
$HL_file = $ARGV[1];
$outputfile = $ARGV[2];

open(REPORT, $inputfile) or die "Cannot find the Annotation Report\n";
open(INPUT, $HL_file) or die "HL\n";

$line = <REPORT>; #skip the header
%Name_hash = ();
while ($line = <REPORT>) {
	@annotation_array = split('\t', $line);
	$name = $annotation_array[0];
	($contig_name) = $name =~ /(c\d*_g\d*_i\d*)/; #adds the > so I didn't have to change anything using Linux.
	$Name_hash{$contig_name} = 1; #doesn't matter just make a hash with any value
}

#print "$_ $Coverage_filter{$_}\n" for (keys %Coverage_filter);
close REPORT;


 
open (INPUT, $HL_file) or die "Cannot find the file $HL_file\n";
open (OUTPUT, ">$outputfile") or die "Cannot open output file $outputfile\n";
@array = <INPUT>;
foreach $hl (@array) { #read through the Fasta file line by line
	($seq_name) = $hl =~ /HLcds.(c\d*_g\d*_i\d*)/;
	print $seq_name;
	if (exists $Name_hash{$seq_name}) { 
		push(@myseqs,$seq_name);
	}
}
print scalar(@myseqs), "\n";
print OUTPUT "@myseqs\n";
close OUTPUT;
close INPUT;
