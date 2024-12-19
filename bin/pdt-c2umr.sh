#! /bin/bash
set -eu -o pipefail
shopt -s extglob

if [[ ${1:-""} != @(all|trx2u|vrf) ]] ; then
    echo 'Specify "all", "trx2u", or "vrf" to run the whole process,' >&2
    echo 'conversion from treex to UMR, or just the verification.' >&2
    exit 1
fi
declare -A action
action=([all]=3 [trx2u]=2 [vrf]=1)

echo Source dir: "$UFAL_PDTC2A" >&2
echo Target dir: "$UFAL_UMR"/data/stepanek/ >&2
[[ -x /usr/bin/srun ]] || {
    echo 'Not on cluster!' >&2
    exit 1
}

srun=(/usr/bin/srun -p cpu-ms,cpu-troja)

pdt2treex() {
    cd "$UFAL_UMR"
    treex -pj48 github/tecto2umr/scen/pdt2treex.scen
    mv "$UFAL_PDTC2A"/annotators/???/done/*.treex.gz \
       "$UFAL_UMR"/data/stepanek/
}

treex2umr() {
    (
        cd data/stepanek >/dev/null
        ls *.treex.gz | sed 's/\.treex\.gz$//'
    ) | xargs -P48 -n20 "${srun[@]}" github/bin/treex2umr
}

verify() {
    count=$(ls data/stepanek/*.umr | wc -l)
    [[ $count = 7090 ]] || {
        echo Found "$count" UMR files instead of 7090. >&2
        exit 1
    }
    grep -L process_end data/stepanek/*.log
    ls data/stepanek/*.umr | xargs -P48 -n20 "${srun[@]}" btred -QNTe1
}

if [[ ${action[$1]} -ge ${action[all]} ]] ; then
    date >&2
    echo 'PDT-C -> Treex' >&2
    pdt2treex
fi

if [[ ${action[$1]} -ge ${action[trx2u]} ]] ; then
    date >&2
    echo 'Treex -> UMR' >&2
    treex2umr
fi

if [[ ${action[$1]} -ge ${action[vrf]} ]] ; then
    date >&2
    echo Verify >&2
    verify
fi

date >&2
echo Done. >&2
