#!/usr/bin/env perl
# Reads validation log for a list of UMR files, assuming that there is always
# - a line with the name of the file
# - optionally one or more lines with error messages
# - a summary line, either *** PASSED ***, or *** FAILED *** with [0-9]+ errors
# Copyright © 2024 Dan Zeman <zeman@ufal.mff.cuni.cz>
# License: GNU GPL

use utf8;
use open ':utf8';
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
binmode(STDERR, ':utf8');

system('rm -rf czech invalid');
mkdir('czech');
mkdir('invalid');
system('cp /net/work/people/zeman/umr/ufal-umr-repo/tecto2umr/README-cs.md czech/README.md');
my $filename;
my $n_valid = 0;
my $n_invalid = 0;
while(<>)
{
    chomp;
    if(m/^(.+\.umr)$/)
    {
        if(defined($filename))
        {
            die("Previous file '$filename' has not been completed");
        }
        $filename = $1;
    }
    elsif(m/^\*\*\* (PASSED|FAILED) \*\*\*/)
    {
        my $result = $1;
        print STDERR ("$result $filename\n");
        if($result eq 'PASSED')
        {
            system("cp $filename czech/czech_$filename");
        }
        else
        {
            system("cp $filename invalid");
        }
        $filename = undef;
    }
}
