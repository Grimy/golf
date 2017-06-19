#!/usr/bin/perl -s
use feature say;
local $/;
sub don't(&) { }

`taskkill /F /IM perl5.8.exe`;

# Reverse c (use pop)

########
# INIT #
########

# Read the uncompressed code
open IN, 'a.pl';
$_ = <IN>;

# Strip whitespace and comments
s/\s|#(?<!\$).*//g;
say length, " chars, packed into...";

########
# DAFT #
########

if ($find) {
for(;;) {
	$max = -5;
	undef $best;

	for $l (2..12) {
		for $i (0..length() - $l) {
			$sub = substr $_, $i, $l;

			$n =()= "$_@rep" =~ /\Q$sub/g;
			$score = $n * ($l-1) - (1 + length($sub));
			if ($score > $max) {
				$max = $score;
				$best = $sub;
			}
		}
	}
	die "$best" if $best =~ /\s/;
	last unless defined $best;

	say $best=~s/\pC/'{'.ord($&).'}'/reg, ": $max";
	s/\Q$best/chr @rep/ge;# for $_, @rep;
	push @rep, $best;
}
die;
}

@rep = qw#
	@_  $:  $-
	map{  $_  }0..
	;sub'  shift
	print/‰.*`‚/sg  vec$T,$/++,1
	{  chr  }
#;

$i=-1;
while ($best = $rep[++$i]) {
	$l = length $best;
	$chr = chr($i)^O;
	#say $best=~s/\pC/'{'.ord($&).'}'/reg, ": ",
	say "$best: ", s/\Q$best/$chr/g;# * 6 * ($l-1) - 8 * ($l+1);
	die $i if $chr !~ /[A-Z]/;
	$rep[$i] ^= $chr;
	die if $rep[$i] =~ /\s/;
}
say "\n", 8*length("@rep") + 6*length, ' bits (', length, '+', length "@rep", ')';

########
# PACK #
########

$_ = uc;
s/[\\\d]+$/\$</ if $cheat;
$_ .= '#' if y===c%4;
die if /[a-z{}\n |~]/;

# Home-made unpack u
$_ = unpack 'B*', $_ ^ '`' x length;
s/..(.{6})/$1/g;
say;
s/0+$//; # Might save a byte
$_ = pack 'B*', $_;
say length . " bytes of packed data";

# Pick a delimiter, ' if possible
$open = $close = q(');
$c = 33;
while (/\Q$close/) {
	do {$open = 'q'.($close = chr $c++);
	}while $close =~ /[\w<{[(]/;
}

# Embed
#$pack = $cheat ? '$<^C' : ' u999';
$pack = ' u78';
$_ = "\$_=pack$pack,$open$_$close;"
   . "sµ.µqw#@rep#"
   . '[79^ord$&]^$&µeg;'
   . "eval";
#s!.!qw#@rep#[ord$&^79]^$&!eg;eval

say length, " chars!";

########
# TEST #
########
$time = time;
open OUT, '>gzok';
binmode OUT;
print OUT;
open OUT, '>gztest';
binmode OUT;
print OUT s/eval/print/r;
say `perl5.8 gztest`;

for (qw(rfc1952.txt rfc1951.txt logo.png)) {
	print;
	open IN, $_;
	say ': ', (`perl5.8 gzok < $_.gz` eq <IN>) ? 'OK!' : 'Fail';
}
length>389?
printf "It needs to be about %.1f%% shorter.\n", (1-389/length)*100:
say 'Bwahaha world record :D :D :D';
say time-$time, " seconds.";

