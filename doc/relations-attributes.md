# Relations and Attributes

This document should serve as a reference list (alphabetically ordered) of
relations and attributes used in UMR. The [UMR
guidelines](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md)
initially seem to distinguish **relations** from **attributes** but are later
very inconsistent in using the terms. Both relations and attributes look like
a colon followed by an identifier. Both occur inside the bracketed definition
of a concept node, and both are followed by something. Relations are followed
by a child node (bracketed concept definition or reference to previously
defined node by its identifier (variable)); this way they express directed
edges in the graph (the parent node is the one in whose definition the
relation appears). Attributes are followed by a value (a number, a string in
quotation marks, sometimes just a symbol such as a hyphen). But some
colon-identifiers can be both (sometimes followed by a value, sometimes by a
node). And if we view the attribute values as abstract concepts, i.e., nodes,
relations and attributes become more or less the same thing.

`:actor` – Argument role used for languages that do not have frame files.
Typically corresponds to `:ARG0`.

`:ARG0` – Argument role of an event. Meaning depends on the particular
predicate frame in the dictionary. Typically corresponds to agent or
experiencer.

`:ARG1` – Argument role of an event. Meaning depends on the particular
predicate frame in the dictionary. Typically corresponds to patient or theme.

`:ARG2` – Argument role of an event. Meaning depends on the particular
predicate frame in the dictionary. Typically corresponds to addressee.

`:ARG3` – Argument role of an event. Meaning depends on the particular
predicate frame in the dictionary.

`:ARG4` – Argument role of an event. Meaning depends on the particular
predicate frame in the dictionary.

`:ARG5` – Argument role of an event. Meaning depends on the particular
predicate frame in the dictionary.

`:ARG6` – Argument role of an event. Meaning depends on the particular
predicate frame in the dictionary.

`:aspect` – Attribute used with every event. Set of predefined values.

`:degree` – Attribute with values `Intensifier`, `Downtoner` or `Equal`, if
expressed morphologically. Otherwise, it is a relation with the child node
holding the lexical degree concept, e.g. the English word _very_. Defined in
[3-3-6](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-6-degree).

`:duration` – _The soup cooled **for an hour**._ (2b) in 3-3-1-5.

`:location` – Used in example (1) in 3-3-4: _Tickets have been sold **on the
StubHub website**._

`:manner` – Example (3b) in 3-3-1-3.

`:mod` – Generic negation for modifiers. Seems to be used whenever no more
specific relation is available.

`:mode` – Sentence modality, defined in
[3-3-2](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-2-mode).
Values: `expressive`, `imperative`, `interrogative`. There is no value for
declarative sentences, so most events lack this attribute.

`:modpred` – Example (2c) in 3-3-1-3.

`:modstr` – Attribute used with every event. Expresses modality at sentence
level. Typical value `FullAff` (fully affirmative).

`:name` – Always has a `name` concept as its child node, which in turn has
`opX` attributes. Used in named entities.

`:op1`, `:op2`, ... – Attribute or relation, used at various places. In names
of entities, each orthographical word of the name has its own op. In
coordination, the concepts of the conjuncts have each its own op. Some
prepositions, like _before_ in (2b) in 3-3-1-5, introduce their argument as
`:op1`.

`:ord` – For ordinal numbers. Example (2a) in 3-3-1-1.

`:place` – Example (4) in 3-3-1-4: _The soup was cooling **on the counter**._
APPARENTLY TWO NAMES FOR THE SAME THING, BECAUSE THEY ALSO USE `:location`!

`:polarity` – Attribute defined in
[3-3-3](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-3-polarity).
At sentence level it marks morphosyntactic negation, even if it does not
signal semantic negation. Value `-`.

`:poss` – Relation from possessed thing to possessor. See example (1b) in
3-3-1-4.

`:purpose` – Example (4c) in 3-3-1-3.

`:ref-number` – An attribute used with (almost?) every entity concept. Values
correspond to grammatical number (`Singular`, `Plural` etc.) but the
attribute is here because of the semantics. On the other hand, it is not a
general means to indicate quantity; for that, the `:quant` attribute is used.

`:ref-person` – An attribute used with entity nodes corresponding to personal
pronouns (overt or not; they can be deduced from verbal morphology or from
other contextual clues).

`:quant` – Typically an attribute, sometimes a relation. Defined in
[3-3-4](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-4-quant).
As an attribute it has a numeric value. As a relation it has a child node
with a concept describing approximate quantity.

`:temporal` – _The soup cooled for an hour **before we ate it**._ (2b) in
3-3-1-5.

`:time` – Example (4d) in 3-3-1-3.

`:undergoer` – Argument role used for languages that do not have frame files.
Typically corresponds to `:ARG1`.

`:unit` – Relation used with quantities. The child node is a unit concept
(both standardized and informal units), e.g., _day_ for duration.

`:wiki` – Attribute of an entity concept, containing a reference to the
article in Wikipedia that describes the entity. The examples in the
guidelines have titles of English articles here, but we should use wikidata
titles instead ("Q"+number).



# Predefined Abstract Concepts

`ordinal-entity`

`temporal-quantity`

`thing`

