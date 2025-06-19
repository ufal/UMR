#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Path::Tiny qw{ path };
use Text::Levenshtein::XS qw{ distance };

die "Usage: $0 ufal-dir release-dir pdt-c-3.0-dir" unless 3 == @ARGV;

my @dirs = @ARGV;

my %origin;
my $pdtc30 = pop @dirs;
say STDERR "Indexing $pdtc30";
path($pdtc30)->visit(sub {
                         my ($path) = @_;
                         $origin{ $path->basename =~ s/\.t$/.umr/r } = "$path"
                             if $path =~ /\.t$/;
                     },
                     {recurse => 1});

my @files = map [path($_)->children(qr/\.umr$/)], @dirs;

my @contents;
for my $i (0 .. $#files) {
    say STDERR "Indexing $dirs[$i]";
    for my $file (@{ $files[$i] }) {
        my $text;
        open my $in, '<:encoding(UTF-8)', $file;
        while (<$in>) {
            $text .= "$1 %%% " if (/^Words: (.*)/);
        }
        push @{ $contents[$i] }, [$file, $text];
    }
}

say STDERR 'Sorting';
for my $group (@contents) {
    @$group = sort { $a->[1] cmp $b->[1] } @$group;
}

my $deleted = @{ $contents[0] } - @{ $contents[1] };

say STDERR "Mapping";
my %mapping;
my $skipped = 0;
FILE:
for my $i (0 .. $#{ $contents[0] }) {
    for my $d ($skipped .. $skipped + $deleted) {
        my $j = $i - $d;
        if ($contents[0][$i][1] eq $contents[1][$j][1]
            || distance($contents[0][$i][1], $contents[1][$j][1]) < 5
        ) {
            $mapping{ $contents[1][$j][0] }
                = $origin{ $contents[0][$i][0]->basename };
            next FILE
        }
    }
    say STDERR "No match for $contents[0][$i][0].";
    ++$skipped;
}
say STDERR scalar keys %mapping, ' mapped of ', scalar @{ $contents[1] };

for my $f (sort keys %mapping) {
    say $f =~ s{.*/}{}r, "\t", $mapping{$f} =~ s{.*data/}{}r;
}

=head1 NAME

map-released.pl - map the Czech files released in UMR 2.0 to the directory
structure of PDT-C 2.0.

=head1 SYNOPSIS

 map-released.pl  /path/to/ufal/umr path/to/release2.0 /path/to/pdt-c/data

=cut
