#!/opt/perl/bin/perl
use warnings;
use Text::Diff;
use strict;
#####Jeanne Whalen###
####input is gmap summary file and the uniq file#########
die "usage: <compare_gmap.pl>\n" unless @ARGV == 3;
$inputfile = $ARGV[0];
$inputfile2 = $ARGV[1];
$outputfile = $ARGV[2];

open (INPUT, $inputfile) or die "Cannot find the input file\n";
open (INPUT2, $inputfile2);
open (OUTPUT, $outputfile);
# %hash = ();
# while ($sequence = <INPUT>){
# 	chomp $sequence;
# 	$hash{$sequence} = 1;
# }
my $diffs = diff INPUT => INPUT2;
print OUTPUT $diffs, "\n";



# while ($line = <INPUT2>){
# 	chomp $line;
# 	next if exists $hash{$sequence};
# 	print OUTPUT "$line\n";
# }
close INPUT;
close INPUT2;
close OUTPUT;
exit;
