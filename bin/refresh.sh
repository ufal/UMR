#! /bin/bash
set -eu

bin=$(readlink -f "${0%/*}")

tally_treex=0
tally_umr=0
failed=()
for t in ~/links/pdtc2a/annotators/???/done/*.t ; do
    f=${t##*/}
    f=${f%.t}
    a=${t%.t}.a
    treex=~/links/work/umr/data/stepanek/$f.treex.gz
    umr=${treex%.treex.gz}.umr


    if [[ $treex -ot $t || $treex -ot $a || ! -s $treex ]] ; then
        echo Referesh $treex >&2
        if "$bin"/pdt2treex "$t" ; then
            mv "$t"reex.gz data/stepanek/
            ((++tally_treex))
        else
            failed+=($treex)
        fi
    fi
    if [[ $umr -ot $treex || ! -s $umr ]] ; then
        echo Refresh "$umr" >&2
        if "$bin"/treex2umr "$f" ; then
            ((++tally_umr))
        else
            failed+=($umr)
        fi
    fi
done
echo Refreshed $tally_treex treex files.
echo Refreshed $tally_umr umr files
if (( ${#failed[@]} )) ; then
    echo Failed: "${failed[@]}"
fi
