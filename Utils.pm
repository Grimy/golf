# use 5.16.0;
use warnings;

package Golf::Utils;

sub import {
    # $$ = $_[1];
    $< = '65534';
    $> = '65534';

	no strict qw(refs);
	for (qw(compress quote quote_regex upload)) {
		*{caller() . "::$_"} = \&{$_};
	}
}

BEGIN { *CORE::GLOBAL::pack = \&pack; }


my @Delimiters = grep { !/[\w<{[(]/ } map { chr } 33..126;

# The content of the memory accessed by the 'pack u' bug on CodeGolf.com
my @Memory = <<'END' =~/./gs;
 !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_ panic: memory wrap             Can't localize through a reference                              "my" variable %s can't be in a package                          The %s function is unimplemented                                Unsupported directory function "%s" called                      Unsupported socket function "%s" called Insecure dependency in %s%s Out of memory!
             Modification of a read-only value attempted                     Modification of non-creatable hash value attempted, subscript "_"                               Modification of non-creatable hash value attempted, subscript "%s"                              Modification of non-creatable array value attempted, subscript %d                               Can't use an undefined value as %s reference                    Can't use string ("%.32s") as %s ref while "strict refs" in use Can't use %s ref as %s ref      Unsuccessful %s on filename containing newline                  Unquoted string "%s" may clash with future reserved word Semicolon seems to be missing  Use of uninitialized value%s%s          mmap crlf pending perlio stdio unix bytes %s:%lld  PERLIO_DEBUG (none) Cannot flush f=%p
 PerlIO_pop f=%p %s
 Destruct popping %s
 PerlIO PerlIO::Layer::NoWarnings %.*s => %p
 Cannot find %.*s
 PerlIO::Layer warning:%s
 define %s %p
 Unknown PerlIO layer "%.*s" Pushing %s
 Layer %lld is %s
 PERLIO perlio.c PerlIO::Layer::find PerlIO_push f=%p %s %s %p
 (Null) :raw f=%p :%s
 fdupopen f=%p param=%p
 fd %d refcnt=%d
 Cleanup layers
 r+ panic: bad pagesize %lld panic: sysconf: %s /tmp/PerlIO_XXXXXX w+ Ir Iw Hash Code  Recursive call to Perl_load_module in PerlIO_find_layer Usage class->find(name[,load])  Argument list not closed for Perl
END

# A list of fortunes
my @Fortunes = split /\n/, <<'END';
Regexes always win.
Magic formulae always win.
Functional approaches sometimes win.
Consider bitwise operators.
do$0 is one sick loop.
Know your magic variables.
$|-- is the golf-friendly magical flip-flop.
Can't possibly work, let's try it anyway.
If you get stuck on one golf game, try another. You may be able to apply tricks learnt in the new game to the one you were previously stuck on.
Study the gory details of every single built-in function the language has to offer.
Milk holes in the tests as much as you want.
Autovivification is the automatic creation of a variable reference when an undefined value is dereferenced.
END

# Emulates the (buggy) behaviour of CodeGolf.com's 'pack' function
sub pack {
	my ($format, @args) = @_;

	# Fall back to the built-in pack for any format other than u
	return CORE::pack $format, @args if $format !~ /^u(\d*)$/ || @args != 1;

	# Number of uncompressed bytes in each line
	my $width = ($1 || 45) / 3 << 2;

	for (@args) {
		$_ = unpack 'B*', $_;
		s/(.)(.{1,5})/0$1$1$2/g;
		$_ = pack 'B*', $_;
		$_ ^= ' ' x length;
		y/ /`/;
		s/(.{1,$width})/$Memory[length($1) * .75]$1${\('`' x (-length($1) & 3))}\n/g;
		return $_;
	}
}

# Does the opposite of a buggy pack u.
# Note that this cannot be achieved with unpack u, which isn't buggy.
sub compress {
	local ($_) = @_;
	map { die "Illegal pack character: $_" . ord } /[a-z{}\n |~]/g;

	$_ ^= ' ' x length;
	$_ = unpack 'B*', $_;
	s/..(.{6})/$1/g;
	s/0+$//;
	$_ = pack 'B*', $_;
}

sub quote {
	return &_quote_one if @_ == 1;

	# First approach: quote each string individually
	my $list = join ',', map { _quote_one($_) } @_;

	# qw won't work if @_ contains any whitespace
	return $list if grep { /\s/ } @_;

	my $qw = join ' ', @_;
	my $delim = _pick_delimiter($qw);
	$qw = "qw$delim$qw$delim";
	
	return length $qw < length $list ? $qw : $list;
}

sub _quote_one {
	local $_ = shift;

	# Numbers don't require quoting
	if ($_ eq do { no warnings 'numeric'; 0+$_ }) {
		s/^0\././;
		s/0{3,}$/'e'.length $&/e;
		return $_;
	}

	# Barewords don't require quoting (TODO: check for keywords)
	return $_ if /^-?[a-zA-Z]\w*$/ && !/^v\d*$/;

	# Return a v-string when it's the shortest form
	return 'v'.ord if /^ [\0-\11\\] $/x;
	
	# Escape backslashes when needed
	s/ \\ (?! [^\\])/\\\\/gx;

	# Try the short forms '' and "" first
	return qq('$_') if !/'/;
	return qq("$_") if !m' ["$] | @ (?= [\w:]) | (?<! \ ) (\{2})* \ (?! \ ) 'x;

	# As a last resort, use q
	my $d = _pick_delimiter($_);
	return "q$d$_$d";
}

sub _pick_delimiter {
	local $_ = shift;

	for my $d (@Delimiters) {
		return $d if !/\Q$d/;
	}

	die "Couldn't find a suitable delimiter for $_";
}

sub quote_regex {
	my $prefix = @_ == 1 ? 'm':
	             @_ == 2 ? 's':
	                       die "Wrong number of arguments";

	# 'm' can be omitted when using '/' as the delimiter
	return "/$_[0]/" if @_ == 1 and $_[0] !~ m'/';

	# TODO: Handle anti-interpolation ''
	return join _pick_delimiter(join q(), @_), $prefix, @_, q();
}

sub fortune {
	my $i = @_ ? $_[0] % @Fortunes : rand(@Fortunes);
	$Fortunes[$i];
}

1;
