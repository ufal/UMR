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
    for(my $i = 0; $i < $n; $i++)
    {
        parse_sentence_tokens(\%file, $i);
        parse_sentence_graph(\%file, $i);
        parse_sentence_alignments(\%file, $i);
    }
    push(@files, \%file);
}
print("\n");
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
        printf STDERR ("WARNING: Missing the token block in sentence %d of file %s (lines %d–%d).\n", $i_sentence+1, $file->{label}, $sentence->{line0}, $sentence->{line1});
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
        printf STDERR ("WARNING: No tokens found the token block (lines %d–%d) in sentence %d of file %s.\n", $token_block->{line0}, $token_block->{line1}, $i_sentence+1, $file->{label});
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
        printf STDERR ("WARNING: Missing the sentence graph block in sentence %d of file %s (lines %d–%d).\n", $i_sentence+1, $file->{label}, $sentence->{line0}, $sentence->{line1});
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
        printf STDERR ("WARNING: Missing the alignment block in sentence %d of file %s (lines %d–%d).\n", $i_sentence+1, $file->{label}, $sentence->{line0}, $sentence->{line1});
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
# Compares two UMR files that have been read to memory (takes the hashes with
# their contents, prints the comparison to STDOUT).
#------------------------------------------------------------------------------
sub compare_files
{
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
    print("-------------------------------------------------------------------------------\n");
    print("SUMMARY:\n");
    print("Number of nodes per file: ", join(', ', map {"$_->{label}:$_->{stats}{n_nodes}"} (@files)), "\n");
    # Compare node alignments for each pair of files. Although both files may
    # come from annotators, imagine that the first file is the gold standard
    # and the second file is evaluated against it; the numbers are then P, R, F.
    print("File-to-file node mapping:\n");
    for(my $i = 0; $i <= $#files; $i++)
    {
        my $labeli = $files[$i]{label};
        my $ni_total = $files[$i]{stats}{n_nodes};
        next if($ni_total == 0);
        for(my $j = $i+1; $j <= $#files; $j++)
        {
            my $labelj = $files[$j]{label};
            my $nj_total = $files[$j]{stats}{n_nodes};
            next if($nj_total == 0);
            my $ni_mapped = $files[$i]{stats}{crossfile}{$labelj};
            my $nj_mapped = $files[$j]{stats}{crossfile}{$labeli};
            my $ni_mapped2 = $files[$i]{stats}{crossfile2}{$labelj} // 0;
            my $nj_mapped2 = $files[$j]{stats}{crossfile2}{$labeli} // 0;
            # Precision: nodes mapped from j to i / total j nodes (how much of what we found we should have found).
            # Recall: nodes mapped from i to j / total i nodes (how much of what we should have found we found).
            my $p = $nj_mapped/$nj_total;
            my $r = $ni_mapped/$ni_total;
            my $f = 2*$p*$r/($p+$r);
            printf("Out of %d total %s nodes, %d mapped to %s (%d ambiguously) => recall    = %d%%.\n", $ni_total, $labeli, $ni_mapped, $labelj, $ni_mapped2, $r*100+0.5);
            printf("Out of %d total %s nodes, %d mapped to %s (%d ambiguously) => precision = %d%%.\n", $nj_total, $labelj, $nj_mapped, $labeli, $nj_mapped2, $p*100+0.5);
            printf(" => F₁($labeli,$labelj) = %d%%.\n", $f*100+0.5);
            print("Concept and relation comparisons (for unmapped nodes all counted as incorrect):\n");
            my $cr_correct = $files[$i]{stats}{cr}{$labelj}{correct};
            my $cr_total_me = $files[$i]{stats}{cr}{$labelj}{total_me};
            my $cr_total_other = $files[$i]{stats}{cr}{$labelj}{total_other};
            $r = $cr_total_me > 0 ? $cr_correct/$cr_total_me : 0;
            $p = $cr_total_other > 0 ? $cr_correct/$cr_total_other : 0;
            $f = 2*$p*$r/($p+$r);
            printf("Out of %d non-empty %s values, %d found in %s => recall    %d%%.\n", $cr_total_me, $labeli, $cr_correct, $labelj, $r*100+0.5);
            printf("Out of %d non-empty %s values, %d found in %s => precision %d%%.\n", $cr_total_other, $labelj, $cr_correct, $labeli, $p*100+0.5);
            printf(" => juːmæʧ ($labeli, $labelj) = F₁ = %d%%.\n", $f*100+0.5); # místo "t͡ʃ" lze případně použít "ʧ"
        }
    }
}



#------------------------------------------------------------------------------
# Compares one sentence in two or more files.
#------------------------------------------------------------------------------
sub compare_sentence
{
    my $i_sentence = shift;
    my @files = @_;
    confess("Not enough files to compare") if(scalar(@files) < 2);
    # Print the sentence graphs side-by-side.
    my @table;
    my @labels = map {$_->{label}} (@files);
    push(@table, \@labels);
    for(my $j = 0; ; $j++)
    {
        my @row;
        my $something = 0;
        foreach my $file (@files)
        {
            if($j <= $#{$file->{sentences}[$i_sentence]{blocks}[1]{lines}})
            {
                push(@row, $file->{sentences}[$i_sentence]{blocks}[1]{lines}[$j]);
                $something = 1;
            }
            else
            {
                push(@row, '');
            }
        }
        if($something)
        {
            push(@table, \@row);
        }
        else
        {
            last;
        }
    }
    print("\n");
    print_table(@table);
    print("\n");
    # Assume it has been checked that the sentence has the same tokens in all files.
    my $tokens = $files[0]{sentences}[$i_sentence]{tokens};
    # Get the mapping between tokens of the sentence and nodes in each file.
    map_node_alignments($i_sentence, @files);
    compute_crossfile_node_references($i_sentence, @files);
    print("Node-token alignments:\n");
    # Print the unaligned nodes.
    foreach my $file (@files)
    {
        my $label = $file->{label};
        my $nodes = $file->{sentences}[$i_sentence]{nodes};
        my @unaligned = @{$file->{sentences}[$i_sentence]{unaligned_nodes}};
        printf("File %s: %d nodes unaligned: %s.\n", $label, scalar(@unaligned), join(', ', map {"$_/$nodes->{$_}{econcept}"} (@unaligned)));
    }
    # Print the tokens and nodes aligned to them in each file.
    @table = ();
    push(@table, ['', '', map {$_->{label}} (@files)]);
    for(my $j = 0; $j <= $#{$tokens}; $j++)
    {
        push(@table, [$j+1, $tokens->[$j], map {join(', ', @{$_->{sentences}[$i_sentence]{aligned_nodes_by_token}[$j]})} (@files)]);
    }
    print_table(@table);
    print("\n");
    # Perform node-to-node comparisons.
    print("Node-node correspondences:\n\n");
    for(my $i = 0; $i <= $#files; $i++)
    {
        for(my $j = $i+1; $j <= $#files; $j++)
        {
            unless($j == $i)
            {
                # So far the results are not completely symmetric, although
                # usually they are. But if we want to see where they are not,
                # we must run the comparison in both directions.
                compare_node_correspondences($files[$i], $files[$j], $i_sentence);
                compare_node_correspondences($files[$j], $files[$i], $i_sentence);
                compare_node_attributes($files[$i], $files[$j], $i_sentence);
                compare_node_attributes($files[$j], $files[$i], $i_sentence);
            }
        }
    }
}



#------------------------------------------------------------------------------
# Takes a sentence number and a list of file hashes. In each file, examines the
# node-token alignments in the given sentence. Returns a list of hashes indexed
# by file labels, where the first hash contains the unaligned nodes in each
# file, the subsequent hashes correspond to tokens and give the nodes aligned
# to that token in each file (the same node can be aligned to multiple tokens,
# and one token can be aligned to multiple nodes in the same file). In each of
# the file-indexed hashes, the value is a list of variables (i.e., node ids,
# not directly the node objects).
#
# New:
# The node lists are saved directly in the respective file/sentence hashes.
# Each file has a list of unaligned nodes, and then for each token a list of
# nodes aligned to that token.
#------------------------------------------------------------------------------
sub map_node_alignments
{
    my $i_sentence = shift;
    my @files = @_;
    # Assume it has been checked that the sentence has the same tokens in all files.
    my $tokens = $files[0]{sentences}[$i_sentence]{tokens};
    foreach my $file (@files)
    {
        my $sentence = $file->{sentences}[$i_sentence];
        my $nodes = $sentence->{nodes};
        my @variables = sort(keys(%{$nodes}));
        my @unaligned = grep {!defined($nodes->{$_}{alignment})} (@variables);
        $sentence->{unaligned_nodes} = \@unaligned;
        $sentence->{aligned_nodes_by_token} = [];
        for(my $j = 0; $j <= $#{$tokens}; $j++)
        {
            my @aligned = map {$nodes->{$_}{variable}} (grep {defined($nodes->{$_}{alignment}) && $nodes->{$_}{alignment}[$j]} (@variables));
            $sentence->{aligned_nodes_by_token}[$j] = \@aligned;
        }
        $file->{stats}{n_nodes} += scalar(@variables);
    }
}



#------------------------------------------------------------------------------
# Takes a sentence number and a list of file hashes, assumes that
# map_node_alignments() has been called already. Computes the cross-references
# between nodes of each pair of files for the given sentence.
#------------------------------------------------------------------------------
sub compute_crossfile_node_references
{
    my $i_sentence = shift;
    my @files = @_;
    # Assume it has been checked that the sentence has the same tokens in all files.
    my $tokens = $files[0]{sentences}[$i_sentence]{tokens};
    # Try to map nodes from different files to each other.
    # Each node should have pointers to all other files.
    # In each foreign file it would link to those nodes whose alignment has at least one token in common with the alignment of the source node. These relations are symmetric.
    # (But if a node in file A corresponds to multiple nodes in file B, we will have hard time with scoring them.)
    for(my $j = 0; $j <= $#{$tokens}; $j++)
    {
        foreach my $file1 (@files)
        {
            my $sentence1 = $file1->{sentences}[$i_sentence];
            foreach my $f1var (@{$sentence1->{aligned_nodes_by_token}[$j]})
            {
                my $node1 = $sentence1->{nodes}{$f1var};
                foreach my $file2 (@files)
                {
                    unless($file2 == $file1)
                    {
                        my $label2 = $file2->{label};
                        my $sentence2 = $file2->{sentences}[$i_sentence];
                        foreach my $f2var (@{$sentence2->{aligned_nodes_by_token}[$j]})
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
        my $sentence1 = $file1->{sentences}[$i_sentence];
        foreach my $f1var (@{$sentence1->{unaligned_nodes}})
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
                    foreach my $f2var (@{$sentence2->{unaligned_nodes}})
                    {
                        my $node2 = $sentence2->{nodes}{$f2var};
                        my $concept2 = $node2->{econcept};
                        $concepts2{$f2var} = $concept2;
                    }
                    my @same_concept_nodes = grep {$concepts2{$_} eq $concept1} (@{$sentence2->{unaligned_nodes}});
                    if(scalar(@same_concept_nodes) == 1)
                    {
                        $node1->{crossfile}{$label2}{$same_concept_nodes[0]}++;
                    }
                }
            }
        }
    }
    # Try to symmetrize the node-node alignments.
    for(my $i = 0; $i <= $#files; $i++)
    {
        for(my $j = $i+1; $j <= $#files; $j++)
        {
            symmetrize_node_projection($files[$i], $files[$j], $i_sentence);
        }
    }
    # Update the statistics about cross-file node mappings.
    foreach my $file1 (@files)
    {
        my $sentence1 = $file1->{sentences}[$i_sentence];
        my @variables1 = sort(keys(%{$sentence1->{nodes}}));
        foreach my $variable1 (@variables1)
        {
            my $node1 = $sentence1->{nodes}{$variable1};
            foreach my $file2 (@files)
            {
                my $label2 = $file2->{label};
                my $n_targets = scalar(keys(%{$node1->{crossfile}{$label2}}));
                $file1->{stats}{crossfile}{$label2}++ if($n_targets > 0);
                $file1->{stats}{crossfile2}{$label2}++ if($n_targets > 1);
            }
        }
    }
}



#------------------------------------------------------------------------------
# Takes annotation of the same sentence in two different files. Assumes that
# initial cross-file node projections have been already computed, but some of
# them may be 1:N projections (from either file to the other one). Gradually
# removes nodes from the projections until all projections are 1:1, symmetric.
#------------------------------------------------------------------------------
sub symmetrize_node_projection
{
    my $file0 = shift;
    my $file1 = shift;
    my $i_sentence = shift;
    my $label0 = $file0->{label};
    my $label1 = $file1->{label};
    my $sentence0 = $file0->{sentences}[$i_sentence];
    my $sentence1 = $file1->{sentences}[$i_sentence];
    my @variables0 = sort(keys(%{$sentence0->{nodes}}));
    my @variables1 = sort(keys(%{$sentence1->{nodes}}));
    my $first_round = 1;
    while(1)
    {
        my @to_resolve = ();
        foreach my $variable (@variables0)
        {
            my $n = $sentence0->{nodes}{$variable};
            my @cf = sort(keys(%{$n->{crossfile}{$label1}}));
            # Purge the links. Remove those whose symmetric link is no longer available.
            # Initially all links are symmetric but this could be result of selecting
            # the winner of an ambiguity.
            for(my $i = 0; $i <= $#cf; $i++)
            {
                if(!exists($sentence1->{nodes}{$cf[$i]}{crossfile}{$label0}{$variable}))
                {
                    delete($n->{crossfile}{$label1}{$cf[$i]});
                    splice(@cf, $i, 1);
                    $i--;
                }
            }
            my $ncf = scalar(@cf);
            if($ncf > 1)
            {
                my $node_text = node_as_string($label0, $n);
                my $cf_text = list_of_node_variables_as_string($label1, $sentence1, @cf);
                print("Ambiguous projection of $node_text to $ncf $cf_text\n") if($first_round);
                foreach my $cf (@cf)
                {
                    my $comparison = compare_two_nodes($n, $sentence0->{nodes}, $sentence1->{nodes}{$cf}, $sentence1->{nodes}, $label1);
                    push(@to_resolve, {'srcnode' => $n, 'tgtnode' => $sentence1->{nodes}{$cf}, 'srclabel' => $label0, 'tgtlabel' => $label1, 'attribute_match' => $comparison->{correct}});
                }
            }
        }
        foreach my $variable (@variables1)
        {
            my $n = $sentence1->{nodes}{$variable};
            my @cf = sort(keys(%{$n->{crossfile}{$label0}}));
            # Purge the links. Remove those whose symmetric link is no longer available.
            # Initially all links are symmetric but this could be result of selecting
            # the winner of an ambiguity.
            for(my $i = 0; $i <= $#cf; $i++)
            {
                if(!exists($sentence0->{nodes}{$cf[$i]}{crossfile}{$label1}{$variable}))
                {
                    delete($n->{crossfile}{$label0}{$cf[$i]});
                    splice(@cf, $i, 1);
                    $i--;
                }
            }
            my $ncf = scalar(@cf);
            if($ncf > 1)
            {
                my $node_text = node_as_string($label1, $n);
                my $cf_text = list_of_node_variables_as_string($label0, $sentence0, @cf);
                my $cf = join(', ', @cf);
                print("Ambiguous projection of $node_text to $ncf $cf_text\n") if($first_round);
                foreach my $cf (@cf)
                {
                    my $comparison = compare_two_nodes($n, $sentence1->{nodes}, $sentence0->{nodes}{$cf}, $sentence0->{nodes}, $label0);
                    push(@to_resolve, {'srcnode' => $n, 'tgtnode' => $sentence0->{nodes}{$cf}, 'srclabel' => $label1, 'tgtlabel' => $label0, 'attribute_match' => $comparison->{correct}});
                }
            }
        }
        my $n_to_resolve = scalar(@to_resolve);
        last if($n_to_resolve == 0);
        # Sort the links to resolve by importance.
        @to_resolve = sort {compare_ambiguous_links($a, $b)} (@to_resolve);
        # The first pair is now guaranteed to survive. Remove its competitors.
        my $winner = shift(@to_resolve);
        #if(scalar(@to_resolve) > 0)
        #{
        #    my $comparison = compare_ambiguous_links($winner, $to_resolve[0]);
        #    if(abs($comparison)<=1)
        #    {
        #        # The winner is not really significantly better than the second in the line.
        #        print("  The winner had to be selected based on uninteresting criteria.\n");
        #        print("  The second in the line is ", ambiguous_link_as_string($to_resolve[0]), ".\n");
        #    }
        #}
        print("  The winner is ", ambiguous_link_as_string($winner), ".\n");
        $winner->{srcnode}{crossfile}{$winner->{tgtlabel}} = {$winner->{tgtnode}{variable} => 1};
        $winner->{tgtnode}{crossfile}{$winner->{srclabel}} = {$winner->{srcnode}{variable} => 1};
        # Now we have to recompute @to_resolve because we may have kicked out many links.
        $first_round = 0;
    }
}



#------------------------------------------------------------------------------
# Provides a textual description of an ambiguous link for diagnostic purposes.
#------------------------------------------------------------------------------
sub ambiguous_link_as_string
{
    my $al = shift; # hash reference
    return node_as_string($al->{srclabel}, $al->{srcnode}).' <--> '.node_as_string($al->{tgtlabel}, $al->{tgtnode}).": econcepts=$al->{srcnode}{econcept}/$al->{tgtnode}{econcept}, match=$al->{attribute_match}";
}



#------------------------------------------------------------------------------
# Takes two hashes describing ambiguous crossfile node-node links. Compares
# them and decides which one is more important and should survive. Returns
# a negative value if the first link is better, a positive value if the second
# link is better, and 0 if they are equally good. The absolute value of the
# result indicates the criterion that decided.
#------------------------------------------------------------------------------
sub compare_ambiguous_links
{
    my $a = shift; # hash reference
    my $b = shift; # hash reference
    my $r;
    if($a->{srcnode}{econcept} eq $a->{tgtnode}{econcept} && $b->{srcnode}{econcept} ne $b->{tgtnode}{econcept})
    {
        $r = -10;
    }
    elsif($a->{srcnode}{econcept} ne $a->{tgtnode}{econcept} && $b->{srcnode}{econcept} eq $b->{tgtnode}{econcept})
    {
        $r = 10;
    }
    else
    {
        $r = 3*($b->{attribute_match} <=> $a->{attribute_match});
        unless($r)
        {
            # Alignment to longer words is better (try to avoid aligning to function words).
            $r = 2*(length($b->{srcnode}{aligned_text})+length($b->{tgtnode}{aligned_text}) <=> length($a->{srcnode}{aligned_text})+length($a->{tgtnode}{aligned_text}));
            ###!!! This is the last resort and there should be better sorting criteria before.
            unless($r)
            {
                $r = $a->{srcnode}{variable}.$a->{tgtnode}{variable} cmp $b->{srcnode}{variable}.$b->{tgtnode}{variable};
            }
        }
    }
    return $r;
}



#------------------------------------------------------------------------------
# Provides a textual description of a node for diagnostic purposes.
#------------------------------------------------------------------------------
sub node_as_string
{
    my $file_label = shift;
    my $node = shift;
    my $variable = $node->{variable};
    my $text = $node->{aligned_text} || $node->{econcept};
    return "$file_label node $variable ($text)";
}



#------------------------------------------------------------------------------
# Provides a textual description of list of nodes for diagnostic purposes.
#------------------------------------------------------------------------------
sub list_of_node_variables_as_string
{
    my $file_label = shift;
    my $sentence = shift;
    my @variables = @_;
    my $result = "$file_label nodes [";
    my @resultlist;
    foreach my $variable (@variables)
    {
        my $node = $sentence->{nodes}{$variable};
        my $text = $node->{aligned_text} || $node->{econcept};
        push(@resultlist, "$variable ($text)");
    }
    $result .= join(', ', @resultlist)."]";
    return $result;
}



#------------------------------------------------------------------------------
# Takes two file hashes and a sentence number. Examines node-to-node cross-
# references from the first file to the second file and prints a summary.
#------------------------------------------------------------------------------
sub compare_node_correspondences
{
    my $file0 = shift;
    my $file1 = shift;
    my $i_sentence = shift;
    my $label0 = $file0->{label};
    my $label1 = $file1->{label};
    my $sentence0 = $file0->{sentences}[$i_sentence];
    my $n_aligned = 0;
    my $n_total = 0;
    my @table = ();
    foreach my $f0var (sort(keys(%{$sentence0->{nodes}})))
    {
        my $n0 = $sentence0->{nodes}{$f0var};
        my $t0 = $n0->{aligned_text} || $n0->{econcept};
        my @cf1 = sort(keys(%{$n0->{crossfile}{$label1}}));
        my $aligned = scalar(@cf1) > 0;
        my $cf1 = join(', ', @cf1) || ''; # we could put '???' here but it does not catch the eye
        push(@table, ["Correspondence $label0 $f0var", "($t0)", "= $label1 $cf1"]);
        $n_aligned++ if($aligned);
        $n_total++;
    }
    print_table(@table);
    print("\n");
    printf("Aligned %d out of %d %s nodes, that is %d%%.\n", $n_aligned, $n_total, $label0, $n_total > 0 ? $n_aligned/$n_total*100+0.5 : 0);
    print("\n");
}



#------------------------------------------------------------------------------
# Takes two file hashes and a sentence number, compares the nodes of the given
# sentence in the two files. ###!!! CURRENTLY NOT SYMMETRIC!
# For each node of the left file, considers the corresponding nodes in the
# right file.
# - If there are 0 counterparts: do nothing.
# - If there is 1 counterpart: compare their attributes/relations.
# - If there are multiple counterparts: ###!!! FOR NOW TAKE THE FIRST ONE.
#------------------------------------------------------------------------------
sub compare_node_attributes
{
    my $file0 = shift;
    my $file1 = shift;
    my $i_sentence = shift;
    my $label0 = $file0->{label};
    my $label1 = $file1->{label};
    my $sentence0 = $file0->{sentences}[$i_sentence];
    my $sentence1 = $file1->{sentences}[$i_sentence];
    print("Comparing attributes of $label0 nodes with their $label1 counterparts.\n");
    my $n_total_0;
    my $n_total_1;
    my $n_correct;
    my @table;
    foreach my $f0var (sort(keys(%{$sentence0->{nodes}})))
    {
        my $node0 = $sentence0->{nodes}{$f0var};
        my $concept0 = $node0->{concept};
        my $text0 = $node0->{aligned_text} ? " ($node0->{aligned_text})" : '';
        my @cf1 = sort(keys(%{$node0->{crossfile}{$label1}}));
        my $ncf1 = scalar(@cf1);
        my @results;
        my $max_i;
        my $max_correct;
        if($ncf1 == 0)
        {
            $results[0] = compare_two_nodes($node0, $sentence0->{nodes}, undef);
            $max_i = 0;
        }
        # If there are multiple counterparts, compare $node0 with all of them and
        # select the best match (i.e., highest number of correct comparisons).
        # (Alternatively, we could do some averaging, but the idea is that $node0
        # really maps only to one of those nodes, we just are not sure which one.)
        foreach my $cf1 (@cf1)
        {
            my $node1 = $sentence1->{nodes}{$cf1};
            my $result = compare_two_nodes($node0, $sentence0->{nodes}, $node1, $sentence1->{nodes}, $label1);
            push(@results, $result);
            if(!defined($max_correct) || $result->{correct} > $max_correct)
            {
                $max_correct = $result->{correct};
                $max_i = $#results;
            }
        }
        $n_total_0 += $results[$max_i]{total0};
        $n_total_1 += $results[$max_i]{total1};
        $n_correct += $results[$max_i]{correct};
        foreach my $mismatch (@{$results[$max_i]{mismatches}})
        {
            push(@table, ["Node $label0 $f0var / $concept0$text0", "mismatch in $mismatch->[0]:", "$label0 = $mismatch->[1]", "$label1 = $mismatch->[2]"]);
        }
    }
    # Also count unaligned nodes of $file1 (aligned ones were already reached through alignments from $file0).
    foreach my $f1var (sort(keys(%{$sentence1->{nodes}})))
    {
        my $node1 = $sentence1->{nodes}{$f1var};
        my $concept1 = $node1->{concept};
        my $text1 = $node1->{aligned_text} ? " ($node1->{aligned_text})" : '';
        my @cf0 = sort(keys(%{$node1->{crossfile}{$label0}}));
        my $ncf0 = scalar(@cf0);
        if($ncf0 == 0)
        {
            my $result = compare_two_nodes($node1, $sentence1->{nodes}, undef);
            $n_total_1 += $result->{total0};
            foreach my $mismatch (@{$result->{mismatches}})
            {
                push(@table, ["Node $label1 $f1var / $concept1$text1", "mismatch in $mismatch->[0]:", "$label1 = $mismatch->[1]", "$label0 = $mismatch->[2]"]);
            }
        }
    }
    print_table(@table);
    print("\n");
    printf("Correct %d out of %d non-empty %s values => recall    %d%%.\n", $n_correct, $n_total_0, $label0, $n_total_0 > 0 ? $n_correct/$n_total_0*100+0.5 : 0);
    printf("Correct %d out of %d non-empty %s values => precision %d%%.\n", $n_correct, $n_total_1, $label1, $n_total_1 > 0 ? $n_correct/$n_total_1*100+0.5 : 0);
    print("\n");
    $file0->{stats}{cr}{$label1}{correct} += $n_correct;
    $file0->{stats}{cr}{$label1}{total_me} += $n_total_0;
    $file0->{stats}{cr}{$label1}{total_other} += $n_total_1;
}



#------------------------------------------------------------------------------
# Compares concepts and relations of two corresponding nodes. If a node has two
# or more ambiguous counterparts, this function can be called for all pairs and
# then the values must be aggregated somehow. Besides the nodes to be compared,
# the function also needs access to the other nodes in their respective
# sentences because if the value of a relation is a child node, the function
# must be able to access the child node's mapping to the other file.
# The function can be called with $node1 undefined if we did not find any
# mapping for $node0. Then it will merely collect the attributes of $node0 and
# consider them all incorrect.
#------------------------------------------------------------------------------
sub compare_two_nodes
{
    my $node0 = shift; # hash reference (node object)
    my $nodes0 = shift; # hash reference, indexed by variables
    my $node1 = shift; # hash reference (node object)
    my $nodes1 = shift; # hash reference, indexed by variables
    my $label1 = shift; # label of the file of $node1
    my $n_correct = 0;
    my @mismatches;
    # Collect attribute-value-modified value triples from both nodes.
    # Modified value applies to node variables, which have to be translated to the other file.
    my @pairs0 = get_node_attributes_mapped($node0, $nodes0, $label1);
    my $n_total_0 = scalar(@pairs0);
    if(!defined($node1))
    {
        foreach my $p0 (@pairs0)
        {
            push(@mismatches, [$p0->[0], $p0->[1], 'UNMAPPED']);
        }
        return {'total0' => $n_total_0, 'total1' => 0, 'correct' => $n_correct, 'mismatches' => \@mismatches};
    }
    my @pairs1 = get_node_attributes_mapped($node1, $nodes1, undef);
    my $n_total_1 = scalar(@pairs1);
    # How many pairs are found in both nodes?
    foreach my $p0 (@pairs0)
    {
        # Compare modified value (->[2]) from $p0 with unmodified value (->[1]) from $p1.
        my $found = scalar(grep {$_->[0] eq $p0->[0] && $_->[1] eq $p0->[2]} (@pairs1));
        if($found)
        {
            $n_correct++;
        }
        else
        {
            # If the other node does not have this attribute with any value, show a single-way mismatch here.
            # If the other node has exactly one such attribute but with a different value, show a merged mismatch on one line.
            # If the other node has multiple such attributes, all with unmatching values, show a single-way mismatch here and leave the opposite ways for later.
            my @same_attribute0 = grep {$_->[0] eq $p0->[0]} (@pairs0);
            my @same_attribute1 = grep {$_->[0] eq $p0->[0]} (@pairs1);
            if(scalar(@same_attribute0) == 1 && scalar(@same_attribute1) == 1)
            {
                push(@mismatches, [$p0->[0], $p0->[1], $same_attribute1[0][1]]);
            }
            else
            {
                push(@mismatches, [$p0->[0], $p0->[1], '']);
            }
        }
    }
    # We already know the counts needed for precision and recall but we have not
    # collected the remaining mismatches from the other node.
    foreach my $p1 (@pairs1)
    {
        # Compare modified value (->[2]) from $p0 with unmodified value (->[1]) from $p1.
        my $found = scalar(grep {$_->[0] eq $p1->[0] && $_->[2] eq $p1->[1]} (@pairs0));
        if(!$found)
        {
            # Skip the merged mismatches that have been already reported. Report the rest.
            my @same_attribute0 = grep {$_->[0] eq $p1->[0]} (@pairs0);
            my @same_attribute1 = grep {$_->[0] eq $p1->[0]} (@pairs1);
            if(scalar(@same_attribute0) != 1 || scalar(@same_attribute1) != 1)
            {
                push(@mismatches, [$p1->[0], '', $p1->[1]]);
            }
        }
    }
    return {'total0' => $n_total_0, 'total1' => $n_total_1, 'correct' => $n_correct, 'mismatches' => \@mismatches};
}



#------------------------------------------------------------------------------
# For a node, collects all attribute-value pairs (concept, edges, attributes).
# In fact it collect triples rather than pairs, because the value is returned
# twice and in some cases the second value is modified. This happens when the
# value is a variable identifying another node: The modified value is the
# corresponding variable in another file.
#------------------------------------------------------------------------------
sub get_node_attributes_mapped
{
    my $node = shift; # the node object we want to examine
    my $nodes = shift; # reference to hash of nodes in the current file/sentence
    my $other_label = shift; # label of the other file to which we want to map variables; undef if we do not want to map variables (if compairing two nodes we must map one and keep the other intact)
    my @pairs;
    my $concept = $node->{concept};
    push(@pairs, ['concept', $concept, $concept]);
    my @relations = sort(keys(%{$node->{relations}}));
    foreach my $relation (@relations)
    {
        my $value = $node->{relations}{$relation};
        # We should not encounter any empty value but just in case...
        next if(!defined($value) || $value eq '');
        # If the value is the variable of another node, we must project it to the other file.
        if(defined($other_label) && exists($nodes->{$value}))
        {
            my $child = $nodes->{$value};
            my @ccf = sort(keys(%{$child->{crossfile}{$other_label}}));
            # If the child is mapped to multiple nodes in the other file, we will add it as multiple children with the same relation.
            # It is very unlikely that all the relations will find their counterparts in the other file; probably at most one.
            # Alternatively, we could count each of them as 1/N of an occurrence of a triple, or ideally pick one of them and
            # throw away the others. But we cannot know which one we should pick. (Unless we look at the node to which we will
            # compare the current one, and check whether one of the relations has its counterpart there.)
            my $nccf = scalar(@ccf);
            if($nccf == 0)
            {
                # The child node has no counterpart. Replace it with a non-variable UNMAPPED. We do not want the variable to match anything accidentally.
                push(@pairs, [$relation, "$value unmapped", 'UNMAPPED']);
            }
            else
            {
                my $ccf = join(', ', @ccf);
                foreach my $other_variable (@ccf)
                {
                    push(@pairs, [$relation, "$value mapped to $other_label $ccf", $other_variable]);
                }
            }
        }
        else
        {
            # This is an ordinary attribute rather than a relation.
            push(@pairs, [$relation, $value, $value]);
        }
    }
    return @pairs;
}



#------------------------------------------------------------------------------
# Prints a table in text mode, padding columns by spaces.
#------------------------------------------------------------------------------
sub print_table
{
    my @table = @_;
    my @max_length;
    # Figure out the required width of each column.
    foreach my $row (@table)
    {
        for(my $i = 0; $i <= $#{$row}; $i++)
        {
            my $l = length($row->[$i]);
            if($l > $max_length[$i])
            {
                $max_length[$i] = $l;
            }
        }
    }
    # Print the table.
    foreach my $row (@table)
    {
        for(my $i = 0; $i <= $#{$row}; $i++)
        {
            # Space between columns.
            print(' ') if($i > 0);
            print($row->[$i]);
            # Padding to the column width.
            print(' ' x ($max_length[$i]-length($row->[$i])));
        }
        print("\n");
    }
}
