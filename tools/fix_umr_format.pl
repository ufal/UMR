#!/usr/bin/env perl
# Reads UMR files and tries to fix low-level formatting errors.
# Copyright © 2026 Dan Zeman <zeman@ufal.mff.cuni.cz>
# License: GNU GPL

use utf8;
use open ':utf8';
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
binmode(STDERR, ':utf8');
use Carp;



###!!! For now, hardcoded path to the UMR validator.
my $validator = '/net/work/people/zeman/umr/umr-ufal/tools/validate.py';
my $validator_options = '--level 2 --no-check-ilg --allow-forward-references --optional-alignments --no-warn-unaligned-token --no-check-wiki --optional-aspect-modstr --allow-duplicate-roles --allow-cycles --allow-coref-entity-event-mismatch';
###!!! For now, assume we are in the top folder of a UMR release, so the path to the data is known. We only need to specify the language (English is default).
#@ARGV = grep {m/^(english|chinese|czech|latin|arapaho|navajo|kukama|sanapana)$/} (map {lc($_)} (@ARGV));
@ARGV = ('english') if(scalar(@ARGV) == 0);
foreach my $arg (@ARGV)
{
    # If $arg is a single word, interpret it as language name in the umr-data-ufal-fixes repository.
    # If it contains at least one slash, interpret it as a path and do not try to modify it.
    if($arg =~ m:/:)
    {
        fix_all_files_in_folder($arg);
    }
    else
    {
        fix_all_files_in_folder("./$arg/umr_data");
    }
}



#------------------------------------------------------------------------------
# Fixes all UMR files in a folder. Their file names must end in '.umr'.
#------------------------------------------------------------------------------
sub fix_all_files_in_folder
{
    my $path = shift; # path to the folder
    opendir(my $fh, $path) or confess("Cannot read folder '$path': $!");
    my @files = sort(grep {-f "$path/$_" && m/\.umr$/} (readdir($fh)));
    closedir($fh);
    if(scalar(@files)==0)
    {
        confess("No UMR files found in '$path'");
    }
    foreach my $file (@files)
    {
        my $filepath = "$path/$file";
        print STDERR ("Fixing $filepath...\n");
        fix_file($filepath);
        print STDERR ("Validating $filepath...\n");
        system("python $validator $validator_options $filepath");
    }
}



#------------------------------------------------------------------------------
# Fixes a file in-place. Reads the whole file into memory and fixes it while
# reading. Then overwrites the original file.
#------------------------------------------------------------------------------
sub fix_file
{
    my $path = shift; # path to the file
    my $contents = '';
    my $fh;
    open($fh, $path) or confess("Cannot read '$path': $!");
    my $previous_line_empty = 0;
    while(<$fh>)
    {
        s/\r?\n$//;
        # Remove trailing whitespace.
        s/\s+$//;
        # Make sure that there is 1 empty line between blocks, 2 between sentences.
        # Assume that a new sentence starts with 80 hashtags (Jin's condition).
        if($_ eq '')
        {
            if($previous_line_empty)
            {
                next;
            }
            $previous_line_empty = 1;
        }
        else
        {
            # In some files converted from AMR, there is no empty line before the sentence level graph.
            if(m/^\# sentence level graph/ && !$previous_line_empty)
            {
                $_ = "\n$_";
            }
            $previous_line_empty = 0;
        }
        if(m/^\#{80}$/)
        {
            # Add one extra line before the next sentence.
            $_ = "\n$_";
        }
        # Normalize the various translation/glossing keywords different teams use in the first block.
        s/^Words\(English\):\s*/Word Gloss (en): /;
        s/^Morphemes\(English\):\s*/Morpheme Gloss (en): /;
        s/^Morpheme Gloss\(English\):\s*/Morpheme Gloss (en): /;
        s/^Morphemes\(Spanish\):\s*/Morpheme Gloss (es): /;
        s/^Morpheme Gloss\(Spanish\):\s*/Morpheme Gloss (es): /;
        s/^Translation\(English\):\s*/Sentence Gloss (en): /;
        # Unaligned nodes should have alignment 0-0, not -1--1.
        s/:\s*-1--1$/: 0-0/;
        # The guidelines originally defined :poss but it has been changed to :possessor (see the Google spreadsheet).
        # However, the data still occasionally contains :poss. Fix it.
        s/:poss(\s)/:possessor$1/g;
        s/:possession-of(\s)/:possessor$1/g;
        # Modal relations: The data sometimes use :AFF, :NEG, :UNSP, which have been replaced.
        s/:modstr(\s)/:modal-strength$1/g;
        s/:AFF(\s)/:full-affirmative$1/g;
        s/:NEG(\s)/:full-negative$1/g;
        s/:UNSP(\s)/:unspecified$1/g;
        # Other uppercase attribute values (from AMR).
        s/:orientation FV([1-3])/:orientation fv$1/g;
        s/:ARG1 09T20/:ARG1 09t20/g;
        $contents .= "$_\n";
    }
    # Add one extra line after the last sentence.
    $contents .= "\n";
    # Split the contents to sentences. Now we can rely on two empty lines after every sentence.
    my @sentences = split(/\n\n\n/, $contents);
    # There are empty sentences in the data converted from AMR. Remove them.
    @sentences = grep {!m/(type = not_in_release|umr-empty)/s} (@sentences);
    # Join the sentences back to one string.
    $contents = scalar(@sentences) > 0 ? join("\n\n\n", @sentences)."\n\n\n" : '';
    # Remove empty lines at the beginning of the file.
    $contents =~ s/^[\r\n]+//s;
    close($fh);
    open($fh, ">$path") or confess("Cannot write '$path': $!");
    print $fh ($contents);
    close($fh);
}
