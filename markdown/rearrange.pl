#!/usr/bin/perl -w

use strict;

my $lang = $ARGV[0] || "en";
my @files = glob("$lang/*.md");

for my $file (@files) {
	open (IFILE, "$file") || die "Fehler beim Oeffnen von $file, RC=$!";
	my @lines = <IFILE>;
	close (IFILE);
	my @oLines = ();
	my $part = 0;
	my $tag = {};
	for my $line (@lines) {
		$tag->{next} = $1 if ($line =~ m|(\[Next\].+?\))|);
		$tag->{prev} = $1 if ($line =~ m|(\[Prev\].+?\))|);
		$tag->{index} = $1 if ($line =~ m|(\[Home\].+?\))|);
		$tag->{up} = $1 if ($line =~ m|(\[Up\].+?\))|);
		$part++ if (($line =~ m|\* \* \* \* \*|) and (! $part));
		if ($part == 1) {
			my $oLine = "";
			$oLine .= $tag->{prev} if (defined $tag->{prev});
			$oLine .= ' ![Icinga](../images/logofullsize.png "Icinga") ';
			$oLine .= $tag->{next} if (defined $tag->{next});
			push @oLines, $oLine . "\n\n";
			$part++;
			$tag = {};
		}
		if (defined $tag->{up}) {
			my $oLine = "";
			$oLine .= $tag->{prev} if (defined $tag->{prev});
			$oLine .= ' | ';
			$oLine .= $tag->{up} if (defined $tag->{up});
			$oLine .= ' | ';
			$oLine .= $tag->{next} if (defined $tag->{next});
			push @oLines, $oLine . "\n\n";
			$part = -1;
			$tag = {};
			next;
		}
		if (defined $tag->{index}) {
			my $oLine = $line;
			$oLine =~ s|^\s+||;
			$oLine =~ s|\s+$||;
			$oLine =~ s|\s+(\[Home\])| <=== $1|;
			$oLine =~ s|\[Home\](.+?\)\s+)| [Index]$1 ===> |;
			push @oLines, $oLine . "\n";
			$part = -1;
			$tag = {};
			next;
		}
		next if ($line =~ m|[-]*\s+[-]*\s+[-]*|);
		$line =~ s#~~~~ {.programlisting}#<pre><code>#;
		$line =~ s#~~~~#</code></pre>#;
		push @oLines, $line if ($part);
	}
 	open (OFILE, ">$file") || die "Fehler beim Anlegen von $file, RC=$!";
 	print OFILE @oLines;
 	close (OFILE);
}
exit 0;
