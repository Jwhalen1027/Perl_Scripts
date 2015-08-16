#!/opt/perl/bin/perl
use warnings;
use strict;
#####Jeanne Whalen###
####input is gmap summary file and the uniq file#########
die "usage: <compare_textfiles.pl>\n" unless @ARGV == 3;
$inputfile1 = $ARGV[0];
$inputfile2 = $ARGV[1];
$outputfile = $ARGV[2];

open(INPUT1, $inputfile1) or die "Couldn't find Input file 1";
open(INPUT2, $inputfile2) or die "Couldn't find Input file 2";

%hash = ();
while ($sequence = <INPUT1>){
	chomp $sequence;
	$hash{$sequence} = 1;
}
close INPUT1;
open(OUTPUT, ">outputfile");

while ($contigs = <INPUT2>){
	chomp $contigs;
	next if exists $hash{$sequence};
	print OUTPUT "$contigs\n";
}
	
close INPUT2;
close OUTPUT;

exit;



