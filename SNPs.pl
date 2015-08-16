#!/opt/perl/bin/perl
use warnings;

die "usage: <highfreq_SNPs_counter.pl>\n" unless @ARGV == 2;
$textfile = $ARGV[0];
$output = $ARGV[1];

#The textfile is just for pseudoscaffold# which has been filtered in Linux
open(TEXTFILE, $textfile) or die "Cannot find the file $textfile\n";
open (OUT, ">$output") or die "Cannot open the file $output to write to :$!\n";


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

$length = scalar(@position);
#$m = 0;
$w = 1;
$x = 0;
$count1 = 0;
while ($w < $length){
		if($position[$w]-$position[$x] <= 100) {
			$count1++;
			$w++;
		}else {
			if($count1 < 3) {
				push(@new_position, $position[$x]);
				$x++;
				$w = $x + 1;
				$count1 =0;
			} else{
			$x++;
			$w = $x +1;
			$count1 = 0;
			}
		}
}
#somewhere need to add another push statement because the first element
#before the clusters isn't being pushed. 
#print "@new_position\n";

$count = 0;
$i = 0;
$j = 20000;
#@sorted = sort {$a <=> $b} @position;
$max = $new_position[-1];
#print $max, "\n";
# #just count the number of sequences within a 20kb window. Everything is already filtered
while ($j < $max) {
 	$count = 0;
 	foreach $SNP(@new_position) {
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
#print scalar(@counter), "\n";
#print "@counter", "\n";

exit;