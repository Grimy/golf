#!perl
die $$;

#use feature say;
#use Smart::Comments;

sub'huff;
sub'bin {
	$- = $&;
	map { $- += 2**$_ * vec $;, ++$/, 1 } K..2+shift;
	$-
}
sub'huff { @_ ? huff @{$_ = $_[bin -2]} : $_ };
sub'lz {
	$: = $- = 00;
	map { $: += 2**--$-, $- = $_ >> @_ } K..$_;
	$: += bin $- - 4
}
@_ = (0)x100;

print &lz for 0..15;
print $/



__END__
sub'lz {
	$: = 1;
	#map { $- = $_ >> @_, $: += 2**--$- } K..$_;
	#map { $- = 2**-@_ * $_ - 1, $: += 2**$- } K..$_;
	map { $: += 2**--($- = 2**-@_ * $_) } K..$_;
	$: -= 2**$- - bin $- - 3
}
say lz 0 for 0..31;

sub'tree {
	@_ = ( (map { --@_[$_] ? %$ : $_ } K..@_),
		map { [shift, shift] } 1..++$: % 35 && &tree/2)
};;

@_ = qw(5 0 0 0 4 4 3 3 3 3 3 4 4 5 0 0 5 6 6);
&tree;
### @_

__END__
sub'_ {
	++$: % 35 ?
	@_=((map { --$_[$_] ? %$ : [$_] } 0..@_), map { [shift, shift] } &_)
	:()
}

say for grep { print "$_: "; eval 'sub'.$_.'V{print 42}'; print v10; !$@ } grep { @_ = eval "qw(a$_:)"; !$#_ } map chr, 0..255;

say &V;
die;
@_ = qw(5 0 0 0 4 4 3 3 3 3 3 4 4 5 0 0 5 6 6);
&_;
$_ = $_[0];
$; = v0.0;
say $/;
say &V;

sub'A;
sub'A { @{$_=$_[0]} ? A$$_[vec $;, ++$/, 1] : $_ };;

sub'E {
	$: = 1;
	map { $- = $_ >> @_, $: -= 2**--$- } 0..$_;
	$: += 2**$-;
	"$:\t$-";
}
sub'V { @{$_=$_[0]} ? V$$_[vec $;, ++$/, 1] : $_ };;

say 0+@_;
@_ = V;
die 0+@_;

$; = AB;
print A[0,1]for 0..15;
say;

@_ = (0)x10;
say &E for 0..31;

sub'C {
	$- = $: = -2; # =0
	map { $: += 2**--$-, $- = $_ >> @_ } 0..$_;
	$: += D$--4
}

sub'_ {
	76 > ++$: ?
	@_ = map { [shift, shift] } @_ =
	((map { --$_[$_] ? %$ : $_ } 0..@_), &_):
	R-1
}

@_ = qw(5 0 0 0 4 4 3 3 3 3 3 4 4 5 0 0 5 6 6);
&_;
print Dumper($_[0]);

$a=11;say $_^chr($a++) for qw(e v @  c  h  r  {  }  [  ]);
die;

map {
	$! = $_;
	$c = grep { $! =~ /\Q$_/ } qw(c h r v e @ [ ] { });
	say "$_: $!" if length $! < 24;
} 0..255;
say length ($!=6)

#sub'_{$b=~s/.{@_}$//;oct"b$&"}
#sub'h{@{$_=shift}?h($$_[chop$b]):$_}

$a=11;say $_^chr($a++) for *n=~/./g;

$v = A..Z;
$/=184;
sub'z{
	$d=$t=0;
	map{$d+=2**$t,$t+=/../>$_%"@_"}@_;
	"$d+$t"
}
sub Z{
	$= = $d = .5;
#	map{$-+=2**$=, $= += ($_>"@_")>$_%"@_"}0..shift;
	map{$d+=2**$=, $= = $_/"@_"-1}0..shift;
	"$d+$="
}

say $/;
Z-1;
say "$=, $%, $/";

say z(4..$_-253), "\t", Z($_-257,4) for 257..288;
say z(2,7..6+$_), "\t", Z($_,2)     for 0..31;

$y = join'', A..Z;
sub'c{
	map { [shift, shift] } @_ = $d++ < 16 ?
#	((map{$_[$_]-$d?():$_}0..@_),&c):
	((grep$_[$_]==$d,0..@_),&c):
	($d-=$d)
}
sub'h { @{$_=shift} ? h($$_[vec$y,$/++,1]) : $_ }

sub'H { %_=@_; my $t; 1until$_ = $_{$t.=vec$y,$/++,1} }
sub'C {
	$a=%_=();
	for $= (1..16) {
		$a *= 2;
		map { $_[$_]-$= || ($_{ sprintf"%0$=b", $a++} = $_) } 0..@_
	}
	%_
}


sub'H {
	$a = $b = 0;
	for $l (1..16) {
		$a += $a + vec$y,$/++,1;
		$b *= 2;
		$_=-1;
		$_[++$_]-$l||$a-$b++||return$_,while $_<@_
	}
}

@_ = qw(5 0 0 0 4 4 3 3 3 3 3 4 4 5 0 0 5 6 6);
print "$_ => $_{$_}\n" for keys %_;

print h(c@_), $" for 1..5;
print $/, v10; $/=0;
print H(C(@_)), $_, $" for 1..5;
print $/, v10; $/=0;


