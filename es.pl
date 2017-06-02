#!perl -nl

BEGIN { *ARGV = *DATA };

my %chars = (
	'' => '<>',
	'' => '<e^',
	'' => '>s^',
	'' => 'es',
	'<' => '<',
	'>' => '>',
	'^' => '^',
	'e' => 'e',
	's' => 's',
	'-' => 's^',
	';' => 'e^',
	'M' => '>s',
	'O' => '<s',
	'Y' => '<e',
	'[' => '>e',
	'`' => '>^',
	'b' => '<^',
	'(' => '>es',
	'*' => '<es',
	'H' => 'es^',
	'\\',  '<>^',
	'g' => '<>e',
	'q' => '<>s',
	'/' => '<>s^',
	'9' => '<>e^',
	't' => '<es^',
	'v' => '>es^',
	'J' => '<>es^',
);

my @codes = ();
my $line = $_;

my $l, my $r;
for (reverse /./g) {
	die ord unless $chars{$_};
	$_ = $chars{$_};
	$_ .= '^^' while y///c < length($codes[-1]);
	push @codes, $_;
	$chars{'\\'} = '><^' if $_ eq '<>^';
}

my @l = ();

for (reverse @codes) {
	my @c = /./g;
	$_[$_] .= $c[$_] for 0..$#c;
}

@_ = map "<$_>", @_;

$" = '^';
print "@_";
print eval "@_";
print eval eval "@_";
print eval eval eval "@_";
print eval eval eval eval "@_";

#    < \ * > < > v \ < b >
# 0: < > < > < < < > > < < > < >
# 1:   <               >
__DATA__
s<\H*>s^^^<<s^^^<<s^^^<<s^^^<<s^^^<<s^^^^s^^^<<s>><<><<s>>><<s>>>^s>>><<s>>><<s>>>^s>>><<s>>>e^s<^>;v;;\e^<sHebMM>
