# UMR Roles

## I. Participant roles

UMR Guidelines: "Every entity and event identified as a participant is related to an event (the event that it is dependent on) and annotated with a participant role label." 

UMR 
[assumes](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-2-1-participant-roles)
that [events](eventive-concepts.md) (and also other concepts) are linked to **frame files** (valency dictionaries), which describe the participants of the event and their semantic roles. 

For language with an existing PropBank-style lexicon (frame files), this lexicon defines UMR predicate-specific roles (target annotation = stage 1). 
For language without such a lexicon, a set of general participant roles should be used (stage 0) and a PropBank-style lexicon is build "on the way" to move towards Stage 1 annotation.

For Czech, we want to use [SynSemClass](https://lindat.mff.cuni.cz/services/SynSemClass40/), the **frames of which can (to some extent) be mapped to PropBank-style roles**: 
- For some verbs, their arguments have been mapped onto ARGx roles - either within the  SynSemClass project, or within CzEngVallex - the mapping can be found in the [conversion files](../tecto2umr/pdt_pb_mapping_via_czengvallex_ssc-merged.xlsx), column C (via CzEngVallex) and D (via CzEngVallex).  
- For verbs without a frame-specific mapping, the default [conversion table](../tecto2umr/functors-to-umrlabels.txt) will be used. 


Thus, we skip the [stage 0 roles annotation](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-2-1-1-stage-0) (using general / non-lexicalized / not frame-specific semantic roles) and **focus on the [stage 1 roles annotation](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-2-1-2-stage-1) (using ARGx roles)** - although the mapping is not perfect). 

Further, we can identify **several other problems**, mainly:
1. change of structure in case of so called **inverse participant roles**;
2. **abstract rolesets**, see [notes on Frames here](frames.md), which UMR adopts to annotate so called non-verbal clauses but also some specific relations and constructions;   
3. **discourse relations** covering structure of complex sentences in UMR (esp. coordination and some types of subordinated structures; not covered by the conversion table yet);  see also [notes on discourse relations here](discourse-relations.md).



### Stage 0 - comments on alternations 

UMR distinguishes two types of alternations:
 -  alternations describing the same "real-world" event but packaging differently (often with different TFA), UMR reffers to them as to **valency / pragmatic alternations**, and 
 -  alternations that  do not refer to the same "real-world" event, called **semantic alternations** in UMR.


#### "Valency / pragmatic" alternations

UMR does not reflect alternations like diatheses (UMR mentions passives, antipassives, or valency-rearranging applicatives) - participants in marked usages are annotated in the same way as in the basic unmarked construction.   
For example, the participant role annotation for the following pair of sentences would be the same:

* [en] _The boy ate the fruit._  /  _The fruit was eaten by the boy._(based on the UMR example from Balinese)  
* [cs] _Dělníci staví školu._ / _Škola se staví._
   

In general, this approach corresponds to that of the PDT - these alternations are subsumed under the label "diathesis", namely those with the diatgram `grammateme` act, pas, res, and deagent:
* act:  [cs] _Karlovu univerzitu **založil.act** Karel IV._ (PDT 3.0 documentation) 
* pas: [cs] _Karlova univerzita **byla založena.pas** Karlem IV._ (PDT 3.0 documentation) 
* res1: [cs] _Obchod **je otevřen.res1** denně mimo neděli._ (PDT 3.0 documentation) 
* res2.1: [cs] _Obchod **má otevřeno.res2.1**._ (PDT 3.0 documentation) 
* res2.2. [cs] _Firma už **má smlouvu podepsánu.res2.2**._ (PDT 3.0 documentation) 
* recip:  [cs] _Horníci dostanou v lednu přidáno.recip._ (PDT 3.0 documentation) 
* disp:  [cs] _Tento produkt se dobře prodává.disp._ (PDT 3.0 documentation)
* deagent: [cs] _**Čeká se.deagent** krutá zima._ (PDT 3.0 documentation)  
* deagent: [cs] _Knihy **se** dnes **vydávají.deagent** i v elektronické podobě._ (PDT 3.0 documentation)  

