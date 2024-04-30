# Temporal Relations

In UMR, temporal annotation is done at both the sentence level and the document level representation.

  

## Short HowTo for Czech annotations:

### Sentence level representation:
  - Any **time expression** (overtly present) should be identified and annotated using the `:temporal` relation.  
  Comment: we do NOT annotate (for the time being?) temporal relations between events and DCT!
  

### Document level annotation:**

**Disclaimer:**   
Note that this HowTo recaps our interpretation of the Guidelines (rather than the Guidelines themselves -- as there are many unclear points there). 

**First**, create **a timeline**  with all detected time expressions and all events (if possible)  for (at least part of) the analyzed document. This timeline serves as a guide for the temporal annotation (it is not part of the annotation itself). 

**Second**, create a temporal **superstructure** (= the top levels of the dependency structure) for (at least part of) the document:
- Create a **"metanode"**, typically corresponding to `DCT` (= document creation time);   
  (in fact, there are 3 other types of metanodes in the Guidelines: `past/present/  future-reference` -- we will only use them for vague time expressions (as _nowadays_), see below);
   - any metanode is (by definition) connected directly  to the `root` by the generic `:depends-on` relation (thus, it is not necessary to annotate it); 
- Add one node for each **locatable temporal expression** (from the text) and relate it to the existing structure: 
  - **concrete absolute** values (as _May 15, 2024_): to the `root` -- in that case, use the `:depends-on` relation;
  - **concrete relative** values (as _today_, _two days later_):  to the metanode `DCT` or to another (already annotated) concrete time expression -- here use one of the "normal"  relations: `:contained`, `:overlap`, `:after`, `:before` (see below).;  
  - **vague** values (as _nowadays_): to `past/present/future-reference` --  which relation(s) should be used **???**;
  - (**unlocatable temporal expression** (as _every month_): they are not represented in the temporal structure (but they influence, e.g., the aspect value)).   
  **Decision:**  There should be "a generic `:depends-on` relation between all nodes in the temporal superstructure". However, this relation appears only sporadically in the data (typically, "normal" temporal relations are used, see below). Thus, we will its use to concrete absolute time expressions, unless we find contexts where "normal" ones seem to be inadequate.)

**Third**, add all events to the temporal annotation -- each event is annotated as **the child of either a time expression** in the superstructure **or another event** (or both). In other words, each event (child) is related to a time expression (which is already anchored) OR to other already anchored event.    

Process in the following way: 
- If necessary, update **the timeline** with all detected time expressions and all events (if possible); this will help you to select the "main" event to which you will relate the other events in the given sentence (not anchored in a time expression). 
- Add the **"main" event** to the temporal annotation (the one which is "closest" to the referential time expression) -- relate it:
    - to the referential **time expression** (esp. to those in the same line as the event), or one of the **metanodes**;
    - use one of the following relations: `:contained`, `:overlap`, `:after`, `:before` (see below).
- Step by step, add all **other events** -- relate them:     
   - primarily to the relevant time expression (esp. to those in the same line as the event), or
   - to other event(s)  
      (this parent event must be a process and has the same modal annotation OR `:full-affirmative` relation to the `author`).
   - Use one of the following relations: `:contained`, `:overlap`, `:after`, `:before` (see below).
   - The **labels** characterize the relation **from child to parent** !!!

**Fourth**, take care of **special cases**:
  - **complement-taking predicates**  
  (see below; main idea: the complement-taking predicate serves as the parent/reference point for its complement);
  - **reporting predicates**  
  (see below; main idea: the reporting event serves as the parent/reference point for reported events);
  - **purpose clauses** --> always `:after` temporal relation  
   (the main clause as a parent, the purpose clause/infinitive as a child).


**Fifth,** check whether **repeated mentions** of the same event got consistent annotation:
- the two (or more) mentions must have the same relation to `DCT`;
- if both of them specify their relation to a third node (or to a third and a fourth node which are coreferential), it must be the same relation;
- ??? more complex situations (as suggested by Dan):
   - the relations `:before`, `:after`, and `:contained` are transitive 
   - `:before` is the opposite of `:after`
   - if X is contained in Y and Z is `:before/:after` Y, then Z is also `:before/:after X`  
**Dan's comments:** The validator can use the above rules to infer temporal relations between other pairs of nodes, where the relation is not annotated explicitly. And it must never happen that two information sources lead to conflicting relations between a given pair of nodes.
  - `:overlap` does not provide information that can be used for inference but it is mutually exclusive with `:before`, `:after`, and `:contained`;
  -  `:depends-on` does not provide useful information and it should be probably avoided because usually we can use one of the more specific relations.  
  **Markéta's comment:** _Na druhém místě je zatím blok Spolehlivý dům ..._ ... the temporal relation _zatím_ seems to depend on `DCT` but I am not sure about the appropriate relation -- what about to reserve `:depends-on` for such cases?  

---
---

## Sentence level annotation
According to the UMR guidelines, the sentence level annotation captures two cases:
- **Time expressions** -- like _včera_ "yesterday", _minulý týden_ "last week",  _4. dubna_ "April 4th", _každý rok_ "every year", _poté co dokončil školu_ "after he finished the school" -- that serve as temporal modifiers of a predicate are annotated using the `:temporal` relation, similarly as in PDT.  
Not surprisingly, this annotation is used for any time expression overtly present in a sentence.

- In addition, ``**the temporal relation between an event and the document creation time** (DCT) is annotated'' using the same `:temporal` relation -- the UMR Guidelines illustrate this on the following sentence:

  - [en] _In April 1998 Arab countries signed an anti-terrorism agreement ..._
    ... it gets `:temporal (b2 / before :op1 (n/now))` annotation indicating that the event described by the predicate _sign_ happened before the sentence were written.  

