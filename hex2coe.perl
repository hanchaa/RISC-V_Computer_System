#!/usr/bin/perl

open (FH, "<test.hex") or die "ooops: $!";
$lcount = 0;
while(<FH>) {
	$lcount++;
}
print $lcount;
close(FH);

open(FH, "<test.hex") or die "ooops: $!";

$file = 'mem_init.coe';
open(MEM, ">$file");
print MEM "memory_initialization_radix=16;\n";
print MEM "memory_initialization_vector=\n";

$count = 0;
while(<FH>) {
	chomp;
	printf MEM "$_";

	if($count==$lcount) {
		printf MEM ";";
	}
	else {
		printf MEM ",\n";
	}
}
close(MEM);
close(FH);
