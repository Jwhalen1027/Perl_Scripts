#!/opt/perl/bin/perl
use warnings;
#a program to filter out low-coverage contigs from a text file

die "usage: <low_coverage_filter.pl>\n" unless @ARGV == 3;
$textfile = $ARGV[0];
$fastafile = $ARGV[1];
$output = $ARGV[2];
open (TEXTFILE, $textfile) or die "Cannot find the file $textfile\n";
open (FASTA, $fastafile) or die "Cannot find the file $fastafile\n";
open (OUTPUT, ">$output");
@low_coverage = <TEXTFILE>;
#foreach $name(@low_coverage){
	#$name = join("", @low_coverage);
	#}
	#@names = split("",$names);	
#$count_contigs =~ tr/LF10/LF10/;
$/ = ">";
$i = 0;
while ($contig = <FASTA>) {
		chomp $contig;
		#$\ = ">";
		while ($i < 149403){
		  if($contig =~ m/"$low_coverage[$i]"/){
			print OUTPUT $contig;
			$i++;
		}
		}
		}
#$i = 0;
#shift @fasta;
#foreach $sequence(@fasta){
		#$sequence = join("", @fasta);
#		if ($sequence eq $low_coverage[$i]){
#			delete $fasta[$sequence];
#			next;
#		}else {
#		$i++;
#		}
#		}
		
#$length = scalar(@fasta);
#print $length, "\n";
#print $contigs, "\n";
#print $fasta[0], "\n";
#print $fasta[1], "\n";
#print $fasta[2], "\n";
close TEXTFILE;
close FASTA;
close OUTPUT;


exit;