#!/usr/bin/perl -ln

@_ = map sprintf("%08b", $_) =~ /./g, @ARGV if 1..1;
next if /^#/;
print STDERR s/.\K/ /gr;
y/0AB/%#;/;
@_[@-] = map { int eval join chr ord, @_[@-] } $&, $1 while /\S(.)/g;
# @_[@-] = map { eval join $_, @_[@-] } $&, $1 while /(\S)\K./g;
print STDERR "@_";
print(oct 'b' . join '', @_), last if eof;