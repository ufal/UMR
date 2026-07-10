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
print STDERR ("Running: $commandline\n");
system($commandline);
