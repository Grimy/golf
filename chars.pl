#!perl -l
for $a ("", "<") {
for $b ("", ">") {
for $c ("", "^") {
for $d ("", "s") {
for $e ("", "e") {
	print "$a$b$c$d$e\t: ", ord($a^$b^$c^$d^$e);
}}}}}
