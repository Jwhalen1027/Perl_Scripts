#!/opt/perl/bin/perl
use warnings;
#####Jeanne Whalen###
####input is gmap summary file and the uniq file#########
die "usage: <compare_gmap.pl>\n" unless @ARGV == 4;
$inputfile = $ARGV[0];
$inputfile2 = $ARGV[1];
$outputfile1 = $ARGV[2];
$outputfile2 = $ARGV[3];
open (GMAP, $inputfile) or die "Cannot find the GMAP Summary\n";

while ($line = <GMAP>) {
	 if ($line =~ />c\d+_g\d+_i\d+/) { #this is a new sequence with a name. 
	 	($name) = $line =~ />(c\d+_g\d+_i\d+)/;
	 	#print $name;
	 	#push (@names, $name);
	 }elsif ($line =~ /Paths \(\d+\):/) { #this line gives the number of paths
	 	($path) = $line =~ /Paths\s\((\d+)\):/;
	 	if ($path != 0){
			push (@hits, $name);
		}#elsif ($path == 0){
		#	push (@nohits, $name);
		#}
	}
}
#print @names, "\n";
print scalar(@hits), "\n";
#print scalar(@nohits), "\n";
close GMAP;

open (OUTPUT1, ">$outputfile1") or die "Cannot find the Output file\n";
foreach $ID(@hits){
	$upID = uc($ID);
	push (@uphits, $upID);
	}

open (INPUT2, $inputfile2) or die "Cannot find the second inputfile\n";
while ($secondline = <INPUT2>){
	chomp $secondline;
	$secondline =~ s/^\s+|\s+$//g;
	push (@input2hits, $secondline);
	}
#print scalar(@input2hits), "\n";

@gmap_array = (@uphits, @input2hits);
chomp @gmap_array;
#print scalar(@gmap_array), "\n"; #This equals 58588, but the hash only seems to get the ones that are in both. 
#where are those extra 4000?
#The problem now lies within the hash, everything above this line works as it should. Almost done!

use List::MoreUtils qw(uniq);
@unique = uniq @gmap_array;

foreach $element1(@unique){
 	print OUTPUT1 "$element1\n";
 	}
open (OUTPUT2, ">$outputfile2") or die "Cannot find the second inputfile\n";
%hash=();
foreach $element2(@gmap_array){
	next unless $hash{$element2}++;
	print OUTPUT2 "$element2\n";
}

#right now the two outputs are two textfiles. One with 32,036 hits, the other has 26,xxx hits. 


close INPUT2;
close OUTPUT1;
close OUTPUT2;
exit;

