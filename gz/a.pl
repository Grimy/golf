#!perl
use feature say;
bin(185);
&tree; sub'huff;
&tree; sub'bin {
    $- = $&;
    map { $- += 2**$_ * vec $:, $/++, 1 } 0..2+shift;
    $-
};;

huff $: = <>;

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

@_[16..18, map { 7&-$_, 8^$_ } 0..7] = map { bin } 0..3+bin+print /‰.*`‚/sg;

&tree;
sub'tree {
    @_ = ( (map { --$_[$_] ? %chr : $_ } 0..@_),
            map { [shift, shift] } 47 & @_ && &tree)
};;

@_ = map {
    16 > &huff ? $; = $_:
    7 & $_     ? map { 0  } 0..2+bin /8/ * 4: # $_ ^ $_+2:
                 map { $; } 0..2+bin -1
} 0..$$;

@] = tree +map { shift @_ } 0..278;
&tree;
sub'huff { @_ ? huff @{$_ = $_[bin -2]} : $_ };;

map {
    print /‰.*`‚/sg, $_ / (127 & huff @]) <3 ?
        $_[@_] = chr:
        #map { $_[@_] = $_[$/] } 0..-lz, lz&huff
        map { $_[@_] = $_[-$;] } 0..lz, lz&huff
} 0..$<