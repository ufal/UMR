#!/usr/bin/env perl
# Reads one or more UMR files given as arguments. Prints statistics about them.
# Copyright © 2026 Dan Zeman <zeman@ufal.mff.cuni.cz>
# License: GNU GPL

use utf8;
use open ':utf8';
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
binmode(STDERR, ':utf8');

sub usage
{
    print STDERR ("Usage: umr_stats.pl file.umr [file2.umr ...]\n");
    print STDERR ("       Prints statistics about the UMR file(s).\n");
}

# We need to tell Perl where to find my umrlib module (same folder as this script).
BEGIN
{
    use Cwd;
    my $path = $0;
    $path =~ s:\\:/:g;
    my $currentpath = getcwd();
    $libpath = $currentpath;
    if($path =~ m:/:)
    {
        $path =~ s:/[^/]*$:/:;
        chdir($path);
        $libpath = getcwd();
    }
    chdir($currentpath);
    #print STDERR ("libpath=$libpath\n");
}
use lib $libpath;
use umrlib;

if(scalar(@ARGV)==0)
{
    usage();
    die("Need at least one file as argument");
}
my $total_sentences = 0;
my $total_tokens = 0;
foreach my $file (@ARGV)
{
    print("File = $file\n");
    my %filehash =
    (
        'label' => $path, ###!!! files have labels such as GOLD and SYS when comparing them, but not in the general case
        'path' => $path,
    );
    my $sentences = umrlib::read_umr_file($file, \%filehash);
    my $n = scalar(@{$sentences});
    my $n_tokens = 0;
    foreach my $sentence (@{$sentences})
    {
        umrlib::parse_sentence_tokens($sentence);
        my $n_tokens_sentence = scalar(@{$sentence->{tokens}});
        $n_tokens += $n_tokens_sentence;
    }
    print("\t$n sentences\n");
    print("\t$n_tokens tokens\n");
    $total_sentences += $n;
    $total_tokens += $n_tokens;
}
if(scalar(@ARGV)>1)
{
    my $n = scalar(@ARGV);
    print("TOTAL $n files\n");
    print("TOTAL $total_sentences sentences\n");
    print("TOTAL $total_tokens tokens\n");
}
