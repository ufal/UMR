#!/usr/bin/env perl
# Runs UMR comparison on selected UMR files. While the comparing script is under
# active development, this helps to keep the output up-to-date for the files
# in which annotators are currently interested; at the same time, the git diff
# of the comparison report helps debug the script.
# Copyright © 2025 Dan Zeman <zeman@ufal.mff.cuni.cz>
# License: GNU GPL

use utf8;
use open ':utf8';
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
binmode(STDERR, ':utf8');

my $root_path = 'C:/Users/zeman/Documents/lingvistika-projekty';
my $script_path = "$root_path/umr-ufal/tools";
my $conv_path = "$root_path/umr-from-ud/testset";
my $czech_path = "$root_path/umr-ufal/data/czech";
my $pdttest_path = "$czech_path/PDT-C-dtest";

# Inter-annotator agreement on Czech samples.
sysrun("perl $script_path/compare_umr.pl DZ $czech_path/mf920922-133_estonsko-DZ.umr ML $czech_path/mf920922-133_estonsko-ML.umr > $czech_path/comparison-DZ-ML.txt");
sysrun("perl $script_path/compare_umr.pl ML $pdttest_path/ln94210_111-ML-all.umr HH $pdttest_path/ln94210_111-HH-s1-s5.umr > $pdttest_path/comparison-ln94210_111.txt");
sysrun("perl $script_path/compare_umr.pl ML $pdttest_path/ln95046_093-ML-s1-s6.umr HH $pdttest_path/ln95046_093-HH-all.umr > $pdttest_path/comparison-ln95046_093.txt");
# Evaluation of Honza's conversion from PDT-C to UMR.
sysrun("perl $script_path/compare_umr.pl GOLD $pdttest_path/ln94210_111-ML-all.umr CONV $pdttest_path/ln94210_111-conv.umr > $pdttest_path/evaluation-ln94210_111.txt");
sysrun("perl $script_path/compare_umr.pl GOLD $pdttest_path/ln95046_093-HH-all.umr CONV $pdttest_path/ln95046_093-conv.umr > $pdttest_path/evaluation-ln95046_093.txt");
sysrun("perl $script_path/compare_umr.pl GOLD $pdttest_path/pdtsc_093_3.02-ML-all.umr CONV $pdttest_path/pdtsc_093_3.02-conv.umr > $pdttest_path/evaluation-pdtsc_093_3.02.txt");
sysrun("perl $script_path/compare_umr.pl GOLD $pdttest_path/pdtsc_146_2.05-HH-all.umr CONV $pdttest_path/pdtsc_146_2.05-conv.umr > $pdttest_path/evaluation-pdtsc_146_2.05.txt");
sysrun("perl $script_path/compare_umr.pl GOLD $pdttest_path/wsj0013.cz-ML.umr CONV $pdttest_path/wsj0013.cz-conv.umr > $pdttest_path/evaluation-wsj0013.cz.txt");
sysrun("perl $script_path/compare_umr.pl GOLD $pdttest_path/wsj0072.cz-HH.umr CONV $pdttest_path/wsj0072.cz-conv.umr > $pdttest_path/evaluation-wsj0072.cz.txt");
# Evaluation of Federica's conversion from UD to UMR.
sysrun("perl $script_path/compare_umr.pl GOLD $conv_path/gold_total_cs_test.txt CONV $conv_path/converter-output_total_cs_test.txt > $conv_path/comparison-cs.txt");
sysrun("perl $script_path/compare_umr.pl GOLD $conv_path/gold_total_en_test.txt CONV $conv_path/converter-output_total_en_test.txt > $conv_path/comparison-en.txt");
sysrun("perl $script_path/compare_umr.pl GOLD $conv_path/gold_total_it_test.txt CONV $conv_path/converter-output_total_it_test.txt > $conv_path/comparison-it.txt");



sub sysrun
{
    my $command = join(' ', @_);
    my $echocommand = $command;
    $echocommand =~ s/^.*?compare_umr.pl/compare/;
    print("$echocommand\n");
    system($command);
    print("\n");
}
