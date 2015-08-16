#!/opt/perl/bin/perl
use warnings;
#Find Interpro's with no matches

die "usage: <interpro_match.pl>\n" unless @ARGV == 2;
$table = $ARGV[0];
$outputfile = $ARGV[1];

open(TABLE, $table) or die "Unable to find the file $table\n";

$line = <TABLE>;
while ($line = <TABLE>) {
	chomp $line;
	@sequence = split('\t',$line);
	#@interpro1 = split('',$sequence[31]);
	#@interpro2 = split('',$seqeunce[32]);
	#@interpro3 = split('',$sequence[33]);
	if ($sequence[31] =~ m/N\/A/ and $sequence[32] =~ m/N\/A/ and $sequence[33] =~ m/N\/A/){
		if ($sequence[0] =~ /c\d*_g\d_i\d/){
			($contig_name) = $sequence[0] =~ /(c\d*_g\d_i\d)/; 
			$contig = $contig_name.".fa";
			push(@no_matches, $contig);
		}
	}
}
foreach $seq(@no_matches){
	system("find */ -name $seq | cp * 'again/'")
	}

#print $sequence 
print scalar(@no_matches);	
close(TABLE);
open(OUTPUT,">$outputfile");
print OUTPUT "@no_matches\n";
close OUTPUT;

exit;