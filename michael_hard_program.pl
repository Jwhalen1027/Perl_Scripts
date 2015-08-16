#/bin/perl
##JW
use warnings; 
die "usage: <michael.pl>\n" unless @ARGV == 3;
$inputfile = $ARGV[0]; #.fna
$inputfile2 = $ARGV[1]; #otu.txt
$outputfile = $ARGV[2];


open(INPUT1, $inputfile);
open(INPUT2, $inputfile2);
open(OUTPUT, ">$outputfile");

$/ = '>';
%hash = ();

while ($line1 = <INPUT1>) { #while .fna 
	chomp $line1; 
	push (@all, $line1);
}

print OUTPUT "@all\n";
foreach $seq_and_id(@all){
	($otu_name) = $seq_and_id =~ /(\d*_\d*)/;
	print $otu_name;
}

	
	
	
	
	
	
	
	# if ($line1 =~ />\d*_\d*/) {
# 		($otu_name) = $line1 =~ />(\d*_\d*)/;
# 	}elsif ($line1 =~ /\d*_\d*/) {
# 		($otu_name) = $line1 =~ /(\d*_\d*)/;
# 	}
# 	push(@names, $otu_name);
# 		#push (@id_and_seq, $line1); #array of id and sequence together. 
# 		#push (@names, $otu_name);	
# 		$hash{$otu_name} = $line1; 
# }
# print scalar(@names);
# 
# #print values %hash;
# #print "$id_and_seq[1]\n";
# 
$i = 1;
while ($line2 = <INPUT2>) {
	$name = $line2[0];
	print $name, "\n";
	if ($line2[1] =~ m//) {
		next;
	} else {
	($otu_id) = $line2[$i] =~ /(\d+_\d+)/;
		if (exists $hash{$otu_id}) {
			#print values %hash;
		}
	$i++;
	}
}
	


exit;