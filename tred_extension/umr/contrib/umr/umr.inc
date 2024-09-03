# -*- cperl -*-
{   package UMR;

    BEGIN { import TredMacro }

    use strict;

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


    sub get_nodelist_hook {
    }


    sub node_release_hook {
        my ($node, $target, $mod) = @_;
        ChangingFile(0);
        return unless $target;
        return 'stop'
    }
}
