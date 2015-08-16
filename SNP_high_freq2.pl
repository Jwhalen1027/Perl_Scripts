#!/opt/perl/bin/perl
use warnings;

die "usage: <highfreq_SNPs_counter.pl>\n" unless @ARGV == 2;
$textfile = $ARGV[0];
$output = $ARGV[1];

#The textfile is just for pseudoscaffold# which has been filtered in Linux
open(TEXTFILE, $textfile) or die "Cannot find the file $textfile\n";
open (OUT, ">$output") or die "Cannot open the file $output to write to :$!\n";

$count = 0;
$i = 0;
$j = 20000;
$w = 0;
$z = 100;
$frequencies = <TEXTFILE>; #skip the header row
while ($frequencies = <TEXTFILE>) {
	chomp $frequencies;
	@frequency_array = split('\t', $frequencies);
	if ($frequency_array[8] =~ /\d+\/\d+/){
		next;
	} elsif ($frequency_array[8] >= 95) {
		push (@position, $frequency_array[1]);
		}
	}

#@sorted = sort {$a <=> $b} @position;
$max = $position[-1];
#print $max, "\n";
# #just count the number of sequences within a 20kb window. Everything is already filtered
while ($w < $max) {
	$too_many = 0;
	foreach $snp(@position) {
		if ($snp >= $w and $snp <= $z) {
			$too_many++;
			}
		}
		if ($too_many < 3) {
		push (@good_snps, $too_many);
		}
		$w = $w + 100;
		$z = $z + 100;
		} 



 while ($j < $max) {
 	$count = 0;
 	foreach $SNP(@good_snps) {
 		if ($SNP >= $i and $SNP <= $j) {
 			$count++;
 		} else {
 		next;
 		}
 	}
 	push (@counter, $count);
 	$i = $i + 20000;
 	$j = $j + 20000;
 }
push (@counter, $count);
@tab_array = join("\t", @counter);
print OUT "@tab_array"; 
close TEXTFILE;
print scalar(@counter), "\n";
print "@counter", "\n";

exit;

