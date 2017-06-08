#!/bin/perl

my $xml = q<<?xml version="1.0"?>
<dungeon character="1009" name="INIT" numLevels="1">
	<level bossNum="-1" music="0" num="1">
		<tiles>%s
		</tiles>
		<traps>%s
		</traps>
		<enemies>%s
		</enemies>
		<items>
			<item x="0" y="0" type="misc_map" bloodCost="0" saleCost="0" singleChoice="0" />
			<item x="0" y="0" type="head_circlet_telepathy" bloodCost="0" saleCost="0" singleChoice="0" />
			<item x="0" y="0" type="torch_foresight" bloodCost="0" saleCost="0" singleChoice="0" />
			<item x="0" y="0" type="weapon_dagger_electric" bloodCost="0" saleCost="0" singleChoice="0" />
		</items>
		<chests />
		<crates />
		<shrines />
	</level>
</dungeon>>;

sub tiles {
	my $y = shift;
	join '', map qq<<tile x="$_" y="$y" type="$_[$_]" zone="6" torch="0" cracked="0" />>, 0..$#_;
}

sub trap { qq<<trap x="$_[0]" y="$_[1]" type="$_[2]" subtype="$_[3]" />> }

sub enemy { qq<<enemy x="$_[0]" y="$_[1]" type="$_[2]" beatDelay="0" lord="0" />> }

my %things = (tile => '', trap => '', enemy => '');

my %modules = (
	'I' =>  tiles(0,   0,   0,   0) .
		tiles(1,   0,  20, 118) .
		tiles(2, 103, 118, 118) .
		trap(2, 1, 1, 5) .
		enemy(1, 1, 711),
	'A<' => tiles(0, 0, 20, 20, 0, 20, 20) .
		tiles(1, 0, 20, 20, 0, 0, 0) .
		tiles(2, 0, 20, 0, 0, 0, 0) .
		trap(4, 0, 1, 1) .
		trap(3, 0, 1, 5) .
		trap(2, 1, 1, 6) .
		trap(2, 0, 1, 4) .
		trap(3, 1, 1, 4) .
		trap(5, 2, 2, 0),
	'&|' => tiles(0, 0, 20, 0, 0, 20, 0) .
		tiles(1, 0, 20, 0, 20, 20, 0) .
		tiles(2, 0, 20, 0, 0, 20, 0) .
		trap(1, 1, 1, 0) .
		trap(2, 1, 1, 0) .
		trap(3, 1, 1, 0) .
		trap(3, 2, 1, 1) .
		trap(2, 2, 1, 1),
	'|&' => tiles(0, 0, 20, 0, 0, 20, 0) .
		tiles(1, 0, 20, 20, 0, 20, 0) .
		tiles(2, 0, 20, 0, 0, 20, 0) .
		trap(4, 1, 1, 1) .
		trap(3, 1, 1, 1) .
		trap(2, 1, 1, 1) .
		trap(2, 2, 1, 0) .
		trap(3, 2, 1, 0),
	'BA' => tiles(0, 0, 20, 0, 0, 20, 0) .
		tiles(1, 0, 20, 0, 0, 20, 0) .
		tiles(2, 0, 20, 0, 0, 20, 0) .
		trap(1, 0, 1, 0) .
		trap(2, 0, 1, 4) .
		trap(4, 0, 1, 1) .
		trap(3, 0, 1, 5) .
		trap(2, 2, 1, 1) .
		trap(3, 2, 1, 0),
	' '  => tiles(0, 0, 20, 0) .
		tiles(1, 0, 20, 0) .
		tiles(2, 0, 20, 0),
);

while (<>) {
	$_ .= ' ' while y///c < 6;
	while (/[ I]|../g) {
		my $x = $-[0] * 3;
		my $y = ($. - 1) * 3;
		my $module = $modules{$&};
		$module =~ s/ x="\K(\d*)/$1 + $x/ge;
		$module =~ s/ y="\K(\d*)/$1 + $y/ge;
		$things{$1} .= "\n\t\t\t$&" while $module =~ /<(\w+) .*?>/g;
	}
}

printf $xml, $things{tile}, $things{trap}, $things{enemy};
