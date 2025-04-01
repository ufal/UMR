#!/usr/bin/env perl
# Compares annotations in two UMR files.
# Copyright © 2025 Dan Zeman <zeman@ufal.mff.cuni.cz>
# License: GNU GPL

use utf8;
use open ':utf8';
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
binmode(STDERR, ':utf8');
use Carp;

sub usage
{
    print STDERR ("Usage: $0 label1 file1 label2 file2 [...]\n");
    print STDERR ("    The labels are used to refer to the files in the output.\n");
    print STDERR ("    They can be e.g. initials of the annotators, or 'GOLD' and 'SYSTEM'.\n");
    print STDERR ("Example:\n");
    print STDERR ("    perl tools\\compare_umr.pl DZ data\\czech\\mf920922-133_estonsko-DZ.txt ML data\\czech\\mf920922-133_estonsko-ML.txt\n");
}



if(scalar(@ARGV) < 4)
{
    usage();
    confess("At least four arguments (two labels and two files) expected");
}
if(scalar(@ARGV) % 2)
{
    usage();
    confess("Even number of arguments expected");
}
my @files;
while(1)
{
    my $label = shift(@ARGV);
    my $path = shift(@ARGV);
    last if(!defined($label));
    my %file =
    (
        'label' => $label,
        'path' => $path,
        'sentences' => read_umr_file($path)
    );
    my $n = scalar(@{$file{sentences}});
    print("Found $n sentences in $label:\n");
    print(join(', ', map {"$_->{line0}-$_->{line1}"} (@{$file{sentences}})), "\n");
}



#------------------------------------------------------------------------------
# Reads a UMR file into memory. Returns a reference to an array of sentence
# hashes.
#------------------------------------------------------------------------------
sub read_umr_file
{
    my $path = shift;
    my @sentences;
    my @blocks;
    my @lines;
    my $last_line_empty;
    my $iline = 0;
    open($fh, $path) or confess("Cannot read '$path': $!");
    while(<$fh>)
    {
        $iline++;
        s/\r?\n$//;
        s/\s+$//;
        if($_ eq '')
        {
            if($last_line_empty)
            {
                add_sentence(\@sentences, \@blocks);
            }
            else # last line was not empty, we are just adding a new block
            {
                add_block(\@blocks, \@lines, $iline);
            }
            $last_line_empty = 1;
        }
        else # non-empty line will be collected
        {
            push(@lines, $_);
            $last_line_empty = 0;
        }
    }
    # If the file does not end with an empty line, collect the last sentence.
    # (Such a file is invalid but this script is not a validator.)
    $iline++;
    add_block(\@blocks, \@lines, $iline);
    add_sentence(\@sentences, \@blocks);
    close($fh);
    return \@sentences;
}



#------------------------------------------------------------------------------
# Takes collected lines, creates a block that contains them, adds it to the
# current sentence, and clears the array of lines. If there are no non-empty
# lines collected, no new block will be created.
#------------------------------------------------------------------------------
sub add_block
{
    my $blocks = shift; # array ref (array of blocks)
    my $lines = shift; # array ref (array of non-empty lines collected so far)
    my $iline = shift; # current line number, 1-based (current line is the first empty line after the block, or it is the last line in the file + 1, if the file does not end with an empty line)
    my $n = scalar(@{$lines});
    return 0 if($n == 0);
    # Get the first and the last line of the block.
    my $line0 = $iline-$n;
    my $line1 = $iline-1;
    my @block_lines = @{$lines};
    my %block =
    (
        'line0' => $line0,
        'line1' => $line1,
        'lines' => \@block_lines
    );
    push(@{$blocks}, \%block);
    @{$lines} = ();
    return 1;
}



#------------------------------------------------------------------------------
# Takes collected blocks, creates a sentence that contains them, adds it to the
# array of sentences, and clears the array of blocks. If there are no blocks
# collected, no new sentence will be created.
#------------------------------------------------------------------------------
sub add_sentence
{
    my $sentences = shift; # array ref
    my $blocks = shift; # array ref
    my $n = scalar(@{$blocks});
    return 0 if($n == 0);
    my @sentence_blocks = @{$blocks};
    my %sentence =
    (
        'line0' => $blocks->[0]{line0},
        'line1' => $blocks->[-1]{line1},
        'blocks' => \@sentence_blocks
    );
    push(@{$sentences}, \%sentence);
    @{$blocks} = ();
    return 1;
}
