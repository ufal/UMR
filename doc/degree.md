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
