#!perl
bin(78);
&tree; sub'huff;
&tree; sub'bin {
	$- = $&;
	map { $- += 2**$_ * vec $:, $/++, 1 } 0..2+shift;
	$-
};;

$|--;
huff $: = <>;
my $btype = bin(-2);

#&tree; sub'lz {
#   $/ = 2**$- -1;
#   map { $/ -= 2**$-, $- = 2**@_ / 4 * $_ -1 } 0..$_-!@_;
#   $/ -= bin $- - 3
#};;
&tree; sub'lz {
	$; = bin -4;
	map { $; += 2**--$-, $- = $_ >> 2-@_ } 0..$_%257;
	$; += bin $- - 4
};;

if ($btype) {
$hlit = bin(2);
$hdist = bin(2);
@_[16..18, map { 7&-$_, 8^$_ } 0..7] = map { bin } 0..3+bin+1;

&tree;
sub'tree {
	@_ = ( (map { --$_[$_] ? () : $_ } 0..@_),
		map { [shift, shift] } 47 & @_ && &tree)
};;

map {
	push @b, @b > $hlit + $hdist + 257 ? () :
	16 > &huff ? $; = $_:
	7 & $_ ? map { 0  } 0..2+bin /8/ * 4: # $_ ^ $_+2:
		map { $; } 0..2+bin -1
	;
} 0..199;
@_ = @b;
}
else {
@_ = ((8) x 144, (9) x 112, (7) x 24, (8) x 8, (5) x 32);
$hlit = 31;
}

@] = tree +map { shift @_ } 0..$hlit+256;
&tree;
sub'huff { @_ ? huff @{$_ = $_[bin -2]} : $_ };;

map {
	print $_ / (127 & huff @]) <3 ?
		$_[@_] = chr:
		map { $_[@_] = $_[-$;] } 0..lz, lz&huff
} 0..1e5