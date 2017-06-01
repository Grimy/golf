sub main {
# /(.+)(-\1|.(?2).)\b/;@r=(s/-$1/-/,I,II,III,IV,V,VI,VII,VIII,IX);s/Act(.+)(.,).+ /$r[$1].\L$r[$2]./
# /(.+)(-\1|.(?2).)\b/;s/-$1/-/;s!.,\D+!(ix,viii,vii,vi,v,iv,iii,ii,i)[-$&]."."!ge;s/\w+ (\w+)/\U$1/
/(.+)(-\1|.(?2).)\b/;s/-$1/-/;s/(.,|\w+) /("",i,ii,iii,iv,v,vi,vii,viii,ix)[$&]."."/ge;s/\w+/\U$&/
}

# IIIVIIIX
# 0 1
# 0 2
# 0 3
# 2 4
# 3 4
# 3 5
# 3 6
# 3 7
# 6 8

sub test {
	$_ = $_[0];
	main();
	print "$_ ne $_[1]\n" if $_ ne $_[1];
}

test("(Act 1, Scene 2, Lines 345-346)", "(I.ii.345-6)");
test("(Act 3, Scene 4, Lines 34-349)", "(III.iv.34-349)");
test("(Act 5, Scene 9, Lines 123-234)", "(V.ix.123-234)");
test("(Act 3, Scene 4, Line 72)", "(III.iv.72)");
test("(Act 2, Scene 3, Lines 123-133)", "(II.iii.123-33)");
test("(Act 4, Scene 8, Lines 124-133)", "(IV.viii.124-33)");
