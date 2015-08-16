#!/opt/perl/bin/perl
use warnings;
#####Jeanne Whalen###
####Takes the interpro raw file and breaks returns the top 10 Pfam domains and their count#####
die "usage: <Pfam_counter.pl>\n" unless @ARGV == 2;
$interpro = $ARGV[0];
$outputfile = $ARGV[1];


open(INTERPRO, $interpro) or die "Cannot find the Annotation Report\n";


#first part will deal with the Process components. 
#line by line I want to search column 
while ($line = <INTERPRO>){
	@interpro_array = split('\t',$line); 
	push(@pfam_array, $interpro_array[4]);
}

open(PFAM_COUNT, ">$outputfile");
%pfam_hash = ();
foreach $element(@pfam_array){
	if (exists $pfam_hash{$element}){
 		$pfam_hash{$element}++;
 	}else{
 		$pfam_hash{$element} = 1;
 	}
}

# #This next part sorts the hash based on value (highest to lowest)
# #then prints the tab delimited files to the output files
sub pfamhashdescending {
	$pfam_hash{$b} <=> $pfam_hash{$a};
}
foreach $element (sort pfamhashdescending (keys(%pfam_hash))){
	print PFAM_COUNT "\t$pfam_hash{$element} \t $element\n";
}	

# # @process_keys = (sort {$process_hash{$b} <=> $process_hash{$a}} keys %process_hash);
# # #print @process_keys;
# # @process_values = (sort {$process_hash{$b} <=> $process_hash{$a}} values %process_hash);
# # print @process_values;
# #open(PROCESS, ">$outputfile1");
# #print PROCESS %process_hash, '\n';

close INTERPRO;
close PFAM_COUNT;
