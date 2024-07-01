#!/usr/bin/env perl
# Reads segmented and tokenized text (one sentence per line, spaces between tokens on the line).
# Generates a template for a corresponding UMR file: Initial comments for each
# of the four annotation blocks, a concept node (including variable) for each
# token (unused nodes can be later deleted) and initial token-node alignment
# (it will have to be adjusted when some nodes are deleted and other nodes
# cover multiple input tokens).
# Future work: Run UDPipe on untokenized text, use lemmas, use the tree structure.
# Copyright © 2024 Dan Zeman <zeman@ufal.mff.cuni.cz>
# License: GNU GPL

use utf8;
use open ':utf8';
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
binmode(STDERR, ':utf8');

sub usage
{
    print STDERR ("Usage: perl sentlines2umr.pl < one_sentence_per_line.txt > umr_template.txt\n");
}

my $isnt = 0;
while(<>)
{
    $isnt++;
    s/\r?\n$//;
    my $sentence = $_;
    $sentence =~ s/^\s+//;
    $sentence =~ s/\s+$//;
    my @tokens = split(/\s+/, $sentence);
    my @indices;
    for(my $i = 0; $i <= $#tokens; $i++)
    {
        push(@indices, $i+1);
    }
    # Typically we need to pad the index with spaces to the length of the token.
    # But it is also possible that the token is one character and the index two.
    my @padded_tokens;
    my @padded_indices;
    my %variables;
    my @variables;
    for(my $i = 0; $i <= $#tokens; $i++)
    {
        my $lt = length($tokens[$i]);
        my $li = length($indices[$i]);
        my $l = $lt > $li ? $lt : $li;
        my $padded_token = $tokens[$i].(' ' x ($l-$lt));
        my $padded_index = $indices[$i].(' ' x ($l-$li));
        push(@padded_tokens, $padded_token);
        push(@padded_indices, $padded_index);
        my $variable;
        $variable = generate_variable($isnt, $tokens[$i], \%variables) unless($tokens[$i] =~ m/^\pP+$/);
        push(@variables, $variable);
    }
    print("\# :: snt$isnt\n");
    print('Index:               ', join(' ', @padded_indices), "\n");
    print('Words:               ', join(' ', @padded_tokens), "\n");
    print("Word Gloss (en):\n");
    # In this version we do not have the untokenized sentence available.
    # So we will just print the tokens, heuristically remove some spaces and let the annotator undo the rest of tokenization where necessary.
    my $sentence = join(' ', @tokens);
    $sentence =~ s/ ([,;:\.])/$1/g;
    print("Sentence:            $sentence\n");
    print("Sentence Gloss (en):\n");
    print("\n");
    print("\# sentence level graph:\n");
    for(my $i = 0; $i <= $#tokens; $i++)
    {
        print("($variables[$i] / $tokens[$i])\n") if(defined($variables[$i]));
    }
    print("\n");
    print("\# alignment:\n");
    for(my $i = 0; $i <= $#tokens; $i++)
    {
        print("$variables[$i]: $indices[$i]-$indices[$i]\n") if(defined($variables[$i]));
    }
    print("\n");
    print("\# document level annotation:\n");
    print("(s${isnt}s0 / sentence\n");
    print("    :temporal ((document-creation-time :before xxx))\n");
    print("    :modal ((root :modal author)))\n");
    print("\n\n");
}



#------------------------------------------------------------------------------
# Takes sentence number, word and the hash of already generated variables
# (node ids). Generates a new variable for the word, returns the variable but
# also saves it in the hash.
#------------------------------------------------------------------------------
sub generate_variable
{
    my $sentence_number = shift;
    my $word = shift;
    my $variables = shift; # hash reference
    die if($sentence_number !~ m/^[1-9][0-9]*$/);
    $word = lc($word);
    # Get rid of diacritics. Currently recognizes only Czech diacritics.
    $word =~ tr/áčďéěíňóřšťúůýž/acdeeinorstuuyz/;
    my $letter = substr($word, 0, 1);
    $letter = 'x' if($letter !~ m/^[a-z]$/);
    my $variable0 = 's'.$sentence_number.$letter;
    my $variable = $variable0;
    my $number = 1; # we will never add 0 or 1; first increment will go to 2
    while(exists($variables->{$variable}))
    {
        $number++;
        $variable = $variable0.$number;
    }
    $variables->{$variable}++;
    return $variable;
}
