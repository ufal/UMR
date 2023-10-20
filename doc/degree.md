# Degree

The UMR guidelines discuss degree constructions in [Part
3-3-6](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-6-degree).
That part focus on degree adverbs like
_very_ and _somewhat_, and on  their morphological counterparts in other
languages. The keyword `degree` is used in two different ways:
- If there is a lexical degree adverb, it is used as a child node of
the relation `:degree` (they refer to it as “attribute” here but it should
probably be a “relation” when it gets child concepts).

```
velmi velký “very large”
(v/ velký-001 'large'
    :degree (v2/ velmi 'very'))
```

The AMR guidelines provide more examples, as, e.g., _I hardly know her._
```
(k / know-01
  :ARG0 (i / i)
  :ARG1 (s / she)
  :degree (h / hardly))
```


- When the degree is expressed morphologically, `:degree` becomes an attribute
with one of the values `Intensifier`, `Downtoner`, `Equal`. The example is
from Sanapaná:

```
ak-yav-ay'-a “very large”
(e/ enyavay'a-00 'large'
    :degree Intensifier)
```

They suggest that in Czech, the lexicon will explain that _velmi_ is an
`Intensifier`. (They actually show it on the example of English _very_.)

### TODO: Lexicon of Czech intensifiers and downtowners  


## Comparisons and superlatives - degree of a quality 


While the UMR guidelines do not analyze comparison, the AMR guidelines do
[provide some examples](https://www.isi.edu/~ulf/amr/lib/popup/degree.html).
Since UMR does not negate the AMR approach, maybe it is done the same way
there. AMR employs the abstract event `have-degree-91`.   
The UMR guidelines mention this abstract event only in one example in [Part
3-1-3-8](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-3-8-miscellaneous-constructions). However, the abstract predicate `have-degree-91`is listed in the [UMR abstract roleset list](https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit#gid=1927108453), with tyhe following set of roles:
```
Have-degree-91
Arg1: domain, entity characterized by attribute (e.g. girl)
Arg2: attribute (e.g. tall)
Arg3: degree itself (e.g. more, most, less, least, times, equal, enough, too, so, to-the-point, at-least, times)
Arg4: compared-to (e.g. (than the) BOY)
Arg5: superlative: reference to superset
Arg6: reference, threshold of sufficiency (e.g. (tall enough, to ride the rollercoaster) )
```


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

According to the AMR Guidelines, "Annotators are encouraged to use have-degree-91 as the root concept (...) when a comparison seems to be the main focus of the sentence, which include cases of the copular construction (e.g., _the girl is taller than the boy_, _she is the tallest girl on the team—see below_, see below).


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


## Comparison of quantity

The [counterexamples in
AMR](https://www.isi.edu/~ulf/amr/lib/popup/degree.html) indicate that the
abstract event `have-degree-91` should not be used when comparing quantities, as in _I need more money_ or _Most students don't like math._ 
On the other
hand, the way the AMR examples are annotated probably is not right in UMR,
where we have the `:quant` attribute / relation. See
[quantity.md](quantity.md).

However, AMR also offers the `have-quant-91` abstract predicate which should be used in a parallel way as `have-degree-91` for comparison of qualities of things (i.e., if some amount is compared to some reference amount), see [Quantity](quantity.md).






