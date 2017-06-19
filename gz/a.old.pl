sub _{$b=~s/.{@_}$//;oct"b$&"}
sub h{@{$_=shift}?h($$_[chop$b]):$_}
#sub h{ref($_=shift)?h($$_[chop$b]):$_}
sub c{
	@_=$/++<14&&((grep$_[$_]==$/,0..@_),&c);
	$/--;
	@c=map[shift,shift],A..T
}
$b=reverse+unpack$/='x23b*',h<>;
print/‰PN.*`/sg;
h+_+5;
h+_+3,for@l[16..18,0,map$_*($_%2-.5)+8,1.._+4];
die map{$_//0,v32}@l;
h(c@l)>16?$#z+=3+/8/*8+_+7>>/7/:
push@z,!/16/?$_:(pop@z)x(4+_+2)
for$_*4..252;
@d=c+splice@z,279;
c@z;
sub z{
	$d=$t=0;
	$d-=1<<$t,$t+=($_>4)>$_%"@_"for@_;
	$d-=_$t
}
print$_-$j?
map$o[@o]=$o[$d],z(4,1..$j-1)..0,z+2..2+h@d:
($o[@o]=chr)while$j=255&h@c
