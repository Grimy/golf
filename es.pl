#!perl -nl

my %chars = (
	'' => '<>',
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
s/^/;YY;/;
my $line = $_;

for (reverse /./g) {
	die ord unless $chars{$_};
	$_ = $chars{$_};
	s/^[<>]*\K/^^/ while y///c < length($codes[-1]) + (/>/ && $codes[-1] =~ />/);
	push @codes, $_;
}

my @l = ();

for (reverse @codes) {
	my @c = /./g;
	print "@l";

	if (/>/) {
		die 'Too soon for >' if !@l;
		my $l = pop @l;
		die "$l >= @c" if $l >= @c;
		@c[$l, $-[0]] = @c[$-[0], $l];
		$_ = join '', @c;
	}

	push @l, $-[0] if /</;

	for (0..$#c) {
		$_[$_] .= $c[$_];
	}
}

for (@_[@l]) {
	$_ .= '>';
	$a = '^' x (y///c - 4);
	push @_, "^<$a^>";
	push @_, "^<>$a";
	if (y///c > length $line) {
		$line .= ';';
		push @_, "^$a^^e";
		push @_, "^$a^^^";
	}
}

@_ = map "<$_>", @_;

$" = '^';
print "@_";
print(eval "@_" or die $@);
print eval eval "@_";


# print *b
