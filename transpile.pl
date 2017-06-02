#!perl -pl

$" = '^';

my %codes = qw(< < > > ^ ^ e e s s ; e^ M >s b <^  <e^  >s^ * <es H es^ \\ <>^ v >es^);

my %chars = (
	'<' => 's>^><>',
	'>' => 's<^>^>^',
	'^' => 's>^>^>',
	'e' => 's>^>e>',
	's' => 's>^>s>',
	'0' => 's>^>e<<e>e',
	'1' => 's>^>s^^^>e',
	';' => 's<^><e^<^>>e',
	'v' => 's<^><<^<^>>^<eee^>^<^^^s>^<^^^e>>ee',
);

sub wrap {
	my (@codes, @c);

	for (reverse $_[0] =~ /./g) {
		my $c = $codes{$_} or die "Unknown char: $_";
		@c = ($c . '^^' x ((@c + 1 - length $c) / 2)) =~ /./g;
		$codes[$_] =~ s/^/$c[$_]/ for 0..$#c;
		s/([<>])([<>])/$2$1/ for $codes{$_};
	}

	@codes = map "<$_>", @codes;
	return "s<><@codes>eeee";
}

sub num {
	my $b = unpack "b8", $_[0];
	my @r;
	push @r, '^^^s' . '<<^^^s' x $-[0] while $b =~ /1/g;

	local $_ = "@r";
	s/\^\^\^s/>>>s/ or die while y/<// > y/>// + 2;
	s/\^\^\^s/><>>s/ if y/<// == y/>// + 2;
	s/\^\^\^s/><<>>s/ if y/<// > y/>//;

	return ~~reverse $_;
}

s/\s+/\n/g;
@_ = map {
	$chars{$_} ||= wrap(q(s<\H*>) . num($_) . q(e^s<^>;v;;\e^<sHebMM>));
} reverse /./g;

$_ = "@_^s<><<eee<e^<see><>>>^<^<^>^^^^s^s^s>^<^^^^^^^^^^^>^<^^^>>eeee";
