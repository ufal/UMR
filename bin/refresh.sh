#! /bin/bash
set -eu

bin=$(readlink -f "${0%/*}")

tally_treex=0
tally_umr=0
for t in ~/links/pdtc2a/annotators/???/done/*.t ; do
    f=${t##*/}
    f=${f%.t}
    a=${t%.t}.a
    treex=~/links/work/umr/data/stepanek/$f.treex.gz
    umr=${treex%.treex.gz}.umr


    if [[ $treex -ot $t || $treex -ot $a ]] ; then
        ls -latr "$t" "$a" "$treex" "$umr"
        echo Referesh $treex >&2
        "$bin"/pdt2treex "$t"
        mv "$t"reex.gz data/stepanek/
        ((++tally_treex))
    fi
    if [[ $umr -ot $treex ]] ; then
        ls -latr "$t" "$a" "$treex" "$umr"
        echo Refresh "$umr" >&2
        "$bin"/treex2umr "$f"
        ((++tally_umr))
    fi
done
echo Refreshed $tally_treex treex files.
echo Refreshed $tally_umr umr files
