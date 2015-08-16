#!/opt/perl/bin/perl
use warnings;

die "usage: <highfreq_SNPs_counter.pl>\n" unless @ARGV == 1;
$textfile = $ARGV[0];


open(TEXTFILE, $textfile) or die "Cannot find the file $textfile\n";

$count1 = 0;
$count2 = 0;
$count3 = 0;
$count4 = 0;
$count5 = 0;
$count6 = 0;
$count7 = 0;
$count8 = 0;
$count9 = 0;
$count10 = 0;
$count11 = 0;
$count12 = 0;
$count13 = 0;
$count14 = 0;
$frequencies = <TEXTFILE>; #skip the header row
while ($frequencies = <TEXTFILE>) {
	chomp $frequencies;
	@frequency_array = split('\t', $frequencies);
	if ($frequency_array[8] =~ /\d+\/\d+/){
	next;
	} elsif ($frequency_array[0] eq "SL9_pseudoscaffold_1" and $frequency_array[8] >= 95) {
	$count1++;
	} elsif ($frequency_array[0] eq "SL9_pseudoscaffold_2" and $frequency_array[8] >= 95) {
	$count2++;
	} elsif ($frequency_array[0] eq "SL9_pseudoscaffold_3" and $frequency_array[8] >= 95) {
	$count3++;
	} elsif ($frequency_array[0] eq "SL9_pseudoscaffold_4" and $frequency_array[8] >= 95) {
	$count4++;
	} elsif ($frequency_array[0] eq "SL9_pseudoscaffold_5" and $frequency_array[8] >= 95) {
	$count5++;
	} elsif ($frequency_array[0] eq "SL9_pseudoscaffold_6" and $frequency_array[8] >= 95) {
	$count6++;
	} elsif ($frequency_array[0] eq "SL9_pseudoscaffold_7" and $frequency_array[8] >= 95) {
	$count7++;
	} elsif ($frequency_array[0] eq "SL9_pseudoscaffold_8" and $frequency_array[8] >= 95) {
	$count8++;
	} elsif ($frequency_array[0] eq "SL9_pseudoscaffold_9" and $frequency_array[8] >= 95) {
	$count9++;
	} elsif ($frequency_array[0] eq "SL9_pseudoscaffold_10" and $frequency_array[8] >= 95) {
	$count10++;
	} elsif ($frequency_array[0] eq "SL9_pseudoscaffold_11" and $frequency_array[8] >= 95) {
	$count11++;
	} elsif ($frequency_array[0] eq "SL9_pseudoscaffold_12" and $frequency_array[8] >= 95) {
	$count12++;
	} elsif ($frequency_array[0] eq "SL9_pseudoscaffold_13" and $frequency_array[8] >= 95) {
	$count13++;
	} elsif ($frequency_array[0] eq "SL9_pseudoscaffold_14" and $frequency_array[8] >= 95) {
	$count14++;
	} 
}
close TEXTFILE;
print "High frequency SNPs in Pseudoscaffold 1: ", $count1, "\n";
print "High frequency SNPs in Pseudoscaffold 2: ", $count2, "\n";
print "High frequency SNPs in Pseudoscaffold 3: ", $count3, "\n";
print "High frequency SNPs in Pseudoscaffold 4: ", $count4, "\n";
print "High frequency SNPs in Pseudoscaffold 5: ", $count5, "\n";
print "High frequency SNPs in Pseudoscaffold 6: ", $count6, "\n";
print "High frequency SNPs in Pseudoscaffold 7: ", $count7, "\n";
print "High frequency SNPs in Pseudoscaffold 8: ", $count8, "\n";
print "High frequency SNPs in Pseudoscaffold 9: ", $count9, "\n";
print "High frequency SNPs in Pseudoscaffold 10: ", $count10, "\n";
print "High frequency SNPs in Pseudoscaffold 11: ", $count11, "\n";
print "High frequency SNPs in Pseudoscaffold 12: ", $count12, "\n";
print "High frequency SNPs in Pseudoscaffold 13: ", $count13, "\n";
print "High frequency SNPs in Pseudoscaffold 14: ", $count14, "\n";
exit;