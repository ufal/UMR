#!/usr/bin/env perl
# Zjistí, které soubory PDT-C patří do které složky.
# Copyright © 2026 Dan Zeman <zeman@ufal.mff.cuni.cz>
# License: GNU GPL

use utf8;
use open ':utf8';
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
binmode(STDERR, ':utf8');
use Cwd qw(abs_path);

my $pdtcdir = '/net/work/people/zeman/hamledt/normalize/cs/data/source';
my %directory;
foreach my $part ('train', 'dev', 'test')
{
    my $path = "$pdtcdir/$part/tamw";
    opendir my $dh, $path or die("Cannot read $path: $!");
    for my $thing (readdir($dh))
    {
        if($thing =~ m/^(.+)\.t$/)
        {
            my $basename = $1;
            my $target = readlink("$path/$thing");
            if($target)
            {
                $directory{$basename} = abs_path($target);
                # We will work with converted UMR files, so the extension is .umr.
                $directory{$basename} =~ s/\.t$/.umr/;
                # Remove the local file system prefix.
                $directory{$basename} =~ s:/lnet/work/people/zeman/PDT-C-2.0/::;
                # Lowercase and simplify the subcorpus prefix.
                $directory{$basename} =~ s:^PDT/pml:pdt:;
                $directory{$basename} =~ s:^PCEDT-cz/pml:pcedt:;
                $directory{$basename} =~ s:^PDTSC/pml:pdtsc:;
                $directory{$basename} =~ s:^Faust/pml:faust:;
            }
        }
    }
}
my @basenames = sort(keys(%directory));
foreach my $basename (@basenames)
{
    print("$basename\t--->\t$directory{$basename}\n");
}
printf("TOTAL %d files\n", scalar(@basenames));
