#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

for my $file (@ARGV) {
    open my $in, '<', $file or die $!;

    my %id;
    while (<$in>) {
        $id{$1} = "T-$1" if / id="(\d[^"]+)"/;
    }
    rename $file, "$file~" or die $!;
    open my $out, '>', $file or die $!;
    close $in;
    open my $in2, '<', "$file~" or die $!;
    while (<$in2>) {
        s{(?<=[">])(\d[^"<]+)}{ $id{$1} // $1 }ge;
        s/a#a#/a#/g;
        print {$out} $_;
    }
    close $out or die $!;
    unlink "$file~" or die $!;
}

