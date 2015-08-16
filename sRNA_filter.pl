#!/opt/perl/bin/perl
use warnings;

die "usage: <sRNA_filter.pl>\n" unless @ARGV == 1;
$inputfile = $ARGV[0];


open(TEXTFILE, $inputfile) or die "Cannot find the file $textfile\n";

$total_count = 0;
$count18 = 0;
$count19 = 0;
$count20 = 0;
$count21 = 0;
$count22 = 0;
$count23 = 0;
$count24 = 0;
$count25 = 0;
$unique_count = 0;


while ($sRNA = <TEXTFILE>){
	@sRNA_array = split('\t',$sRNA);
	$sequence  = join('',$sRNA_array[0]);
	if (length($sequence) > 25){	#filter out sRNAs that are too long
		#$total_count++;
	}elsif ($sRNA_array[1] == 1){ #filter out those that only have count equal to 1
		next;
	}elsif (length($sequence) == 18){
 		$count18 = ($count18 + $sRNA_array[1]);
		$unique_count++;
	}elsif (length($sequence) == 19){
		$count19 = ($count19 + $sRNA_array[1]);
		$unique_count++;
	}elsif (length($sequence) == 20){
		$count20 = ($count20 + $sRNA_array[1]);
		$unique_count++;
	}elsif (length($sequence) == 21){
		$count21 = ($count21 + $sRNA_array[1]);
		$unique_count++;
	}elsif (length($sequence) == 22){
		$count22 = ($count22 + $sRNA_array[1]);
		$unique_count++;
	}elsif (length($sequence) == 23){
		$count23 = ($count23 + $sRNA_array[1]);
		$unique_count++;
	}elsif (length($sequence) == 24){
		$count24 = ($count24 + $sRNA_array[1]);
		$unique_count++;
	}elsif (length($sequence) == 25){
		$count25 = ($count25 + $sRNA_array[1]);
		$unique_count++;
	}
}
close TEXTFILE;
$total_count = ($count18 + $count19 + $count20 + $count21 + $count22 + $count23 + $count24 + $count25);
print "The count for length 18 is: $count18\n";
print "The count for length 19 is: $count19\n";
print "The count for length 20 is: $count20\n";
print "The count for length 21 is: $count21\n";
print "The count for length 22 is: $count22\n";
print "The count for length 23 is: $count23\n";
print "The count for length 24 is: $count24\n";
print "The count for length 25 is: $count25\n";
print "The total count is $total_count\n";
print "The number of unique sRNAs: $unique_count\n";
exit;