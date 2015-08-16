#!/opt/perl/bin/perl
use warnings;
# -------Jeanne Whalen homework 5

die "usage: <assembly_info.pl>\n" unless @ARGV == 1;
$filename1 = $ARGV[0];

open (FASTA1, $filename1) or die "Cannot find the file $filename1\n";

 
$contig_count = 0;
$nuc_count = 0;
$contig_length = 0;
$A_count = 0;
$C_count = 0;
$G_count = 0;
$T_count = 0;
$N_count = 0;

while ($line = <FASTA1>) {
	 if ($line =~ />/){ 
	 $contig_count++; #Found a header! 
	 push (@contigs, $contig_length);
	 $contig_length = 0;
	 next; 
	 } else { #Not a header- this is the contig
	 chomp($line);
	 $nuc_count = length($line) + $nuc_count; #a running total of all nucleotides in the file
	 $contig_length = length($line) + $contig_length; #resets every time a header is reached
	 $A_count = $A_count + $line =~ tr/A/A/;
	 $C_count = $C_count + $line =~ tr/C/C/;
	 $G_count = $G_count + $line =~ tr/G/G/;
	 $T_count = $T_count + $line =~ tr/T/T/;
	 $N_count = $N_count + $line =~ tr/N/N/;
	 }
	 }
	 push (@contigs, $contig_length);
	
@sorted_contigs = sort {$a<=>$b } @contigs;
shift @sorted_contigs;
$minimum = $sorted_contigs[0];
$maximum = $sorted_contigs[-1];
#for the mean, I want to add up every value in the array @sorted_contigs, and divide by the number of contigs ($contig_count)
#every value added will just be the total number of nucleotides!
$mean = ($nuc_count)/($contig_count);
$contig_scalar = scalar(@sorted_contigs);
	if ($contig_scalar % 2 == 0) {
		$location1 = (($contig_scalar/2));
		$location2 = $location1 - 1;
		$median = ($sorted_contigs[$location1] + $sorted_contigs[$location2])/2;
	}else {
		$location = ((($contig_scalar/2)+0.5)-1);
		$median = $sorted_contigs[$location];
	}	

@reverse_sorted_contigs = sort {$b<=>$a} @sorted_contigs;
$i = 0;
$j = 0;
$k = 0;
$sum = 0;
$sum25 = 0;
$sum75 = 0;
$N50_length = $nuc_count/2;
$N75_length = $nuc_count * 0.75;
$N25_length = $nuc_count * 0.25;
while ($sum < $N50_length){
		$sum = $reverse_sorted_contigs[$i] + $sum;	
		$i++;
	}
$N50 = $reverse_sorted_contigs[$i-1];


while ($sum75 < $N75_length){
		$sum75 = $reverse_sorted_contigs[$j] + $sum75;	
		$j++;
	}
$N75 = $reverse_sorted_contigs[$j-1];

while ($sum25 < $N25_length){
		$sum25 = $reverse_sorted_contigs[$k] + $sum25;	
		$k++;
	}
$N25 = $reverse_sorted_contigs[$k-1];

print "Number of contigs: ", $contig_count, "\n";
print "Number of nucleotides: ", $nuc_count, "\n";
$GC = $G_count + $C_count;
$PercentGC = ($GC/$nuc_count)*100;
#print "@sorted_contigs", "\n";
#store contig lengths into an array when you reach a new header. 
#print "You have this many A's:",$A_count, "\n";
#print "You have this many C's:",$C_count, "\n";
#print "You have this many G's:",$G_count, "\n";
#print "You have this many T's:",$T_count, "\n";
print "You have this many unknown nucleotides:",$N_count, "\n";
print "The minimum contig length is ",$minimum, "\n";
print "The maximum contig length is ", $maximum, "\n";
print "The average contig length is ", $mean, "\n";
print "The median contig length is ", $median, "\n";
print "N25: ", $N25, "\n";
print "N50: ", $N50, "\n";
print "N75: ", $N75, "\n";
print "%GC: ", $PercentGC, "%", "\n";
#print $N75_length, "\n";
#print $N25_length, "\n";
#print $contig_scalar, "\n";
#count the number of contigs
#count the number of bases
#count the number of each individual base
#min, max, mean, median
#N50
close FASTA1;
exit;
