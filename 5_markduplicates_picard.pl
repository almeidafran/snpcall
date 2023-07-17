#!/usr/bin/perl -w
use strict;

unless ($#ARGV==1) {print "uso: script <folder_files> <folder_run>\n"; exit;}
my $dir_bam = $ARGV[0];
my $dir_output = $ARGV[1];

print "input\:$dir_bam\n";	
print "output\:$dir_output\n\n";	

#~ #####################################################################
#~ #####################  picard    ###################
#~ ##################### 	Mark duplicates			
#~ ########################################################################
#~ ############### reading files in bam folder ###############

opendir(DIR2, $dir_bam) or die $!;
my @files_bam 
        = grep { 
            /^\./             # Begins with a period
	    || -f "$dir_bam/$_"   # and is a file
} readdir(DIR2);
closedir(DIR2);

my $path_picard = $dir_output."picard";
#~ #####################################################################
#~ ### checking picard output directory
#~ #####################################################################

if ($path_picard =~ /^(.*)\/picard$/){
    if (-e $path_picard) {
        print "Directory $path_picard already exist.\n";
    }else{
        mkdir $path_picard or die "Error creating directory: $1";
        print "******* Directory created ********\n";
    }
}else{
    die "invalid directory name: $path_picard";
}
#~ #####################################################################
my $fn_picard='';
print "ichecking file name bwa\n";
my $prg_picard ="~/programas/anaconda2/bin/picard";
foreach my $fbam (@files_bam) {
	if ($fbam=~/(.*)\.bam$/){   # checking file name
		$fn_picard = $1;
		print "\t*** $fn_picard\n";
		my $cpic =$prg_picard." MarkDuplicates";
		my $Ip="I=".$dir_bam.$fbam;
		my $Op="O=".$path_picard."/".$fn_picard."-sorted-md.bam";
		my $Mp="M=".$path_picard."/".$fn_picard."-md-metrics.txt";
		my $cmd_picard = "$cpic $Ip $Op $Mp";
		print "$cmd_picard\n";
		system($cmd_picard);       
   }
	$fn_picard='';
}


