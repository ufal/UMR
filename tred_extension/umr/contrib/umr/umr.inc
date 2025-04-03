# -*- cperl -*-

#bind compare_trees to = menu Compare Trees

{   package UMR;

    BEGIN { import TredMacro }

    use strict;
    use Scalar::Util qw{ weaken };

    unshift @TrEd::Config::open_types, [
        'Uniform Meaning Representation',
        [ '.txt' ],
    ] unless grep $_ eq 'Uniform Meaning Representation',
             @{ $TrEd::Config::open_types[0] };

    our $previous_stylesheet;

    my $umr_backend = 'UMR';
    AddBackend(Treex::PML::ImportBackends($umr_backend))
        unless grep $umr_backend eq $_, Backends();

    push @TredMacro::AUTO_CONTEXT_GUESSING, sub {
        my ($hook) = @_;
        my $resuming = ($hook eq 'file_resumed_hook');
        my $current = CurrentContext();
        return detect() ? __PACKAGE__ : ()
    };


    sub detect {
        return (((PML::SchemaName() || "") eq 'umr') ? 1 : 0)
    }


    sub file_close_hook {
        $previous_stylesheet = GetCurrentStylesheet();
        return
    }


    sub allow_switch_context_hook {
        return 'stop' unless detect();
    }


    sub switch_context_hook {
        if (STYLESHEET_FROM_FILE() eq GetCurrentStylesheet()) {
            my $stylesheet = $previous_stylesheet // 'UMR';
            SetCurrentStylesheet($stylesheet);
        }
        Redraw() if GUI();
    }


    sub get_value_line_hook {
        my ($doc, $tree_no) = @_;
        my $tree = $doc->tree($tree_no);

        my $h = [
            map { my $word = $_;
                  [$word->{word},
                   [map { my $id = $_;
                         grep $id eq $_->{id}, $tree->descendants
                   } @{ $word->value }]], [' ']
            } ListV($tree->{words})
        ];
        return $h
    }


    sub GetNodeHash {
        my $fsfile = $_[0] || $grp->{FSFile};
        return {} if !ref $fsfile;
        if (! ref $fsfile->appData('id-hash')) {
            my %ids;
            my $trees = $fsfile->treeList();
            for my $i (0 .. $#{$trees}) {
                my $node = $trees->[$i];
                while ($node) {
                    weaken( $ids{ $node->{id} } = $node );
                } continue {
                    $node = $node->following;
                }
            }
            $fsfile->changeAppData('id-hash', \%ids);
        }
        return $fsfile->appData('id-hash')
    }


    # sub get_nodelist_hook {
    # }

    my %ARROW_COLOR = (
        _PREVIOUS_ => {arrow => 'darkgreen'},
        _MISSING_  => {arrow => 'brown'},
        _OTHER_    => {arrow => 'cyan3',      text => 'cyan3'},
        ARG0       => {arrow => 'violet',     text => 'violet'},
        ARG1       => {arrow => 'pink',       text => 'pink'},
        ARG2       => {arrow => 'plum',       text => 'plum'},
        affectee   => {arrow => 'orange',     text => 'orange'},
        start      => {arrow => 'lightblue1', text => 'lightblue1'},
        path       => {arrow => 'lightblue2', text => 'lightblue2'},
        goal       => {arrow => 'lightblue3', text => 'lightblue3'},
        place      => {arrow => 'lightblue4', text => 'lightblue4'},
        mod        => {arrow => 'lightgreen', text => 'lightgreen'},
        'ARG0-of'  => {arrow => 'cyan2',     text => 'violet'},
        'ARG1-of'  => {arrow => 'cyan2',       text => 'pink'},
        'ARG2-of'  => {arrow => 'cyan2',       text => 'plum'},
    );
    sub arrow_color {
        my ($type, $relation) = @_;

        $relation =~ s/.*://;
        return $ARROW_COLOR{$relation}{$type} if exists $ARROW_COLOR{$relation};

        return $ARROW_COLOR{_OTHER_}{$type}
    }


    sub node_release_hook {
        my ($node, $target, $mod) = @_;
        ChangingFile(0);
        return unless $target;
        return 'stop'
    }

    sub _get_alignment {
        my (@windows) = @_;
        my %alignment;
        for my $window_index (0, 1) {
            my @roots = ListV($windows[$window_index]->{FSFile}->treeList);
            for my $root_index (0 .. $#roots) {
                my $root = $roots[$root_index];
                for my $i (0 .. $root->{words}->count - 1) {
                    my $word = $root->{words}->[$i];
                    if ($word->value->count) {
                        do {
                            undef $alignment{w2n}[$window_index][$root_index]
                                {$i}{$_};
                            undef $alignment{n2w}[$window_index][$root_index]
                                {$_}{$i};
                        } for ListV($word->value);
                    } else {
                        undef $alignment{w2n}[$window_index][$root_index]{$i};
                    }
                }
            }
        }
        return \%alignment
    }

    sub get_dag_parents {
        my ($node) = @_;
        my @parents = $node->parent;

        for my $p ($node->root->descendants) {
            push @parents, $p if grep $_->{'target.rf'} eq $node->{id}
                                      && 0 == index($_->value, 'rel:'),
                                 ListV($p->{links});
        }
        return @parents
    }

    sub compare_trees {
        ChangingFile(0);
        my @windows = sort { $b->is_focused <=> $a->is_focused }
                      @{ $grp->{framegroup}{treeWindows} };
        die '2 windows expected' unless 2 == @windows;

        my $alignment = _get_alignment(@windows);
        my $root_index = CurrentTreeNumber();
        die 'Different number of words'
            if keys %{ $alignment->{w2n}[0][$root_index] }
            != keys %{ $alignment->{w2n}[1][$root_index] };

        my %mapping;
        for my $word_index (keys %{ $alignment->{w2n}[0][$root_index] }) {
            my @nodes0 = keys
                %{ $alignment->{w2n}[0][$root_index]{$word_index} };
            if (1 == @nodes0) {
                my @nodes1 = keys
                    %{ $alignment->{w2n}[1][$root_index]{$word_index} };
                if (1 == @nodes1) {
                    undef $mapping{'01'}{ $nodes0[0] }{ $nodes1[0] };
                    undef $mapping{'10'}{ $nodes1[0] }{ $nodes0[0] };
                }
            }
        }
        my $root0 = $windows[0]->{currentNode}->root;
        delete $_->{_diff} for $root0->descendants;
        my $root1 = $windows[1]->{currentNode}->root;
        undef $mapping{'01'}{ $root0->{id} }{ $root1->{id} };
        undef $mapping{'10'}{ $root1->{id} }{ $root0->{id} };
        for my $node ($root0->descendants) {
            if (exists $mapping{'01'}{ $node->{id} }) {
                my @nodes1 = keys %{ $mapping{'01'}{ $node->{id} } };
                if (1 == @nodes1) {
                    my ($node1) = grep $_->{id} eq $nodes1[0],
                                  $root1->descendants;
                    $node->{_diff}{relation} = 1
                        if ($node->{relation} // "")
                           ne ($node1->{relation} // "");
                    $node->{_diff}{label} = 1
                        unless $node->{label} eq $node1->{label};

                    for my $parent (get_dag_parents($node)) {
                        my $parent_id = $parent->{id};
                        my @mapped_parents
                            = sort grep defined,
                              @{ $alignment->{n2w}[0][$root_index] }
                              { keys %{ $mapping{'01'}{$parent_id} } };
                        my @parents1
                            = sort grep defined,
                              @{ $alignment->{nw2}[1][$root_index] }
                              { map $_->{id}, get_dag_parents($node1) };
                        $node->{_diff}{parent}{$_} = 1
                            for grep {
                                my $p = $_;
                                ! grep $p eq $_, @parents1
                            } @mapped_parents;
                    }
                } else {
                    $node->{_diff}{m2n} = 1;
                }
            } else {
                $node->{_diff}{unmapped} = 1;
            }
        }
    }
}
