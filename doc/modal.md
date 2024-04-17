# Modal Dependency



In UMR, the modal annotation captures the **modal strength** of events, but not the modal type of the event (i.e., epistemic/evidential, deontic, permissive, etc.).

Modal annotation is done at both the sentence level and the document level representation.

  

## Short HowTo for Czech annotations:



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

XXXXXXXXXXX chybí úvodní odstavec části 4.3

Guidelines: "UMR represents modal strength and polarity as a dependency structure. The nodes are either events or conceivers (i.e., a source, an entity whose perspective on an event is modelled in the text). The edges in the dependency structure correspond to modal strength and polarity values (i.e., how certain a specific conceiver is about the occurrence of the event in the real world). Annotators do not have to construct the dependency structure directly, but it can be built up “behind the scenes” by annotating some modal/polarity information and leveraging the participant role annotation."


XXXXXXXXXXXX Part 4-3-1-2. modal-predicate relation





### Special cases:
#### Modal-predicate relation
#### Reported events (`:quote` relation)




#### Purpose and condition relations
In addition, events in purpose clauses and events in conditional constructions must be taken up in the modal dependency tree. ... ??the Guielines mention that such annotation should be added automatically??
