#!/usr/bin/perl
use warnings;
use strict;

if (@ARGV != 2
    || grep ! -f $_, @ARGV
) {
    die "$0 vallex.changes pdt2pb.csv > pdt2pb-new.csv\n";
}

my $vallex_changes = shift;
my $pdt2pb = shift;

my %new_frame;
open my $in1, '<', $vallex_changes or die "$vallex_changes: $!";
while (<$in1>) {
    next if /^#/;

    my ($old, $new) = split ' ';
    undef $new if 'delete' eq $new;
    die "Duplicate $old" if exists $new_frame{$old};

    $new_frame{$old} = $new;
}

open my $in2, '<', $pdt2pb or die "$pdt2pb: $!";
while (<$in2>) {
    if (/\((v-w[^)]+)\)/) {
        my $old = $1;
        if (exists $new_frame{$old}) {
            if (defined $new_frame{$old}) {
                s/\Q$old/$new_frame{$old}/;
            } else {
                warn "Deleted $old: $_";
            }
        }
    }
    print;
}

=head1 NAME

update.pl - Update the PDT Vallex to PropBank translation table

=head1 SYNOPSIS

 update.pl vallex.changes pdt2pb.csv > pdt2pb-new.csv

=head1 DESCRIPTION

C<vallex.changes> should contain two columns: old frame id and the new
frame id. The special value C<delete> in the second column means the
frame was removed. The left column must contain unique values.

=cut