Thus no problems in annotation are expected (the diatgram grammateme disregarded).

We can suppose that also so-called lexical alternations have the same set of roles in the PropBank lexicon, with the same mappping of semantic participants to the ARG roles (type _load the wagon.ARG1 with hay.ARG2_ / _load hay.ARG2 onto the wagon.ARG1_ - both usages fall under the same `load-01` predicate).
However, this principle is not employed in the PDT-Vallex lexicon (_naložit vůz.PAT senem.EFF_ coresponds to `naložit-001` (v-w2096f3) vs. _naložit seno.PAT na vůz.DIR3_  corresponds to `naložit-002` v-w2096f2). 
Ideally, the mappings of PDT frame-specific functors to UMR labels would result in the required consistency of semantic participant --> ARGx mappings (`ARG1`=beast of burden, `ARG2`=cargo). But this is not guaranteed"   


#### "Semantic" alternations

According to the Guidelines, in semantic alternations, the basic and non-basic constructions differ in their semantic content (they do not refer to the same "real-world" event), exemplified with reciprocals.

The UMR guide mentions the following types in Stage 0 annotation
- causatives and its subtypes, as e.g. causatives of transitives:
  * [en] _Grandmother.causer made the kid.actor drink the water.undergoer_ (3-1-3-2 (1a))
- valency-increasing applicatives: appropriate role for new participant
- reflexives:  a single participant with two roles

```
U 	a 	ù-yé 	bánì  (3-2-1-1-2 (8a))
he 	PERF 	he-REFL wound  
‘He has wounded himself.’
(b/ bánì-00 ‘wound’ 
	:actor (p/ person
		:ref-person 3rd
		:ref-number Singular) 
	:undergoer p
	:aspect Performance
	:modstr FullAff)
```
- reciprocals: a single participant with two roles
```
Pi 	a 	pì-yé 		kánù   (3-2-1-1-2 (8b))
they 	PERF	they-REFL 	love  
‘They loved each other.’
(k/ kánù-00 ‘love’
	:actor (p/ person
		:ref-person 3rd
		:ref-number Plural)
	:undergoer p
	:aspect State
	:modstr FullAff)
```

PDT-Vallex, due to its theoretical background in FGD, does not reflect these considerations. 

### Stage 1 Roles Annotation

Stage 1 annotation is based on PropBank-style frame files, in our case derived from the [PDT-Vallex (via the SynSemClass annotation or via CzEngVallex)](../tecto2umr/pdt_pb_mapping_via_czengvallex_ssc-merged.xlsx), with the general [conversion table](../tecto2umr/functors-to-umrlabels.txt) for those predicates that are not covered by this mapping.  

### Inverse participant roles

