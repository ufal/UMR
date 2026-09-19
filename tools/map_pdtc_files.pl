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
# Use the paths to modify UMR file mapping.
my $umrdir = '/net/work/people/zeman/umr/umr-data-choroba';
open my $ifh, "$umrdir/umr_file_name_mapping.txt" or die("Cannot read file name mapping: $!");
my %target_directory;
while(<$ifh>)
{
    s/\r?\n$//;
    if(m:^czech/umr_data/czech_(.+)\.umr\t(.+)$:)
    {
        my $basename = $1;
        my $target = $2;
        if(exists($directory{$basename}))
        {
            $target_directory{$target} = "czech/converted/$directory{$basename}";
        }
        else
        {
            die("Unknown Czech file '$basename'");
        }
    }
    elsif(m:(.+?)\t(.+):)
    {
        $target_directory{$2} = $1;
    }
}
my @targets = sort(keys(%target_directory));
open my $ofh, ">$umrdir/new_file_name_mapping.txt" or die("Cannot write file name mapping: $!");
foreach my $target (@targets)
{
    print $ofh ("$target_directory{$target}\t$target\n");
}
