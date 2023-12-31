# Relations and Attributes in Sentence Level Annotation

**Disclaimer:** We should use the  [**UMR
lists**](https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit#gid=1927108453)
as provided by the UMR team – these lists are updated from time to time,
hopefully more often than the
[guidelines](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md)
from which the relations on this page were extracted. The keywords from the
UMR lists should also be used in the current UMR tool (UMR Writer). The lists
specify:

- **Abstract concepts** ... like (i) "person", "thing", "place", etc.; but
  also (ii) discourse connectors as "but" or "multi-sentence" and (iii)
  structured entities as "date-entity" or "quantities" and others;
- **Abstract rolesets**  ... like (i) frames for "non-verbal" clauses, (ii)
  discourse rolesets and (iii) implicite relation for specific constructions as
  titles, citations or addresses;
- **Roles** ... for (i) participant relations (both general and ARGx) and
  (ii) non-participant relations (and their subroles) but also for (iii) ?some?
  attributes (like ":aspect", ":modstr", ":quot"), and (iv) discourse relations
  as ":condition"
- **Named entities**.

The file provides also sheets with AMR to UMR mappings.

**Disclaimer on the disclaimer:** While the UMR lists are supposed to be the
most authoritative source available, it is not guaranteed that they match the
[UMR 1.0 data](http://hdl.handle.net/11234/1-5198). For example, both the
guidelines and the UMR lists define the relation `:quot` but the data contain
`:quote` instead (see [this
issue](https://github.com/umr4nlp/umr-guidelines/issues/22)).

---

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

Well organized [UMR
lists](https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit#gid=1927108453)
of abstract concepts, abstract rolesets (=abstract predicates), and roles (=
relations/attributes identified by the colon mark) have been recently shared
by Julia.

Additional information can be found also in [AMR annotation
dictionary](https://amr.isi.edu/doc/amr-dict.html).

`:accompanier` –  Introduced in the AMR guidelines as a non-core role in Part II. [Concepts and relations](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#part-ii--concepts-and-relations), exemplified in  *The soldier hummed a tune **for the girl** as he walked with her to town.* (ML added)
?Probably replaced by `:companion` in UMR, example 1 (6), _... before he returns home **with his wife Sherry**?

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

`:aspect` – Attribute used with every event. Set of predefined values. See [Part 3-3-1](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-1-Aspect) of the UMR guidelines.

`:beneficiary` – Introduced in AMR as a non-core role in Part II. [Concepts and relations](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#part-ii--concepts-and-relations) exemplified in  *The soldier hummed a tune for the girl as **he** walked with her to town.* (probably error - the annotation suggests different sentence structure: *The soldier hummed a tune for the girl as she walked with **him** to town.*)
The relation is also listed in the UMR [Reification section](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#reification) there where mapped onto the `benefit-01' predicate (as in *the 5k run is **for kids*** ). (ML added)

`:calendar` – This relation is mentioned in 3-2-2-1, it is used within `date-entity` concepts (see below). Examples in AMR guidelines, section [Other entities: dates, times, percentages, phone, email, URLs](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#other-entities-dates-times-percentages-phone-email-urls) (added by ML)

`:cause` – Introduced in 3-2-1-1 (not listed among AMR / UMR relations). See also `:reason`. ?? TWO SAME NAMES FOR THE SAME CONCEPT (but should be translated as cause-01, so :cause is just a shortcut.)

`:causer` – Used in causatives. See Table 11 in 3-2-1-1-2.

`:century` – This relation is mentioned in 3-2-2-1, it is used within `date-entity` concepts (see below). Examples in AMR guidelines, section [Other entities: dates, times, percentages, phone, email, URLs](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#other-entities-dates-times-percentages-phone-email-urls) (ML)

`:companion` – Argument role used for languages that do not have frame files.
Appears in example (7b) in 3-2-1-1.
Also used for Eng. as a replacement of `:acompanier`, example 1 (6) ??

`:concession` – Briefly mentioned at the end of 3-2.

`:condition` – Briefly mentioned at the end of 3-2.

`:consist-of` - Introduced in the AMR guidelines as a non-core role in Part II. [Concepts and relations](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#part-ii--concepts-and-relations), example: *a ring **of gold***, *a team **of monkeys*** (ML added)

`:day` – Looks like attribute, mentioned among relations in 3-2-2-1. The value is the day-of-month number; see also `:weekday`. It is used within `date-entity`concepts (see below). Examples in AMR guidelines, section [Other entities: dates, times, percentages, phone, email, URLs](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#other-entities-dates-times-percentages-phone-email-urls) (ML)

`:dayperiod` – This relation is mentioned in 3-2-2-1, it is used within `date-entity`concepts (see below). Examples in AMR guidelines, section [Other entities: dates, times, percentages, phone, email, URLs](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#other-entities-dates-times-percentages-phone-email-urls) (ML)

`:decade` – This relation is mentioned in 3-2-2-1, it is used within `date-entity` concepts (see below). Examples in AMR guidelines, section [Other entities: dates, times, percentages, phone, email, URLs](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#other-entities-dates-times-percentages-phone-email-urls) (ML)

`:degree` – Attribute with values `Intensifier`, `Downtoner` or `Equal`, if
expressed morphologically. Otherwise, it is a relation with the child node
holding the lexical degree concept, e.g. the English word _very_. Defined in
[3-3-6](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-6-degree).

`:destination` Introduced in the AMR guidelines as a non-core role in Part II. [Concepts and relations](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#part-ii--concepts-and-relations), example: *He drove west, from Houston **to Austin**.* (ML added)

`:direction` – Introduced in the AMR guidelines as a non-core role in Part II. [Concepts and relations](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#part-ii--concepts-and-relations), example:_He drove **west**._ (repeated in UMR guidelines as (1a) in 3-2-2-3).

`:domain` – Introduced in the AMR guidelines as a non-core role in the overview in Part II. [Concepts and relations](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#part-ii--concepts-and-relations) but no examples there. Used for annotation of copula constructions if there is no appropriate frame for the predicative concept, see [Main verb “be”](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#main-verb-be), e.g., ***The marble** is small.* is annotated as `(s/small
   :domain (m/marble))`, i.e., *marble* being the child of *small* (ML added)

`:duration` – _The soup cooled **for an hour**._ (2b) in 3-3-1-5.

`:era` – This relation is mentioned in 3-2-2-1, it is used within `date-entity` concepts (see below). Examples in AMR guidelines, section [Other entities: dates, times, percentages, phone, email, URLs](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#other-entities-dates-times-percentages-phone-email-urls) (ML)

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
StubHub website**._ Nevertheless, it seems to be obsolete (probably inherited
from AMR but never used in real UMR annotation). Use `:place` instead.

`:manner` – Example (3b) in 3-3-1-3.

`:material` – Argument role used for languages that do not have frame files.
Introduced in 3-2-1-1. It only occurs with creation events, as in (1c): _She
built a house **out of wood**._

`:medium` – Used to introduce language in which something is said or written.
Example (2g) in 3-2-2-2: _a **French** song_.

`:mod` – Generic relation for modifiers. Seems to be used whenever no more
specific relation is available. Used also with demonstratives: (2d) in
3-2-2-2.

`modal-predicate` (originally `:modpred`) – Example (2c) in
[3-3-1-3](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#part-3-3-1-3-state).
If a modal word is identified as its own event, events under its scope are
annotated with a `:modal-predicate` relation going back to the modal. This
typically means that a cycle is formed in the graph.

`:modal-strength` (originally `:modstr`) – Attribute used with every event.
Expresses modality at sentence level. Typical value `full-affirmative`. See
[4-3-1-1](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-4-3-1-1-modstr-values).
This attribute is one of the last-minute changes in UMR release 1.0 to make
the annotation more human-readable. The attribute is now called
`:modal-strength` instead of `:modstr`. The values of `:modal-strength` are
also different and more in line with the lowercase-hyphen style of AMR. For
example, `full-affirmative` is used instead of `FullAff`. Other known values
are `partial-affirmative`, `neutral-affirmative`, `neutral-negative`,
`partial-negative`, and `full-negative`.

`:mode` – Sentence modality, defined in
[3-3-2](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-2-mode).
Values: `expressive`, `imperative`, `interrogative`. There is no value for
declarative sentences, so most events lack this attribute.

`:month` – Looks like attribute, introduced among relations in 3-2-2-1. The
value is the month number. (Not sure what they do with lunar and other
calendars.) It is used within `date-entity` concepts (see below). Examples in
AMR guidelines, section [Other entities: dates, times, percentages, phone,
email,
URLs](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#other-entities-dates-times-percentages-phone-email-urls)
(ML)

`:name` – Always has a `name` concept as its child node, which in turn has
`opX` attributes. Used in named entities.

`:op1`, `:op2`, ... – Attribute or relation, used at various places. In names
of entities, each orthographical word of the name has its own op. In
coordination, the concepts of the conjuncts have each its own op. Some
prepositions, like _before_ in (2b) in 3-3-1-5, introduce their argument as
`:op1`.

`:ord` – Used with quantities, for ordinal numbers. Introduced in  3-2-2-5.
It always takes an (o/ ordinal-entity) concept as its daughter. Example (2a)
in 3-3-1-1. Introduced in 3-2-2-5.

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

`:quant` – Used with quentities, used for annotating both exact and
approximate cardinalities of sets of countable objects (three houses, more
than three houses) as well as for the number of "units" of non-countable
substances (three cups of milk).  Introduced in  3-2-2-5. Typically an
attribute, sometimes a relation. Defined in
[3-3-4](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-4-quant).
As an attribute it has a numeric value. As a relation it has a child node
with a concept describing approximate quantity.

`:quarter` – Looks like attribute, introduced among relations in 3-2-2-1. The
value is the number (1, 2, 3, 4). It is used within `date-entity` concepts
(see below). Examples in AMR guidelines, section [Other entities: dates,
times, percentages, phone, email,
URLs](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#other-entities-dates-times-percentages-phone-email-urls)
(ML)

`:quote` (originally `:quot`) – Modal relation that goes from a reported
event back to the reporting event (speech verb), thus forming a cycle because
the reported event is also the `:ARG1` of the reporting event. Mentioned at
various places in the guidelines, defined in
[4-3-1-3](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-4-3-1-3-quot-relation)
(in the chapter on document level annotation, although the relation is used
in sentence level graphs!), also shown on the Roles tab in the UMR list
spreadsheet. Nevertheless, the UMR 1.0 data use the relation `:quote` instead
(see also [this issue](https://github.com/umr4nlp/umr-guidelines/issues/22)).
Julia has confirmed that there were a number of last-minute changes to make
the annotations more human-readable.

`:range` – Used with quentities,  to indicate a specific time period.
Introduced in  3-2-2-5. Example (1b) in 3-2-2-5.

`:reason` – Introduced in 3-2-1-1 (BUT not listed among AMR / UMR relations). See also `:cause`.

`:recipient` – Argument role used for languages that do not have frame files.
Typically corresponds to `:ARG2`.

`:refer-number` (originally `:ref-number`) – An attribute used with (almost?)
every entity concept. Values correspond to grammatical number (`singular`,
`dual`, `paucal`, `plural` etc.) but the attribute is here because of the
semantics. On the other hand, it is not a general means to indicate quantity;
for that, the `:quant` attribute is used.

`:refer-person` (originally `:ref-person`) – An attribute used with entity
nodes corresponding to personal pronouns (overt or not; they can be deduced
from verbal morphology or from other contextual clues). Known values are
`1st`, `2nd`, `3rd`, and `4th`.

`:scale` – Used together with `:quant`, e.g. in _6.5 **on the Richter
scale**_. Example (1h) in 3-2-2-5.

`:season` – This relation is mentioned in 3-2-2-1,  it is used within `date-entity` concepts (see below). Examples in AMR guidelines, section [Other entities: dates, times, percentages, phone, email, URLs](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#other-entities-dates-times-percentages-phone-email-urls) (ML)

`:source` – Argument role used for languages that do not have frame files. But also a non-core role in AMR (*He drove west, **from Houston** to Austin.*)

`:start` – Argument role used for languages that do not have frame files.

`:stimulus` – Argument role used for languages that do not have frame files.

`:subevent` - Introduced in the AMR guidelines as a non-core role in Part II. [Concepts and relations](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#part-ii--concepts-and-relations), example from AMR guidelines: *The boy won **the race** in the Olympics.* (= the race being the subevent-of the Olympics game). (ML added)

`:substitute` – Example 3-1-6 (4c), discourse relation:  _**Instead of** going out to eat, we barbecued chicken at home._

`:subtraction` – Example (8) in 3-1-6: _**except for Joe**_.

`:temporal` – _The soup cooled for an hour **before we ate it**._ (2b) in 3-3-1-5. According to the UMR guidelines, Part 3-2-1-1. Stage 0: "... UMR uses `:temporal` to annotate temporal circumstantials of events, while `:time` is only used as a daughter of date-entity concepts to annotate hours and minutes on the clock." (but example 3-1-3-7 (1b) uses `:time` for *soon*, by mistake??)
(Difference between AMR and UMR: `:time` as used in AMR are replaced by `:temporal` in UMR.) (ML)

`:theme` – Argument role used for languages that do not have frame files.
Typically corresponds to `:ARG1`.

`:time` – Example (4d) in 3-3-1-3. It looks like attribute, introduced among relations in 3-2-2-1. The value is the local time in 24h format. See also
`:timezone`(see date-entity below). The relation is used within `date-entity` concepts (see below). According to the UMR guidelines, Part 3-2-1-1. Stage 0: "... UMR uses `:temporal` to annotate temporal circumstantials of events, while `:time` is only used as a daughter of date-entity concepts to annotate hours and minutes on the clock." (but example 3-1-3-7 (1b) uses `:time` for *soon*, by mistake??).
(Difference between AMR and UMR: `:time` as used in AMR are replaced by `:temporal` in UMR.) (ML)

`:timezone` – A relation introduced in 3-2-2-1. Typically used together with `:time`. The child node is a concept defining the zone. Apparently they assume some standardized time zone concepts, as the text contained _Albuquerque time_ but they converted it to `:timezone (z/ MST)`, i.e.,
Mountain Standard Time (see date-entity below).
The relation is used within `date-entity` (see below). Examples in AMR guidelines, section [Other entities: dates, times, percentages, phone, email, URLs](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#other-entities-dates-times-percentages-phone-email-urls) (ML)

`:topic` – Example (2f) in 3-2-2-2: _information **about the case**_.

`:undergoer` – Argument role used for languages that do not have frame files.
Typically corresponds to `:ARG1`.

`:unit` – Used with quentities,  used for both standardized, well-established units such as (dollars, weeks) and for ad-hoc mensural constructions (three cups of milk). Introduced in  3-2-2-5. The child node is a unit concept
(both standardized and informal units), e.g., _day_ for duration.

`:value` – Used with quentities, used for annotating percentages, phone
numbers, e-mail addresses, and urls; used with `ordinal-entity`,
`percentage-entity`, `url-entity`. Introduced in  3-2-2-5 (in AMR, for other
entities as well).

`:vocative` – Not mentioned in the guidelines but listed in the spreadsheet
(Lists for UMR tool) and used in the data. Parent node is the event of the
clause (e.g., a question) that contains the vocative. Child node is the
person to whom the clause is addressed.

`:weekday` – A relation introduced in 3-2-2-1. The child node is the concept
with the name of the day of the week, presumably in the local language (they
have an English example and there is `:weekday (f/ Friday)`). See also
`:day`). This relation is used within `date-entity` concepts (see below).
Examples in AMR guidelines, section [Other entities: dates, times,
percentages, phone, email,
URLs](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#other-entities-dates-times-percentages-phone-email-urls)
(ML)

`:wiki` – Attribute of an entity concept, containing a reference to the
article in Wikipedia that describes the entity. The examples in the
guidelines have titles of English articles here, but we should use wikidata
titles instead ("Q"+number).

`xx-91` - Abstract predicates are distinguished with the `-91` suffix. Seven **non-verbal clause  predicates**  are introduced in Part 3-1-1-3 and 3-2-1-1-1. Other predicates with the -91 suffix appear throughout the guidelines -- they should  listed in frame files.

`:year` – Looks like attribute, introduced among relations in 3-2-2-1. The
value is the year number. (Not sure what they do with BCE or other
calendars.)
This relation is used within `date-entity` concepts (see below). Examples in AMR guidelines, section [Other entities: dates, times, percentages, phone, email, URLs](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#other-entities-dates-times-percentages-phone-email-urls) (ML)

`:year2` – This relation is mentioned in 3-2-2-1, it is used within `date-entity` concepts (see below), e.g., *academic year 2011-**2012*** (from AMR guidelines, section [Other entities: dates, times, percentages, phone, email, URLs](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#other-entities-dates-times-percentages-phone-email-urls)) (ML)



# Predefined Abstract Concepts

`and`

`date-entity` - Mentioned in UMR guidelines, exemplified in 2-2-3 (2c). Introduced in AMR guidelines; roles used in `date-entity` are listed there in Part II. [Concepts and relations](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#part-ii--concepts-and-relations), examples are in section [Other entities: dates, times, percentages, phone, email, URLs](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#other-entities-dates-times-percentages-phone-email-urls); the same list presented in UMR Part 3-2-2-1: `:calendar`, `:century`, `:day`, `:dayperiod` (as *afternoon*), `:decade`, `:era`, `:month`, `:quarter`, `:season`, `:timezone`, `:weekday`, `:year`, and `:year2`.
In UMR, `:time` is added to roles used within `date-entity` concepts.
(According to the UMR guidelines, Part 3-2-1-1. Stage 0: "... UMR uses `:temporal` to annotate temporal circumstantials of events, while `:time` is only used as a daughter of date-entity concepts to annotate hours and minutes on the clock.") (ML)

?? `date-interval` Defined in the AMR guidelines, used with `:opx` rekation; no mention in UMR (ML added)

`distance-quantity` - Mentioned in UMR guidelines, no examples there. Used in the AMR guidelines in examples but apparently without any description. (ML added)

??`email-address-entity` - Defined in the AMR guidelines, no mention in UMR, used together with `:value` relation/attribute  (ML added)

`monetary-quantity` - Mentioned in UMR guidelines, exemplified in 2-2-3 (2b) (ML added)

`ordinal-entity` - Used e.g. in example 2 (1), Part 2. From AMR to UMR  *Edmund Pope tasted freedom today for **the first time in more than eight months*** (here together with the `:range` relation); also with the `:value` relation/attribute, *I visited New York **for the third time**.* 3-2-2-5 (1a), or both of them 3-2-2-5 (1b).

`percentage-entity` - Mentioned in UMR guidelines, used together with `:value` relation/attribute; exemplified in 3-2-2-5 (1c)

??`phone-number-entity` - Defined in the AMR guidelines, no mention in UMR, used together with `:value` relation/attribute  (ML added)

??`product-of` - Defined in the AMR guidelines, no mention in UMR (ML added)

`seismic-quantity`- Used in 3-2-2-5 (1h), example: ***6.5 on the Richter scale*** (ML added)

`speed-quantity` - Used in 3-3-1-3 (3b), example: *This car can go up to **150 mph**.* (ML added)

?? `sum-of` - Defined in the AMR guidelines, no mention in UMR (ML added)

`temporal-quantity` - Mentioned in UMR guidelines, exemplified in 2-2-3 (2a), 2-2-3 (2b); used with `:quant` and  `:unit` relation(s)/attribute(s); example: *The **thirty year**-old man.*

`thing`

`truth-value`

`url-entity`


## Quantity types

AMR guidelines mention Quantity types in Sect. [Quantities](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#quantities):

Quantity types include: `monetary-quantity`, `distance-quantity`, `area-quantity`, `volume-quantity`, `temporal-quantity`, `frequency-quantity`, `speed-quantity`, `acceleration-quantity`, `mass-quantity`, `force-quantity`, `pressure-quantity`, `energy-quantity`, `power-quantity`, `voltage-quantity` (zap!), `charge-quantity`, `potential-quantity`, `resistance-quantity`, `inductance-quantity`, `magnetic-field-quantity`, `magnetic-flux-quantity`, `radiation-quantity`, `concentration-quantity`, `temperature-quantity`, `score-quantity`, `fuel-consumption-quantity`, `seismic-quantity`, some of them are exemplified there. However, no exhaustive list and descriptions/definitions are provided.
