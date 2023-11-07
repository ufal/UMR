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
