# Entities

**Entities** constitute one of the three main types of concepts in UMR, alongside **states** and **processes.**
They typically correspond to physical objects, but there are also abstract entities such as _soul._

A _mention_ of an entity in text can be **specific** or **generic.**
A specific mention refers to a concrete, unique instance of the entity. Not necessarily by its name (meaning that
not every specific entity is a named entity), but there is one specific instance that the speaker has in mind.

In (1a), there are three mentions of the same specific entity, the unique institution in Prague, called “National Museum”.
It is first referred to by its name, then by the personal pronoun _mu_, and finally by the common noun _muzeum_.
In contrast, the common noun _muzea_ (plural of _muzeum_) in (1b) is a generic entity: It refers to various institutions
that all belong to the category of museums.

* (1a) [cs] _Národní muzeum v Praze získá nový bezpečnostní systém, který mu dodá firma CESS. Muzeum za něj zaplatí necelé 2 milióny korun._
            “The National Museum in Prague will get a new security system, which will be supplied by CESS. The museum will pay almost 2 million crowns for it.”
* (1b) [cs] _V každé zemi podléhají muzea jiné legislativě._
            “In each country, museums are subject to different legislation.”

If a proper name is used, it typically refers to a specific entity, but as we see in (1a), specific entities can be
referenced by other means, too. Even if the name were not present in the sentence, the context would tell us that
we are talking about one specific museum, which probably has a name, and perhaps the context would be specific enough
to allow us to identify the entity and its name in the real world. However, that is not a necessary condition for
a specific entity. In (2a), _staršího muže_ “an elderly man” refers to a person whom we do not know and who may not
even exist in the real world (the text may be a work of fiction). The man may not be mentioned again and we may not
learn anything else about him, yet in this local context he is a specific entity and not a generic one.

* (2) [cs] _Když opouštěl budovu, zahlédl staršího muže, jenž nesl v náručí žlutou krabici._
           “As he was leaving the building, he saw an elderly man carrying a yellow box in his arms.”

A specific entity is a **named entity** if it is referenced by its **name.** Name is a word or a sequence of words
whose purpose is to label a specific instance, not to describe a category of entities by their properties or relations
to other entities. Thus _muzeum_ is not a name because it can be used to refer to any institution that meets certain
parameters. The phrase _Národní muzeum_ is a name because it was specifically designed to label one particular museum.
The name does not have to be unique: An important museum in another country may also be called _Národní muzeum_, just
like there are multiple people called _John Smith_. People may have to add more information if misinterpretation is
possible, but the intended purpose of a name is to give the entity a reasonably locally unique identifier, and the
purpose is what matters.

Furthermore, it is not necessary that a specific entity has only one name. For example, _Spojené státy americké_,
_Spojené státy_, _USA_ and _Amerika_ are all names and all refer to the same country. One can even encounter just
_Státy_ used as a name and referring to the USA. When used in a Czech sentence in this manner, it cannot refer to,
e.g., the United States of Mexico. The same word, _státy_ “states” (not capitalized, unless sentence-initial), can
be used as a common noun (hence not a name), referring to a group of entities (states or countries) that may be
specific or generic. On the other hand, depending on context, _Amerika_ may refer to a continent rather than to
a country (North America, South America), or it may refer to a quarry southwest of Prague.

Proper names are thus designed to label specific instances, while common nouns are meant to describe broader
categories (types). The borderline may be occasionally blurry when a common noun is repurposed as a name (as we
have seen with _Státy_ above) but it is much less likely that a proper name will be used for a generic entity.
We can certainly define a category of all people named _Václav_, as in (3), but that does not convert the name
into a common noun – all these people first got that name with the hope that it will make them identifiable and
distinguishable from other people, and only later the speaker artificially grouped them, using their name as
the property defining the group.

* (3) [cs] _Všichni Václavové by měli znát své slavné jmenovce._
           “All Václavs should know their famous namesakes.”

While the use of _Václavové_ in (3) is unusual, there are proper names that denote a type rather than an instance.
A primary example is product names, as in (4) (the specification of product category is enclosed in parentheses in
the example because it is optional):

* (4) [cs] _Používám (prací prostředek) Persil._
           “I use Persil (detergent).”

Clearly, _Persil_ is a proper name rather than a common noun, as it was invented specifically to distinguish this
detergent from other detergents; it is not a common noun that we expect to find in dictionaries. However, the name
denotes a type of product, not one particular instance. There are millions of packages of Persil, and they all share
this name. And while the name could be used when referring to a specific package, in (4) it actually refers to
a generic entity. We will use the term **categorial proper names / categorial named entities** with names that
denote types (categories) rather than instances.


