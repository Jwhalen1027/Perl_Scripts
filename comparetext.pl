#!/opt/perl/bin/perl
use warnings;
use strict;
#####Jeanne Whalen###
####input is gmap summary file and the uniq file#########


my $file1 = "mylist.txt";
my $file2 = "otherlist.txt";
my $OUTPUT = "final_result.txt";
my %results = (); 
open FILE1, "$file1" or die "Could not open $file1 \n";
   while(my $matchLine = <FILE1>)
       {   
         $results{$matchLine} = 1;
    }
    close(FILE1); 
    open FILE2, "$file2" or die "Could not open $file2 \n";
   while(my $matchLine =<FILE2>) 
        {  
    $results{$matchLine} = 2 if $results{$matchLine}; #Only when already found in file1
        }
    close(FILE2);  
    open (OUTPUT, ">$OUTPUT") or die "Cannot open $OUTPUT \n";
    foreach my $matchLine (keys %results) { 
    print OUTPUT $matchLine if $results{$matchLine} ne 1;
    }
    close OUTPUT;