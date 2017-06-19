#!perl
# for $f (qw{m a i n : : S C A L A R R E F ( 0 x G L O B ( 0}) {
	# print "\n$f: ";
for $a ("", "<") {
for $b ("", ">") {
for $c ("", "^") {
for $d ("", "s") {
for $e ("", "e") {
	# print "$a$b$c$d$e\t: ", ord($a^$b^$c^$d^$e);
	print ord($a^$b^$c^$d^$e), "\n";
	# print "$a$b$c$d$e$f " if ($a^$b^$c^$d^$e^$f) =~ /\s/;
	# print +($a^$b^$c^$d^$e^$f) =~ s/\s/ /gr;
}}}}}
