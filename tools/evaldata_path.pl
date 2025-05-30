#!/usr/bin/perl
use warnings;
use strict;

use Path::Tiny qw{ path };

-d $ENV{UFAL_PDTC} or die '$UFAL_PDTC not set!';

my %pdtc_path;
my $iter = path($ENV{UFAL_PDTC}, 'WorkData2.0')->iterator({recurse => 1});
while (my $path = $iter->()) {
    $pdtc_path{$2} = $1 if $path =~ m{/([de]test|train[^/]*)/(.+\.t)$};
}

while (<>) {
    my ($filename) = /^([^,]+)/;
    print $pdtc_path{$filename} // "NOT FOUND <$filename>", ",$_";
}

=head1 NAME

evaldata_path.pl - Add path to filenames generated by C<propose_evaldata.btred> so train/etest/dtest can be considered.

=cut
