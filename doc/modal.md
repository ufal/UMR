# Modal Dependency



In UMR, the modal annotation captures the **modal strength** of events, but not the modal type of the event (i.e., epistemic/evidential, deontic, permissive, etc.).

Modal annotation is done at both the sentence level and the document level representation.

**Question 1**:
I am not sure what is the added value of the document level annotation - it seems to simple copy the sentence level annotation?  
In fact, in several examples in the section on reported events, the document level modal structures do not mirror the sentence level `:modal-strength` values. However, these differences are not discussed and in fact, I do not understand the reasoning underlying the document level annotation.  

**Question 2**:  
It is not clear (to me) why the `:purpose` and `:condition` relations need specific treatment -- in which aspects they are different compared to, e.g., `:cause` or `:reason` .  
What about their **inverse** relations or their **reifications**? 
  

## Short HowTo for Czech annotations:

**Sentence level representation:**
- for **"almost all" event concepts** add the `:modal-strength` attribute and its appropriate value (`full/partial/neutral-affirmative/negative`);  
  (the only exception: events under the scope of modals, see below); 
- **reported events** (= events that are under the scope of a reporting event) as well as **reporting verbs** get the "default" `:modal-strength` attribute);  
   - **in addition**, for **reported events**, add the `:quote` relation pointing out to the **reporting verb** (more precisely, enter the ID of the reporting verb as its child node);  
- while **modal verbs** (as _want_, _think_, _forbid_,  ... ) get the "default" `:modal-strength` attribute, 
  -  **events under the scope of modals** (= modalized events identified as their own events) use the `:modal-predicate` relation identifying the relevant **modal verb** 
(using their ID as the child node);  
  - the `:modal-predicate` is used **instead of**  `:modal-strength` (these verbs form the only exception);   

**Notes/reminders**:   
- **Deontic modality** (_can_, _must_, _may_, …, _probably_, …) is conceived as just 1 event, with just `:modal-strength` annotation (`full/partial/neutral-affirnaive/negative`) at the sentence level.
- UMR seems to use **very broad interpretation for modal predicates** (see below and the Guidelines, [Part 4-3-1-6](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#part-4-3-1-6-modal-dependency-structure) and [Part 4-3-2](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#part-4-3-2-english-modals).

**Document level representation:**
- identify the **root** and the **author**... (root :modal author);   
    **?? AUTH --> author (in our fork of the Guidelines) ??**;   
  (note: this is used only in some English files);
- identify all **conceivers** (= sources / entities whose perspective on an event is modeled in the text), typically the author (already added, see above), but also
   - for **reporting events**, the **"speaker/sayer/reporter"** should be also identified and linked to the author;   
   - for **purpose** clauses, the **"actor/agens"** of the main clause should be linked to the author (more complex, see below);
   - (for **conditional** clauses, no additional conceivers are supposed);
- identify all **event concepts** and add each of them to the modal structure: 
     - **"default"**: as a chil of the "author" node with the appropriate relation (`full/partial/neutral-affirmative/negative`) 
     - **reported event**: as a child of the "speaker/sayer/reporter" node (=conceiver) with the appropriate relation (`full/partial/neutral-affirmative/negative`), see below; 
     - XXXXXXXXXXXXXXXX **modalized event**: more complex, see below;  
       - **1.** the modal verb is linked to the "author" node indirectly via its subject entity (author -- subject; subject -- modal verb); 
       - **2.** the modalized event is represented as a child of the modal with the `:Unsp` relation;
     - **purpose**:  more complex, see below;    
       - the main clause "actor/agens" as the parent of the special "purpose" node with the `:partial-affirmative` relation, 
       - which itself is the parent of the purpose clause event);   
       ?? the Guidelines suggest automatic process (based on the sentence level annotation) ??;
     - **condition**:  more complex, see below;  
       - the "have-condition" node is added as a child of the author node  with `:neutral-affirmative relation`, 
       - then both events (the main clause, the conditional clause) are linked to this "have-condition" node);  
        ?? the Guidelines suggest automatic process (based on the sentence level annotation) ?? 


## Sentence-level representation

