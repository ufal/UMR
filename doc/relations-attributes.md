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
Typically corresponds to `:ARG0`. See 3-2-1-4.

`:affectee` – Argument role used for languages that do not have frame files.
Typically corresponds to `:ARG2`. See 3-2-1-4.

`:age` – Example (2d) in 3-2-2-2: _the **thirty year-old** man_.

`:apprehensive` – Example (3b) in 3-1-6.

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

`:cause` – Introduced in 3-2-1-1. See also `:reason`.

`:causer` – Used in causatives. See Table 11 in 3-2-1-1-2.

`:century` – This relation is mentioned in 3-2-2-1 but there are no examples
how it is used.

`:companion` – Argument role used for languages that do not have frame files.
Appears in example (7b) in 3-2-1-1.

`:concession` – Briefly mentioned at the end of 3-2.

`:condition` – Briefly mentioned at the end of 3-2.

`:day` – Looks like attribute, introduced among relations in 3-2-2-1. The
value is the day-of-month number. See also `:weekday`.

`:dayperiod` – This relation is mentioned in 3-2-2-1 but there are no
examples how it is used.

`:decade` – This relation is mentioned in 3-2-2-1 but there are no examples
how it is used.

`:degree` – Attribute with values `Intensifier`, `Downtoner` or `Equal`, if
expressed morphologically. Otherwise, it is a relation with the child node
holding the lexical degree concept, e.g. the English word _very_. Defined in
[3-3-6](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-6-degree).

`:direction` – _He drove **west**._ (1a) in 3-2-2-3.

`:duration` – _The soup cooled **for an hour**._ (2b) in 3-3-1-5.

`:era` – This relation is mentioned in 3-2-2-1 but there are no examples how
it is used.

`:example` – _countries **like Germany and France**._ (1a) in 3-2-2-6.

`:experiencer` – Argument role used for languages that do not have frame
files. Typically corresponds to `:ARG0`.

`:extent` – Introduced in 3-2-1-1.

`:force` – Argument role used for languages that do not have frame files.
Appears in example (7g) in 3-2-1-1.

`:frequency` – _I visited New York City **twice**._ (1d) in 3-2-2-3. Despite
being shown among relations, it seems to be an attribute. The value is a
number (2, not _twice_).

`:goal` – Argument role used for languages that do not have frame files.
Typically corresponds to `:ARG2`.

`:group` – Used in partitives. Example (2e) in 3-2-2-2: _a swarm **of
bees**_. See also `:part`.

`:instrument` – Argument role used for languages that do not have frame
files.

`:li` – Attribute with string value that holds the list item label in
numbered lists, if the parent concept is a list item. The whole list is
treated as coordination, so the parent of `:li` is a child of `:opX` of the
`and` concept. Example (1c) in 3-2-2-6.

`:location` – Used in example (1) in 3-3-4: _Tickets have been sold **on the
StubHub website**._

`:manner` – Example (3b) in 3-3-1-3.

`:material` – Argument role used for languages that do not have frame files.
Introduced in 3-2-1-1. It only occurs with creation events, as in (1c): _She
built a house **out of wood**._

`:medium` – Used to introduce language in which something is said or written.
Example (2g) in 3-2-2-2: _a **French** song_.

`:mod` – Generic negation for modifiers. Seems to be used whenever no more
specific relation is available. Used also with demonstratives: (2d) in
3-2-2-2.

`:mode` – Sentence modality, defined in
[3-3-2](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-2-mode).
Values: `expressive`, `imperative`, `interrogative`. There is no value for
declarative sentences, so most events lack this attribute.

`:modpred` – Example (2c) in 3-3-1-3.

`:modstr` – Attribute used with every event. Expresses modality at sentence
level. Typical value `FullAff` (fully affirmative).

`:month` – Looks like attribute, introduced among relations in 3-2-2-1. The
value is the month number. (Not sure what they do with lunar and other
calendars.)

`:name` – Always has a `name` concept as its child node, which in turn has
`opX` attributes. Used in named entities.

`:op1`, `:op2`, ... – Attribute or relation, used at various places. In names
of entities, each orthographical word of the name has its own op. In
coordination, the concepts of the conjuncts have each its own op. Some
prepositions, like _before_ in (2b) in 3-3-1-5, introduce their argument as
`:op1`.

`:ord` – For ordinal numbers. Example (2a) in 3-3-1-1. Introduced in 3-2-2-5.

`:other-role` – Introduced in Table 5 in 3-2-1-1, described at the end of
3-2. Used if the annotator encounters a concept for which UMR currently does
not have a defined procedure of annotating it.