## Representation of entities in UMR

An entity that is referred to by a **common noun** is represented by a regular concept (node), typically with the lemma
of the noun as the label of the concept (but occasionally the label may be a multi-word string). This is done
no matter if the entity is specific or generic.

An entity that is referred to by a **name** is represented by an abstract concept corresponding to the semantic class
of the entity (e.g., “person” or “organization”; see below for the taxonomy of semantic classes). The name of the
entity is in a separate node, which has the abstract concept “name” and is attached to the class concept via the
relation `:name`. Individual orthographic words of the name are listed in the name concept each in its own attribute,
the attributes are named `:opX` where X is the ordinal number of the word within the name. The words are not always
exact copies from the sentence, as the name is converted to its canonical form. Note however that this does not
mean that all words in the name are replaced by their lemmas; some will be lemmatized, others will stay in a frozen
inflected form.

An entity that is referred to by a **pronoun** is represented by an abstract concept corresponding to the semantic class
of the entity. Unlike named entities, there is no child node with the “name” concept.

Common noun _muzeum_ “museum”:
```
(m/ muzeum)
```

Named entity _Národní muzeum_ “National Museum”:
```
(o/ organization
    :name (n/ name
        :op1 "Národní"
        :op2 "muzeum"))
```

* (5) [cs] _Získal práci na Ministerstvu školství, mládeže a tělovýchovy._
           “He got a job at the Ministry of Education, Youth and Sports.”

```
(o/ organization
    :name (n/ name
        :op1 "Ministerstvo"
        :op2 "školství"
        :op3 ","
        :op4 "mládeže"
        :op5 "a"
        :op6 "tělovýchovy"))
```

Note that the canonical form of the multi-word name of the ministry in (5) is composed of the canonical form of the
head (_Ministerstvu_ was converted to nominative singular, but its capitalization was retained) and the inflected
forms of the dependent words; the comma is also a separate `:opX` attribute.

With categorial named entities, the `:name` relation can occur even with a generic entity:

```
(p/ product
    :name (n/ name
        :op1 "Persil"))
```


## Anchoring entities in ontologies

