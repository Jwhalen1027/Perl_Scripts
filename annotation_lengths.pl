#!/opt/perl/bin/perl
use warnings;
###Determining the lengths of the sequences from the annotation report

die "usage: <annotation_lengths.pl>\n" unless @ARGV == 2;
$annotation_report = $ARGV[0] or die "Cannot find the Annotation Report\n";
$inputfile = $ARGV[1] or die "Cannot find the sequence file\n";

open (INPUT, $inputfile);

%name_hash =();
$fasta = <INPUT>; #skip the header
while ($fasta = <INPUT>) {
	if ($fasta =~ />/) { #this is a header, not the sequence itself
		($seq_name) = $fasta =~ />(c\d*_g\d*_i\d*)/; #seq_name is stored in the same format as Annotation Report
		$name_hash{$seq_name} = 1;
	}
}

close INPUT;
open (ANNOTATION, $annotation_report);
$uninformative = 0;
$informative = 0;
$no_annotation = 0;

$report = <ANNOTATION>;
while ($report = <ANNOTATION>) {
	@seq_line = split('\t', $report);
	$seq_id = $seq_line[0];
	#print $seq_id;
	if ((exists $name_hash{$seq_id}) and ($seq_line[12] =~ /uninformative/)) {
		$uninformative++; 
	}elsif ((exists$name_hash{$seq_id}) and (($seq_line[12] =~ /PREDICTED/) or ($seq_line[12] =~ /.+/))) {
		$informative++;
	}elsif (exists $name_hash{$seq_id}) {
		$no_annotation++; 
	}
}

print "there are $uninformative uninformative annotations\n";
print "there are $informative informative annotations\n";
print "there are $no_annotation without annotation\n";
$total = $no_annotation + $informative + $uninformative;

print "The total is: $total\n";

close ANNOTATION;
  
	