# Alignment between UMR graph and the sentence tokens

Alignment is an important part of UMR annotation that anchors UMR concept
nodes to the sentence. Unlike AMR, alignments in UMR are supposed to be
available for every annotated sentence and are directly stored in the same
file as the graphs. However, at present they are not documented in the [UMR
annotation
guidelines](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md).
We have to guess the rules from the [released
data](http://hdl.handle.net/11234/1-5198) or from what the [UMR annotation
tool](https://github.com/jinzhao3611/umr-annotation-tool) does.

A UMR file has four annotation blocks for each sentence. Each block starts
with a comment line (first character is `#`) and ends with an empty line. The
alignment is described in the third block but the first block is important as
well because it defines the tokens to which the alignment refers. The format
of the first block is not unified and varies across languages in UMR 1.0. The
important point is that the surface sentence must be presented as a sequence
of tokens where neighboring tokens must be separated by a space character. So
for example, we must insert a space between a word and a following comma.

The third block has as many non-comment lines as there are concept nodes in
the sentence level graph. The order of the lines (nodes) is not significant.
Each such line starts with a node id (variable), followed by a colon and a
space, followed by numeric references to token ranges. For example, the
following line says that node `s16p` is aligned to the first token of the
sentence (whose index is 1, not 0):

```
s16p: 1-1
```

Note that even if the node is aligned to a single token, it is still
presented as a range.

## Discontinuous alignment

Sometimes a node corresponds to multiple tokens that are not adjacent in the
sentence. It means that we need discontinuous alignments. Nothing similar
occurs in the UMR 1.0 data, so we define the notation here. An alignment line
may contain multiple ranges separated by a comma and a space. When this
happens, the sub-ranges must be ordered by the token numbers and the first
token number of a sub-range must be higher than the last token number of the
previous sub-range + 1 (that is, there must be a gap containing at least one
token, otherwise the sub-ranges could be merged).

```
s16p: 1-2, 4-4
```

## Unaligned nodes

Abstract concepts (reifications, discourse relations etc.) that do not have a
corresponding token on the surface still have an alignment line but their
alignment is 0-0. Naturally, 0 cannot be combined with real token ranges,
hence 0-1 would be illegal.

Certain special nodes (such as the `name` concept attached via a `:name`
relation to a concept representing a named entity) are anchored to "-1"
instead of 0, so their range is -1--1. See also [issue #2 in the UMR
annotation repository](https://github.com/cu-clear/UMR-Annotation/issues/2).

## Unaligned tokens

??? – to investigate

## Overlapping alignments?

??? – to investigate whether two nodes can map to the same token

## What to align to what

These are our (ÚFAL) guidelines. They may be inspired by what we saw in UMR
1.0 but they do not attempt to mimic exactly the approach taken there.

* The easiest alignment is between a content word and the concept node that
represents it: entities to nouns, states to adjectives or verbs, and
processes to verbs.

* Overtly expressed discourse connectives often have their own nodes, too.

* Auxiliary verbs are aligned together with the main verb to the same event
concept. The same holds for non-referential reflexive markers (_smát se_ “to
laugh”) and for verbal particles (_come up_).

* Some prepositions may have their own concept nodes. If they do not, then
they should be aligned to the same node as their noun (they are like case
markers in other languages). Note that this may lead to discontinuous
alignment if there is an adjective between the preposition and the noun.

* Subordinating conjunctions are to clauses what prepositions are to
nominals, so we might treat them accordingly and align them with verbs,
unless they have their own node. This would be parallel to languages where
subordination is marked morphologically on the verb.

* Numerical quantities do not have their own concept node because they are
annotated as numerical `:quant` attributes, e.g. `(s1h / house :quant 10)`.
Therefore we should align `s1h` to the whole expression _ten houses_. (This
is different from approximate quantities that have their own node and
`:quant` is the relation that attaches them, e.g. `(s1h / house :quant (s1s /
several))` will have `s1h` attached to _houses_ and `s1s` to _several_.)

* Punctuation tokens are normally not aligned with nodes. An exception would
be that a node is aligned to a range of tokens, there is a punctuation symbol
somewhere in the middle of the range and excluding it from the alignment
would break the otherwise contiguous alignment into two sub-ranges.

* Reifications (the \*-91 event concepts) are meant as abstract concepts,
meaning that they _typically_ do not have a corresponding token. However, if
there is a token that is not aligned to anything else and that gave rise to
the event, we should align it with the \*-91 node. In particular, the copula
(_být_ “to be”) will often correspond to `have-property-91`.

* The abstract concepts `person`, `thing` etc. may be aligned to overtly
expressed pronouns. If the concept is only inferred from morphological
agreement marked on the verb, it will stay unaligned.

* Somewhat schizophrenic situation arises with named entities. Typically
there is an abstract concept (`person`, `organization` etc.) with a `name`
child node. The abstract parent is aligned to the name tokens in the
sentence. The `name` child stays unaligned, although it directly points to
the orthographic words of the name via its `:opN` attributes. (This rule is
inferred from the data relased in UMR 1.0.)
  * Nevertheless, there are situations when a `name` node is aligned to
    the name tokens. If the parent node has other children and they are
    aligned, then the parent node will not be aligned to the name tokens,
    hence the name node will align with them. For example, _the Philippine
    island of Leyte_ is analyzed as
    `(s4i2 / island :wiki "Leyte"
        :name (s4n2 / name :op1 "Leyte")
        :place (s4c / country  :wiki "Philippines"
            :name (s4n3 / name :op1 "Philippine")))`
    where `s4i2` is aligned to _island_, `s4n2` to _Leyte_, `s4c` to
    _Philippine_, and `s4n3` is unaligned.

* More generally, the approach in UMR 1.0 seems to be:
  * If the parent node covers the same tokens as its child node, the alignment
    will be assigned to the parent and the child will be formally unaligned.
    For example (english_umr-0003, snt8), _doctor_ is represented as
    `(s8p2 / person :ARG1-of (s8h / have-role-91 :ARG3 (s8d / doctor)))`;
    the token is aligned to `s8p2`, while `s8h` and `s8d` are unaligned.
  * If the parent node has multiple children that together completely cover
    the parent's span, the alignment will be assigned to the children and the
    parent will be formally unaligned. For example (english_umr-0003, snt6),
    _next several days_ is represented as
    `(s6t / temporal-quantity :quant (s6s2 / several) :unit (s6d / day) :mod (s6n / next))`;
    here, `s6s2`, `s6d` and `s6n` are aligned to their respective tokens while
    `s6t` is unaligned.

* While the above rules strive to align as many non-punctuation tokens as
possible, it is not required that all of them are aligned to concepts. There
may be words that are not even distantly related to any individual node; such
words will stay unaligned.
