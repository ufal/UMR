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
my $eston_path = "$root_path/umr-ufal/data/czech";
my $pdttest_path = "$eston_path/PDT-dtest-part-manual";

system("perl $script_path/compare_umr.pl DZ $eston_path/mf920922-133_estonsko-DZ.umr ML $eston_path/mf920922-133_estonsko-ML.umr > $eston_path/comparison-DZ-ML.txt");
system("perl $script_path/compare_umr.pl ML $pdttest_path/ln94210_111-ML-all.umr HH $pdttest_path/ln94210_111-HH-s1-s5.umr > $pdttest_path/comparison-ln94210_111.txt");
system("perl $script_path/compare_umr.pl ML $pdttest_path/ln95046_093-ML-s1-s6.umr HH $pdttest_path/ln95046_093-HH-all.umr > $pdttest_path/comparison-ln95046_093.txt");
system("perl $script_path/compare_umr.pl GOLD $conv_path/gold_total_cs_test.txt CONV $conv_path/converter-output_total_cs_test.txt > $conv_path/comparison-cs.txt");
system("perl $script_path/compare_umr.pl GOLD $conv_path/gold_total_en_test.txt CONV $conv_path/converter-output_total_en_test.txt > $conv_path/comparison-en.txt");
system("perl $script_path/compare_umr.pl GOLD $conv_path/gold_total_it_test.txt CONV $conv_path/converter-output_total_it_test.txt > $conv_path/comparison-it.txt");
