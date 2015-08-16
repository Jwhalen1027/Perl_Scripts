#!/opt/perl/bin/perl
use warnings;
#a program to filter out low-coverage contigs from a text file

die "usage: <coverage_filter.pl>\n" unless @ARGV == 3;
$textfile = $ARGV[0];
$fastafile = $ARGV[1];
$output = $ARGV[2];
open (TEXTFILE, $textfile) or die "Cannot find the file $textfile\n";

while ($coverage = <TEXTFILE>){
		#chomp $coverage;
		@coverage_array = split("\t", $coverage);
		shift @coverage_array;
		$names = $coverage_array[0];
		$values = $coverage_array[-1];
		push(@contig_names, $names);
		push (@coverage_values, $values);
		} 
		%Coverage_filter = ();
		$Coverage_filter{$contig_names} = $coverage_values;
		#This way could have worked if you used the map tool. Look this up. 
		#@contig_names = keys %Coverage_filter;
		#@coverage_values = values %Coverage_filter;
		#$Coverage_filter{@contig_names} = $coverage_values;
		

close TEXTFILE;
print %Coverage_filter, "\n";
#print keys %Coverage_filter, "\n";		
		
#print @contig_names, "\n";		
#print @coverage_array, "\n";
#print $coverage_array[0], "\n";
#print $coverage_array[-1], "\n";
#print $coverage_values[2];
#$array_length = scalar(@contig_names);
open (FASTA, $fastafile) or die "Cannot find the file $fastafile\n";
open (OUTPUT, ">$output");
while ($line = <FASTA>){
	if ($line =~ />/) { #found a header!!
		$name = $line; 
		if (exists $Coverage_filter{$contig_names} && $Coverage_filter{$contig_names} >= 10){
		print OUTPUT $name;
		}
	}
}

close FASTA;
close OUTPUT;









exit;