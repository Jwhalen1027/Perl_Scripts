#!/opt/perl/bin/perl
use warnings;
#####Jeanne F Whalen###
#####GObreakdown.pl####
####Takes the blast2go text file and breaks down processes, components and functions and gives the count for each#####
die "usage: <GObreakdown.pl>\n" unless @ARGV == 4;
$inputfile = $ARGV[0];
$outputfile1 = $ARGV[1]; #PROCESS results
$outputfile2 = $ARGV[2]; #FUNCTION results
$outputfile3 = $ARGV[3]; #COMPONENT results

open(REPORT, $inputfile) or die "Cannot find the Annotation Report\n";


#line by line search column w/ blast2go info, store the necessary information
$pro = 0;
$fun = 0;
$com = 0; 
$line_count = 0;
$blast2go = <REPORT>; #skip the header
while ($blast2go = <REPORT>){
	$line_count++;
	@blast_array = split('\t',$blast2go); 
	if ($blast_array[7] =~ /(.*)P(.+)/){ #Find all the process terms, for total count
		$pro++;
	}elsif ($blast_array[7] =~ /(.*)F:(.+)/){ #find all function terms
		$fun++;
	}elsif ($blast_array[7] =~ /(.*)C:(.+)/){ #find all the components
		$com++;
	@GOs = split(';', $blast_array[7]); #each line have multiple Processes/Functions/Components
	#print "@GOs\n";
	foreach $term(@GOs) {
		if ($term =~ /P:.+/){
			($process) = $term =~ /P:(.+)/;
 			push (@process_array, $process); #push the process to an array
			
		}elsif ($term =~ /F:.+/){
			($function) = $term =~ /F:(.+)/; #push function to array
			push (@function_array, $function);
		}elsif ($term =~ /C:.+/){
			($component) = $term =~ /C:(.+)/; #push component to array
			push (@component_array, $component);
		}
 	}
}
open(PROCESS, ">$outputfile1");
open(FUNCTION, ">$outputfile2");
open(COMPONENT, ">outputfile3");
##Create a hash for each of the 3 types of Gene Ontology terms
##If the specific term isn't in the hash yet, add the term and set the count to zero
##If it already is in the hash, increase the value by one (count for each term)
%process_hash = ();
foreach $element(@process_array){
	if (exists $process_hash{$element}){
		$process_hash{$element}++;
	}else{
	$process_hash{$element} = 1; 
	}
}

%function_hash = ();
foreach $element(@function_array){
	if (exists $function_hash{$element}){
		$function_hash{$element}++;
	}else{
	$function_hash{$element} = 1;
	}
}

%component_hash = ();
foreach $element(@component_array){
	if (exists $component_hash{$element}){
		$component_hash{$element}++;
	}else{
	$component_hash{$element} = 1;
	}
}
#Sort the hashes based on value (highest to lowest)
#then prints the tab delimited files to the output files
sub processhashdescending {
	$process_hash{$b} <=> $process_hash{$a};
	}
foreach $element (sort processhashdescending (keys(%process_hash))){
	print PROCESS "\t$process_hash{$element} \t $element\n";
}	
sub functionhashdescending {
	$function_hash{$b} <=> $function_hash{$a};
	}
foreach $element (sort functionhashdescending (keys(%function_hash))){
	print FUNCTION "\t$function_hash{$element} \t $element\n";
}	

sub componenthashdescending {
	$component_hash{$b} <=> $function_hash{$a};
	}
foreach $element (sort componenthashdescending (keys(%component_hash))){
	print COMPONENT "\t$component_hash{$element} \t $element\n";
}

print "$line_count\n";
print "$pro\n";
print "$fun\n";
print "$com\n";
close REPORT;
close PROCESS;
close FUNCTION;
close COMPONENT;

			
			

