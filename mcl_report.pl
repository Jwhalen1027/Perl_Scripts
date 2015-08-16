#!/opt/perl/bin/perl
use warnings;
#MCL report

die "usage: <mcl_report.pl>\n" unless @ARGV == 2;
$table = $ARGV[0];
$output1 = $ARGV[1];
#$output2 = $ARGV[2];
#$output3 = $ARGV[3];
#$output4 = $ARGV[4];

open(TABLE, $table) or die "Unable to find the file $table\n";
open(OUTPUT1, ">$output1");
#open(OUTPUT2, ">$output2");
#open(OUTPUT3, ">$output3");
#open(OUTPUT4, ">$output4");

$line = <TABLE>;
$count = 0;
while ($line = <TABLE>){
	$count++;
	@gene_info = split('\t', $line);
	if ($gene_info[12] == 11) { #$gene_info[10] is the number of genomes that have genes in this family
		push (@gene_family, $gene_info[0]);
	}elsif (($gene_info[12] == 1) and ($gene_info[10] != 0)) { #gene_info[10] is the pongamia column
		 push (@walnut_genes, $gene_info[0]);
		 push (@walnut_descriptions, $gene_info[13]);
		 push (@walnut_counts, $gene_info[10]);
	}elsif (($gene_info[12] == 9) and ($gene_info[10] == 0)) { #number of genomes = 9 and none in walnut
		 push (@not_walnut, $gene_info[13]);
		 push (@not_walnut_counts, $gene_info[10]);
	}
}
print "There are ", scalar(@gene_family), " gene families conserved across 11 genomes\n";
print "There are ", scalar(@walnut_genes), " gene families unique to pongamia\n";
print "There are ", scalar(@not_walnut), " gene families conserved across 9 genomes\n";
print $count, "\n";
print OUTPUT1 "@walnut_descriptions\n";
#print OUTPUT2 "@walnut_counts\n";
#print OUTPUT3 "@not_walnut\n";
#print OUTPUT4 "@not_walnut_counts\n";
#close TABLE;
exit;
