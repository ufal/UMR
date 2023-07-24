# Degree

The UMR guidelines discuss degree constructions in [Part
3-3-6](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-6-degree).
That part is not primarily about comparison. It is about degree adverbs like
_very_ and _somewhat_, and about their morphological counterparts in other
languages. If there is a lexical degree adverb, it is used as a child node of
the relation `:degree` (they refer to it as “attribute” here but it should
probably be a “relation” when it gets child concepts).

```
velmi velký “very large”
(v/ velký-001 'large'
    :degree (v2/ velmi 'very'))
```

When the degree is expressed morphologically, `:degree` becomes an attribute
with one of the values `Intensifier`, `Downtoner`, `Equal`. The example is
from Sanapaná:

```
ak-yav-ay'-a “very large”
(e/ enyavay'a-00 'large'
    :degree Intensifier)
```

They suggest that in Czech, the lexicon will explain that _velmi_ is an
`Intensifier`. (They actually show it on the example of English _very_.)

## Comparison

While the UMR guidelines do not analyze comparison, the AMR guidelines do
[provide some examples](https://www.isi.edu/~ulf/amr/lib/popup/degree.html).
Since UMR does not negate the AMR approach, maybe it is done the same way
there. AMR employs the abstract event `have-degree-91`. (The UMR guidelines
mention this abstract event only in one example in [Part
3-1-3-8](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-3-8-miscellaneous-constructions).)

```
the most expensive dress
(d/ dress
    :ARG1-of (h/ have-degree-91
        :ARG2 (e/ expensive)
        :ARG3 (m/ most)))
```

The superlative in Czech is morphological but the `:degree Intensifier`
attribute would not be appropriate here because _nejvíce_ is not the same
concept as _velmi_. Also, it is not clear how we would use the attribute
instead of the `have-degree-91` event.

```
nejdražší šaty “the most expensive dress”
(š/ šaty
    :ARG1-of (h/ have-degree-91
        :ARG2 (d/ drahý-001)
        :ARG3 (n/ nejvíce)))
```

AMR uses :ARG3 and :ARG4 of `have-degree-91` to express the standard of
comparison.

```
dívka je vyšší než chlapec “the girl is taller than the boy”
(h/ have-degree-91
    :ARG1 (d/ dívka)
    :ARG2 (v/ vysoký-001)
    :ARG3 (v2/ více)
    :ARG4 (ch/ chlapec))
```

AMR also uses :ARG6 to express purpose or result (_it is small enough to fit
in your pocket_, _he was so tired that he slept for 10 hours_).
