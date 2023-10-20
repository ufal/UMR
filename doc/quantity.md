# Quantity

The UMR Guidelines list `:quant` among attributes in [Part 3-3.](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-UMR-attributes) as it is followed by a single value, not by a daughter node representing a concept. This single value is
- typically a **number**, but there are also other options as
- a **pre-defined identifier** (I suppose they refer to concepts like "more-then", "most", "between", "as-many-as", but also "all", "many", "several" or "a-few" - which looks like a concept at first sight, as it is in brackets and has its variable, typically followed by `op1` with a number or other numerical value) or 
- ??? a **string in quotation marks** - not found in the English data)

In more detail, they discuss quantitative concepts in [Part
3-2-2-5](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-2-2-5-quantification).

For quantification, the following relations and attributes are available:
- `:quant` (role) ... as a basic keyword,
- `:ord` (role) ... for ordinals, with obligatory o/ordinal-entity as its daughter complemented with the `:value` relation.  

These non-participant roles are supplemented by the following sub-roles:
- `:unit`... both for standardized, well-established units _dollars_, _weeks_) and for ad-hoc mensural constructions (_cups_), 
- `:value`... for numerical expressions incl. ordinals; further, for percentages, phone numbers, e-mail addresses, and urls. 

Further, two sub-roles are available:
- `:range` ... to specify a time period, 
- `:scale`...  for special cases like (_Richter scale_, _Decibel scale_). 

## :quant (role)

The most basic keyword for quantification is `:quant`. The guidelines
sometimes call it a “relation”, which would mean that it should be understood
as an edge going to a child concept node, and sometimes an “attribute”, which
means that there is an atomic value but no child node (see also
[terminology](terminologie.md)). Based on the examples, `:quant` can be both.
In the typical situation, it is an attribute with a numeric value. But when
it is used to annotate approximate cardinalities (_more than_, _most_), it
will look as a relation whose child node is the approximative concept.

The `:quant` attribute is used for both exact and approximate cardinalities of sets of countable objects (_three.quant houses_, _more than.quant three.op1 houses_) as well as for the number of "units" of non-countable substances (_three.quant cups.unit of milk_),

For exact quantities, the value is expressed in digits even if the surface
expression was verbose. The guidelines do not specify how it is normalized; I suppose that in languages where decimal comma is used in the text, it will be normalized to decimal point in UMR.

```
tři domy “three houses”
(d/ dům
    :quant 3)
```

~~DZ: The guidelines give an English example for _more than 3_, see (1f) below. It is thus unclear whether we should use native concepts in other languages, or should we use more-than as a cross-lingual abstract concept? Furthermore, example (1f) in the guidelines shows an :op1 attribute of more-than, which gives the numeric value to compare with.~~

```
(1f) more than three houses
(h/ house
	:quant (m/ more-than :op1 3))
```


