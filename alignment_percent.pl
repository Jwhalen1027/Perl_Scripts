#!/opt/perl/bin/perl
use warnings;
#####Jeanne Whalen###
####input is the Interpro.raw file#########
die "usage: <alignment_percent.pl>\n" unless @ARGV == 1;
$inputfile = $ARGV[0];

open(REPORT, $inputfile) or die "Cannot find the Annotation Report\n";


$count9 = 0;
$count8 = 0;
$count7 = 0;
#line by line I want to search column 
$report = <REPORT>; #skip the header
while ($report = <REPORT>){
	@report_array = split('\t',$report); 
	$seq_start = $report_array[6];
	#print $seq_start; 
	$seq_end = $report_array[7];
	$seq = $seq_end - $seq_start;
	$length = $report_array[2];
	$percent = ($seq)/($length);
	if ($percent >= .9){
		$count7++;
		$count8++;
		$count9++;
	}elsif ($percent >= .8 and $percent < .9){
		$count7++;
		$count8++;
	}elsif ($percent >= .7 and $percent < .9){
		$count7++;
	}else{
		next;
	}
}

print "$count7 sequences align 70%\n";
print "$count8 sequences align 80%\n";
print "$count9 sequences align 90%\n"; 		

close REPORT;
exit;