Based on [Part 3-2-1-3](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-2-1-3-inverse-participant-roles), the **inverse participant roles** (esp., `ARGx-of` roles) are used in AMR to annotate:
-  events that function as **modifiers** (typically relative clauses or participles, as in _I bought the sweater **that you saw**.,_ with _sweater_ annotated as `ARG1-of` the predicate _see_), 
- **embedded interrogatives** (as in _I didn't see **whether** he **bought** the sweater_, with truth-value.ARG1 modified by :polarity-of buy !!!), and 
- participant **nominalizations** (as in _The **runner** was wearing a sweater_, with _runner_ = person ARG0-of run).  

According to the guidelines, such event concept nodes (= which are linked to other concepts by means of inverse participant roles) can then further take their own full argument structure annotation and attribute values for e.g. aspect.

Upon these, UMR adds: 
- inverses for the general (i.e. non-predicate-specific) participant roles (like `Actor-of` and `Undergoer-of` roles);
- inverse relations that mostly considered as **nominal modification**, like kinship relations (e.g., _my father_) and certain other relational noun (e.g., the President of the University of New Mexico) - UMR annotates these using the abstract predicate  `have-role-91` (or more specific `have-rel-role-92`, `have-org-role-92`):

```I met my father.
(m/ meet-03
	:ARG0 (p/ person
		:ref-person 1st
		:ref-number Singular)
	:ARG1 (p2/ person
		:ARG1-of (h/ have-rel-role-92
			:ARG2 p
			:ARG3 (f/ father)))
	:aspect Performance
	:modstr FullAff)
```

```
I met the President of the University of New Mexico.
(m/ meet-03
	:ARG0 (p/ person
		:ref-person 1st
		:ref-number Singular)
	:ARG1 (p2/ person
		:ARG1-of (h/ have-org-role-92
			:ARG2 (a/ academic_organization
				:name (n/ name
					:op1 "University
					:op2 "of"
					:op3 "New"
					:op4 "Mexico")
				:wiki "University_of_New_Mexico")
			:ARG2 (p3/ president)))
	:aspect Performance
	:modstr FullAff)
```


## II. Non-participant role UMR relations
Non-participant roles are not verb-specific - they are mainly used 
- to mark NP-internal relations, 
- to mark some types of modifiers of predicates, and 
- to make the meanings of certain natural language expressions computationally tractable.

Most of them inherited from AMR but some changes were applied - we can work with the [UMR working list](https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit#gid=235257559) with the latest updates. 

#### Temporal relations

While the `:temporal` relation is listed among participants in the [UMR working list](https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit#gid=235257559), the Guidelines in this section mentions only temporal modifications expressed as the NE date-entity.  
 

#### Modifiers 

In the Guidelines, the term "modifier" refers to relations mostly modifying object concepts, i.e., modifiers are mostly attributes (in our terminology). Semantically, they distinguish anchoring and typifying modifiers (Croft, to appear).

##### Anchoring modifiers (:poss, :part, have-rel-role-92)

Anchoring modifiers "situate the intended referent ... via reference to another object". In other words, "they provide referential grounding for a referent expression". 

This referential grounding are often expressed as possessive relations.  

###### Ownership relation (:poss)

The ownership relations are annotated using the `:poss` label, which indicates the relation between the possessum (as the parent) and the possessor (as the daughter):

```
John's car
(c/ car
	:poss (p/ person
		:name (n/ name	:op1 "John"))
	:ref-number Singular)
```

- In PDT, the `:poss` relation corresponds to one type of relations subsumed under the `APP` functor: 
   - PDT typ (5) = vztah vlastnictví, označení vlastníka (_její.APP seznam_, _má.APP vyšší postava_, _dům mého otce.APP_)... OK, possessum as the parent, owner as a child


###### Part-whole relation (:part)

The part-whole relations are annotated using the `:part` label, which indicates the relation between the part (as the parent) and the whole (as the daughter):
```
Guitar strings
(s/ string
	:part (g/ guitar)
	:ref-number Plural)
```

- In PDT, the `:part` relation corresponds to several types of relations subsumed under the `APP` functor: 
  - PDT typ (2) =  příslušnost osoby k nějakému celku, instituci (_příslušník armády.APP_, _brankář vedoucího týmu.APP_, _člen výkonného výboru.APP_)  ... OK, part as the parent, whole as a child)
  - PDT typ (3) = příslušnost osoby k nějakému celku, instituci (_tým brankářů.APP_, _organizace neslyšících.APP_) ... KO, whole as the parent ... HERE the  `:group` relation should be used, as in _a swarm of bees.group_
  - PDT typ (6) = část-celek ( _střecha domu.APP_, _široký pás území.APP_, _závěr utkání.APP_,_Guitar.part strings_) 

- **??? Other mappings of APP: ???**
  - ??? PDT typ (4) = nositel vlastnosti (vyjádřené řídícím slovem) (_míra nezaměstnanosti.APP_, _úroveň ubytování.APP_, _průměrná délka vazby.APP_, _autorova.APP upřímnost_) ...   ??? how to annotate in UMR
  - PDT typ (7) = vyjádření přináležitosti v širokém smyslu (u abstraktních výrazů) (_auto roku.APP_, _poezie lásky.APP_)


###### Kinship relation (have-rel-role-9)

The kinship relations are annotated using the `have-rel-role-92` predicate, with `:ARG1` for the entity and `:ARG3` for its role (in case of two entities, `:ARG2`and `:ARG4` are used for the second entity and its role, respectively - example??):

```
Grandmother  ...
(p/ person
	:ARG1-of (h/ have-rel-role-92
	:ARG3 (g/ grandmother))
	:ref-number Singular)
```

- In PDT, the kinship relation corresponds to one type of relations subsumed under the `APP` functor: 
  - PDT typ (1) =  příbuzenské (a přátelské) vztahy (_manžel slavné spisovatelky.APP,_ _duchovní otec nové měny.APP_, _její.APP příbuzná_, _přítel ministra.APP_)
 

##### Typifying modifiers (:mod and its subtypes)

Typifying modifiers "enrich the referent description by subcategorizing it or selecting the quantity (...) of the category or type denoted by the head noun." For this cases, general `:mod` relation is available, e.g., in _a women's.mod magazine_ (reading: _a magazine for women_; as opposed to _that woman's.poss magazine_ reading: the magazine belonging to the/a woman).  
This relation is used to annotate property concept modifiers that do not have their own frame files (, _my.poss quirky.mod shirts_):
```
My quirky shirts
(s/ shirt
	:poss (p/ person
		:ref-person 1st
		:ref-number Singular)
	:mod (q/ quirky)
	:ref-number Plural)
```
(This relation also used to annotate demonstrative determiners, _these.mod shirts of mine.poss_).

A number of subtypes ara available: 
- `:age`,  as in _The thirty year-old man_:
```
The thirty year-old man
(m/ man
	:age (t/ temporal-quantity
		:quant 30
		:unit (y/ year))
	:ref-number Singular)
```
- `:group`, as in _a swarm of bees.group_,
- `:topic`, as in _Information about the case.topic_,
- `:medium`, as in  _a French.medium song_
```
a French song
(t/ thing
	:ARG1-of (s/ sing-01)
	:medium (l/ language
		:wiki "French_language"
		:name (n/ name :op1 "French")))
```

#### Circumstantial temporals and locatives

Number of relations modifying events rather than objects, adopted from AMR, as  locatives `:direction` and `:path` or tempotrals `:duration` and `frequency`.

#### Named entities (:name, :wiki`, and :opX)

UMR: "The relations `:name`, `:wiki`, and `:opX` are mostly used in the treatment of named entities."

```
Edmond_Pope
(s1p / person
        :wiki "Edmond_Pope"
        :name (s1n / name :op1 "Edmund" :op2 "Pope"))
 ```
 
 ```    
New York City
(c/ city
		:name (n/ name
			:op1 "New"
			:op2 "York"
			:op3 "City")
		:wiki "New_York_City")
```

#### Quantification (:ord, :quant, :range, :scale, :unit,  :value)

See [Quantity](quantity.md)!

#### Other relations 

- `:example` ... to annotate illustrative examples of object categories (_countries like Germany and France_), 
-  `:polite` ... to indicate that an utterance (often a command) is marked for deference with respect to the interlocutor ... _**!!!attribute (not relation)!!!**_,
```
Could you close the window?
(c/ close-01
	:ARG0 (p/ person
		:ref-person 2nd
		:ref-number Singular)
	:ARG1 (w/ window)
	:aspect Performance
	:mode Imperative
	:polite +)
```
- `:li` ... to mark entities as entries on a bulleted list
- `:condition` and `:concession` ... alternative ways of annotating the `have-condition-91` and `have-concession-91`
- `:other-role` ... for  concepts not (currently) covered by UMR that should be annotated


