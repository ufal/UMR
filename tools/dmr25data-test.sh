#!/bin/bash
# Run this in a temporary folder where you can create temporary files.
SRC=/net/work/people/stepanek/dmr25data
CSANOT=$SRC/cs/parallel_annotation
CSAUTO=$SRC/cs/converion_evaluation
LAAUTO=$SRC/la/converion_evaluation
EXCEPT="--except wiki,modal-strength,mode,quote,polite"
cat $CSAUTO/ln94210_111-auto.umr $CSAUTO/ln95046_093-auto.umr > pdt-auto.umr
cat $CSAUTO/ln94210_111-manual.umr $CSAUTO/ln95046_093-manual.umr > pdt-manual.umr
cat $CSAUTO/pdtsc_093_3.02-auto.umr $CSAUTO/pdtsc_146_2.05-auto.umr > pdtsc-auto.umr
cat $CSAUTO/pdtsc_093_3.02-manual.umr $CSAUTO/pdtsc_146_2.05-manual.umr > pdtsc-manual.umr
cat $CSAUTO/wsj0013.cz-auto.umr $CSAUTO/wsj0072.cz-auto.umr > pcedt-auto.umr
cat $CSAUTO/wsj0013.cz-manual.umr $CSAUTO/wsj0072.cz-manual.umr > pcedt-manual.umr
cat pdt-auto.umr pdtsc-auto.umr pcedt-auto.umr > pdtc-auto.umr
cat pdt-manual.umr pdtsc-manual.umr pcedt-manual.umr > pdtc-manual.umr
cp $LAAUTO/sallust-auto.umr ldt-auto.umr
cp $LAAUTO/sallust-manual.umr ldt-manual.umr
for i in pdt pdtsc pcedt pdtc ldt ; do
  echo $i
  /net/work/people/zeman/umr/ufal-umr-repo/tools/compare_umr.pl $EXCEPT GOLD $i-manual.umr CONV $i-auto.umr 2>&1 | tail -18
  echo
done
echo Czech parallel annotation
/net/work/people/zeman/umr/ufal-umr-repo/tools/compare_umr.pl $EXCEPT A1 $CSANOT/annot1.umr A2 $CSANOT/annot2.umr 2>&1 | tail -18

