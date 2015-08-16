#!/opt/perl/bin/perl
use warnings;
#####Jeanne Whalen###
####Takes the blast2go text file and breaks down processes and functions and gives the count for each#####
die "usage: <GObreakdown.pl>\n" unless @ARGV == 1;
$inputfile = $ARGV[0];


open(REPORT, $inputfile) or die "Cannot find the Annotation Report\n";



$pro = 0;
$fun = 0;
$com = 0; 
$line_count = 0;
$blast2go = <REPORT>; #skip the header
while ($blast2go = <REPORT>){
	@blast_array = split('\t',$blast2go);
	print @blast_array; 
	if ($blast_array[32] !~ /\s/ or $blast_array[32] !~ /N\/A/){
		$pro++;
	}elsif ($blast_array[33] !~ /\s/ or $blast_array[33] !~ /N\/A/){
		$fun++;
	}elsif ($blast_array[34] !~ /\s/ or $blast_array[34] !~ /N\/A/){
		$com++;
	}
}

print $pro, "\n";
print $fun, "\n";
print $com, "\n";
print $line_count, "\n";
print @blast_array;

close REPORT;