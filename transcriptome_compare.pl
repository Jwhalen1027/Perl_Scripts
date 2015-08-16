#!/opt/perl/bin/perl
##Determine the overlap and unique sequences between two assemblies
use warnings;

die "usage: <Transcriptome_comparison.pl> Fasta1 Fasta2\n" unless @ARGV == 2;

$inputfile1 = $ARGV[0];
$inputfile2 = $ARGV[1];

open (FASTA1, $inputfile1);

%transcript_hash = ();
while  ($line = <FASTA1>){
	if ($line =~ /'>'/) {
		($contig) = $line =~ />(c\d+_g\d+_i\d+)|/;
		$transcript_hash{$contig} = 1;
		push (@fasta1_transcripts, $contig);
	}
}
close FASTA1;
open (FASTA2, $inputfile2);
$fasta1 = 0;
$fasta2 = 0;
$shared = 0;
%transcript_hash2 = ();
while ($sequence = <FASTA2>) {
	if ($sequence =~ /'>'/){
		($seqname) = $sequence =~ />(c\d+_g\d+_i\d+)|/;
		$transcript_hash2{$seqname} = 1;
		push (@fasta2_transcripts, $seqname);
		if (exists $transcript_hash{$seqname}){
			$shared++;
		}
	}
}
close FASTA2;
foreach $seq(@fasta1_transcripts){
	if (!exists $transcript_hash2{$seq}){
		$fasta1++;
	}
}

foreach $seq2(@fasta2_transcripts){
	if (!exists $transcript_hash{$seq2}){
		$fasta2++;
	}
}

print "Shared transcripts: $shared\n";
print "Unique to Fasta1: $fasta1\n";
print "Unique to Fasta2: $fasta2\n";



		