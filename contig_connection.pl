#!/opt/perl/bin/perl
use warnings; use strict;

die "usage: <Genome_assembly_coverage_filter.pl>\n" unless @ARGV == 3;
my $inputfile1 = $ARGV[0];
my $inputfile2 = $ARGV[1];
my $output = $ARGV[2];

open (FILE1, $inputfile1) or die "Cannot open the file $inputfile1:$!\n";
open (FILE2, $inputfile2) or die "Cannot open the file $inputfile2:$!\n";
open (OUT, ">$output") or die "Cannot open the file $output to write to :$!\n";

my $genome = '';
my $pseudo_scaffold = '';
my $strand = '';
my $name = '';
my $seq = '';
my $scaffold_number = '';

while (<FILE2>) {
	$genome .= $_;
	}
$genome .= '>';

while (<FILE1>) {
	if ($_ =~ /^>/) {
		if ($pseudo_scaffold) {
		print OUT ">pseudo$scaffold_number\n$pseudo_scaffold";
		}
		($scaffold_number) = $_ =~ />(scaffold_\d+)\s/;
		print "$scaffold_number starts\n";
		$pseudo_scaffold = '';
		} else {
			($strand) = $_ =~ /\t([\+\-])\t/;
			($name) = $_ =~/\t(SL9_contig\d+)$/;
			if ($strand =~ /\+/){
			($seq) = $genome =~ />$name\n(.*?)>/s;
			$seq .= "NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN";
			$pseudo_scaffold .= $seq;
			} else {
			($seq) = $genome =~ />$name\n(.*?)>/s;
			$seq = reverse ($seq);
			$seq =~ tr/ATGCatgc/TACGtacg/;
			$seq .= "NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN";
			$pseudo_scaffold .= $seq;
			}
		}
	}
	
print OUT ">pseudo_scaffold_number\n$pseudo_scaffold";
close FILE1;
close FILE2;
close OUT;