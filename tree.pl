# read .sh until .pl
open(FILE,">","tree.log");
while<STDIN>{
	my $if_deep;
	chomp;
	next unless $_;
	my @mark = split /\s+/,$_;
	my $sh_name;
	foreach my $x (@mark){
		$if_deep = 1 if($x =~ /\.sh$/);
		$sh_name = $x;
	}
	&deepin(FILE,$x) if($if_deep);
}
sub deepin {
	my $file = shift;
	my $ref = shift;
	my $xt = shift;
	if(ref $ref eq "SCALAR"){
		open(FILE,"<",$ref) or die "can't open $ref $@";
		while(<FILE>){
			chomp;
			next unless $_;
			my @mark = split /\s+/,$_; 
			if($mark[0] = "sh"){
				print $file "\t" x $xt,$ref,"\n";
				&deepin($file,$mark[1],$xt++);
				
			}elsif($mark[0] eq "perl"){
				print $file "\t" x $xt,$mark[1],"\n";

			}

		}
	}
}
