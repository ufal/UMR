package Treex::PML::Backend::UMR;

=head1 NAME

Treex::PML::Backend::UMR - TrEd backend to load and save UMR files directly

=cut

use warnings;
use strict;

use Treex::PML::IO qw{ open_backend close_backend };


my $SCHEMA = 'Treex::PML::Factory'->createPMLSchema({
    filename      => 'umr_schema.xml',
    use_resources => 1});


sub test {
    my ($filename, $encoding) = @_;
    die "Invalid encoding $encoding" unless 'UTF-8' eq $encoding;
    my $in = open_backend($filename, 'r', $encoding) or die "$filename: $!";
    while (<$in>) {
        return 1 if /^\#\ *sentence\ level\ graph
                    |^Index:[\ 0-9]+$/x
    }
    return
}


sub read {
    my ($fh, $doc) = @_;
    $doc->changeMetaData('schema', $SCHEMA);
    my @trees;

    my $root;
    my $buffer = "";
    my $mode = "";
    my $sentence_index = 0;
    while (<$fh>) {
        s/[\n\r]*//;
        s/#\s*TODO.*//;
        if (/# *sentence level graph/ && "" eq $mode) {
            $mode = 'sentence';

        } elsif (/^(?| Words :? \s* (.*)
                     | \# \s+ :: \s+ snt[0-9]+ \s+ (.+) )/x
        ) {
            my @words = split ' ', $1;
            $root = new_root(\@words, ++$sentence_index);
            $doc->append_tree($root);

        } elsif (/^\(/ && 'sentence' eq $mode) {
            $buffer = $_;

        } elsif (length $buffer && 'sentence' eq $mode) {
            if ("" eq $_) {
                $root = new_root([], ++$sentence_index)
                    unless $root;  # Empty sentence.
                parse_sentence($root, \$buffer);
                die "Sentence $sentence_index: Leftover $buffer"
                    if length $buffer;
                #use Data::Dumper; warn Dumper PARSED => $root;

            } else {
                $buffer .= $_;
            }

        } elsif (/# *alignment/) {
            $mode = 'alignment';

        } elsif ('alignment' eq $mode) {
            if ("" eq $_) {
                $mode = "";

            } elsif (/^(\w+): ([-0-9, ]+)/) {
                my ($id, $alignment) = ($1, $2);
                my @ords = map {
                               my ($from, $to) = '-1--1' eq $_ ? (0, 0)
                                                               : split /-/;
                               $from .. $to
                           } split /, */, $alignment;
                $root->{words}[$_]->set_value(PML::List(
                    PML::ListV($root->{words}[$_]->value), $id
                )) for @ords;
            }

        } elsif (/# *document level annotation/) {
            $mode = 'document';

        } elsif ('document' eq $mode) {
            if ("" eq $_) {
                $mode = "";
            } elsif (/\( (\w+) \s+ :same-(e(?:ntity|vent)) \s+ (\w+) \)/x) {
                my ($target_id, $type, $source_id) = ($1, $2, $3);
                if (my $source = (grep $_->{id} eq $source_id,
                                  $root->descendants)[0]
                ) {
                    add_to_links($source, $target_id, "coref:$type");
                } elsif (my $target = (grep $_->{id} eq $target_id,
                                       $root->descendants)[0]
                ) {
                    add_to_links($target, $source_id, "coref:$type");
                } else {
                    die "Neither $source_id nor $target_id found";
                }
            }
        }
        #warn "$mode: $_" if length $mode || length;
    }
}


sub write {
    my ($fh, $doc) = @_;
    return 1;

    for my $root ($doc->trees) {
    }
    return 1
}

sub new_root {
    my ($words, $sentence_index) = @_;
    'Treex::PML::Factory'->createTypedNode(
        'umr.sent.type',
        $SCHEMA, {
            words => 'Treex::PML::Factory'->createList([
                map 'Treex::PML::Factory'->createContainer(
                    'Treex::PML::Factory'->createList,
                    {word => $_}),
                "", @$words]),
            id => 'umr' . $sentence_index,
            '#name' => 'sent',
    });
}

sub parse_sentence {
    my ($root, $buffer) = @_;
    #warn "LABEL $root->{label}.";
    #warn "\n\nParsing $$buffer";
    my $node;
    if ($$buffer =~ s{ ^ \( (\w+) \s* / \s* ([^\s)]+) \s* }{}x) {
        my ($var, $label) = ($1, $2);
        $node = 'Treex::PML::Factory'->createTypedNode(
            'umr.node.type',
            $SCHEMA,
            {label    => $label,
             id       => $var});
        if ($root->children) {
            $node->paste_after(($root->children)[-1]);
        } else {
            $node->paste_on($root);
        }

        while ($$buffer =~ s/^:((?:!!)?[-\w]+)\s*//g) {
            #use Data::Dumper; warn Dumper $root;
            my $relation = $1;
            if ($$buffer =~ /^\(/) {
                #warn "Recurse! $$buffer";
                my $child = parse_sentence($node, $buffer);
                $child->{relation} = $relation;
                push @{ $root->{CHILDREN} }, $child;

            } elsif ($$buffer =~ s/^"([^"]+)"\s*//) {
                #warn "QQ[$1]";
                my $value = $1;
                add_to_features($node, $relation, $value);

            } elsif ($$buffer =~ s/^([^\s)]+)\s*//) {
                my $value = $1;
                if ($value =~ /^s[0-9]\w+$/) {
                    add_to_links($node, $value, "rel:$relation");
                } else {
                    add_to_features($node, $relation, $value);
                }
                #warn "\n\nExtracted '$value', left $$buffer";

            } else {
                #use Data::Dumper; warn Dumper($root);
                die "XXX!!! Can't parse:\n$$buffer"
            }
        }
    }
    if ($$buffer =~ s{\)\s*}{}) {
        #warn "\n\n\nEnd of node";
        return $node

    } elsif (length $$buffer) {
        die "Can't parse:\n<<$$buffer>>\n.";
    }
}

sub add_to_links {
    my ($node, $target_id, $type) = @_;
    $node->{links} //= 'Treex::PML::Factory'->createList();
    $node->{links}->push(
        'Treex::PML::Factory'->createContainer(
            $type, {'target.rf' => $target_id}));
}

sub add_to_features {
    my ($node, $relation, $value) = @_;
    $node->{features} //= 'Treex::PML::Factory'->createList();
    $node->{features}->push(
        'Treex::PML::Factory'->createContainer(
            $value, {type => $relation}));
}

__PACKAGE__
