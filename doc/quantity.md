# Quantity

The UMR guidelines discuss quantitative concepts in [Part
3-2-2-5](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-2-2-5-quantification).

The most basic keyword for quantification is `:quant`. The guidelines
sometimes call it a “relation”, which would mean that it should be understood
as an edge going to a child concept node, and sometimes an “attribute”, which
means that there is an atomic value but no child node (see also
[terminology](terminologie.md)). Based on the examples, `:quant` can be both.
In the typical situation, it is an attribute with a numeric value. But when
it is used to annotate approximate cardinalities (_more than_, _most_), it
will look as a relation whose child node is the approximative concept.

For exact quantities, the value is expressed in digits even if the surface
expression was verbose. The guidelines do not specify how it is normalized; I
suppose that in languages where decimal comma is used in the text, it will be
normalized to decimal point in UMR.

```
tři domy “three houses”
(d/ dům
    :quant 3)
```

The guidelines give an English example for _more than 3_. It is thus unclear
whether we should use native concepts in other languages, or should we use
`more-than` as a cross-lingual abstract concept? Furthermore, example (1f) in
the guidelines shows an `:op1` attribute of `more-than`, which gives the
numeric value to compare with.

```
více než tři domy “more than three houses”
(d/ dům
    :quant (v/ více-než :op1 3))
```

Other comparison-like quantities are probably treated similarly because the
[degree](degree.md) attribute and abstract event seem to be intended only for
the degree of a quality.

```
nejvíce hlasů “most votes”
(h/ hlas
    :quant (n/ nejvíce))
```

Units (both standardized and informal) are presented as a relation whose
child node is the unit concept. The relation goes from the concept counted
(it is a sibling of `:quant`).

```
tři hrnky mléka “three cups of milk”
(m/ mléko
    :quant 3
    :unit (h/ hrnek))
```

**Percentage** should use the abstract concept `percentage-entity` with the
numeric attribute `:value` (example (1c) in the guidelines. The guidelines do
not show its usage in a sentence though. I assume that it could be used as a
child node of the `:quant` relation.

```
20,5 procenta voličů “20.5 percent of voters”
(v/ volič
    :quant (p/ percentage-entity
        :value 20.5))
```

How to annotate **indefinite quantity**?
```
[la] paululum commoratus 'having waited for a while'
(c/commoror
    :ARG0 (p/person
            ...)
    :duration (t/temporal-quantity
                :quant? (p2/paululum)))
```


### Quantity types

AMR guidelines mention **Quantity types** in Sect. [Quantities](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#quantities):

Quantity types include: `monetary-quantity`, `distance-quantity`, `area-quantity`, `volume-quantity`, `temporal-quantity`, `frequency-quantity`, `speed-quantity`, `acceleration-quantity`, `mass-quantity`, `force-quantity`, `pressure-quantity`, `energy-quantity`, `power-quantity`, `voltage-quantity` (zap!), `charge-quantity`, `potential-quantity`, `resistance-quantity`, `inductance-quantity`, `magnetic-field-quantity`, `magnetic-flux-quantity`, `radiation-quantity`, `concentration-quantity`, `temperature-quantity`, `score-quantity`, `fuel-consumption-quantity`, `seismic-quantity`, some of them are exemplified there. However, no exhaustive list and full descriptions/definitions are provided.