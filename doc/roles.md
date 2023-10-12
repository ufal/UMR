## Participant Roles

UMR Guidelines: "Every entity and event identified as a participant is related to an event (the event that it is dependent on) and annotated with a participant role label." 

UMR 
[assumes](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-2-1-participant-roles)
that [events](eventive-concepts.md) are linked to **frame files** (valency
dictionaries), which describe the participants of the event and their
semantic roles. 

For language with an existing PropBank-style lexicon (frame files), this lexicon defines UMR predicate-specific roles (target annotation = stage 1). 
For language without such a lexicon, a set of general participant roles should be used (stage 0) and a PropBank-style lexicon is build "on the way" to move towards Stage 1 annotation.

For Czech, we want to use [SynSemClass](https://lindat.mff.cuni.cz/services/SynSemClass40/), the frames of which can (to some extent) be mapped to PropBank-style roles: 
- For some verbs, their arguments have been mapped onto ARGx roles - either within the  SynSemClass project, or within CzEngVallex - the mapping can be found in the [conversion files](../tecto2umr/pdt_pb_mapping_via_czengvallex_ssc-merged.xlsx), column C (via CzEngVallex) and D (via CzEngVallex).  
- For verbs without a frame-specific mapping, the default [conversion table](../tecto2umr/functors-to-umrlabels.txt) will be used. 


Thus, we skip the [stage 0 roles annotation](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-2-1-1-stage-0) (using general / non-lexicalized / not frame-specific semantic roles) and focus on the [stage 1 roles annotation](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-2-1-2-stage-1) (using ARGx roles) - although the mapping is not perfect). 

### Stage 0 - comments on alternations 

UMR distinguishes two types of alternations:
 -  alternations describing the same "real-world" event but packaging differently (often with different TFA), UMR reffers to them as to valency / pragmatic alternations, and 
 -  alternations that  do not refer to the same "real-world" event, called semantic alternations in UMR.


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

PDT-Vallex, due to its theoretical background in GFGD, does not reflect these considerations. 

### Stage 1 Roles Annotation

Stage 1 annotation is based on PropBank-style frame files, in our case derived from the [PDT-Vallex (via the SynSemClass annotation or via CzEngVallex)](../tecto2umr/pdt_pb_mapping_via_czengvallex_ssc-merged.xlsx), with the general [conversion table](../tecto2umr/functors-to-umrlabels.txt) for those predicates that are not covered by this mapping.  

### Inverse participant roles

The inverse participant roles (i.e., `ARGx-of` roles) are used in AMR to annotate:
-  events that function as modifiers (typically relative clauses or participles, as in _I bought the sweater **that you saw**.,_ with _sweater_ annotated as `ARG1-of` the predicate _see_), 
- embedded interrogatives, and 
- participant nominalizations.  
- 
Upon these, UMR adds: 
- inverses for the general (i.e. non-predicate-specific) participant roles (like `Actor-of` and `Undergoer-of` roles);
- inverse relations for mostly considered as nominal modification, like kinship relations (e.g., _my father_) and certain other relational noun (e.g., the President of the University of New Mexico) - UMR annotates these using the abstract predicate  `have-role-91` (or more specific `have-rel-role-92`, `have-org-role-92`):

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

## Non-participant UMR relations (Part 3-2-2)

Part 3-2-2-1. Temporal relations
Part 3-2-2-2. Modifiers
Part 3-2-2-3. Circumstantial temporals and locatives
Part 3-2-2-4. Named entities
Part 3-2-2-5. Quantification
Part 3-2-2-6. Other relations
