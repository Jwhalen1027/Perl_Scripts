#!/opt/perl/bin/perl
use warnings;

die "usage: <highfreq_SNPs_counter.pl>\n" unless @ARGV == 1;
$textfile = $ARGV[0];


open(TEXTFILE, $textfile) or die "Cannot find the file $textfile\n";

%name_count = ();
$count = 0;
$i = 0;
$j = 20000;
$frequencies = <TEXTFILE>; #skip the header row
while ($frequencies = <TEXTFILE>) {
	chomp $frequencies;
	@frequency_array = split('\t', $frequencies);
	if ($frequency_array[2] =~ /\d+\/\d+/){
		next;
	} elsif ($frequency_array[2] >= 95) {
		$reference_postion = $frequency_array[1];
		push (@reference_position, $frequency_array[1]);
		$scaffold_number = $frequency_array[0];
		push (@scaffold_number, $frequency_array[0]);
		$name_count{$scaffold_number} = $reference_position;
		} else {
		next;
		}
		#$name_count{$scaffold_number} = $reference_position;
	}
#print @reference_position, "\n";
#print "@frequency_array[0], \n";
print scalar keys %name_count, "\n";
#print $frequency_array[0];
#print @SNPfreq;
#print scalar @scaffold_number;
@sorted = sort {$a <=> $b} @reference_position;
$max = $sorted[-1];
$scaffold1_count = 0;
$scaffold5_count = 0;
#$name_count{$scaffold_number} = $reference_position;
#just count the number of sequences within a 20kb window. Everything is already filtered
 while ($j < $max) {
 	$count = 0;
 	foreach $SNP(@reference_position) {
 		if ($SNP >= $i and $SNP <= $j) {
 			$count++;
 			#Right here do the hash exists count too
 		} else {
 		next;
 		}
 	}
 	push (@counter, $count);
 	$i = $i + 20000;
 	$j = $j + 20000;
}
push (@counter, $count);




#@counts_in_range = split('', @counter);
close TEXTFILE;
#print scalar @SNPfreq, "\n";
#print @SNPfreq[0], "\n";
#print scalar(@counter), "\n";
#print "@counter", "\n";
#print values %name_count;
#print $max, "\n";
#print @counts_in_range;
#print scalar @scaffold_number;
#print $scaffold1_count, "\n";
#print $scaffold5_count, "\n";
#print "@scaffold1_counter", "\n";
#print @scaffold5_counter, "\n";
exit;