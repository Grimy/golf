#!perl -pl

$" = '^';

my %codes = qw(
	b <^
	< < > > ^ ^ e e s s ; e^ [ >e  <e^  >s^ * <es H es^ \\ ><^ v >es^
);

my %chars = (
	'<' => 's>><>',
	'>' => 's<>^>^',
	'^' => 's>>^>',
	'e' => 's>>e>',
	's' => 's>>s>',
	'0' => 's>>e<<e>e',
	'1' => 's>>s^^^>e',
	';' => 's<><e^<^>>e',
	'v' => 's<><<^<^>>^<eee^>^<^^^s>^<^^^e>>ee',
);

sub wrap {
	my (@codes, @c);
	my $w;

	for (reverse $_[0] =~ /./g) {
		my $c = $codes{$_} or die "Unknown char: $_";
		$c .= '^^' x (($w + 1 - length $c) / 2);
		$w = length $c;
		push @c, $c;
	}

	for (reverse @c) {
		s/^>(.)/$1>/ if $codes[1] =~ y/<// > $codes[1] =~ y/>//;
		my @c = /./g;
		$codes[$_] .= $c[$_] for 0..$#c;
	}

	@codes = map "<$_>", @codes;
	return "s<><@codes>eeee";
}

sub num {
	my $b = unpack "b8", $_[0];
	my @r;
	push @r, '^^^s' . '<<^^^s' x $-[0] while $b =~ /1/g;

	local $_ = "@r";
	s/\^\^\^s/>>>s/ while y/<// > y/>// + 1;
	s/\^\^\^s/><>>s/ if y/<// > y/>//;
	s/\^\^\^s/><<>>s/ if y/<// == y/>//;

	return ~~reverse $_;
}

# print wrap(';b;<*>');

s/\s+/\n/g;
@_ = map {
	$chars{$_} ||= wrap(q(s\H*) . num($_) . q(e^s<^>;v;;\e^<sHe[>));
} reverse /./g;

$_ = "@_^s<><<eee<e^<see><>>>^<^<^>^^^^s^s^s>^<^^^^^^^^^^^>^<^^^>>eeee";
