#!/opt/perl/bin/perl
use warnings;
#####Jeanne Whalen###
####input is gmap summary file and the uniq file#########
die "usage: <gmap_statistics.pl>\n" unless @ARGV == 2;
$inputfile = $ARGV[0];
$annotationfile = $ARGV[1];

open (GMAP, $inputfile) or die "Cannot find the GMAP Summary\n";

while ($line = <GMAP>) {
	 if ($line =~ />c\d+_g\d+_i\d+/) { #this is a new sequence with a name. 
	 	($name) = $line =~ />(c\d+_g\d+_i\d+)/;
	 }elsif ($line =~ /Paths \(\d+\):/) { #this line gives the number of paths
	 	($path) = $line =~ /Paths\s\((\d+)\):/;
	 	if ($path != 0){
			push (@hits, $name);
		}elsif ($path == 0){
			push (@nohits, $name);
		}
	}
}
##make a hash from the annotation file so we can compare
open (ANNOTATION, $annotationfile) or die "Cannot find the Annotation Report\n";
%hash = ();
$complete = 0;
$no_annotation = 0;
$report = <ANNOTATION>;
while ($report = <ANNOTATION>){
	@new_line = split('\t', $report);
	($seq_name) = $new_line[0] =~ /(c\d+_g\d+_i\d+)/;
	($length) = $new_line[0] =~ /.+type:(\w+).+/;
	if ($length eq 'complete'){
		$hash{$seq_name} = 2;
		$complete++;
	}elsif ($new_line[11] eq 'uninformative') {
		$hash{$seq_name} = 1;
		$no_annotation++;
	}else {
		$hash{$seq_name} = 3;
	}
}

$full_length = 0;
$unannotated = 0;
$trans_total = 0;
foreach $contig(@hits){
	if (exists $hash{$contig} and $hash{$contig} == 2){
		$full_length++;
	}elsif (exists $hash{$contig} and $hash{$contig} == 1){
		$unannotated++;
	}
}

$total = scalar(@nohits) + scalar(@hits);
$percent = (scalar(@hits)/$total) * 100;
#print @names, "\n";
$full_percent = ($full_length/$complete) * 100;
$unanno_percent = ($unannotated/$no_annotation) * 100;
print "The number of full-length transcripts annotated is ", $full_length, "\n";
print "The percent of full_length transcripts is mapping back is", $full_percent, "\n";
print "The number of unannotated transcripts is ", $unannotated, "\n";
print "The percent of unannotated transcripts mapping back is ", $unanno_percent, "\n";
print "The total number of transcripts tested is: ", $total, "\n"; 
print "The number of transcripts mapping back to the genome is:", scalar(@hits), "\n";
#print "The total number of transcripts not mapping is: ", scalar(@nohits), "\n";
print "The percentage of hits is: ", $percent, "%\n";
#print scalar(@nohits), "\n";
close GMAP;
close ANNOTATION;


exit;

