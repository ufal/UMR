# -*- mode: cperl, encoding: utf-8 -*-

#bind compare_trees to = menu Compare Trees
#bind show_diff to ? menu Show Diff
#bind load_original_file to o menu Load Original File

{   package UMR;
    use utf8;

    BEGIN { import TredMacro }

    use strict;
    use File::Basename qw{ basename };
    use Scalar::Util qw{ weaken };

    unshift @TrEd::Config::open_types, [
        'Uniform Meaning Representation',
        [ '.umr' ],
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

    sub get_dag_children {
        my ($node) = @_;
        my @children = $node->children;
        my %ch_ids;
        @ch_ids{ map $_->{'target.rf'},
                 grep 0 == index($_->{value}, 'rel:'),
                 ListV($node->{links}) } = ();
        push @children, grep exists $ch_ids{ $_->{id} },
                        $node->root->descendants;
        return @children
    }

    sub label_with_name_expanded {
        my ($node) = @_;
        return $node->{label}
            if (($node->{relation} // "") ne 'name'
                && $node->{label} ne 'foreign-phrase')
            || ! $node->{features};

        my @words = map $_->value =~ s/^"|"$//gr, ListV($node->{features});
        my ($leftq, $rightq) = $node->{label} eq 'foreign-phrase'
                             ? ('«', '»')
                             : ('"', '"');
        return $leftq . join('_', @words) . $rightq
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
            next unless $word_index;
            my @nodes0 = keys
                %{ $alignment->{w2n}[0][$root_index]{$word_index} };
            if (1 == @nodes0) {
                my @nodes1 = keys
                    %{ $alignment->{w2n}[1][$root_index]{$word_index} };
                if (1 == @nodes1
                    && 1 == keys
                        %{ $alignment->{n2w}[1][$root_index]{ $nodes1[0] } }
                    && 1 == keys
                        %{ $alignment->{n2w}[0][$root_index]{ $nodes0[0] } }
                ) {
                    undef $mapping{'01'}{ $nodes0[0] }{ $nodes1[0] };
                    undef $mapping{'10'}{ $nodes1[0] }{ $nodes0[0] };
                    warn "Map by node $nodes0[0] $nodes1[0]: ",
                        join('+', keys
                             %{ $alignment->{n2w}[1][$root_index]{ $nodes1[0] } }),
                                 ',',
                                 join('+', keys
                                      %{ $alignment->{n2w}[0][$root_index]{ $nodes0[0] } });
                }
            }
        }

        my $root0 = $windows[0]->{currentNode}->root;
        my $root1 = $windows[1]->{currentNode}->root;

        for my $i (0, 1) {
            my $root = ($root0, $root1)[$i];
            for my $node ($root->descendants) {
                next if exists $mapping{ $i . (1 - $i)}{ $node };

                my $words = join ',', sort keys %{
                    $alignment->{n2w}[$i][$root_index]{ $node->{id} } };
                next if -1 == index $words, ',';

                undef $alignment->{ws2n}{$words}[$i]{ $node->{id} };
            }
        }
        for my $words (keys %{ $alignment->{ws2n} }) {
            next if 2 != grep defined, @{ $alignment->{ws2n}{$words} };
            next if 2 != grep 1 == keys %$_, @{ $alignment->{ws2n}{$words} };

            my $node0 = (keys %{ $alignment->{ws2n}{$words}[0] } )[0];
            my $node1 = (keys %{ $alignment->{ws2n}{$words}[1] } )[0];

            undef $mapping{'01'}{$node0}{$node1};
            undef $mapping{'10'}{$node1}{$node0};
            warn "Map by words: $node0 $node1";
        }

        my @expanded_labels;
        for my $idx (0, 1) {
            for my $node (($root0, $root1)[$idx]->descendants) {
                $expanded_labels[$idx]{ $node->{id} }
                    = label_with_name_expanded($node);
            }
        }

        my $change = 1;
        while ($change) {
            undef $change;

            # use Data::Dumper;
            # warn Dumper map $_->[$root_index],
            #             map @$_, @$alignment{qw{ w2n n2w }};
            # warn Dumper \%mapping;

            for my $node (grep ! keys %{ $mapping{'01'}{ $_->{id} } // {} },
                          $root0->descendants
            ) {
                my @children = get_dag_children($node);

                if (grep keys %{
                    exists $mapping{'01'}{ $_->{id} }
                        ? $mapping{'01'}{ $_->{id} }
                        : {} },
                    @children
                ) {
                    my @children1 = map exists $mapping{'01'}{ $_->{id} }
                                        ? keys %{ $mapping{'01'}{ $_->{id} } }
                                        : (),
                                    @children;
                    my @parents1 = uniq(map $_->{id},
                                        map get_dag_parents($_), grep {
                                            my $n1 = $_;
                                            grep $n1->{id} eq $_, @children1
                                        } $root1->descendants);
                    use Data::Dumper; warn Dumper $node->{id}, [map $_->{id}, @children], \@children1, \@parents1;
                    if (1 == @parents1
                        && ! exists $mapping{'10'}{ $parents1[0] }
                    ) {
                        undef $mapping{'01'}{ $node->{id} }{ $parents1[0] };
                        undef $mapping{'10'}{ $parents1[0] }{ $node->{id} };
                        warn "Mapped by children: $node->{id}";
                        $change = 1;
                    }

                } elsif (! @children) {
                    warn "Trying label";
                    my $exp = $expanded_labels[0]{ $node->{id} };
                    if (1 == grep $exp eq $_, values %{ $expanded_labels[0] }) {
                        my @matches = grep $expanded_labels[1]{$_} eq $exp,
                                      keys %{ $expanded_labels[1] };
                        if (1 == @matches) {
                            undef $mapping{'01'}{ $node->{id} }{ $matches[0] };
                            undef $mapping{'10'}{ $matches[0] }{ $node->{id} };
                            warn "Mapped by label: $node->{id}";
                            $change = 1;
                        }
                    }
                }
            }
            for my $n0 (keys %{ $mapping{'01'} }) {
                writeln("$n0: ", join ', ', sort keys %{ $mapping{'01'}{$n0} });
            }
        }

        delete $_->{_diff} for $root0->descendants;
        undef $mapping{'01'}{ $root0->{id} }{ $root1->{id} };
        undef $mapping{'10'}{ $root1->{id} }{ $root0->{id} };
        for my $root_index (0, 1) {
            my $other_index = 1 - $root_index;
            my $root = ($root0, $root1)[$root_index];
            my $other_root = ($root0, $root1)[$other_index];
            my $direction = qw( 01 10 )[$root_index];
            my $n2w = $alignment->{n2w}[$other_index][$root_index];
            for my $node ($root->descendants) {
                if (exists $mapping{$direction}{ $node->{id} }) {
                    my @nodes1 = keys %{ $mapping{$direction}{ $node->{id} } };
                    if (1 == @nodes1) {
                        my ($node1) = grep $_->{id} eq $nodes1[0],
                                      $other_root->descendants;
                        $node->{_diff}{relation} = 1
                            if ($node->{relation} // "")
                               ne ($node1->{relation} // "");
                        $node->{_diff}{label} = 1
                            unless $node->{label} eq $node1->{label};

                        for my $parent (get_dag_parents($node)) {
                            my $parent_id = $parent->{id};
                            my @mapped_parents
                                = map keys %$_,
                                  grep defined,
                                  @$n2w{
                                      keys %{ $mapping{$direction}{$parent_id} }
                                  };
                            my @parents1
                                = map keys %$_,
                                  grep defined,
                                  @$n2w{
                                      map $_->{id}, get_dag_parents($node1)
                                  };
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
        Redraw_All();
    }

    sub show_diff {
        ChangingFile(0);
        use Data::Dumper;
        print Dumper $this->{_diff};
    }

    {   my %map;
        sub load_original_file {
            ChangingFile(0);
            if (! exists $TrEd::Config::userConf->{_umr_umr20_pdtc}
                && ! exists $TrEd::Config::userConf->{_umr_umr20_treex}
            ) {
                ToplevelFrame()->Dialog(
                    -title => 'UMR not configured',
                    -bitmap => 'error',
                    -text => "Neither 'user_UMR_UMR20_PDTC'"
                             . " nor 'user_UMR_UMR20_Treex'"
                             . " set in .tredrc",
                    -buttons => ['OK'],
                -default_button => 'OK')->Show;
                return
            }
            my $basename = basename(FileName());
            load_map()  unless keys %map;
            my $f;
            if ($basename =~ /^czech_umr-\d{4}\.umr$/) {
                $f = $map{$basename};
            }  elsif (my ($full_path) = do {
                my $tfile = $basename =~ s/\.umr$/.t/r;
                grep m{/\Q$tfile\E$}, values %map
            }) {
                $f = $full_path;
            } else {
                ToplevelFrame()->Dialog(
                    -title => 'Original file not known',
                    -bitmap => 'error',
                    -text => "UMR can't find the original file to $basename",
                    -buttons => ['OK'],
                -default_button => 'OK')->Show;
                return
            }

            for my $opt (qw( _umr_umr20_pdtc _umr_umr20_treex )) {
                if ($TrEd::Config::userConf->{$opt}) {
                    $f = 'File::Spec'->catfile(
                        $TrEd::Config::userConf->{$opt}, $f);
                    $f .= 'reex.gz' if '_umr_umr20_treex' eq $opt;
                    last if -f $f;
                    $f = 'File::Spec'->catfile(
                        $TrEd::Config::userConf->{$opt}, basename($f));
                    last if -f $f;
                }
            }
            my $sentence = CurrentTreeNumber() + 1;
            my $framegroup = $grp->{framegroup};
            my $win = $framegroup->{focusedWindow};
            my $new_win = main::splitWindow($framegroup, 'vert');
            my $file = TrEd::File::open_file($grp, $f);
            $grp->set_current_file($file);
            TredMacro::GotoTree($sentence);
            main::focusNextWindow($framegroup) until $win->is_focused;
            main::switchContext($win, 'UMR', 1);
        }

        sub load_map {
            my $map;
            my @paths = grep /umr/, ResourcePaths();
            for my $path (@paths) {
                $map = 'File::Spec'->catfile($path, 'umr.map');
                last
            }
            return unless -f $map;

            open my $in, '<', $map or die "$map: $!";
            while (<$in>) {
                s/[\r\n]+//g;
                my ($umr, $pdtc) = split /\t/;
                $map{$umr} = $pdtc;
            }
        }
    }

}