ML: The UMR Guidelines give an English example for  _more than 3_, see (1f) above. The [UMR list](https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit#gid=0) of abstract concepts offers  `more-than`  as a cross-lingual abstract concept which should be used in such examples (instead of native concepts in other languages). 
Further, example (1f) in
the guidelines shows an `:op1` attribute of `more-than`, which gives the
numeric value to compare with.

```
více než tři domy “more than three houses”
(d/ dům
    :quant (v/ více-než :op1 3))   OR RATHER  :quant (m/ more-than :op1 3))
```

However, the superlative-like construction _nejvíce hlasů_ “most votes” will be annotated as an elliptical construction (= _nejvíce hlasů ze všech odevzdaných hlasů_) using the `have-quant-91`abstract predicate, as described in the following section.

Having this in mind, comparison-like constructions as _více něž 3 domy_ could be alternatively interpreted as elliptical, too (meaning _více domů než 3 (domy)_ ). Then, their annotation would be parallel to the one offered for superlative-like constructions. However, this possibility is not mentioned in the Guidelines.

Alternatively, comparison constructions can be treated as elliptical constructions, as suggested in the :

### Comparisons and superlatives relating to amounts of things (`have-quant-91`)

As the UMR Guidelines do not discuss comparative-like and superlative-like constructions,  we have to consult the AMR Guidelines.
 
For comparison-like quantities, the [AMR Guidelines](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#quantities) suggest to use `have-quant-91` with the following roleset:

```
have-quant-91
ARG1: entity (thing being quantified)
ARG2: quantity (numerical or quantifier: many, much)
ARG3: degree mention (more, less, equal, too)
ARG4: compared-to
ARG5: superlative: reference to superset
ARG6: consequence, result
```

And exemplified this:

* [en] _He sold **as many** cars as his competitor._   
(= He sold cars the quantity of which.ARG1 is equal.ARG3 comparing to those cars.ARG4 which were sold by his competitor.)

```
He sold as many cars as his competitor. 
(s / sell-01
      :ARG0 (h/ he)
      :ARG1 (c/ car
            :ARG1-of (h2/ have-quant-91
                  :ARG3 (e2/ equal)
                  :ARG4 (c3/ car
                        :ARG1-of (s2/ sell-01
                              :ARG0 (p/ person
                                    :ARG0-of (c2/ compete-02
                                          :ARG1 h)))))))
```

* [en] _He sold **the most** cars of his competitors._   
(= He sold cars the quantity of which.ARG1 has degree most.ARG3, which is superlative with respect to   those cars.ARG5 (=reference to the superset) which were sold by his competitor.)

```
He sold the most cars of his competitors. 
(s / sell-01
      :ARG0 (h/ he)
      :ARG1 (c/ car
            :ARG1-of (h2/ have-quant-91
                  :ARG3 (m/ most)
                  :ARG5 (c3/ car
                        :ARG1-of (s2/ sell-01
                              :ARG0 (p/ person
                                    :ARG0-of (c2/ compete-02
                                          :ARG1 h)))))))
```


* [en] _I had **scarcely enough** drinking water to last a week._


```
(h / have-03
      :ARG0 (i/ i)
      :ARG1 (w/ water
            :purpose (d2/ drink-01
                  :ARG0 i)
            :ARG1-of (h3/ have-quant-91
                  :ARG3 (e/ enough
                        :mod (s/ scarce))
                  :ARG6 (l/ last-03
                        :ARG1 w
                        :ARG2 (t/ temporal-quantity :quant 1
                              :unit (w2/ week))
                        :ARG3 i))))

```

### Comparison of quality 

For **comparisons and superlatives of quality**, the `have-degree-91` abstract predicate is used (in a parallel way as `have-quant-91` for comparison of qualities of things), see [Degree](degree.md).



## :units

Units (both standardized and informal) are presented as a relation whose
child node is the unit concept. The relation goes from the concept counted
(it is a sibling of `:quant`).

```
tři hrnky mléka “three cups of milk”
(m/ mléko
    :quant 3
    :unit (h/ hrnek))
```

## :value

A value of the `:value` attribute is typically a numerical number. 

Thus attribute is also used also for annotating ordinal numbers (with obligatory abstract concept `ordinal-entity`). 
```
The second training was cancelled yesterday.
(c/ cancel-01
	:ARG1 (t/ train-01
		:ord (o/ ordinal-entity
			:value 2)
		:aspect Process)
	:temporal (y/ yesterday)
	:aspect Performance
	:modstr FullAff) 
```
	
However, the same keyword `:value` is used as a relation for annotating percentages, phone numbers, e-mail addresses, and urls.

**Percentage** should use the abstract concept `percentage-entity` with the
numeric attribute `:value` (example (1c) in the guidelines. The guidelines do
not show its usage in a sentence though. I assume that it could be used as a
child node of the `:quant` relation.
```
30 percent
(p/ percentage-entity
	:value 30)
```

```
20,5 procenta voličů “20.5 percent of voters”
(v/ volič
    :quant (p/ percentage-entity
        :value 20.5))
```

**Urls** 
```
http://umr-tool.cs.brandeis.edu/display_post
(u/ url-entity
	:value "http://umr-tool.cs.brandeis.edu/display_post")
```


## :ord (role)
... for ordinals, with obligatory o/ordinal-entity as its daughter complemented with the `:value` relation, 

## :range
 ... to specify a time period, 

## :scale
...  for special cases like (_Richter scale_, _Decibel scale_).


# Questions

How to annotate **indefinite quantity**?
```
[la] paululum commoratus 'having waited for a while'
(c/commoror
    :ARG0 (p/person
            ...)
    :duration (t/temporal-quantity
                :quant? (p2/paululum)))
```

# Quantity types

The [UMR lists](https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit#gid=0) provide also a set of pre-defined **quantities** (as abstract concepts) covering mainly **physical quantities** (fyzikální veličiny) like speed, volume, distance, temperature, acidity, etc., but also, e.g., monetary values. 
These quantities share 
- the `:quant` role (relation/attribute) for the amount and 
- `:unit` role (relation/attribute), represented as siblings in UMR graphs.   
In special cases,   
- `:scale` is used instead `:unit` (for acidity-quantity and seismic-quantity), or as its alternative (temperature-quantity with `:unit` for degree and `:scale` for celsius, kelvin, or farenheit).

~~AMR guidelines mention **Quantity types** in Sect. [Quantities](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#quantities):~~

~~Quantity types include:  
`monetary-quantity`, `distance-quantity`, `area-quantity`, `volume-quantity`, `temporal-quantity`, `frequency-quantity`, `speed-quantity`, `acceleration-quantity`, `mass-quantity`, `force-quantity`, `pressure-quantity`, `energy-quantity`, `power-quantity`, `voltage-quantity` (zap!), `charge-quantity`, `potential-quantity`, `resistance-quantity`, `inductance-quantity`, `magnetic-field-quantity`, `magnetic-flux-quantity`, `radiation-quantity`, `concentration-quantity`, `temperature-quantity`, `score-quantity`, `fuel-consumption-quantity`, `seismic-quantity`, some of them are exemplified there.~~   
~~However, no exhaustive list and full descriptions/definitions are provided.~~


