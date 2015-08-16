#!/opt/perl/bin/perl
use warnings;
#a program to filter out low-coverage contigs from a text file

die "usage: <low_coverage_filter.pl>\n" unless @ARGV == 2;
$textfile = $ARGV[0];
$fastafile = $ARGV[1];
open (TEXTFILE, $textfile) or die "Cannot find the file $textfile\n";
open (FASTA, $fastafile) or die "Cannot find the file $fastafile\n";

@low_coverage = <TEXTFILE>;
#print $low_coverage[0];

$i = 0;
$j = 0;

$/ = ">"
First sequence will be empty, just get rid of tha later on. This is called the record separator.
#while ($contig = <FASTA>) {
#	if ($contig =~ />/){ #This is a contig header
#		if ($contig ne $low_coverage[$i]){ #if the fasta file contig name matches a contaminant name
#				push (@fasta, $contig); #add the name and following sequence to an array
#				$i++;
#				}else {
#				$i++
#				next;
#				}
#	}else { #this is a sequence. How do I store this with the appropriate name?
#	}
#	}
#somehow I want to reset the loop whenever the line starts with '>'
#Regarding the $low_coverage[$i] Everything will still be stored in the array @fasta because
#no contig name will match all the low_coverage names. How do I fix this idea?

#This might be much better!!!!	
#@fasta = <FASTA>;	
#foreach $sequence(@fasta) {
#	if ($sequence =~ />/){ #This is a contig header
#		$sequence = $contig
#		if ($sequence eq $low_coverage[$i]){ #if the fasta file contig name matches a contaminant name
#				pop (@fasta, $sequence); #ta
#				$i++;
#				}else {
#				$i++
#				next;
#				}
#	}else { #this is a sequence. How do I store this with the appropriate name/delete it all if the header is a contaminant match?
#	}
#	}




#store the contig names in a hash the name is the $key and the value is 1 
#if (exists $hash{


#foreach 
#if name from textfile eq name in fasta file
#	delete the name and the sequence that follows

#print @low_coverage;
#print @sorted_low_coverage;


#open (<LF10g_v1.35.fa>);

#I could do this the really hard way by looping with every single 





exit;
