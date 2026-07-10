#!/usr/bin/env perl
# Převezme příkaz a jeho argumenty, vypíše je na STDERR a pak spustí.
# Copyright © 2026 Dan Zeman <zeman@ufal.mff.cuni.cz>
# License: GNU GPL

use utf8;
use open ':utf8';
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
binmode(STDERR, ':utf8');

if(scalar(@ARGV) == 0)
{
    die("Expected at least one argument");
}
my $commandline = join(' ', @ARGV);
# If we are redirecting STDOUT to a file and we want the first line of that file
# to show the commandline arguments, we must print this to STDOUT, too. But if
# we still want to see it in the terminal, we must also print it to STDERR.
print("Running: $commandline\n");
print STDERR ("Running: $commandline\n");
system($commandline);