At the sentence level, three relations/attributes relate to  the modal annotation
- the `:modal-strength` attribute, combining 
  - **epistemic strength** typically corresponds to the degree of **confidence of a conceiver** (often, the author) that **the event occurs** in the real world [Non-future events](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#part-4-3-1-1-1-non-future-events), see below; 
    - for more complicated examples, see [Evidential justification](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#part-4-3-1-1-2-evidential-justification) (_I saw ..._, _Mary must have ..._), and
    - [Future events and deontic modality](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#part-4-3-1-1-3-future-events-and-deontic-modality));  
  -  3 **basic** values for epistemic strength: 
     - `full` (complete certainty) 
     - `neutral` (not certain but probable) 
     - `partial` (50:50 possibility) 
  -  and **polarity**
     - 2 values for polarity: `affirmative` / `negative`  
- with **modalized verbs**, the `:modal-predicate` relation is used to identify the **modal verb** (cycle!!) ... see below for comments!!;  
  (NO `:modal-strength` annotation here!!)
- with **reported events**, the`:quote` relation identifies the reporting verb (cycle!!);   
(this relation is used in addition to the `:modal-strength` attribute, see below).

In addition,  events in purpose clauses (`:purpose`) and events in conditional constructions (`:condition`, its reification `have-condition-91`) are used in the document-level representation.
 

### Non-future events
The Guidelines: "For non-future (non-deontic) events, the `:modal-strength` values correspond to the author’s level of certainty towards the occurrence of the event in the real world." 

For examples, see [Part 4-3-1-1-1](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#part-4-3-1-1-1-non-future-events).

### Evidential justification

There might be direct and indirect justification - both of them correspond to the strength of epistemic support.

Example of the direct support:
- [en] _(I saw) Mary feed the cat._   ... `:full-affirmative`
  (the author has direct knowledge by witnessing the event)

Example of the in direct support:  
- [en] _Mary must have fed the cat._  ... `:partial-affirmative`
  (the author is inferring that the feeding event occurred (without direct, perceptual knowledge))

(Examples from [Part 4-3-1-1-2](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#part-4-3-1-1-2-evidential-justification).)

### Future events and deontic modality

The Guidelines: "For events presented as (potentially) happening in the future, `:modal-strength` refers to the predictability of the occurrence of the event in the future, as presented by the author."
- predictive future has `:full` strength (as in _I will go to Santa Fe_),
- intentions and commands have `:partial` strength (as in _I must go to Santa Fe_),
- desire and permission have `:neutral` strength (as in _I can go to Santa Fe_)

(Examples from [Part 4-3-1-1-3](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#part-4-3-1-1-3-future-events-and-deontic-modality).)

### Reported events 

Reporting predicates  are annotated with a `:modal-strength` value (corresponding to the author’s certainty that the reporting event happened).  
Reported events get -- on addition to the `:modal-strength` attribute (corresponding to the certainty with which the **speaker/sayer/reporter** reports the events) -- also the `:quote` relations in the sentence level annotation. (The reporting event). 

### Modal predicates 
While **a modal verb** gets the usual `:modal-strength` attribute in the sentence level annotation, with a modalized verb (i.e., verb) 

XXXXXXXXXXXXXXXXXXXXXXXXXX

In some examples (but not consistently), UMR seems to use very extensive interpretation of modal predicates, they **include more-or-less ALL complement taking verbs** (incl., e.g., _see_ in _I saw him knock on the door._).  

BUT for some predicates identified as modals in the Guidelines (the Edmund Pope examples), the `:modal-predicate` relation is removed in the released English data (e.g., english_umr-0003.txt, snt2 _charge-05_).  
For other predicates, the English data combines `:modal-strength` and `:modal-predicate` annotation, which contradicts the above mentioned principles (e.g., english_umr-0001.txt, snt21: _... come ... to help look for bodies_ with _help_ annotated as modal predicate and _look_ with both attributes) 


## Document-level representation

The modal representation has a form of a tree at the document level:
- **nodes**: **events** and **conceivers** (i.e., a source, an entity whose perspective on an event is modeled in the text)
- **edges**:  **modal strength** and **polarity values** (i.e., how certain a specific conceiver is about the occurrence of the event in the real world)


### Special cases

#### Reported events 

For reported events, there are two nodes corresponding to conceivers in the document structure (contrary to all other events with just an "author" as the conceiver):
- the **author** ... as the modal annotation expresses "the author’s certainty that the reporting event happened", and
- the **speaker/sayer/reporter** (the subject of the reporting verbs) ... as the modal annotation expresses "the certainty with which the sayer/reporter reports the events".

The following examples are from [Part  4-3-1-3](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#part-4-3-1-3-quote-relation).

- [en] a. _Mary said that she went to Santa Fe._     
        sent-level: both verbs have `:full-affirmative` value
```
:modal ((root :modal author)             ???
        (author :full-affirmative say)
		(author :full-affirmative Mary)
		(Mary :full-affirmative go))      
```

- [en] b. _Mary might have said that she went to Santa Fe._  
        sent-level: _say_ with `:neutral-affirmative`,  
       _go_ with `:full-affirmative` value   
```
:modal ((root :modal author)             ???
        (author :neutral-affirmative say)
		(author :neutral-affirmative Mary)
		(Mary :full-affirmative go))
```

- [en] c. _Mary didn’t say that she went to Santa Fe._  
        sent-level: _say_ with `:full-negative`,  
       _go_ with `:full-affirmative` value   
```
:modal ((root :modal author)             ???
        (author :full-negative say)
		(author :full-negative Mary)
		(Mary :full-affirmative go))
```

- [en] d. _Mary said that John might have gone to Santa Fe._
        sent-level: _say_ with `:full-affirmative`,  
       _go_ with `:neutral-affirmative` value   
```
:modal ((root :modal author)             ???
        (author :full-negative say)           ???:full-affirmative
		(author :neutral-affirmative Mary)    ???:full-affirmative
		(Mary :neutral-affirmative go))
```

- [en] e. _Mary said that John probably didn’t go to Santa Fe._  
        sent-level: _say_ with `:full-affirmative`,  
       _go_ with `:partial-negative` value  
```
:modal ((root :modal author)             ???
        (author :full-negative say)      ???:full-affirmative    
		(author :partial-negative Mary)  ???:full-affirmative  
		(Mary :partial-negative go))
```


#### Modal-predicate relation 
(the `:modal-predicate` relation in the sentence structure)  

XXXXXXXXXXXXXXXXXXXXXXXXXXX

NOTE:  UMR seems to use very broad interpretation for modal predicates (but the Guidelines examples and the English released data are not consistent wrt to modals and their annotation).  
  The Guidelines mention that the relevant information will be added to the frame files for modal verbs (e.g., for _want_, its frame file will indicate (in addition to the argument structure), also the `:modal-strength of complement: neutral-affirmative`).
  
  
Some predicates impart full, positive (full-affirmative) strength on their complements, often called factive predicates (e.g., manage to). Strong epistemic modals (e.g., expect that, deduce) and strong deontic modals, including intention modals (e.g., plan to, decide to) and obligation modals (e.g., need, demand), impart partial-affirmative strength on their complements. Weak deontic modals, including desire (e.g., want) and permission (e.g., allow), impart neutral-affirmative strength on their complements. Certain modals may also lexicalize negation, such as doubt, forbid, or wish. These are annotated with the neutral-negative, partial-negative, and full-negative values, respectively.
  



XXXXXXXXXXXX následující už OK

#### Purpose relations
(the `:purpose` relation in the sentence structure)  

??the Guidelines mention that such annotation should be added automatically??

- [en] _They dropped water in order to fight the fire._

```
:modal ((root :modal author)             ???
        (author :full-affirmative drop)    
		(author :full-affirmative they)  
		(they :partial-affirmative purpose)
		(purpose :full-affirmative fight))
```
		
- [en] _He walked quickly in order to not arrive late._
```
:modal ((root :modal author)             ???
	    (author :full-affirmative walk)
		(author :full-affirmative he)
		(he :partial-affirmative purpose)
		(purpose :full-negative arrive))
```
     

#### Condition relations
(the `:condition`  relation in the sentence structure)  

??the Guidelines mention that such annotation should be added automatically??

Guidelines:  "the event in the protasis [~ dependent clause] is annotated with a `:condition` relation to the event in the apodosis [~ main clause]." ... OK, the sentence level annotation

- [en] _If she’s hungry, I’ll feed her dinner._
```
:modal ((root :modal author)                         ???
        (author :neutral-affirmative have-condition)
		(have-condition :full-affirmative hunger-01)
		(have-condition :full-affirmative feed))
```

- [en] _If she’s hungry, maybe I’ll cook pasta._
```
:modal ((root :modal author)                         ???
        (author :neutral-affirmative have-condition)
		(have-condition :full-affirmative hunger-01)
		(have-condition :neutral-affirmative cook))
```

- [en] _If she isn’t hungry, we’ll just watch a movie._
```
:modal ((root :modal author)                         ???
        (author :neutral-affirmative have-condition)
		(have-condition :full-negative hunger-01)
		(have-condition :full-affirmative watch))     NOT cook
```