The temporal relation between an event and the DCT is annotated **when this temporal relation is defined in that context.**  

The Guideline examples suggest that this should be the case of any finite verb if it clearly indicates whether the described event precedes the DCT or follows after DCT. However, it seems that the released English data limit temporal annotation at the sentence level to time expressions overtly present in sentences.  

> **Preliminary rule for Czech annotations:**  
> The temporal annotation at the sentence level is limited to time expressions expressions (or other "clues") overtly present in sentences (past/future tense is not enough).   
The temporal relation between an event and the DCT may be added later based on the tense grammateme where possible.  



## Document level annotation
The document level annotation focuses on 
- time-time relations (when interpretation of a relative time depends on another time expression);
- event-time relations;
- event-events 
  - only when the temporal relations are clearly supported by morpho-syntactic clues, or
  - clear temporal sequence can be inferred.


#### 1. phase: Setting up the temporal superstructure 
The temporal superstructure contains: 
- the **locatable temporal expressions** in the text (see below for their classification),  
- **pre-defined metanodes**, namely `past-reference`, `present-reference`, `future-reference`, and `document-creation-time` or (`DCT`) ... and also `root` (not explicitely mentioned in the Guidelines),
- and their temporal relations to each other -- just 1 relation is mentioned in the guidelines, namely the `:depends-on` relation.

As for temporal expressions, all of them should be identified in a document and annotated. Further, they should be related to the metanodes whenever possible:
- locatable time expressions:
  - concrete absolute (_May 15:) to the `root`;
  - concrete relative (_today_, _two days later_) to the `DCT` or to other concrete time expression
  - vague (_nowadays_) to the `present/past/future-reference`
- unlocatable time expressions (_each month_): without reference
 

#### 2. phase: Adding events to the temporal dependency structure

4 temporal relations -- **note that the labels characterize the relation from child to parent!!!**
- `:contained` ... parent begins before child and parent ends after child, including
  - **subevent structures** (a subevent as a child)
  - events with a **purely temporal** (not causal or conceptual) relation between them
- `:after`
  - incl. **causally-related** events   
  _The crops grew well because it rained enough_ ... (rain :after grow) 
- `:before`
- `:overlap`
  - incl. perfectly **simultaneous events** (beginning and ending at the exact same time point)

**For each event:**  
**A. Relate it to a time expression** (if possible, i.e., to those in the same line as the event or other in the text)
  - exception:  when an event is contained in another event contained in a time expression  

**B. Relate it to other event** (if no time expression is available) -- the parent event must meet the following criteria:
  - there is a **clear temporal relation** between both events;
  - the parent event is (a subtype of) a **process** (in particular, not state, not habitual);
  - both events have **the same modal annotation** (parent+value)   
  OR the parent event has `:full-affirmative` relation to the `author`.

**Principle**: Make a **timeline** and try to relate each event to **immediately preceding / following** event or time expression! 

- [en] _The opening of the food can prompted my cat to meow_   ... first, I open a can (1), and this is a prompt (2) causing my cat to meow (3); thus the annotation should be the following:  
```  
  :temporal ((present-reference: contained open)  
             (open :after prompt)  
             (prompt :after meow))
```

For events related to a time expression, a second annotation specifying its relationship with another event may also be added!!

**C.** Events with NO such relations should be related to the appropriate tense metanode




### Special cases:
#### Complement-taking predicates
The complement-taking predicate acts as the reference time for its complement.

- First, find the complement-taking predicate and add the corresponding event event to the document level temporal structure, i.e., relate it to appropriate time expression (or to the DCT/past/present/future-reference node).  
- Second, create a timeline (just for you).
- Finally, link the event expressed as the complement to the complement-taking predicate (with the appropriate temporal relation).   
  In case of multiple complements, at least one of them must be related to the complement-taking verb. With the others, you must consider whether the complements are ordered with respect to each other OR to the main predicate.

Example:

- [en] _I want to go to the city and visit a museum._  
  timeline: ... **want** ... go ... visit ... _want_ as being a complement-taking verb)

```
:temporal ((present-reference :contained want)
           (want :after visit)) !!not city (as in the Guidelines)!!
```

- [en] _I saw him knock on the door._  ... _see_ as a complement-taking verb  
   timeline: _seeing_ and _knocking_ overlap)

```
:temporal ((past-reference :contained see)
           (see :overlap knock)))
```


  
#### Reporting events
The reporting event serves as the reference time for the reported events.

- First, find the reporting verb and add the reporting event to the document level temporal structure, i.e., relate it to appropriate time expression (or to the DCT/past/present/future-reference node).  
- Second, create a timeline (just for you).
- Finally, link reported events linked to the reporting predicate (with the appropriate temporal relation).   
  In case of multiple reported events, one of them must be related to the reporting verb. With the others, you may link them to the reporting verb OR to each other.

Examples:

- [en] _Magdalena said she arrived home, ate dinner, and will meet us at the theater.._  ... _say_ as the reporting verb
  timeline: ... arrive ... eat ... **say** ... meet ...

```
:temporal ((past-reference :contained say)
           (say :before eat)
           (eat :before arrive)
           (s1s :after s1m)))
```



#### Purpose clauses
Events in purpose clauses are always linked to their main clauses in the temporal structure using the `:after` relation.

- [en]  _He went home (in order) to wash the dishes._  
  :temporal ((past-reference :contained s1g)
		 (s1g :after s1w)))

```
:temporal ((past-reference :contained go)
           (go :after wash))
```