UMR defines the (optional) `:wiki` attribute, which can be used to link a concept to a corresponding article in
Wikipedia. The examples in the UMR guidelines currently show names of English Wikipedia articles in these attributes;
however, a more robust and thus preferred solution is to use Wikidata identifiers. They are not bound to a particular
language mutation of Wikipedia (all Wikipedias that have an article about the concept are linked from the Wikidata
page) and they should be more stable (e.g. when one of the Wikipedias decides that a different title should be used
for the article and the old title should become a redirect). Obtaining Wikidata identifiers is easy: Let's assume
we want to anchor the Czech entity _Národní muzeum_ and we find its article in the Czech Wikipedia at
[https://cs.wikipedia.org/wiki/N%C3%A1rodn%C3%AD_muzeum](https://cs.wikipedia.org/wiki/N%C3%A1rodn%C3%AD_muzeum).
In the menu on the right-hand side we see a link labeled “Položka Wikidat” and leading to
[https://www.wikidata.org/wiki/Q188112](https://www.wikidata.org/wiki/Q188112).

Although the attribute is optional in UMR, in our data we should strive to provide it for every mention of a specific
entity that has a Wikidata entry. (In practice, we could use the coreference annotation in UMR to automatically
propagate the anchor from one mention to all other mentions. Note however that it would be a mistake to say that we
only fill the attribute manually for named entities. It can happen that a specific entity is never mentioned by its
name in a document, yet the context doubtlessly points to a known entity described in Wikipedia.)

```
(o/ organization
    :wiki "Q188112"
    :name (n/ name
        :op1 "Národní"
        :op2 "muzeum"))
```

If a specific entity has no Wikidata presence, we have to register it in a local ontology that becomes part of the
annotation, and provide a local identifier instead. Note that the entries in the local ontology are not always local
to just one document. They are still part of the same universe that is partially described in Wikipedia. Consider,
for example, a news article reporting that _A man (80) was killed this morning in a traffic accident._ There could
be several other documents reporting on the same event, and if it can be established that they are indeed talking
about the same accident, then all the mentions of the nameless man should be anchored to the same entry in the
ontology.
<span style="color:red">TODO: Implement a prototype of the local ontology and specify how it should be linked from
the annotation. We should probably use a different attribute, e.g., `:lwiki`.</span>


## Other attributes of entities

Every entity concept should have the attribute `:ref-number`, with the value reflecting the grammatical number. UMR
defines a number of possible values for the attribute, based on grammars of various languages. For Modern Czech data
the value will probably (almost?) always be `Singular` or `Plural`. We will not use `Dual` just because we know that
we are speaking about two people. The dual as a grammatical number has mostly vanished from Czech, and UMR has
other means to annotate quantity (there is not a separate value of `:ref-number` for each integer number). A possible
exception in Modern Czech is paired body parts _(nohy, ruce, oči, uši)_ because that is where grammatical dual still
survives.

Abstract entity concepts that correspond to personal pronouns (or their reflections in verbal morphology) will
additionally have the attribute `:ref-person`. This attribute is not used with other entity mentions (for which it
would be very unusual to interpret them as anything else than 3rd person).

We now repeat example (1a) as (6) here and show the annotations of entities from the example, using all the rules
specified so far. (We omit the monetary entity from the end because such types of entities have not been discussed
yet.)

* (6) [cs] _Národní muzeum v Praze získá nový bezpečnostní systém, který mu dodá firma CESS. Muzeum za něj zaplatí necelé 2 milióny korun._
            “The National Museum in Prague will get a new security system, which will be supplied by CESS. The museum will pay almost 2 million crowns for it.”

```
(o/ organization
    :wiki "Q188112"
    :name (n/ name
        :op1 "Národní"
        :op2 "muzeum")
    :ref-number Singular)

(c/ city
    :wiki "Q1085"
    :name (n2/ name
        :op1 "Praha")
    :ref-number Singular)

(s/ systém
    :lwiki "L1"
    :ref-number Singular)

(o2/ organization
    :wiki "Q188112"
    :ref-number Singular
    :ref-person 3)

(o3/ organization
    :lwiki "L2"
    :name (n3/ name
        :op1 "CESS")
    :ref-number Singular)

(m/ muzeum
    :wiki "Q188112"
    :ref-number Singular)

(t/ thing
    :lwiki "L1"
    :ref-number Singular
    :ref-person 3)
```


## Taxonomy of entity types

The [UMR guidelines](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md) give a taxonomy of entity
classes, types and subtypes in [Section 3-1-2](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-2-named-entities).
They can be used as abstract concepts for named entities and for entities represented by pronouns. As of now (June 2023),
the taxonomy is reportedly under revision by the UMR team. At any rate, the current table has a number of issues.
We will now examine some of the entity types and discuss their utility.

### person

A top-level class without subordinate types and subtypes. Besides humans, the class could serve as a natural
fallback for human-like beings that do not have a class of their own: deities, dwarves, hobbits, elves etc.
What about robots?

### animal

A top-level class. As a named entity, it can be used to represent a pet that was given a name by its owner, or
an animal character in a fairy tale, including fantastic beasts like dragons. The class is not suitable to represent
_species_ of animals. (They have their own type in the taxonomy but it is problematic, see below.)

### plant

Analogous to animals but covering plants.

### thing

Not listed in the current UMR table but used in their examples (e.g. sentence (3) in Part 1) and clearly needed
at least for pronouns that refer neither to persons nor to animals or plants or other types specifically listed
in the taxonomy.

### geographic-entity

A subset of what other named entity taxonomies often label as “location”. This subset contains only phenomena created
by nature, not by mankind. The UMR guidelines currently provide 15 types belonging to this class, probably not
exhaustive and to be extended in the future. The annotators should use the types as abstract concepts if they know
them, otherwise they can fall back to the whole class.

The types are: `ocean`, `sea`, `lake`, `river`, `gulf`, `bay`, `strait`, `island`, `peninsula`, `mountain`, `volcano`,
`valley`, `canyon`, `desert`, `forest`.

### celestial-body

Like `geographic-entity` but on a cosmic scale. Currently four types: `moon`, `planet`, `star`, `constellation`.
Again not exhaustive: What do we do with objects that are smaller than planets but are not moons?

Note that for _Měsíc_ “Moon”, _Země_ “Earth” and _Slunce_ “Sun”, there is a blurred context-based borderline between
a name of a celestial body and a common noun. But at least the Czech grammar puts the burden of decision on the
shoulders of the author: if it is a name of a celestial body, it has to be written capitalized. So, unless it is the
first word of a sentence, the annotator can take capitalization as the cue.

### geo-political-entity

A subset of what other named entity taxonomies often label as “location”. This subset contains only phenomena created
by mankind, not by nature. The UMR guidelines currently provide 7 types belonging to this class, probably not
exhaustive and to be extended in the future. The annotators should use the types as abstract concepts if they know
them, otherwise they can fall back to the whole class.

The types are: `country`, `state`, `province`, `territory`, `county`, `city`, `city-district`.

The current selection is too much focused on North America. For example, the Czech sub-country administrative unit,
_kraj_ “region”, is neither a state, nor a province, territory or county. Czech _okres_ could probably be annotated
as `county`. See also the `region` class below.

### region

A class with three types: `world-region`, `country-region`, `local-region`. There is no definition and it is difficult
to guess what the authors had in mind. But it is not in the `geo-political-entity` class, so it is probably not meant
as an official administrative unit and it does not solve the problem with Czech _kraj_. Maybe it is meant for less
official or formal regions such as _Valašsko_, _Morava_ or _Evropa_. Still, we need criteria to decide between the
three types of regions.

### facility

A class of man-made entities that have a fixed location but the name does not pertain just to the location but also
to the building (or whatever other facility it is). In some cases, a facility is also an organization (example:
_museum_), which is a different entity class, but they may share a name. Then the annotator will have to decide by
context whether the utterance is more about the legal entity (organization), or the place or building (facility).

The guidelines currently list 19 types of facilities: `airport`, `station`, `port`, `tunnel`, `bridge`, `road`,
`railway-line`, `canal`, `building`, `theater`, `museum`, `palace`, `hotel`, `worship-place`, `market`,
`sports-facility`, `park`, `zoo`, `amusement-park`.

### social-group

A large class with 6 types: `family`, `clan`, `ethnic-group`, `regional-group`, `religious-group`, `organization`.
The common characteristic of all six is that they denote groups of people. In the case of `organization`, it also
has a common property, set of activities, and usually also some kind of legal existence; this may also true to some
extent about families and even clans, but typically not about the other types of groups. More importantly, an
organization typically has a name that refers to the organization as a single entity _(IBM)_, while an ethnic group
is often denoted by a plural form of a name that labels one member of the group _(Baskové,_ the plural of _Bask_
“(a) Basque (person)”). It is thus unclear whether and why these diverse types should be analyzed the same way.
An ethnic group is more like a categorial named entity (see also `product`), it denotes people who share a language
and/or some cultural and historical heritage. Similarly, religious groups is just a common label for people who share
beliefs. Do we also want a “named entity” for races, or for tall/short/slim/fat people etc., or for people who share
political views, or love for rock-and-roll, or anything else?

#### organization

A large type of the `social-group` class, see above for my doubts about its (dis)similarity to other types. There is
much less doubt (than for the other types) that organizations are named entities, but the definition of the subtypes
has to be clarified. The type has currently 11 subtypes: `international-organization`, `business`, `company`,
`government-organization`, `political-organization`, `criminal-organization`, `armed-organization`,
`academic-organization`, `association`, `sports-organization`, `religious-organization`.

### nationality

A separate top-level class. I do not understand why the authors did not make it a type of `social-group`, just like
`ethnic-group` and `regional-group`, to which it is very close. For example, _Čech_ “Czech” can be, depending on
context, any of the three: A member of the ethnic group (sharing the Czech language and traditions, including people
who do not have Czech citizenship, as their ancestors left the country and settled abroad); a member of the nationality
(having the citizenship of the Czech Republic, even if living abroad and/or having a mother tongue other than Czech);
a member of a regional group, living in _Čechy_ “Bohemia” (as opposed to Moravia and Silesia, which are the other two
parts of the country called _Česko_ “Czechia”).

### product

This class is not listed in the current UMR guidelines, which seems to be a gap that has to be patched. The current
taxonomy actually lists some types that could be classified as special cases of `product`, such as `aircraft-type`
or `car-make`. But there are proper names for other products, like _Persil_ in example (4) above. Products are typical
examples of what we call categorial named entity.

### vehicle

This is a separate class with currently 5 types: `ship`, `aircraft`, `aircraft-type`, `spaceship`, `car-make`. Note
that `aircraft-type` and `car-make` are categorial named entities that would be better described as special types of
`product`. For `ship` and `spaceship` it is more typical that a name denotes a single instance (e.g., _Titanic_).
Perhaps `aircraft` is also meant to denote an instance rather than a type. People may occasionally give a nickname
to their car, then the name will also denote an instance and the entity type `car-make` will not be suitable for it.

### computer-program

This is a separate class with no types. It could be regarded as a type of `product`.

### food-dish

This is a separate class with no types. It seems to be a categorial named entity like `product` but it has an unsharp
boundary between names and descriptions of dishes, so it is quite questionable whether, how, and where exactly the
class concept should be used.

### cultural-artifact

This is a separate class with currently 8 types: `work-of-art`, `picture`, `music`, `dance`, `show`,
`broadcast-program`, `literature`, `publication`; the last one has subtypes `book`, `newspaper`, `magazine`, `journal`.
Since there is no description, it is not clear what is the difference between `literature` and `publication` supposed
to be. Also, there does not seem to be a category suitable for movies.

Some works of art could be seen as a categorial named entity similar to `product`: Typically there are many copies of
a book, a movie, or a CD. But even here the prototypical reading is that the name refers to the single intangible
work, not to one of its copies.

### law

This is a top-level class with two types: `court-decision`, `treaty`. Supposedly the class itself should be used for
actual laws. There is a need for other types, such as a named dean's regulation at a university.

One could say that laws are close to publications; but they can hardly be categorized as a cultural artifact.

### language

This is a top-level class without types. Supposedly there is no distinction between languages and dialects, i.e.,
names of dialects would also be labeled as `language`. Not sure about language groups and families. Note that names of
languages are often (but not always) related to names of ethnic groups, nationalities, regions and countries.

It is not clear how this label is intended to be used. Should it apply only to the name of the language (noun), e.g.,
_angličtina_ “(the) English (language)”, or also to adverbs (_Mluví anglicky._ “He speaks English.”) and adjectives
(_Procvičuje si anglická slovesa._ “She is practicing English verbs.”)

Do we also use this label for constructed languages _(esperanto)_? I think we do.
Do we also use it for programming languages _(Pascal, C, Perl, Python)_? I am not sure. Maybe those fall under the
class `computer-program`.

### notational-system

This is a top-level class with currently three types: `writing-script` (e.g. _dévanágarí_), `music-key`,
`musical-note`. It denotes an abstract entity.

### cultural-activity

This is a top-level class without definition and without types. It would be useful to have an example. See also
`event` below.

### event

This is a top-level class with currently 8 types: `incident`, `war`, `natural-disaster`, `earthquake`, `conference`,
`game`, `festival`, `ceremony`. Besides the usual problem that types are not defined, it is not clear why `earthquake`
shall be distinguished from other natural disasters. It is also unclear why `cultural-activity` is a class separate
from `event`.

Furthermore, note that this concept denotes events as entities, although events are typically processes (refer to the
main distinction between entities, states and processes, shown in Table 1 in Section 3-1-1 of the UMR guidelines).
Section 3-1-1 even uses the term “event” to refer to all processes in any packaging, plus entities and states when
used in predication. Nevertheless, if an event has a name (such as _Druhá světová válka_ “World War II”), it is covered
by this taxonomy. It would be helpful to have an annotated example here.

### award

Top-level class with no types. Supposedly, _Nobelova cena za fyziku_ “Nobel Prize for Physics” would be an example.

### biomedical-entity

This is a top-level class with currently 18 types: `molecular-physical-entity`, `small-molecule`, `protein`,
`protein-family`, `protein-segment`, `amino-acid`, `macro-molecular-complex`, `enzyme`, `nucleic-acid`, `pathway`,
`gene`, `dna-sequence`, `cell`, `cell-line`, `species`, `taxon`, `disease`, `medical-condition`. They are obviously
inspired by the bulk of work on biomedical processing and we would need more documentation to understand how the
authors intended to use them.

However, at least three types reach into layman's language: `species`, `taxon`, and `disease`. The closely related
`species` and `taxon` would be categorial named entities (like `product`), where the name denotes a whole category
(type) of entities rather than a single instance. That is, if they deserve to be treated as named entities in the
first place. For example, _kočka_ “cat” is an animal with a particular set of characteristics, just like _dub_ “oak”
is a particular type (hyponym) of tree, and _hrad_ “castle” is a particular type of building. But the first two words
are biological genuses, hence `taxon`s, while _hrad_ has no special status in the UMR taxonomy. (In the Czech grammar,
all three are common nouns.) There is no reason why _kočka_ and _dub_ should be named entities. And by extension,
there is little reason why `species` should be named entities, for example _kočka domácí_ “cat (Felis catus)”, or
_dub letní_ “pedunculate oak (Quercus robur)”, or why other taxons should, for example _šelmy_ “beasts of prey,
Carnivora”, _savci_ “mammals”, or _živočichové_ “animals, Animalia”. It is true that some species have names that are
less common than others and were invented by scholars who discovered and described the species, rather than being part
of the language since ancient times. But it would be neither tractable nor helpful to attempt to distinguish them.
Perhaps the only exception is the scientific names in Latin, provided that the language of the annotated text is not
Latin.

Similarly, diseases may have scientific names but many common diseases are just common nouns or expressions (_angína_
“tonsillitis”, _chřipka_ “flu”, _mor_ “plague”, _neštovice_ “chickenpox”) and it is not clear why they should be
handled differently from other common nouns. Moreover, diseases are states rather than entities.

### variable

What is this supposed to mean?
