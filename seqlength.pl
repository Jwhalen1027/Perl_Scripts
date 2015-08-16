#!/opt/perl/bin/perl
use warnings;
# -------FASTA STATS----------

die "usage: <fasta_stat.pl>\n" unless @ARGV == 1;
$filename1 = $ARGV[0];
#$outputfile = $ARGV[1];

open (FASTA1, $filename1) or die "Cannot find the file $filename1\n";

 
$sequence_count = 0;
$sequence_length = 0;
$bin1 = 0;
$bin2 = 0;
$bin3 = 0;
$bin4 = 0;
$bin5 = 0;
$bin6 = 0;
$bin7 = 0;
$bin8 = 0;
$bin9 = 0;
$bin10 = 0;
$bin11 = 0;

while ($line = <FASTA1>) {
	 if ($line =~ />/){ 
	 $sequence_count++; #Found a header! 
	 push (@sequences, $sequence_length);
	 $sequence_length = 0;
	 next; 
	 } else { #Not a header- this is the sequence
	 chomp($line);
	 $nuc_count = length($line) + $nuc_count;
	 $sequence_length = length($line) + $sequence_length; #resets every time a header is reached
	 }
}
push (@sequences, $sequence_length);
	
@sorted_contigs = sort {$a<=>$b } @sequences;
shift @sorted_contigs;
$minimum = $sorted_contigs[0];
$maximum = $sorted_contigs[-1];
foreach $length(@sorted_contigs){
		if ($length > 200 and $length <= 500){
	 		$bin1++;
	 	}elsif ($length > 500 and $length <= 1000){
	 		$bin2++;
	 	}elsif ($length > 1000 and $length <= 1500){
	 		$bin3++;
	 	}elsif ($length > 1500 and $length <= 2000){
	 		$bin4++;
	 	}elsif ($length > 2000 and $length <= 2500){
	 		$bin5++;
	 	}elsif ($length > 2500 and $length <= 3000){
	 		$bin6++;
	 	}elsif ($length > 3000 and $length <= 3500){
	 		$bin7++;
	 	}elsif ($length > 3500 and $length <= 4000){
	 		$bin8++;
	 	}elsif ($length > 4000 and $length <= 4500){
	 		$bin9++;
	 	}elsif ($length > 4500 and $length <= 5000){
	 		$bin10++;
	 	}elsif ($length > 5000){
	 		$bin11++;
	 	}
#for the mean, I want to add up every value in the array @sorted_contigs, and divide by the number of contigs ($contig_count)
#every value added will just be the total number of nucleotides!
$mean = ($nuc_count)/($sequence_count);
$contig_scalar = scalar(@sorted_contigs);
	if ($contig_scalar % 2 == 0) {
		$location1 = (($contig_scalar/2));
		$location2 = $location1 - 1;
		$median = ($sorted_contigs[$location1] + $sorted_contigs[$location2])/2;
	}else {
		$location = ((($contig_scalar/2)+0.5)-1);
		$median = $sorted_contigs[$location];
	}	
	
print "$bin1\n";
print "$bin2\n";
print "$bin3\n";
print "$bin4\n";
print "$bin5\n";
print "$bin6\n";
print "$bin7\n";
print "$bin8\n";
print "$bin9\n";
print "$bin10\n";
print "$bin11\n";

close FASTA1;
exit;
