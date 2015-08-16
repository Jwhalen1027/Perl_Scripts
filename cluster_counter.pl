#!/opt/perl/bin/perl
use warnings;
#######THE JEANNE#######
######A PROGRAM CAPTAIN AMERICA WOULD BE PROUD OF##################
######NO BUT REALLY IT'S JUST FINDING LIBRARIES THAT DIDN'T CLUSTER#######

die "usage: <cluster_counter.pl>\n" unless @ARGV == 2;
$inputfile = $ARGV[0];
$outputfile = $ARGV[1];

open (INPUT, $inputfile) or die "Cannot find the input file\n";
open (OUTPUT, ">$outputfile") or die "Cannot find the outputfile\n";

$line = <INPUT>;
while ($line = <INPUT>) {
	@cluster_line = split('\t', $line);
	if ($cluster_line[0] =~ /C/ and $cluster_line[2] == 1) { ####we have a non-cluster sequence!
		push(@not_clustered, $cluster_line[8]);
	}
}

print OUTPUT "@not_clustered\n";

close INPUT;
close OUTPUT;
exit;
