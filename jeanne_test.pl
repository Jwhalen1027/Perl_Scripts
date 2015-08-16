#!/opt/perl/bin/perl
use warnings;

die "usage: <coverage_filter.pl>\n" unless @ARGV == 3;
$textfile = $ARGV[0];
$fastafile = $ARGV[1];
$outputfile = $ARGV[2];

%Coverage_filter = ();
open(TEXTFILE, $textfile) or die "Cannot find the file $textfile\n";

###################################
# Skip the header row
###################################
$coverage = <TEXTFILE>;
while ($coverage = <TEXTFILE>) {
	chomp $coverage;
	@coverage_array = split('\t', $coverage);
	@contig_name_parts = split(' ', $coverage_array[0]);
#####################################
#  Just a little cheat on the contig name - to prepend it with >, since this
#  is what the contig names are prepended with in the file we will search for
#####################################
	$contig_name = ">".$contig_name_parts[0] . "_" . $contig_name_parts[1];
#	push(@contig_names, $contig_name);
#	push(@coverage_values, $coverage_array[5]);

	$Coverage_filter{$contig_name} = $coverage_array[5];
}
#####################################
#  Test to print out hash contents
#####################################
#print "$_ $Coverage_filter{$_}\n" for (keys %Coverage_filter);
close TEXTFILE;


####################################
#  We will use $InWriteContig to keep track of if we are in a contig that needs to be written back out
####################################
$InWriteContig = 0;
open (FASTA, $fastafile) or die "Cannot find the file $fastafile\n";
open (OUTPUT, ">$outputfile") or die "Cannot open output file $outputfile\n";
while ($line = <FASTA>) {
	chomp $line;
####################################
#  Check to see if we hit a header line
####################################
	if ($line =~ />/) { 
		$InWriteContig = 0;
		if (exists $Coverage_filter{$line} && $Coverage_filter{$line} >= 10) {
			$InWriteContig = 1;
		}
	}

	if ($InWriteContig == 1) {
		print OUTPUT "$line\n";	
	}
}

close OUTPUT;
close FASTA;

