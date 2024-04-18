# Modal Dependency



In UMR, the modal annotation captures the **modal strength** of events, but not the modal type of the event (i.e., epistemic/evidential, deontic, permissive, etc.).

Modal annotation is done at both the sentence level and the document level representation.

**Question**:  
It is not clear (to me) why the `:purpose` and `:condition` relations need specific treatment -- in which aspects they are different compared to, e.g., `:cause` or `:reason` .  
What about their **inverse** relations or their **reifications**? 
  

## Short HowTo for Czech annotations:

- **sentence level representation:**
  - for **"almost all" event concepts** add the `:modal-strength` attribute and its appropriate value (`full/partial/neutral-affirmative/negative`);  
  (the only exception: events under the scope of modals, see below); 
  - for **reported events** (= events that are under the scope of a reporting event) add **also** the `:quote` relation pointing out to the **reporting verb** (more precisely, enter the ID of the reporting verb as its child node);
  - for all **events under the scope of modals** (= modalized events identified as their own events) use the `:modal-predicate` relation identifying the relevant **modal verb**, as _want_, _think_, _forbid_,  ...);  
  NOTE: this relation is used **instead of**  `:modal-strength` (the only exception);   
  NOTE:  UMR seems to use very broad interpretation for modal predicates (see below and the Guidelines, [Part 4-3-1-6](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#part-4-3-1-6-modal-dependency-structure) and [Part 4-3-2](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#part-4-3-2-english-modals).
 
- **document level representation:**
  - identify the **root** and the **author**... (root :modal author); 
    ... **?? AUTH --> author (in our fork of the Guidelines) ??**;   
  (note: this is used only in some English files);
  - identify all **conceivers** (= sources / entities whose perspective on an event is modeled in the text), typically the author (already added, see above), but also
     - for **reporting events**, the **speaker** should be also identified and linked to the author;   ; 
     - for **purpose** clauses, the **"actor/agens"** of the main clause should be linked to the author (more complex, see below);
     - (for **conditional** clauses, no additional conceivers are supposed);
  - identify all **event concepts** and add each of them to the modal structure: 
     - **"default"**: as a chil of the "author" node with the appropriate relation (`full/partial/neutral-affirmative/negative`) 
     - XXXXXXXXXXXXXXXX **reported event**: as a child of the speaker node (=conceiver) with the appropriate relation (`full/partial/neutral-affirmative/negative`), see below; 
     - XXXXXXXXXXXXXXXX **modalized event**: more complex, see below;  
     (**1.** the modal verb is linked to the "author" node indirectly via its subject entity (author -- subject; subject -- modal verb); **2**. the modalized event is represented as a child of the modal with the `:Unsp` relation);
     - **purpose**:  more complex, see below ... the Guidelines suggest automatic process (based on the sentence level annotation);   
     (the main clause "actor/agens" as the parent of the special "purpose" node with the `:partial-affirmative` relation, which itself is the parent of the purpose clause event);
     - **condition**:  more complex, see below ... the Guidelines suggest automatic process (based on the sentence level annotation) 
     (the "have-condition" node is added as a child of the author node  with `:neutral-affirmative relation`, then both events (the main clause, the conditional clause) are linked to this "have-condition" node).

**Reminder**: deontic modality (_can_, _must_, _may_, …, _probably_, …) is conceived as just 1 event, with just `:modal-strength` annotation (`full/partial/neutral-affirnaive/negative`) at the sentence level.

## Sentence-level representation

At the sentence level, three relations/attributes relate to  the modal annotation
- the `:modal-strength` attribute, combining 
  - **epistemic strength** typically corresponds to the degree of **confidence of a conceiver** (often, the author) that **the event occurs** in the real world [Non-future events](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#part-4-3-1-1-1-non-future-events); (for more complicated examples, see [Evidential justification](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#part-4-3-1-1-2-evidential-justification) (_I saw ..._, _Mary must have ..._), and [Future events and deontic modality](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#part-4-3-1-1-3-future-events-and-deontic-modality));  
  3 **basic** values for epistemic strength: 
    - `full` (complete certainty) 
    - `neutral` (not certain but probable) 
    - `partial` (50:50 possibility) 
  -  and **polarity**
     - 2 values for polarity: `affirmative` / `negative`  
- with **modalized verbs**, the `:modal-predicate` relation is used to identify the **modal verb** (cycle!!);  
  (NO `:modal-strength` annotation here!!)
- with **reported events**, the`:quote` relation identifies the reporting verb (cycle!!);   
(this relation is used in addition to the `:modal-strength` attribute).

In addition,  events in purpose clauses (`:purpose`) and events in conditional constructions (`:condition`, its reification `have-condition-91`) are used in the document-level representation.

Why different than, e.g., `:cause`???  
And what about the reification `have-purpose-91`???
 
**Comment:**  
In some examples (not consistently), UMR seems to use very extensive interpretation of modal predicates, they include more-or-less ALL complement taking verbs (incl., e.g., _see_ in _I saw him knock on the door._).  

BUT for some predicates identified as modals in the Guidelines (the Edmund Pope examples), the `:modal-predicate` relation is removed in the released English data (e.g., english_umr-0003.txt, snt2 _charge-05_).  
For other predicates, the English data combines `:modal-strength` and `:modal-predicate` annotation, which contradicts the above mentioned principles (e.g., english_umr-0001.txt, snt21: _... come ... to help look for bodies_ with _help_ annotated as modal predicate and _look_ with both attributes) 


## Document-level representation

The modal representation has a form of a tree at the document level:
- **nodes**: **events** and **conceivers** (i.e., a source, an entity whose perspective on an event is modeled in the text)
- **edges**:  **modal strength** and **polarity values** (i.e., how certain a specific conceiver is about the occurrence of the event in the real world)



XXXXXXXXXXXX Part 4-3-1-2. modal-predicate relation





### Special cases

#### Reported events 
(the `:modal-strength` and `:quote` relations in the sentence structure relations)  

#### Modal-predicate relation 
(the `:modal-predicate` relation in the sentence structure)  

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