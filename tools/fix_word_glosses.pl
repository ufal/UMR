#!/usr/bin/env perl
# One-time script to fix word-level glosses in Navajo UMR. The problem to be
# fixed: When one Navajo word is translated to several English words, the
# English words are separated by spaces, making it difficult to align them
# visually with their Navajo counterparts. Fortunately, clusters of English
# words are typically separated by more than one space, so we can still find
# the boundaries. The solution is to avoid spaces inside such clusters and use
# the period instead.
# Copyright © 2026 Dan Zeman <zeman@ufal.mff.cuni.cz>
# License: GNU GPL

use utf8;
use open ':utf8';
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
binmode(STDERR, ':utf8');

while(<>)
{
    if(m/^Word Gloss \([a-z]+\)):/)
    {
        my $glossline = $_;
        $glossline =~ s/^(Words Gloss \([a-z]+\)):\s*//;
        my $header = $1;
        $glossline =~ s/\s*\r?\n$//;
        # Sequences of two or more spaces or tabulators separate clusters.
        # If there is just a single tabulator, we assume it also separates clusters.
        $glossline =~ s/\s\s+/\t/g;
        # What remains should be just single spaces separating words within one
        # cluster. Replace them with periods.
        $glossline =~ s/ /./g;
        print("$header: $glossline\n");
    }
    else
    {
        # Pass all other lines simply through.
        print;
    }
}
