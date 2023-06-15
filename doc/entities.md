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

* (4) [cs] _Získal práci na Ministerstvu školství, mládeže a tělovýchovy._
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

Note that the canonical form of the multi-word name of the ministry in (4) is composed of the canonical form of the
head (_Ministerstvu_ was converted to nominative singular, but its capitalization was retained) and the inflected
forms of the dependent words; the comma is also a separate `:opX` attribute.


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

We now repeat example (1a) as (5) here and show the annotations of entities from the example, using all the rules
specified so far. (We omit the monetary entity from the end because such types of entities have not been discussed
yet.)

* (5) [cs] _Národní muzeum v Praze získá nový bezpečnostní systém, který mu dodá firma CESS. Muzeum za něj zaplatí necelé 2 milióny korun._
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

### to be continued...
