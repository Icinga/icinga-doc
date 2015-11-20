#!/bin/perl -w

use strict;

my $lang = $ARGV[0] || "en";
my @files = glob("$lang/*.html");
my %tag = ();

for my $iFile (@files) {
	open (IFILE, "$iFile") || die "Fehler beim Öffnen von $iFile, RC=$!";
	print "--- $iFile ---\n";
	while (<IFILE>) {
		chomp;
		if (m|<a name="(.*?)"></a>(.*?)</|) {
			my $anchor = $1;
			my $text = $2;
			$text =~ s|\*|\\*|g;
			$text =~ s|\+|\\+|g;
			$text =~ s|(\?.*)||g;
			$tag{"$text"} = $anchor;
		}
	}
	close (IFILE);
}

@files = glob("$lang/*.md");
for my $iFile (@files) {
	print "$iFile\n";
	open (IFILE, "$iFile") || die "Fehler beim Öffnen von $iFile, RC=$!";
	my @lines = <IFILE>;
	close (IFILE);
	open (OFILE, ">$iFile") || die "Fehler beim Anlegen von $iFile, RC=$!";
	for (@lines) {
		chomp;
		for my $key (keys %tag) {
			if ((/$key/s) and ($_ !~ /\[[PNIU]/)) {
				s|$key|<a id="$tag{$key}"></a>$key|;
			}
		}
		print OFILE "$_\n";
	}
	close (OFILE);
} 
