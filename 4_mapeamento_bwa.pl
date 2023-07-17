#!/usr/bin/perl -w
use strict;

unless ($#ARGV==1) {print "uso: script <folder_file_fastq> <folder_run>\n"; exit;}
my $dir_input = $ARGV[0];
my $dir_output = $ARGV[1];
my $bwa_db1 = "/home/directory_reference_genome/sequences.fa";
print "input\:$dir_input\n";	
print "output\:$dir_output\n\n";	
#$count=0;  my $sfil = $ARGV[0];
############### reading files in input folder  ###############
opendir(DIR, $dir_input) or die $!;
my @files_fastq 
        = grep { 
            /^\./             # Begins with a period
	    || -f "$dir_input/$_"   # and is a file
} readdir(DIR);
closedir(DIR);

#####################  mapping   ##########################
my $path_bam = $dir_output."mapped_bwa";
########################################################################
### checking the output of bam
########################################################################

if ($path_bam =~ /^(.*)\/mapped_bwa$/){
    if (-e $path_bam) {
        print "The directory $path_bam already exists.\n";
    }else{
        mkdir $path_bam or die "Error creating directory: $1";
        print "******* Directory created ********\n";
    }
}else{
    die "invalid directory name: $path_bam";
}
########################################################################
my $fn_bam='';

print "starting mapping bwa\n";
foreach my $ffasq (@files_fastq) {
	if ($ffasq=~/(.*)\.fastq\.gztrimmed_\.fq\.gz$/){   # checking file name    
	#if ($ffasq=~/(.*)\.fq$/){   # checking file name
		$fn_bam = $1;
		print "\t*** $fn_bam\n";
		#print "\t*** $1\n";
		my $tmp_group ="\'\@RG\\tID:".$fn_bam."\\tSM:".$fn_bam."\\tLB:".$fn_bam."'";
		my $bwa1 ="bwa mem -R ".$tmp_group;
		my $view1 = "samtools view -b ";
		my $sort1 = "samtools sort --threads 4";
		my $outf_name1 = $path_bam."\/".$fn_bam.".bam";
		my $cmd_bwa1 = "$bwa1 $bwa_db1 $dir_input$ffasq \| $view1 \| $sort1 \> $outf_name1";
		print "$cmd_bwa1\n";
		system($cmd_bwa1);       
   }elsif ($ffasq=~/(.*)trimmed_\.fq\.gz$/){   # checking file name    
        #if ($ffasq=~/(.*)\.fq$/){   # checking file name
                $fn_bam = $1;
                print "\t*** $fn_bam\n";
                #print "\t*** $1\n";
                my $tmp_group ="\'\@RG\\tID:".$fn_bam."\\tSM:".$fn_bam."\\tLB:".$fn_bam."'";
                my $bwa1 ="bwa mem -R ".$tmp_group;
                my $view1 = "samtools view -b ";
                my $sort1 = "samtools sort --threads 4";
                my $outf_name1 = $path_bam."\/".$fn_bam.".bam";
                my $cmd_bwa1 = "$bwa1 $bwa_db1 $dir_input$ffasq \| $view1 \| $sort1 \> $outf_name1";
                print "$cmd_bwa1\n";
                system($cmd_bwa1);
   }





	$fn_bam='';
	
	
}

