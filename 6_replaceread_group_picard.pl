#!/usr/bin/perl -w
use strict;

unless ($#ARGV==1) {print "uso: script <folder_file> <folder_run>\n"; exit;}
my $dir_picard = $ARGV[0];
my $dir_output = $ARGV[1];

print "input\:$dir_picard\n";	
print "output\:$dir_output\n\n";	

#~ #####################################################################
#~ #####################  picard marcar duplicados   ###################
#~ #####################  AddOrReplaceReadGroups         ##############		
#~ ########################################################################

#~ #####################################################################
my $fn_picard2='';
print "iniciando picard adicionando grupos\n";
my $prg_picard="~/programas/anaconda2/bin/picard";
foreach my $fpic (@files_pic) {
	if ($fpic=~/(.*)\-sorted\-md\.bam$/){   # verificando o nome de arquivo
		$fn_picard2 = $1;
		print "\t*** $fn_picard2\n";
		my $cpic =$prg_picard." AddOrReplaceReadGroups";
		my $Ip="I=".$dir_picard.$fpic;
		my $Op="O=".$path_picard_grupos."/".$fn_picard2."_sorted_rg.bam";
		my $rgid="RGID=".$fn_picard2;
		my $rglb ="RGLB=".$fn_picard2;
		my $rgsm ="RGSM=".$fn_picard2;
		my $rgpl = "RGPL=illumina RGPU=unit1";
		my $cmd_picard = "$cpic $Ip $Op $rgid $rglb $rgsm $rgpl";
		print "$cmd_picard\n";
		system($cmd_picard);
                my $cmd_index = "samtools index ".$path_picard_grupos."/".$fn_picard2."_sorted_rg.bam";
		print "\n$cmd_index\n";
		system($cmd_index);
   }
	$fn_picard2='';
}

exit 0;
