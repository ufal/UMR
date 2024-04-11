# Temporal Relations

In UMR, temporal annotation is done at both the sentence level and the document level representation.

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
- the **temporal expressions** in the text (see below for their classification),  
- **pre-defined metanodes**, namely `past-reference`, `present-reference`, `future-reference`, and `document-creation-time` or (`DCT`) ... and also `root` (not explicitely mentioned in the Guidelines),
- and their temporal relations to each other -- just 1 relation is mentioned in the guidelines, namely the `:depends-on` relation.

As for temporal expressions, all of them should be identified in a document and annotated. Further, they should be related to the metanodes whenever possible:
- locatable time expressions:
  - concrete absolute (_May 15:) to the `root`;
  - concrete relative (_today_, _two days later_) to the `DCT` or to other concrete time expression
  - vague (_nowadays_) to the `present/past/future-reference`
- unlocatable time expressions (_each month_): without reference
 

#### 2. phase: Adding events to the temporal dependency structure

XXXXXXXXX Part 4-2-2 Time relations XXXXXXXXX



### Special cases:
#### Complement-taking predicates
#### Reporting events
#### Purpose clauses