`:part` – Used to attach a concept describing the whole as a child node of
the concept describing its part. Example (1b) in 3-2-2-2: _**guitar**
strings_. See also `:group`.

`:path` – _He drove **through the tunnel**._ (1b) in 3-2-2-3.

`:place` – Example (4) in 3-3-1-4: _The soup was cooling **on the counter**._
APPARENTLY TWO NAMES FOR THE SAME THING, BECAUSE THEY ALSO USE `:location`!
But `:place` is also shown as an argument role (e.g. of _sit_) used for
languages that do not have frame files (part 3-2-1-4).

`:polarity` – Attribute defined in
[3-3-3](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-3-polarity).
At sentence level it marks morphosyntactic negation, even if it does not
signal semantic negation. Value `-`.

`:polite` – Shown among relations (example (1b) in 3-2-2-6) but it looks like
an attribute with the boolean value `+`.

`:poss` – Relation from possessed thing to possessor. See example (1b) in
3-3-1-4.

`:purpose` – Example (4c) in 3-3-1-3.

`:quant` – Typically an attribute, sometimes a relation. Defined in
[3-3-4](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-4-quant).
As an attribute it has a numeric value. As a relation it has a child node
with a concept describing approximate quantity.

`:quarter` – This relation is mentioned in 3-2-2-1 but there are no examples
how it is used.

`:range` – Used with quantities. Example (1b) in 3-2-2-5.

`:reason` – Introduced in 3-2-1-1. See also `:cause`.

`:recipient` – Argument role used for languages that do not have frame files.
Typically corresponds to `:ARG2`.

`:ref-number` – An attribute used with (almost?) every entity concept. Values
correspond to grammatical number (`Singular`, `Plural` etc.) but the
attribute is here because of the semantics. On the other hand, it is not a
general means to indicate quantity; for that, the `:quant` attribute is used.

`:ref-person` – An attribute used with entity nodes corresponding to personal
pronouns (overt or not; they can be deduced from verbal morphology or from
other contextual clues).

`:scale` – Used together with `:quant`, e.g. in _6.5 **on the Richter
scale**_. Example (1h) in 3-2-2-5.

`:season` – This relation is mentioned in 3-2-2-1 but there are no examples
how it is used.

`:source` – Argument role used for languages that do not have frame files.

`:start` – Argument role used for languages that do not have frame files.

`:stimulus` – Argument role used for languages that do not have frame files.

`:subtraction` – Example (8) in 3-1-6: _**except for Joe**_.

`:temporal` – _The soup cooled for an hour **before we ate it**._ (2b) in
3-3-1-5.

`:theme` – Argument role used for languages that do not have frame files.
Typically corresponds to `:ARG1`.

`:time` – Example (4d) in 3-3-1-3. It looks like attribute, introduced among
relations in 3-2-2-1. The value is the local time in 24h format. See also
`:timezone`.

`:timezone` – A relation introduced in 3-2-2-1. Typically used together with
`:time`. The child node is a concept defining the zone. Apparently they
assume some standardized time zone concepts, as the text contained
_Albuquerque time_ but they converted it to `:timezone (z/ MST)`, i.e.,
Mountain Standard Time.

`:topic` – Example (2f) in 3-2-2-2: _information **about the case**_.

`:undergoer` – Argument role used for languages that do not have frame files.
Typically corresponds to `:ARG1`.

`:unit` – Relation used with quantities. The child node is a unit concept
(both standardized and informal units), e.g., _day_ for duration.

`:value` – Used with `ordinal-entity`, `percentage-entity`, `url-entity` in
3-2-2-5.

`:weekday` – A relation introduced in 3-2-2-1. The child node is the concept
with the name of the day of the week, presumably in the local language (they
have an English example and there is `:weekday (f/ Friday)`). See also
`:day`.

`:wiki` – Attribute of an entity concept, containing a reference to the
article in Wikipedia that describes the entity. The examples in the
guidelines have titles of English articles here, but we should use wikidata
titles instead ("Q"+number).

`:year` – Looks like attribute, introduced among relations in 3-2-2-1. The
value is the year number. (Not sure what they do with BCE or other
calendars.)

`:year2` – This relation is mentioned in 3-2-2-1 but there are no examples
how it is used.



# Predefined Abstract Concepts

`and`

`date-entity`

`ordinal-entity`

`percentage-entity`

`temporal-quantity`

`thing`

`truth-value`

`url-entity`

