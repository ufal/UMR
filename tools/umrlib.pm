# Perl module with functions for reading a UMR file.
# Copyright © 2025-2026 Dan Zeman <zeman@ufal.mff.cuni.cz>
# License: GNU GPL

package umrlib;

use Carp;
use utf8;
use open ':utf8';



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
# Takes a sentence hash. Parses the lines of the first block of the sentence
# (tokens) and saves the resulting structure in the sentence hash.
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
# Takes a sentence hash. Parses the lines of the sentence graph block in the
# given sentence and saves the resulting structure in the sentence hash.
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
            if($cline =~ s:^\(\s*([\pL\pN]+)\s*/\s*::) # )
            {
                # New node.
                my $variable = $1;
                # Now we also expect the concept.
                if($cline =~ s:([^\s\(\)]+)::)
                {
                    my $concept = $1;
                    my %node =
                    (
                        'variable' => $variable,
                        'concept' => $concept,
                        'relations' => []
                    );
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
                else
                {
                    # One of the errors was that the converter from PDT generated concepts like '#Rcp' but the '#' character was then interpreted as signalling a comment.
                    confess("Found what looks like a new node $variable at line $iline of file $file->{label} but could not recognize the concept; the rest of the line is '$cline'");
                }
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
                    confess("Nodes closed prematurely; extra attribute value $value at line $iline of file $file->{label}");
                }
                if(!defined($current_relation))
                {
                    confess("Missing relation for value $value at line $iline of file $file->{label}");
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
# Takes a sentence hash. Parses the lines of the alignment block in the given
# sentence and saves the resulting structure in the sentence hash.
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



#------------------------------------------------------------------------------
# Takes a sentence hash. Parses the lines of the document-level relation block
# in the given sentence and saves the resulting structure in the sentence hash.
#------------------------------------------------------------------------------
sub parse_sentence_docrels
{
    my $sentence = shift; # hash reference
    my $file = $sentence->{file};
    my $dgraph_block = $sentence->{blocks}[3];
    if(!defined($dgraph_block))
    {
        printf STDERR ("WARNING: Missing the document-level relation block in sentence %d of file %s (lines %d–%d).\n", $i_sentence+1, $file->{label}, $sentence->{line0}, $sentence->{line1});
    }
    my %docrels; # hash indexed by "node0 :relation node1" triples
    $sentence->{docrels} = \%docrels;
    my $iline = $dgraph_block->{line0}-1;
    my $inside_graph = 0;
    my $current_relation_set;
    my $after_relation_set = 0;
    foreach my $line (@{$dgraph_block->{lines}})
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
            # We expect the following steps:
            # Initial bracket, sentence id and the sentence "concept": (s2s0 / sentence
            # Label for a list of relations. Only :temporal, :modal and :coref are expected, but we can allow any string of lowercase letters following a colon.
            # Opening brakcet of the set of relations.
            # Each relation is a triple enclosed in its own pair of brackets: (document-creation-time :overlap s2d)
            # - We can simplify the task and assume that this triple (including the brackets) is never split among multiple lines, i.e., we can read it in one step.
            # Closing bracket of the set of relations.
            # Final bracket: )
            if($cline =~ s:^\(\s*([\pL\pN]+)\s*/\s*sentence\s*::) # )
            {
                # Skip initial opening bracket, sentence id and concept.
                $inside_graph = 1;
            }
            elsif($cline =~ s/^(:[-\pL\pN]+)\s*//)
            {
                # New set of relations (:temporal, :modal, :coref).
                $current_relation_set = $1;
                if(!$inside_graph)
                {
                    confess("Expecting beginning of a document-level relation graph at line $iline of file $file->{label}");
                }
                elsif($after_relation_set)
                {
                    confess("Expecting opening bracket after relation set $current_relation_set at line $iline of file $file->{label}");
                }
                $after_relation_set = 1;
            }
            elsif($cline =~ s/^\(\s*([-\pL\pN]+)\s*(:[-\pL\pN]+)\s*([-\pL\pN]+)\s*\)//)
            {
                # New document-level relation. Nodes are either node ids (variables) or predefined constants such as document-creation-time.
                my $node0 = $1;
                my $relation = $2;
                my $node1 = $3;
                if(!$inside_graph)
                {
                    confess("Expecting beginning of a document-level relation graph at line $iline of file $file->{label}");
                }
                elsif($after_relation_set)
                {
                    confess("Expecting opening bracket after relation set $current_relation_set at line $iline of file $file->{label}");
                }
                if(!defined($current_relation_set))
                {
                    print STDERR ("Rest of line $iline of file $file->{label}: $cline\n");
                    confess("Not expecting relation triple (we are not inside a relation set) at line $iline of file $file->{label}");
                }
                # Concatenate the triple again to a hashable string (but now with just one space as separator).
                my $triple = "$node0 $relation $node1";
                # Note that we throw away the current relation set, assuming that individual relation names are unique across sets (e.g., :overlap is a temporal relation, not modal or coreferential).
                $docrels{$triple}++;
            }
            elsif($cline =~ s/^\(\s*//) # )
            {
                if(!$inside_graph)
                {
                    confess("Expecting beginning of a document-level relation graph at line $iline of file $file->{label}");
                }
                elsif($after_relation_set)
                {
                    $after_relation_set = 0;
                }
                else
                {
                    print STDERR ("Rest of line $iline of file $file->{label}: $cline\n");
                    confess("Not expecting opening bracket at line $iline of file $file->{label}");
                }
            }
            # (
            elsif($cline =~ s/^\)//)
            {
                # Closing bracket of a set of relations or of the whole document-level graph.
                if(!$inside_graph)
                {
                    confess("Expecting beginning of a document-level relation graph at line $iline of file $file->{label}");
                }
                elsif($after_relation_set)
                {
                    confess("Expecting opening bracket after relation set $current_relation_set at line $iline of file $file->{label}");
                }
                if(defined($current_relation_set))
                {
                    $current_relation_set = undef;
                }
                else # this closing bracket terminates the whole document-level relation graph
                {
                    $inside_graph = 0;
                }
            }
            elsif($cline =~ s/^\s+//)
            {
                # Skip leading spaces.
            }
            else
            {
                # We should not be here.
                print STDERR ("Rest of line $iline of file $file->{label}: $cline\n");
                confess("Internal error");
            }
        }
    }
    if($inside_graph)
    {
        print STDERR ("WARNING: Missing closing bracket at line $iline of file $file->{label}: document-level relation graph not closed.\n");
    }
}



1;
