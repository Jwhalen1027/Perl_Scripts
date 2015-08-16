#!/opt/perl/bin/perl
use warnings;
#####Jeanne Whalen###
####Takes the blast2go text file and breaks down processes and functions and gives the count for each#####
die "usage: <gmap_counting.pl>\n" unless @ARGV == 3;
$annotationfile = $ARGV[0];
$gmapfile = $ARGV[1];
$outputfile = $ARGV[2];

open(REPORT, $annotationfile) or die "Cannot find the Annotation Report\n";
open(GMAP, $gmapfile) or die "GMAP\n";

$line = <REPORT>; #skip the header
%gmap_hash = ();
while ($line = <REPORT>) {
	@annotation_array = split('\t', $line);
	$name = $annotation_array[0];
	($contig_name) = $name =~ /(c\d*_g\d*_i\d*)/; #adds the > so I didn't have to change anything using Linux.
	$gmap_hash{$contig_name} = 1; #doesn't matter just make a hash with any value
}

#print "$_ $Coverage_filter{$_}\n" for (keys %Coverage_filter);
close REPORT;


 
open (GMAP, $gmapfile) or die "Cannot find the file $fastafile\n";
open (OUTPUT, ">$outputfile") or die "Cannot open output file $outputfile\n";
while ($gline = <GMAP>) {
	 if ($gline =~ />c\d+_g\d+_i\d+/) { #this is a new sequence with a name. 
	 	($gmap_name) = $gline =~ />(c\d*_g\d*+_i\d*)/;
		#print $seq_name;
		if (exists $gmap_hash{$gmap_name}) { 
			push(@myseqs,$gmap_name);
		}
	}
}
print scalar(@myseqs), "\n";
print OUTPUT "@myseqs\n";
close OUTPUT;
close FASTA;

