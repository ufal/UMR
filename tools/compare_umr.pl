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
    push(@files, \%file);
}
print("\n");
###!!! Initially we support only comparing the first two files, although we can send the function all of them.
compare_files(@files);



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



#------------------------------------------------------------------------------
# Compares two UMR files that have been read to memory (takes the hashes with
# their contents, prints the comparison to STDOUT).
#------------------------------------------------------------------------------
sub compare_files
{
    ###!!! We take any number of file hashes but right now we can only compare the first two.
    my @files = @_;
    confess("Not enough files to compare") if(scalar(@files) < 2);
    # All the files should have the same number of sentences. If they do not,
    # print a warning and compare as many initial sentences as there are in all
    # the files.
    my $n_sentences = scalar(@{$files[0]{sentences}});
    my $mismatch = 0;
    for(my $i = 1; $i <= $#files; $i++)
    {
        my $current_n_sentences = scalar(@{$files[$i]{sentences}});
        if($current_n_sentences != $n_sentences)
        {
            $mismatch++;
            if($current_n_sentences < $n_sentences)
            {
                $n_sentences = $current_n_sentences;
            }
        }
    }
    if($n_sentences == 0)
    {
        confess("FATAL: At least one of the files has 0 sentences");
    }
    if($mismatch)
    {
        print STDERR ("WARNING: The files have varying numbers of sentences. Only the first $n_sentences sentences from each file will be compared.\n");
    }
    # Loop over sentence numbers, look at the same-numbered sentence in each file.
    for(my $i = 0; $i < $n_sentences; $i++)
    {
        print("-------------------------------------------------------------------------------\n");
        printf("Comparing sentence %d:\n", $i+1);
        foreach my $file (@files)
        {
            parse_sentence_tokens($file, $i);
            parse_sentence_graph($file, $i);
            parse_sentence_alignments($file, $i);
        }
        # Check that the sentence has the same tokens in all files.
        my $sentence_text;
        foreach my $file (@files)
        {
            my $sentence = $file->{sentences}[$i];
            if(!defined($sentence_text))
            {
                $sentence_text = join(' ', @{$sentence->{tokens}});
            }
            else
            {
                my $current_sentence_text = join(' ', @{$sentence->{tokens}});
                if($current_sentence_text ne $sentence_text)
                {
                    printf STDERR ("Tokens %s: %s\n", $files[0]{label}, $sentence_text);
                    printf STDERR ("Tokens %s: %s\n", $file->{label}, $current_sentence_text);
                    confess(sprintf("Mismatch in tokens of sentence %d in file %s (lines %d–%d)", $i+1, $file->{label}, $sentence->{line0}, $sentence->{line1}));
                }
            }
        }
        print(join(' ', @{$files[0]{sentences}[$i]{tokens}}), "\n");
        compare_sentence($i, @files);
    }
}



#------------------------------------------------------------------------------
# Takes a file hash and a sentence number. Parses the lines of the sentence
# tokens block in the given sentence and saves the resulting structure in the
# sentence hash. (The only reason why we need reference to the whole file is
# the label that we may need in error messages.)
#------------------------------------------------------------------------------
sub parse_sentence_tokens
{
    my $file = shift; # hash reference
    my $i_sentence = shift; # index of the sentence whose graph should be parsed
    my $sentence = $file->{sentences}[$i_sentence];
    my $token_block = $sentence->{blocks}[0];
    if(!defined($token_block))
    {
        printf STDERR ("Missing the token block in sentence %d of file %s (lines %d–%d).\n", $i_sentence+1, $file->{label}, $sentence->{line0}, $sentence->{line1});
        confess("Too few blocks");
    }
    my @tokens;
    foreach my $line (@{$token_block->{lines}})
    {
        if($line =~ m/^Words:\s*(.+)$/)
        {
            @tokens = split(/\s+/, $1);
            last;
        }
    }
    if(scalar(@tokens) == 0)
    {
        confess(sprintf STDERR ("No tokens found the token block (lines %d–%d) in sentence %d of file %s.\n", $token_block->{line0}, $token_block->{line1}, $i_sentence+1, $file->{label}));
    }
    $sentence->{tokens} = \@tokens;
}



#------------------------------------------------------------------------------
# Takes a file hash and a sentence number. Parses the lines of the sentence
# graph block in the given sentence and saves the resulting structure in the
# sentence hash. (The only reason why we need reference to the whole file is
# the label that we may need in error messages.)
#------------------------------------------------------------------------------
sub parse_sentence_graph
{
    my $file = shift; # hash reference
    my $i_sentence = shift; # index of the sentence whose graph should be parsed
    my $sentence = $file->{sentences}[$i_sentence];
    my $sgraph_block = $sentence->{blocks}[1];
    if(!defined($sgraph_block))
    {
        printf STDERR ("Missing the sentence graph block in sentence %d of file %s (lines %d–%d).\n", $i_sentence+1, $file->{label}, $sentence->{line0}, $sentence->{line1});
        confess("Too few blocks");
    }
    my %nodes; # hash indexed by variables
    $sentence->{nodes} = \%nodes;
    my $iline = $sgraph_block->{line0}-1;
    my @stack;
    my $current_relation = 'START';
    foreach my $line (@{$sgraph_block->{lines}})
    {
        $iline++;
        # Make a copy of the line that we can eat without modifying the original.
        my $cline = $line;
        # Remove comments, leading and trailing spaces.
        $cline =~ s/\#.*//;
        $cline =~ s/^\s+//;
        $cline =~ s/\s+$//;
        next if($cline eq '');
        while($cline)
        {
            if($cline =~ s:^\(\s*([\pL\pN]+)\s*/\s*([^\s\)]+)::)
            {
                # New node.
                my $variable = $1;
                my $concept = $2;
                my %node =
                (
                    'variable' => $variable,
                    'concept' => $concept,
                    'relations' => {}
                );
                #print STDERR ("variable $variable concept $concept\n");
                if(!defined($current_relation))
                {
                    confess("Not expecting new node (this is not START and there was no relation name) at line $iline of file $file->{label}");
                }
                unless($current_relation eq 'START')
                {
                    $stack[-1]{relations}{$current_relation} = $variable;
                }
                $nodes{$variable} = \%node;
                push(@stack, \%node);
                $current_relation = undef;
            }
            elsif($cline =~ s/^(:[-\pL\pN]+)\s*//)
            {
                # New relation or attribute.
                #print STDERR ("attribute $1\n");
                $current_relation = $1;
            }
            elsif($cline =~ s/^([^\s\)]+)//)
            {
                # New value of attribute or node reference for reentrant relation.
                my $value = $1;
                #print STDERR ("value $value\n");
                if(scalar(@stack) == 0)
                {
                    confess("Nodes closed prematurely; extra attribute value $1 at line $iline of file $file->{label}");
                }
                if(!defined($current_relation))
                {
                    confess("Missing relation for value $1 at line $iline of file $file->{label}");
                }
                $stack[-1]{relations}{$current_relation} = $value;
                $current_relation = undef;
            } # (
            elsif($cline =~ s/^\)//)
            {
                # Closing bracket of a node.
                if(defined($current_relation))
                {
                    confess("Missing value for relation $current_relation at line $iline of file $file->{label}");
                }
                if(scalar(@stack) == 0)
                {
                    confess("Extra closing bracket at line $iline of file $file->{label}");
                }
                #print STDERR ("Closing stack node: $stack[-1]{variable} / $stack[-1]{concept}\n");
                pop(@stack);
            }
            elsif($cline =~ s/^\s+//)
            {
                # Skip leading spaces.
            }
            else
            {
                # We should not be here.
                confess("Internal error");
            }
        }
    }
    if(scalar(@stack) > 0)
    {
        my $n = scalar(@stack);
        print STDERR ("Topmost node on stack: $stack[-1]{variable} / $stack[-1]{concept}\n");
        confess("Missing closing bracket at line $iline of file $file->{label}: $n node(s) not closed");
    }
    # Extended concepts should better identify nodes for debugging and, possibly, alignment.
    # Currently we define one extension: a 'name' concept will be extended by the values of its :opX attributes.
    foreach my $variable (sort(keys(%nodes)))
    {
        my $node = $nodes{$variable};
        my $econcept = $node->{concept};
        if($econcept eq 'name')
        {
            my @opnames = grep {m/^:op[0-9]+$/} (sort(keys(%{$node->{relations}})));
            my $name = join(' ', map {$node->{relations}{$_}} (@opnames));
            $econcept .= '['.$name.']';
        }
        $node->{econcept} = $econcept;
    }
}



#------------------------------------------------------------------------------
# Takes a file hash and a sentence number. Parses the lines of the alignment
# block in the given sentence and saves the resulting structure in the sentence
# hash. (The only reason why we need reference to the whole file is the label
# that we may need in error messages.)
#------------------------------------------------------------------------------
sub parse_sentence_alignments
{
    my $file = shift; # hash reference
    my $i_sentence = shift; # index of the sentence whose graph should be parsed
    my $sentence = $file->{sentences}[$i_sentence];
    my $alignment_block = $sentence->{blocks}[2];
    if(!defined($alignment_block))
    {
        printf STDERR ("Missing the alignment block in sentence %d of file %s (lines %d–%d).\n", $i_sentence+1, $file->{label}, $sentence->{line0}, $sentence->{line1});
        confess("Too few blocks");
    }
    my $iline = $alignment_block->{line0}-1;
    foreach my $line (@{$alignment_block->{lines}})
    {
        $iline++;
        # Make a copy of the line that we can eat without modifying the original.
        my $cline = $line;
        # Remove comments, leading and trailing spaces.
        $cline =~ s/\#.*//;
        $cline =~ s/^\s+//;
        $cline =~ s/\s+$//;
        next if($cline eq '');
        if($cline =~ m/^([\pL\pN]+):\s*([0-9]+-[0-9]+(\s*,\s*[0-9]+-[0-9]+)*)$/)
        {
            my $variable = $1;
            my $alignment = $2;
            # Assuming that the sentence graph has been parsed previously, the variable must be known.
            if(!exists($sentence->{nodes}{$variable}))
            {
                confess(sprintf("Variable %s not known in the current sentence at line %d of file %s", $variable, $iline, $file->{label}));
            }
            my $node = $sentence->{nodes}{$variable};
            # Convert the alignment to a boolean array (mask for the token array).
            # If the alignment is 0-0, convert it to undef.
            if($alignment eq '0-0')
            {
                $node->{alignment} = undef;
            }
            else
            {
                my @alignments = split(/\s*,\s*/, $alignment);
                my @mask;
                foreach my $a (@alignments)
                {
                    if($a =~ m/^([0-9]+)-([0-9]+)$/)
                    {
                        my $x = $1;
                        my $y = $2;
                        if($x == 0 || $y == 0 || $x > $y)
                        {
                            confess(sprintf("Bad alignment interval %s at line %d of file %s", $a, $iline, $file->{label}));
                        }
                        for(my $i = $x; $i <= $y; $i++)
                        {
                            $mask[$i-1]++;
                        }
                    }
                    else
                    {
                        confess("Internal error");
                    }
                }
                $node->{alignment} = \@mask;
                my @aligned_tokens = grep {defined($_)} (map {$mask[$_] ? $sentence->{tokens}[$_] : undef} (0..$#mask));
                $node->{aligned_text} = join(' ', @aligned_tokens);
            }
        }
        else
        {
            confess(sprintf("Cannot parse the alignment line %d of file %s", $iline, $file->{label}));
        }
    }
}



#------------------------------------------------------------------------------
# Compares one sentence in two or more files.
#------------------------------------------------------------------------------
sub compare_sentence
{
    my $i_sentence = shift;
    ###!!! We take any number of file hashes but right now we can only compare the first two.
    my @files = @_;
    confess("Not enough files to compare") if(scalar(@files) < 2);
    # Assume it has been checked that the sentence has the same tokens in all files.
    my $tokens = $files[0]{sentences}[$i_sentence]{tokens};
    my %unaligned; # indexed by file label, values are array references, the arrays contain node variables
    my @toktable; # array of hash references
    foreach my $file (@files)
    {
        my $label = $file->{label};
        my $sentence = $file->{sentences}[$i_sentence];
        my $nodes = $sentence->{nodes};
        my @unaligned = grep {!defined($nodes->{$_}{alignment})} (sort(keys(%{$nodes})));
        $unaligned{$label} = \@unaligned;
        printf("File %s: %d nodes unaligned: %s.\n", $label, scalar(@unaligned), join(', ', map {"$_/$nodes->{$_}{econcept}"} (@unaligned)));
        for(my $j = 0; $j <= $#{$tokens}; $j++)
        {
            $toktable[$j]{$label}{token} = $tokens->[$j];
            my @variables = map {$nodes->{$_}{variable}} (grep {defined($nodes->{$_}{alignment}) && $nodes->{$_}{alignment}[$j]} (sort(keys(%{$nodes}))));
            $toktable[$j]{$label}{variables} = \@variables;
        }
    }
    print("Tokens\t\t", join("\t", map {$_->{label}} @files), "\n");
    for(my $j = 0; $j <= $#toktable; $j++)
    {
        printf("  %d\t%s\t", $j+1, $tokens->[$j]);
        print(join("\t", map {join(', ', @{$toktable[$j]{$_->{label}}{variables}})} @files));
        print("\n");
    }
    print("\n");
    # Try to map nodes from different files to each other.
    # Each node should have pointers to all other files.
    # In each foreign file it would link to those nodes whose alignment has at least one token in common with the alignment of the source node. These relations are symmetric.
    # (But if a node in file A corresponds to multiple nodes in file B, we will have hard time with scoring them.)
    for(my $j = 0; $j <= $#toktable; $j++)
    {
        foreach my $file1 (@files)
        {
            my $label1 = $file1->{label};
            my $sentence1 = $file1->{sentences}[$i_sentence];
            foreach my $f1var (@{$toktable[$j]{$label1}{variables}})
            {
                my $node1 = $sentence1->{nodes}{$f1var};
                foreach my $file2 (@files)
                {
                    unless($file2 == $file1)
                    {
                        my $label2 = $file2->{label};
                        foreach my $f2var (@{$toktable[$j]{$label2}{variables}})
                        {
                            $node1->{crossfile}{$label2}{$f2var}++;
                        }
                    }
                }
            }
        }
    }
    # Try to map unaligned nodes based on other criteria, such as concept equivalence.
    foreach my $file1 (@files)
    {
        my $label1 = $file1->{label};
        my $sentence1 = $file1->{sentences}[$i_sentence];
        foreach my $f1var (@{$unaligned{$label1}})
        {
            my $node1 = $sentence1->{nodes}{$f1var};
            my $concept1 = $node1->{econcept};
            foreach my $file2 (@files)
            {
                unless($file2 == $file1)
                {
                    my $label2 = $file2->{label};
                    my $sentence2 = $file2->{sentences}[$i_sentence];
                    # Consider links between nodes that are unaligned in both files
                    # but do not consider links between unaligned and aligned nodes.
                    # Are there nodes in $file2 that have the same concept as $f1var?
                    my %concepts2;
                    foreach my $f2var (@{$unaligned{$label2}})
                    {
                        my $node2 = $sentence2->{nodes}{$f2var};
                        my $concept2 = $node2->{econcept};
                        $concepts2{$f2var} = $concept2;
                    }
                    my @same_concept_nodes = grep {$concepts2{$_} eq $concept1} (@{$unaligned{$label2}});
                    if(scalar(@same_concept_nodes) == 1)
                    {
                        $node1->{crossfile}{$label2}{$same_concept_nodes[0]}++;
                    }
                }
            }
        }
    }
    my $label0 = $files[0]{label};
    my $label1 = $files[1]{label};
    my $n_aligned = 0;
    my $n_total = 0;
    foreach my $f0var (sort(keys(%{$files[0]{sentences}[$i_sentence]{nodes}})))
    {
        my $n0 = $files[0]{sentences}[$i_sentence]{nodes}{$f0var};
        my $t0 = $n0->{aligned_text} || $n0->{concept};
        my @cf1 = sort(keys(%{$n0->{crossfile}{$label1}}));
        my $aligned = scalar(@cf1) > 0;
        my $cf1 = join(', ', @cf1) || '???';
        print("Correspondence $label0 $f0var ($t0) = $label1 $cf1\n");
        $n_aligned++ if($aligned);
        $n_total++;
    }
    printf("Aligned %d out of %d %s nodes, that is %d%%.\n", $n_aligned, $n_total, $label0, $n_total > 0 ? $n_aligned/$n_total*100+0.5 : 0);
    print("\n");
}
