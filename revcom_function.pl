#!/opt/perl/bin/perl
use strict; use warnings;
#define reverse complement function

my $sequence = $ARGV[0];
print rev_com($sequence), "\n";
print "this is the original sequence: $sequence\n";

sub rev_com {
my ($sequence) = @_;
my $rev_com = reverse $sequence;
$rev_com =~ tr/ATGCatgc/TACGtacg/;
return $rev_com;
}


#regular variables are called Global variables
#if you use 'my' then it is a local variable. That variable is only accessible in the subroutine
#sequence in line 7 is different than all the $sequence 's in the subroutine