sub _{$b=~s/.{@_}//;ord+pack"b*",$&}
sub _{$b=~s/.{@_}$//;oct"b$&"}
sub _{oct reverse+eval"&v."x"@_".b}
sub'_{my$t;map{$t+=2**$_*vec$v,$/++,1}0..shift;$t}
sub _{oct b.reverse+join'',map&v,1..pop}
sub c{@c=map[shift,shift],@_=$t++<14?((grep$_[$_]==$t,0..@_),&c):z()}


say z(4..$_-253), "\t", Z($_-257,4) for 257..288;
say z(2,7..6+$_), "\t", Z($_-2,2)     for 0..31;
sub h{@{$_=shift}?h($$_[chop$b]):$_}
sub h{@{$_=shift}?h($$_[&v]):$_}
sub'c{map{[shift,shift]}@_=$d++<16?((grep$_[$_]==$d,0..@_),&c):($d-=$d)}
sub'c{@_=$d++<16?((grep$_[$_]==$d,0..@_),&c):do{$d-=$d;()};map{[shift,shift]}1..@_/2}
sub t{h+c+(@_)x2**pop}

$v=join'',A..Y;
$/=184;

@_=c(1,3,2,3);
### @_

# Recurring strings
if (!$auto) {
@rep = qw#
	}-2..  $d[@d]=  $d-=  }@_=
	@_  $_  $t  $d  vec$v,$/++,1  shift  
	map{  +2  2**  ;print  ;sub'  ..  16
#;

# Replace recurring strings with placeholders (\x00-\x1F)
for $i (0..$#rep) {
	s/\Q$rep[$i]/chr $i/ge >= 6 / length $rep[$i] or die "$rep[$i]";
}

# Search for other repetitions
for $l (2..12) {
	for $i (0..length() - $l) {
		$sub = substr $_, $i, $l;
		$n =()= /\Q$sub/g;
		$low = $sub =~ y/ -/ -/;
		$sub =~ s/[ -]/$rep[ord$&]/ge;
		$score = $n * ($l-1) - 1 - $l;# length($sub);
		$rep{$sub} = $score if $score >= 0;
	}
}
say "$_\t: $rep{$_}" for sort {$rep{$a} <=> $rep{$b}} keys %rep;
}

# Convert to bit-string, 6 bits per character
#s/./unpack 'b6', $&/ges;
$_ = unpack 'B*';
s/..(.{6})/$1/g;

# If the packed string doesn't end on a byte boundary, trailing 0's will appear
# Fix this by adding a ';'
#say 'Adding ; ', s/$/111011/ while y===c % 8;

# Attempt to use ' as a delimiter, with either encoding
%data = ('B*' => pack('B*', $_), 'b*' => pack('b*', $_));
$open = $close = q(');
map { $f = $_ if $data{$_} !~ /'/ } keys %data;

# Otherwise, pick any other delimiter
if (!$f) {
	$f = 'B*';
	for $c (33..126) {
		$open = 'q'.($close = chr $c);
		next if $close =~ /[\w<{[(]/;
		last if $data{$f} !~ /\Q$close/;
	}
}

$_ = "\$_=unpack'$f',$open$data{$f}$close;"
   . "s�.{6}�$rep"
   . '[$_=oct"b$&"]^chr�ge;eval';

   . 's=.{6}=pack+b6,$&=ge.'
   . "y]$low_unused]$high_used]/"
   . "s~[ -]~qw{@rep}[ord\$&]~ge&"

# Embed
#$_ = "\$_='$_';s`[ -]`qw#@rep#[ord\$&]`ge;eval";
$_ = "\$_='$_';1while+s`[ -]`qw#@rep#[ord\$&]`e;eval";
#$_ = "q#$_#;s`[ -]`qw#@rep#[ord\$&]`e||s/..//;print\$_,v10;eval";
#$_ = "\$_='$_';s`[ -]`qw#@rep#[ord\$&]`e until eval";
#[\\pC] # Requires v5.10

# Remove conflictual characters
s/\Q�.*`�/.PNG.*`./;

# Convert to bit-string, dropping the high bit on each byte
s/./unpack 'b7', $&/ges;

# Prevent the apparition of a null byte when decompressing
s/^(.{8})+.$/${_}0000010/;

# Attempt to use ' as a delimiter, with either encoding
%data = ('B*' => pack('B*', $_), 'b*' => pack('b*', $_));
$open = $close = q(');
map { $f = $_ if $data{$_} !~ /'/ } keys %data;

# Otherwise, pick any other delimiter
if (!$f) {
	$f = 'B*';
	for $c (33..126) {
		$open = 'q'.($close = chr $c);
		next if $close =~ /[\w<{[(]/;
		last if $data{$f} !~ /\Q$close/;
	}
}

s/...$//;
$_ .= qw(02 1 +69 69)[y===c%4];
#  8196, 10000, 6900, 6900
#   \00        $< \00

"@rep" =~ /( \w)+$/;
$rep = $&;
$pre = $`;
$rep =~ s/\s//g;
$rep = "(qw�$pre�,$rep=~/./g)";

# Embed
$_ = "\$_=unpack'$f',$open$data{$f}$close;".
	'eval pack"(b7)*",/.{7}/g';
#	'$_=pack"(b7)*",/.{7}/g;eval';

