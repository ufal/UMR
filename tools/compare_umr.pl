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
use Getopt::Long;

sub usage
{
    print STDERR ("Usage: $0 label1 file1 label2 file2 [...] [--only rel1,rel2] [--except rel1,rel2]\n");
    print STDERR ("    The labels are used to refer to the files in the output.\n");
    print STDERR ("    They can be e.g. initials of the annotators, or 'GOLD' and 'SYSTEM'.\n");
    print STDERR ("Example:\n");
    print STDERR ("    perl tools\\compare_umr.pl DZ data\\czech\\mf920922-133_estonsko-DZ.txt ML data\\czech\\mf920922-133_estonsko-ML.txt\n");
}

my $only_relations;
my $except_relations;
GetOptions
(
    'only=s'   => \$only_relations,
    'except=s' => \$except_relations
);
my %config =
(
    'only_relations'   => {},
    'except_relations' => {}
);
if(defined($only_relations))
{
    map {s/^://; $config{only_relations}{$_}++} (split(',', $only_relations));
}
if(defined($except_relations))
{
    map {s/^://; $config{except_relations}{$_}++} (split(',', $except_relations));
}
# It does not make sense to use both --only and --except but if it happens,
# remove the "except" relations from the "only" relations.
my $n_only = scalar(keys(%{$config{only_relations}}));
my $n_except = scalar(keys(%{$config{except_relations}}));
if($n_only && $n_except)
{
    foreach my $e (keys(%{$config{except_relations}}))
    {
        delete($config{only_relations}{$e});
    }
    $config{except_relations} = {};
    $n_except = 0;
    $n_only = scalar(keys(%{$config{only_relations}}));
    confess("--except relations canceled all --only relations") if($n_only == 0);
    $config{use_only} = 1;
}
elsif($n_only)
{
    $config{use_only} = 1;
}
elsif($n_except)
{
    $config{use_except} = 1;
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
    );
    $file{sentences} = read_umr_file($path, \%file);
    my $n = scalar(@{$file{sentences}});
    print("Found $n sentences in $label:\n");
    print(join(', ', map {"$_->{line0}-$_->{line1}"} (@{$file{sentences}})), "\n");
    foreach my $sentence (@{$file{sentences}})
    {
        parse_sentence_tokens($sentence);
        parse_sentence_graph($sentence);
        parse_sentence_alignments($sentence);
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
    my $file = shift; # hash ref; the sentences will get it as a back reference to their file
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
                add_sentence(\@sentences, \@blocks, $file);
            }
            else # last line was not empty, we are just adding a new block
            {
                add_block(\@blocks, \@lines, $iline, $file);
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
    add_block(\@blocks, \@lines, $iline, $file);
    add_sentence(\@sentences, \@blocks, $file);
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
    my $file = shift; # hash ref; the sentences will get it as a back reference to their file
    my $n = scalar(@{$lines});
    return 0 if($n == 0);
    # Get the first and the last line of the block.
    my $line0 = $iline-$n;
    my $line1 = $iline-1;
    my @block_lines = @{$lines};
    my %block =
    (
        'file'  => $file,
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
    my $file = shift; # hash ref; the sentences will get it as a back reference to their file
    my $n = scalar(@{$blocks});
    return 0 if($n == 0);
    my @sentence_blocks = @{$blocks};
    my %sentence =
    (
        'file'  => $file,
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
    my $sentence = shift; # hash reference
    my $file = $sentence->{file};
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
    my $sentence = shift; # hash reference
    my $file = $sentence->{file};
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
                    'relations' => []
                );
                #print STDERR ("variable $variable concept $concept\n");
                if(!defined($current_relation))
                {
                    confess("Not expecting new node (this is not START and there was no relation name) at line $iline of file $file->{label}");
                }
                unless($current_relation eq 'START')
                {
                    # A parent node may have several same-named outgoing relations to different children.
                    push(@{$stack[-1]{relations}}, {'name' => $current_relation, 'value' => $variable});
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
                push(@{$stack[-1]{relations}}, {'name' => $current_relation, 'value' => $value});
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
        print STDERR ("WARNING: Topmost node on stack: $stack[-1]{variable} / $stack[-1]{concept}\n");
        print STDERR ("WARNING: Missing closing bracket at line $iline of file $file->{label}: $n node(s) not closed.\n");
    }
    # Extended concepts should better identify nodes for debugging and, possibly, alignment.
    # Currently we define one extension: a 'name' concept will be extended by the values of its :opX attributes.
    foreach my $variable (sort(keys(%nodes)))
    {
        my $node = $nodes{$variable};
        my $econcept = $node->{concept};
        if($econcept eq 'name')
        {
            my $name = join(' ', map {$_->{value}} (grep {$_->{name} =~ m/^:op[0-9]+$/} (sort {lc($a->{name}) cmp lc($b->{name})} (@{$node->{relations}}))));
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
    my $sentence = shift; # hash reference
    my $file = $sentence->{file};
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



#==============================================================================
# Multi-file comparison functions
#==============================================================================



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
        my @sentences;
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
                    printf("WARNING: Mismatch in tokens of sentence %d in file %s (lines %d–%d)", $i+1, $file->{label}, $sentence->{line0}, $sentence->{line1});
                }
            }
            push(@sentences, $sentence);
        }
        print("$sentence_text\n");
        compare_sentences(@sentences);
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
            # Summarize node projections and correspondences.
            my $labelj = $files[$j]{label};
            my $nj_total = $files[$j]{stats}{n_nodes};
            next if($nj_total == 0);
            my $ni_mapped = $files[$i]{stats}{crossfile}{$labelj};
            my $nj_mapped = $files[$j]{stats}{crossfile}{$labeli};
            # Precision: nodes mapped from j to i / total j nodes (how much of what we found we should have found).
            # Recall: nodes mapped from i to j / total i nodes (how much of what we should have found we found).
            my $p = $nj_mapped/$nj_total;
            my $r = $ni_mapped/$ni_total;
            my $f = 2*$p*$r/($p+$r);
            printf("Out of %d total %s nodes, %d mapped to %s => recall    = %d%%.\n", $ni_total, $labeli, $ni_mapped, $labelj, $r*100+0.5);
            printf("Out of %d total %s nodes, %d mapped to %s => precision = %d%%.\n", $nj_total, $labelj, $nj_mapped, $labeli, $p*100+0.5);
            printf(" => F₁($labeli,$labelj) = %d%%.\n", $f*100+0.5);
            # Summarize projections that were originally ambiguous (before we symmetrized them).
            my $ni_ambiguous_src = $files[$i]{stats}{cr}{$labelj}{nodes_with_originally_ambiguous_projection};
            my $nj_ambiguous_src = $files[$j]{stats}{cr}{$labeli}{nodes_with_originally_ambiguous_projection};
            my $ni_ambiguous_tgt = $files[$i]{stats}{cr}{$labelj}{nodes_in_originally_ambiguous_projections};
            my $nj_ambiguous_tgt = $files[$j]{stats}{cr}{$labeli}{nodes_in_originally_ambiguous_projections};
            printf("Before symmetrization, %d %s nodes were projected ambiguously to %d %s nodes.\n", $ni_ambiguous_src, $labeli, $ni_ambiguous_tgt, $labelj);
            printf("Before symmetrization, %d %s nodes were projected ambiguously to %d %s nodes.\n", $nj_ambiguous_src, $labelj, $nj_ambiguous_tgt, $labeli);
            # Summarize comparison of concepts and relations (mapped nodes only).
            print("Concept and relation comparisons (only mapped nodes; unmapped are ignored):\n");
            my $cr_correct = $files[$i]{stats}{cr}{$labelj}{correct_mapped};
            my $cr_total_me = $files[$i]{stats}{cr}{$labelj}{total_me_mapped};
            my $cr_total_other = $files[$i]{stats}{cr}{$labelj}{total_other_mapped};
            $r = $cr_total_me > 0 ? $cr_correct/$cr_total_me : 0;
            $p = $cr_total_other > 0 ? $cr_correct/$cr_total_other : 0;
            $f = 2*$p*$r/($p+$r);
            printf("Out of %d non-empty %s values, %d found in %s => recall    %d%%.\n", $cr_total_me, $labeli, $cr_correct, $labelj, $r*100+0.5);
            printf("Out of %d non-empty %s values, %d found in %s => precision %d%%.\n", $cr_total_other, $labelj, $cr_correct, $labeli, $p*100+0.5);
            printf(" => F₁ = %d%%.\n", $f*100+0.5);
            # Summarize comparison of concepts and relations.
            print("Concept and relation comparisons (for unmapped nodes all counted as incorrect):\n");
            $cr_correct = $files[$i]{stats}{cr}{$labelj}{correct};
            $cr_total_me = $files[$i]{stats}{cr}{$labelj}{total_me};
            $cr_total_other = $files[$i]{stats}{cr}{$labelj}{total_other};
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
# Compares corresponding sentences in two or more files.
#------------------------------------------------------------------------------
sub compare_sentences
{
    my @sentences = @_;
    confess("Not enough sentences to compare") if(scalar(@sentences) < 2);
    # Print the sentence graphs side-by-side.
    my @table;
    my @labels = map {$_->{label}} (@files);
    push(@table, \@labels);
    for(my $j = 0; ; $j++)
    {
        my @row;
        my $something = 0;
        foreach my $sentence (@sentences)
        {
            if($j <= $#{$sentence->{blocks}[1]{lines}})
            {
                push(@row, $sentence->{blocks}[1]{lines}[$j]);
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
    my $tokens = $sentences[0]{tokens};
    # Get the mapping between tokens of the sentence and nodes in each file.
    map_node_alignments(@sentences);
    compute_crossfile_node_references(@sentences);
    print("Node-token alignments:\n");
    # Print the unaligned nodes.
    foreach my $sentence (@sentences)
    {
        my $label = $sentence->{file}{label};
        my $nodes = $sentence->{nodes};
        my @unaligned = @{$sentence->{unaligned_nodes}};
        printf("File %s: %d nodes unaligned: %s.\n", $label, scalar(@unaligned), join(', ', map {"$_/$nodes->{$_}{econcept}"} (@unaligned)));
    }
    # Print the tokens and nodes aligned to them in each file.
    @table = ();
    push(@table, ['', '', map {$_->{file}{label}} (@sentences)]);
    for(my $j = 0; $j <= $#{$tokens}; $j++)
    {
        push(@table, [$j+1, $tokens->[$j], map {join(', ', @{$_->{aligned_nodes_by_token}[$j]})} (@sentences)]);
    }
    print_table(@table);
    print("\n");
    # Perform node-to-node comparisons.
    print("Node-node correspondences:\n\n");
    for(my $i = 0; $i <= $#sentences; $i++)
    {
        for(my $j = $i+1; $j <= $#sentences; $j++)
        {
            # Perform symmetric comparison of the two sentences.
            compare_two_sentences($sentences[$i], $sentences[$j]);
        }
    }
}



#------------------------------------------------------------------------------
# Takes a list of sentence hashes, holding corresponding sentences in different
# files. In each file, examines the node-token alignments in the given sentence.
# Saves two new lists of nodes in each sentence hash. The first list contains
# unaligned nodes. The second list is organized by sentence tokens, each token
# has a list of nodes aligned to it. In both cases, the lists contain variables
# that identify the nodes, not directly the node hashes.
#------------------------------------------------------------------------------
sub map_node_alignments
{
    my @sentences = @_;
    # Assume it has been checked that the sentence has the same tokens in all files.
    my $tokens = $sentences[0]{tokens};
    foreach my $sentence (@sentences)
    {
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
        $sentence->{file}{stats}{n_nodes} += scalar(@variables);
    }
}



#------------------------------------------------------------------------------
# Takes a list of sentence hashes, holding corresponding sentences in different
# files. Assumes that map_node_alignments() has been called already. Computes
# the cross-references between nodes of each pair of sentences.
#------------------------------------------------------------------------------
sub compute_crossfile_node_references
{
    my @sentences = @_;
    # Assume it has been checked that the sentence has the same tokens in all files.
    my $tokens = $sentences[0]{tokens};
    # Try to map nodes from different files to each other.
    # Each node should have pointers to all other files.
    # In each foreign file it would link to those nodes whose alignment has at least one token in common with the alignment of the source node. These relations are symmetric.
    # (But if a node in file A corresponds to multiple nodes in file B, we will have hard time with scoring them.)
    for(my $j = 0; $j <= $#{$tokens}; $j++)
    {
        foreach my $sentence1 (@sentences)
        {
            foreach my $f1var (@{$sentence1->{aligned_nodes_by_token}[$j]})
            {
                my $node1 = $sentence1->{nodes}{$f1var};
                foreach my $sentence2 (@sentences)
                {
                    unless($sentence2 == $sentence1)
                    {
                        my $label2 = $sentence2->{file}{label};
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
    # The way we do it may also introduce ambiguous projections, so symmetrization
    # must be run afterwards.
    for(my $i = 0; $i <= $#sentences; $i++)
    {
        $labeli = $sentences[$i]{file}{label};
        for(my $j = $i+1; $j <= $#sentences; $j++)
        {
            my $labelj = $sentences[$j]{file}{label};
            foreach my $variablei (@{$sentences[$i]{unaligned_nodes}})
            {
                my $nodei = $sentences[$i]{nodes}{$variablei};
                my $concepti = $nodei->{econcept};
                # Consider links between nodes that are unaligned in both files
                # but do not consider links between unaligned and aligned nodes.
                # Are there nodes in $sentences[$j] that have the same concept
                # as $nodei? If there are multiple such nodes, link them all;
                # the symmetrization that we run next will select one.
                my @same_concept_nodes = grep {$sentences[$j]{nodes}{$_}{econcept} eq $concepti} (@{$sentences[$j]{unaligned_nodes}});
                foreach my $variablej (@same_concept_nodes)
                {
                    $nodej = $sentences[$j]{nodes}{$variablej};
                    $nodei->{crossfile}{$labelj}{$variablej}++;
                    $nodej->{crossfile}{$labeli}{$variablei}++;
                }
            }
        }
    }
    # Try to symmetrize the node-node alignments.
    for(my $i = 0; $i <= $#sentences; $i++)
    {
        for(my $j = $i+1; $j <= $#sentences; $j++)
        {
            symmetrize_node_projection($sentences[$i], $sentences[$j]);
        }
    }
    # Similarly to smatch, we could try to find mappings for as many remaining
    # nodes as possible (i.e., there will be unmapped nodes only if one file
    # has more nodes than the other). But it could create nonsensical mappings,
    # so it is now turned off.
    # find_correspondences_for_remaining_nodes(@sentences);
    # Update the statistics about cross-file node mappings.
    foreach my $sentence1 (@sentences)
    {
        my @variables1 = sort(keys(%{$sentence1->{nodes}}));
        foreach my $variable1 (@variables1)
        {
            my $node1 = $sentence1->{nodes}{$variable1};
            foreach my $sentence2 (@sentences)
            {
                my $label2 = $sentence2->{file}{label};
                my $n_targets = scalar(keys(%{$node1->{crossfile}{$label2}}));
                $sentence1->{file}{stats}{crossfile}{$label2}++ if($n_targets > 0);
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
    my $sentence0 = shift;
    my $sentence1 = shift;
    my $do_not_record_ambiguity = shift; # turn recording off if using this function to project the remainder
    my $label0 = $sentence0->{file}{label};
    my $label1 = $sentence1->{file}{label};
    my @variables0 = sort(keys(%{$sentence0->{nodes}}));
    my @variables1 = sort(keys(%{$sentence1->{nodes}}));
    while(1)
    {
        my @to_resolve = ();
        foreach my $variable (@variables0)
        {
            my @new_to_resolve = get_ambiguous_links_from_node($sentence0, $variable, $sentence1, $do_not_record_ambiguity);
            push(@to_resolve, @new_to_resolve) if(scalar(@new_to_resolve));
        }
        foreach my $variable (@variables1)
        {
            my @new_to_resolve = get_ambiguous_links_from_node($sentence1, $variable, $sentence0, $do_not_record_ambiguity);
            push(@to_resolve, @new_to_resolve) if(scalar(@new_to_resolve));
        }
        my $n_to_resolve = scalar(@to_resolve);
        last if($n_to_resolve == 0);
        # Sort the links to resolve by importance.
        @to_resolve = sort {compare_ambiguous_links($a, $b)} (@to_resolve);
        # The first pair is now guaranteed to survive. Remove its competitors.
        my $winner = shift(@to_resolve);
        $winner->{srcnode}{crossfile}{$winner->{tgtlabel}} = {$winner->{tgtnode}{variable} => 1};
        $winner->{tgtnode}{crossfile}{$winner->{srclabel}} = {$winner->{srcnode}{variable} => 1};
        # For diagnostic purposes, record the winning link including its scores
        # at the source node. (We could compute the score again when printing,
        # but why not remember it if we already have it.)
        $winner->{srcnode}{winning_cf}{$winner->{tgtlabel}} = $winner unless($do_not_record_ambiguity);
        # Now we have to recompute @to_resolve because we may have kicked out many links.
    }
}



#------------------------------------------------------------------------------
# Examines the projection of a node to another file. If the projection is
# ambiguous, i.e., there are links to more than one node in the target file,
# returns the list of the ambiguous links.
#------------------------------------------------------------------------------
sub get_ambiguous_links_from_node
{
    my $sentence0 = shift;
    my $variable = shift;
    my $sentence1 = shift;
    my $do_not_record_ambiguity = shift; # turn recording off if using this function to project the remainder
    my $label0 = $sentence0->{file}{label};
    my $label1 = $sentence1->{file}{label};
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
    my @to_resolve;
    if($ncf > 1)
    {
        # If this is the first round of removing ambiguous links of a node,
        # remember the links before they are removed, so we can later report
        # on them.
        if(!$do_not_record_ambiguity && !exists($n->{original_ambiguous_cf}{$label1}))
        {
            $n->{original_ambiguous_cf}{$label1} = \@cf;
        }
        foreach my $cf (@cf)
        {
            my $same_concept = $n->{econcept} eq $sentence1->{nodes}{$cf}{econcept};
            my $comparison = compare_two_nodes($n, $sentence0->{nodes}, $sentence1->{nodes}{$cf}, $sentence1->{nodes}, $label1);
            my $weak_comparison = compare_two_nodes($n, $sentence0->{nodes}, $sentence1->{nodes}{$cf}, $sentence1->{nodes}, $label1, 1);
            my $strong_match = join(',', map {"$_->[0]=$_->[1]"} (@{$comparison->{matches}}));
            my $weak_match = join(',', map {$_->[0]} (@{$weak_comparison->{matches}}));
            push(@to_resolve, {'srcnode' => $n, 'tgtnode' => $sentence1->{nodes}{$cf}, 'srclabel' => $label0, 'tgtlabel' => $label1, 'same_concept' => $same_concept, 'attribute_match' => $comparison->{correct}." ($strong_match)", 'weak_attribute_match' => $weak_comparison->{correct}." ($weak_match)"});
        }
    }
    return @to_resolve;
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
    if($a->{same_concept} && !$b->{same_concept})
    {
        $r = -10;
    }
    elsif(!$a->{same_concept} && $b->{same_concept})
    {
        $r = 10;
    }
    else
    {
        $r = 4*($b->{attribute_match} <=> $a->{attribute_match});
        unless($r)
        {
            $r = 3*($b->{weak_attribute_match} <=> $a->{weak_attribute_match});
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
    }
    return $r;
}



#------------------------------------------------------------------------------
# There may be nodes that have no correspondence in the other file.
# Either they were unaligned to text and we did not manage to find them
# a counterpart in the block where we were looking at unaligned nodes, or
# they were aligned ambiguously and kicked out during symmetrization.
# We could either leave them unmapped (which might be for many of them the
# most reasonable thing to do) or we could try to map as many of them as
# possible, by using the symmetrization criteria again. That is what this
# function tries to do.
#
# Note: This will bring the final score closer to smatch in mapping as many
# nodes as possible. Occasionally it may even pick up mapping that really makes
# sense (I saw one example with a node meaning "asi" in the DZ-ML comparison of
# the "Estonian" file). But most often it will pair nodes that have nothing to
# do with each other; if they share a relation, it is a pure coincidence. And
# the node-by-node differences of attributes will be much less informative.
#------------------------------------------------------------------------------
sub find_correspondences_for_remaining_nodes
{
    my @sentences = @_;
    for(my $i = 0; $i <= $#sentences; $i++)
    {
        my $labeli = $sentences[$i]{file}{label};
        my $sentencei = $sentences[$i];
        my @nodesi = map {$sentencei->{nodes}{$_}} (sort(keys(%{$sentencei->{nodes}})));
        for(my $j = $i+1; $j <= $#sentences; $j++)
        {
            my $labelj = $sentences[$j]{file}{label};
            my $sentencej = $sentences[$j];
            my @nodesj = map {$sentencej->{nodes}{$_}} (sort(keys(%{$sentencej->{nodes}})));
            my @unmapped_i_to_j;
            my @unmapped_j_to_i;
            foreach my $nodei (@nodesi)
            {
                if(scalar(keys(%{$nodei->{crossfile}{$labelj}})) == 0)
                {
                    push(@unmapped_i_to_j, $nodei);
                }
            }
            foreach my $nodej (@nodesj)
            {
                if(scalar(keys(%{$nodej->{crossfile}{$labeli}})) == 0)
                {
                    push(@unmapped_j_to_i, $nodej);
                }
            }
            if(scalar(@unmapped_i_to_j) > 0 && scalar(@unmapped_j_to_i) > 0)
            {
                #printf("   $labeli to $labelj unmapped %d\n", scalar(@unmapped_i_to_j));
                #printf("   $labelj to $labeli unmapped %d\n", scalar(@unmapped_j_to_i));
                foreach my $uij (@unmapped_i_to_j)
                {
                    foreach my $uji (@unmapped_j_to_i)
                    {
                        $uij->{crossfile}{$labelj}{$uji->{variable}}++;
                        $uji->{crossfile}{$labeli}{$uij->{variable}}++;
                    }
                }
                # The last parameter (1) says that we do not want to record
                # ambiguities in the file because this time they are artificial
                # ambiguities that we created.
                symmetrize_node_projection($sentences[$i], $sentences[$j], 1);
            }
        }
    }
}



#==============================================================================
# Two-file comparison functions
#==============================================================================



#------------------------------------------------------------------------------
# Takes two sentence hashes, holding corresponding sentences from different
# files. Performs symmetric comparison of the nodes in the sentences, prints
# the differences and stores the statistics in the respective files.
#------------------------------------------------------------------------------
sub compare_two_sentences
{
    my $sentence0 = shift;
    my $sentence1 = shift;
    print_symmetrization_report($sentence0, $sentence1);
    print_symmetrization_report($sentence1, $sentence0);
    compare_node_correspondences($sentence0, $sentence1);
    compare_node_attributes($sentence0, $sentence1);
    compare_node_attributes($sentence1, $sentence0);
}



#------------------------------------------------------------------------------
# Takes two sentence hashes, holding corresponding sentences from different
# files. Prints a report on what we did with ambiguous cross-file node
# projections during symmetrization.
#------------------------------------------------------------------------------
sub print_symmetrization_report
{
    my $sentence0 = shift;
    my $sentence1 = shift;
    my $file0 = $sentence0->{file};
    my $file1 = $sentence1->{file};
    my $label0 = $file0->{label};
    my $label1 = $file1->{label};
    my $n_nodes_with_ambiguous_projection = 0;
    my $n_nodes_in_ambiguous_projections = 0;
    my @variables0 = sort(keys(%{$sentence0->{nodes}}));
    foreach my $f0var (@variables0)
    {
        my $n0 = $sentence0->{nodes}{$f0var};
        if(exists($n0->{original_ambiguous_cf}{$label1}))
        {
            $n_nodes_with_ambiguous_projection++;
            my @ocf1 = @{$n0->{original_ambiguous_cf}{$label1}};
            my $ncf1 = scalar(@ocf1);
            $n_nodes_in_ambiguous_projections += $ncf1;
            my $node_text = node_as_string($label0, $n0);
            my $ocf1_text = list_of_node_variables_as_string($label1, $sentence1, @ocf1);
            print("Ambiguous projection of $node_text to $ncf1 $ocf1_text\n");
        }
    }
    if($n_nodes_with_ambiguous_projection > 0)
    {
        foreach my $f0var (@variables0)
        {
            my $n0 = $sentence0->{nodes}{$f0var};
            if(exists($n0->{winning_cf}{$label1}))
            {
                print("  The winner is ", ambiguous_link_as_string($n0->{winning_cf}{$label1}), ".\n");
            }
        }
        print("\n");
        $file0->{stats}{cr}{$label1}{nodes_with_originally_ambiguous_projection} += $n_nodes_with_ambiguous_projection;
        $file0->{stats}{cr}{$label1}{nodes_in_originally_ambiguous_projections} += $n_nodes_in_ambiguous_projections;
    }
}



#------------------------------------------------------------------------------
# Takes two sentence hashes, holding corresponding sentences from different
# files. Examines node-to-node cross-references between the files and prints
# a summary. The symmetric correspondences are printed only once, then the
# rest; if we ran symmetrization, then the rest consists of unmapped nodes.
#------------------------------------------------------------------------------
sub compare_node_correspondences
{
    my $sentence0 = shift;
    my $sentence1 = shift;
    my $file0 = $sentence0->{file};
    my $file1 = $sentence1->{file};
    my $label0 = $file0->{label};
    my $label1 = $file1->{label};
    my @variables0 = sort(keys(%{$sentence0->{nodes}}));
    my @variables1 = sort(keys(%{$sentence1->{nodes}}));
    my $n_aligned_0 = 0;
    my $n_total_0 = 0;
    my $n_aligned_1 = 0;
    my $n_total_1 = 0;
    my @table_symmetric = ();
    my @table_from_0 = ();
    my @table_from_1 = ();
    # Print the correspondences.
    foreach my $f0var (@variables0)
    {
        my $n0 = $sentence0->{nodes}{$f0var};
        my $t0 = $n0->{aligned_text} || $n0->{econcept};
        my @cf1 = sort(keys(%{$n0->{crossfile}{$label1}}));
        my $ncf1 = scalar(@cf1);
        # Since we symmetrize projections, $ncf1 should be either 1 or 0.
        # But let's keep this function prepared for ambiguous projections, too.
        if($ncf1 == 1)
        {
            my $n1 = $sentence1->{nodes}{$cf1[0]};
            my $t1 = $n1->{aligned_text} || $n1->{econcept};
            if(exists($n1->{crossfile}{$label0}{$f0var}))
            {
                push(@table_symmetric, ["Correspondence $label0 $f0var", "($t0)", "= $label1 $cf1[0]", "($t1)"]);
                $n_aligned_0++;
                $n_total_0++;
                $n_aligned_1++;
                $n_total_1++;
            }
            else
            {
                push(@table_from_0, ["Correspondence $label0 $f0var", "($t0)", "= $label1 $cf1[0]", "($t1)"]);
                $n_aligned_0++;
                $n_total_0++;
            }
        }
        else
        {
            my $cf1 = join(', ', @cf1) || ''; # we could put '???' here but it does not catch the eye
            push(@table_from_0, ["Correspondence $label0 $f0var", "($t0)", "= $label1 $cf1"]);
            $n_aligned_0++ if($ncf1 > 0);
            $n_total_0++;
        }
    }
    foreach my $f1var (@variables1)
    {
        my $n1 = $sentence1->{nodes}{$f1var};
        my $t1 = $n1->{aligned_text} || $n1->{econcept};
        my @cf0 = sort(keys(%{$n1->{crossfile}{$label0}}));
        my $ncf0 = scalar(@cf0);
        # Since we symmetrize projections, $ncf1 should be either 1 or 0.
        # But let's keep this function prepared for ambiguous projections, too.
        if($ncf0 == 1)
        {
            my $n0 = $sentence0->{nodes}{$cf0[0]};
            my $t0 = $n0->{aligned_text} || $n0->{econcept};
            # If it is symmetric, it has been printed already above.
            if(!exists($n0->{crossfile}{$label1}{$f1var}))
            {
                push(@table_from_1, ["Correspondence $label0 $cf0[0]", "($t0)", "= $label1 $f1var", "($t1)"]);
                $n_aligned_1++;
                $n_total_1++;
            }
        }
        else
        {
            my $cf0 = join(', ', @cf0) || ''; # we could put '???' here but it does not catch the eye
            push(@table_from_1, ["Correspondence $label0 $cf0", '', "= $label1 $f1var", "($t1)"]);
            $n_aligned_1++ if($ncf0 > 0);
            $n_total_1++;
        }
    }
    print_table(@table_symmetric, @table_from_0, @table_from_1);
    print("\n");
    printf("Aligned %d out of %d %s nodes, that is %d%%.\n", $n_aligned_0, $n_total_0, $label0, $n_total_0 > 0 ? $n_aligned_0/$n_total_0*100+0.5 : 0);
    printf("Aligned %d out of %d %s nodes, that is %d%%.\n", $n_aligned_1, $n_total_1, $label1, $n_total_1 > 0 ? $n_aligned_1/$n_total_1*100+0.5 : 0);
    print("\n");
}



#------------------------------------------------------------------------------
# Takes two sentence hashes, holding corresponding sentences from different
# files. Compares the nodes in the two files. For each node of the left file,
# considers the corresponding nodes in the right file.
# - If there are 0 counterparts: compare attributes/relations with an empty node.
# - If there is 1 counterpart: compare their attributes/relations.
# - There cannot be multiple counterparts if we have run symmetrization.
#   (But if we have not run it and there are multiple counterparts, we look for
#   the one with the best score. However, then compare(X,Y) may result in
#   different score than compare(Y,X).)
#------------------------------------------------------------------------------
sub compare_node_attributes
{
    my $sentence0 = shift;
    my $sentence1 = shift;
    my $file0 = $sentence0->{file};
    my $file1 = $sentence1->{file};
    my $label0 = $file0->{label};
    my $label1 = $file1->{label};
    print("Comparing attributes of $label0 nodes with their $label1 counterparts.\n");
    my $n_total_0;
    my $n_total_1;
    my $n_correct;
    my $n_total_0_mapped;
    my $n_total_1_mapped;
    my $n_correct_mapped;
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
        $n_total_0_mapped += $results[$max_i]{total0_mapped};
        $n_total_1_mapped += $results[$max_i]{total1_mapped};
        $n_correct_mapped += $results[$max_i]{correct_mapped};
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
    $file0->{stats}{cr}{$label1}{correct_mapped} += $n_correct_mapped;
    $file0->{stats}{cr}{$label1}{total_me_mapped} += $n_total_0_mapped;
    $file0->{stats}{cr}{$label1}{total_other_mapped} += $n_total_1_mapped;
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
    my $weak = shift; # compare only names of relations (if strong, compare also mapped values and the concept)
    my $n_total_0 = 0;
    my $n_total_1 = 0;
    my $n_correct = 0;
    my @matches;
    my @mismatches;
    if($weak)
    {
        my @rnames0 = ('concept', map {$_->{name}} (@{$node0->{relations}}));
        my @rnames1 = defined($node1) ? ('concept', map {$_->{name}} (@{$node1->{relations}})) : ();
        $n_total_0 = scalar(@rnames0);
        $n_total_1 = scalar(@rnames1);
        my %rnames1;
        map {$rnames1{$_}++} (@rnames1);
        foreach my $rn0 (@rnames0)
        {
            if($rnames1{$rn0} > 0)
            {
                $n_correct++;
                $rnames1{$rn0}--;
                push(@matches, [$rn0, 'WEAK', 'WEAK']);
            }
            else
            {
                push(@mismatches, [$rn0, 'WEAK', 'WEAK']);
            }
        }
    }
    else # strong, i.e., compare both names and values
    {
        # Collect attribute-value-modified value triples from both nodes.
        # Modified value applies to node variables, which have to be translated to the other file.
        my @pairs0 = get_node_attributes_mapped($node0, $nodes0, $label1);
        $n_total_0 = scalar(@pairs0);
        if(!defined($node1))
        {
            foreach my $p0 (@pairs0)
            {
                push(@mismatches, [$p0->[0], $p0->[1], 'UNMAPPED']);
            }
            return {'total0' => $n_total_0, 'total1' => 0, 'correct' => $n_correct, 'mismatches' => \@mismatches, 'matches' => \@matches};
        }
        my @pairs1 = get_node_attributes_mapped($node1, $nodes1, undef);
        $n_total_1 = scalar(@pairs1);
        # How many pairs are found in both nodes?
        foreach my $p0 (@pairs0)
        {
            # Compare modified value (->[2]) from $p0 with unmodified value (->[1]) from $p1.
            my $found = scalar(grep {$_->[0] eq $p0->[0] && $_->[1] eq $p0->[2]} (@pairs1));
            if($found)
            {
                $n_correct++;
                for(my $i = 0; $i <= $#pairs1; $i++)
                {
                    if($pairs1[$i][0] eq $p0->[0] && $pairs1[$i][1] eq $p0->[2])
                    {
                        splice(@pairs1, $i, 1);
                        last;
                    }
                }
                push(@matches, $p0);
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
    }
    # If $node1 was undefined, we would have returned from another block above.
    # If we are here, it means that the counts reflect comparison of mapped nodes
    # and we can also update the nicer global counts for mapped nodes.
    return {'total0' => $n_total_0, 'total1' => $n_total_1, 'correct' => $n_correct, 'mismatches' => \@mismatches, 'matches' => \@matches,
            'total0_mapped' => $n_total_0, 'total1_mapped' => $n_total_1, 'correct_mapped' => $n_correct};
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
    push(@pairs, ['concept', $concept, $concept]) unless(is_relation_ignored('concept'));
    my @relations = sort {lc($a->{name}) cmp lc($b->{name})} (@{$node->{relations}});
    foreach my $relation (@relations)
    {
        my $rname = $relation->{name};
        # The user may have asked us to ignore certain relations.
        next if(is_relation_ignored($rname));
        my $value = $relation->{value};
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
                push(@pairs, [$rname, "$value unmapped", 'UNMAPPED']);
            }
            else
            {
                my $ccf = join(', ', @ccf);
                foreach my $other_variable (@ccf)
                {
                    push(@pairs, [$rname, "$value mapped to $other_label $ccf", $other_variable]);
                }
            }
        }
        else
        {
            # This is an ordinary attribute rather than a relation.
            push(@pairs, [$rname, $value, $value]);
        }
    }
    return @pairs;
}



#------------------------------------------------------------------------------
# Takes a relation name, looks into the global configuration hash, and says
# whether the relation should be ignored in the current evaluation.
#------------------------------------------------------------------------------
sub is_relation_ignored
{
    my $relation = shift;
    $relation =~ s/^://;
    if($config{use_only})
    {
        return !exists($config{only_relations}{$relation});
    }
    elsif($config{use_except})
    {
        return exists($config{except_relations}{$relation});
    }
    else
    {
        return 0;
    }
}



#==============================================================================
# Formatting and printing functions
#==============================================================================



#------------------------------------------------------------------------------
# Provides a textual description of an ambiguous link for diagnostic purposes.
#------------------------------------------------------------------------------
sub ambiguous_link_as_string
{
    my $al = shift; # hash reference
    return node_as_string($al->{srclabel}, $al->{srcnode}).' <--> '.node_as_string($al->{tgtlabel}, $al->{tgtnode}).": econcepts=$al->{srcnode}{econcept}/$al->{tgtnode}{econcept}, match=$al->{attribute_match}, weak match=$al->{weak_attribute_match}";
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
            print(' ' x ($max_length[$i]-length($row->[$i]))) unless($i == $#{$row});
        }
        print("\n");
    }
}
