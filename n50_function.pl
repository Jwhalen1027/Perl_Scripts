#!/opt/perl/bin/perl
use warnings;
#function of N50


N_statistic(25, $total_size, \@contig_length) #the backslash will reference back to an array 
sub N_statistic {

my ($cutoff, $total, $contig_length_ref) = @_;
my $i = 0;
my $sum = 0;

while ($sum < $total_size * $cutoff/100){
		$sum += $$contig_length_ref[$i];	#double $$ because you are pointing back to the array and then using the array at that index. (I don't know, check the course notes)
		$i++;
	}
$N_cutoff = $contig_length_ref[$i-1];
print "The N$cutoff is: $N_cutoff\n";
}