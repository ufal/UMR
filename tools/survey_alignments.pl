#!/usr/bin/env perl
# Reads UMR file(s), surveys word alignments.
# Copyright © 2025 Dan Zeman <zeman@ufal.mff.cuni.cz>
# License: GNU GPL

use utf8;
use open ':utf8';
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
binmode(STDERR, ':utf8');

my @current_tokens;
my $now_reading_alignment = 0;
my ($n, $n_aligned, $n_aligned_discont, $n_unaligned);
while(<>)
{
    chomp;
    # Read tokens from a line that looks like this:
    # Words: Omnis homines , qui sese student praestare ceteris animalibus , summa ope niti decet , ne vitam silentio transeant veluti pecora , quae natura prona atque ventri oboedientia finxit
    if(m/^Words:\s*(.+)$/)
    {
        my $words = $1;
        $words =~ s/\s+$//;
        @current_tokens = split(/\s+/, $words);
    }
    elsif(m/^\#\s*alignment:/i)
    {
        $now_reading_alignment = 1;
    }
    elsif($now_reading_alignment)
    {
        if(m/^\w+\s*:\s*([0-9]+-[0-9]+(\s*,\s*[0-9]+-[0-9]+)*)/)
        {
            my $a = $1;
            # All nodes are listed in the Alignment section, including the unaligned ones.
            $n++;
            if($a eq '0-0' || $a eq '-1--1')
            {
                $n_unaligned++;
            }
            elsif($a =~ m/,/)
            {
                $n_aligned++;
                $n_aligned_discont++;
            }
            else
            {
                $n_aligned++;
            }
        }
        elsif(m/^\s*$/)
        {
            $now_reading_alignment = 0;
        }
    }
}
print("Total nodes:  \t$n\n");
if($n > 0)
{
    printf("Unaligned:    \t$n_unaligned (%d%%)\n", $n_unaligned/$n*100+0.5);
    printf("Aligned:      \t$n_aligned (%d%%)\n", $n_aligned/$n*100+0.5);
    print(" discontinuous\t$n_aligned_discont\n");
}
