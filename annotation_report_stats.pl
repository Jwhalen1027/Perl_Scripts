#!/opt/perl/bin/perl
use warnings;
#Combined Annotation Report Statistics

die "usage: <annotation_statistics.pl>\n" unless @ARGV == 1;
$table = $ARGV[0];

open(TABLE, $table) or die "Unable to find the file $table\n";

$line = <TABLE>;
$no_interpro = 0;
$contigs = 0;
$no_blast = 0;
$nothing = 0;
while ($line = <TABLE>) {
	chomp $line;
	$contigs++;
	@data = split('\t',$line);
	if ($data[14] =~ m/N\/A/ and $data[15] =~ m/N\/A/ and $data[16] =~ m/N\/A/){
		$no_interpro++;
	}
	if ($data[17] =~ m/\s/ and $data[18] =~ m/\s/ and $data[19] =~ m/\s/){
		$no_blast++;
	}
	if ($data[14] =~ m/N\/A/ and $data[15] =~ m/N\/A/ and $data[16] =~ m/N\/A/ and $data[17] =~ m/\s/ and $data[18] =~ m/\s/ and $data[19] =~ m/\s/){
		$nothing++;
	}
}


$no_interpro_percent = ($no_interpro/$contigs) * 100;
$no_blast_percent = ($no_blast/$contigs) * 100;
if ($nothing != 0) {
	$nothing_percent = ($nothing/$contigs) * 100;
	print "The percentage of contigs with no InterPro or Blast hits is: ", "$nothing_percent", "\n";
}elsif ($nothing == 0) {
	print "All the contigs had some information", "\n";
}

print "The percentage of contigs with no InterPro hits is: ", "$no_interpro_percent", "%", "\n";
print "The percentage of contigs with no Blast hits is: ", "$no_blast_percent", "%", "\n";
print "There were $contigs contigs queried\n";
#print $sequence 	
close(TABLE);

exit;