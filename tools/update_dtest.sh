#!/bin/bash
SRC=/net/work/people/stepanek/umr/data/stepanek
cp $SRC/ln94210_111.umr ./ln94210_111-conv.umr
cp $SRC/ln95046_093.umr ./ln95046_093-conv.umr
cat ./ln94210_111-conv.umr ./ln95046_093-conv.umr > ./pdt-conv.umr
cp $SRC/pdtsc_093_3.02.umr ./pdtsc_093_3.02-conv.umr
cp $SRC/pdtsc_146_2.05.umr ./pdtsc_146_2.05-conv.umr
cat ./pdtsc_093_3.02-conv.umr ./pdtsc_146_2.05-conv.umr > ./pdtsc-conv.umr
cp $SRC/wsj0013.cz.umr ./wsj0013.cz-conv.umr
cp $SRC/wsj0072.cz.umr ./wsj0072.cz-conv.umr
cat ./wsj0013.cz-conv.umr ./wsj0072.cz-conv.umr > ./pcedt-conv.umr
cat ./pdt-conv.umr ./pdtsc-conv.umr ./pcedt-conv.umr > ./dtest-conv.umr
