#!/bin/bash
SRC=/net/work/people/stepanek/umr/data/stepanek
cat $SRC/ln94210_111.umr | perl -pe 's:/\s*\#:/ :g' > ./ln94210_111-conv.umr
cat $SRC/ln95046_093.umr | perl -pe 's:/\s*\#:/ :g' > ./ln95046_093-conv.umr
cat $SRC/pdtsc_093_3.02.umr | perl -pe 's:/\s*\#:/ :g' > ./pdtsc_093_3.02-conv.umr
cat $SRC/pdtsc_146_2.05.umr | perl -pe 's:/\s*\#:/ :g' > ./pdtsc_146_2.05-conv.umr
cat $SRC/wsj0013.cz.umr | perl -pe 's:/\s*\#:/ :g' > ./wsj0013.cz-conv.umr
cat $SRC/wsj0072.cz.umr | perl -pe 's:/\s*\#:/ :g' > ./wsj0072.cz-conv.umr
#------------------------------------------------------------------------------
echo WARNING! The gold standard files have fewer sentences than the original files
echo (pending manual annotation). The converted files must be shortened accordingly.
echo Without prior shortening, the concatenations below cannot be evaluated.
#------------------------------------------------------------------------------
cat ./ln94210_111-conv.umr ./ln95046_093-conv.umr > ./pdt-conv.umr
cat ./pdtsc_093_3.02-conv.umr ./pdtsc_146_2.05-conv.umr > ./pdtsc-conv.umr
cat ./wsj0013.cz-conv.umr ./wsj0072.cz-conv.umr > ./pcedt-conv.umr
cat ./pdt-conv.umr ./pdtsc-conv.umr ./pcedt-conv.umr > ./dtest-conv.umr
#------------------------------------------------------------------------------
# Conversions to AMR can be used to compute smatch.
extract_sentence_graphs.pl < ./pdt-conv.umr > ./pdt-conv.amr
extract_sentence_graphs.pl < ./pdtsc-conv.umr > ./pdtsc-conv.amr
extract_sentence_graphs.pl < ./pcedt-conv.umr > ./pcedt-conv.amr
extract_sentence_graphs.pl < ./dtest-conv.umr > ./dtest-conv.amr
