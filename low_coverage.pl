#!/opt/perl/bin/perl
use warnings;

die "usage: <coverage_filter.pl>\n" unless @ARGV == 3;
$textfile = $ARGV[0];
$fastafile = $ARGV[1];
$outputfile = $ARGV[2];



%Coverage_filter = ();
open(TEXTFILE, $textfile) or die "Cannot find the file $textfile\n";


$coverage = <TEXTFILE>; #skip the header row
while ($coverage = <TEXTFILE>) {
	chomp $coverage;
	@coverage_array = split('\t', $coverage);
	@contig_name_parts = split(' ', $coverage_array[0]);
	$contig_name = ">".$contig_name_parts[0] . "_" . $contig_name_parts[1]; #adds the > so I didn't have to change anything using Linux.
	$Coverage_filter{$contig_name} = $coverage_array[5];
}

#print "$_ $Coverage_filter{$_}\n" for (keys %Coverage_filter);
close TEXTFILE;



#use $InWriteContig to keep track of if we are in a contig that needs to be written back out
$InWriteContig = 0; #set index thing to 0. 
open (FASTA, $fastafile) or die "Cannot find the file $fastafile\n";
open (OUTPUT, ">$outputfile") or die "Cannot open output file $outputfile\n";
while ($line = <FASTA>) { #read through the Fasta file line by line
	chomp $line; #gets rid of the new line \n so the sequence will stick with the contig name
	if ($line =~ />/) { #Check for headers. Every time we reach a > it is a new contig
		$InWriteContig = 0; #if the line is a header, keep the index at 0
		if (exists $Coverage_filter{$line} && $Coverage_filter{$line} >= 10) { #BUT if the line exists in the hash, and the coverage is greater
			#than or equal to 10, then I want to write this line to the output file so set the index for that contig to 1
			$InWriteContig = 1;
		}
	}

	if ($InWriteContig == 1) { 
		print OUTPUT "$line\n"; #for all the contigs that have the index = 1, it will be printed to the output file. 	
	}
}

close OUTPUT;
close FASTA;

