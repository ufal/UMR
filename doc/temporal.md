# Temporal Relations ... Short HowTo for Czech annotations

In UMR, temporal annotation is done at both the sentence level and the document level representation.

> **Disclaimer:**  
> Note that this HowTo recaps our interpretation of the Guidelines (rather than the Guidelines themselves -- as there are many unclear points there).

 

## 1. Sentence level representation:

- Any **time expression** (any overtly present) should be identified and annotated using the `:temporal` relation modifying the respective **event**.  
  
  (Examples:  *včera* "yesterday", *minulý týden* "last week", *4. dubna* "April 4th", *každý rok* "every year", *poté co dokončil školu* "after he finished the school" )

- Relations between an **event** and **its DCT** are supposed to be annotated at the sentence level as well: 
  
  - <u>Guidelines</u>: "The temporal relation between an event and the DCT is annotated when this temporal relation is defined in that context."
  
  The Guideline examples suggest that this should be the case of any finite verb if it clearly indicates whether the described event precedes the DCT or follows after DCT. However, it seems that the released English data limit temporal annotation at the sentence level to time expressions overtly present in sentences
  
  - [en] *In April 1998 Arab countries signed an anti-terrorism agreement ...* 
    
    It gets `:temporal (b2 / before :op1 (n/now))` annotation indicating that the event described by the predicate *sign* happened before the sentence were written.

> **Preliminary rule for Czech annotations:**  
> 
> The temporal annotation at the sentence level is limited to time expressions expressions (or other "clues") overtly present in sentences (past/future tense is not enough). 
> We do **NOT annotate (for the time being?) temporal relations between events and DCT just on the basis of the verb tense!** 

(The temporal relation between an event and the DCT may be added later based on the tense grammateme where possible.)

---

## 2. Document level annotation:

### Pass 0: Create a timeline

First, create **a timeline**  with all detected **time expressions** and all **events** (if possible)  for (at least part of) the analyzed document. This timeline serves as a guide for the temporal annotation (it is not part of the annotation itself). 

**Principle**: Try to relate each event to **immediately preceding / following** event or time expression!

Example (from the Guidelines):

- [en] *The opening of the food can prompted my cat to meow* ... first, I open a can (1), and this is a prompt (2) causing my cat to meow (3); thus the annotation should be the following:   
  timeline: open ... prompt ... meow
  
  ```
  :temporal ((present-reference: contained open)  
             (open :after prompt)  
             (prompt :after meow))
  ```

For events related to a time expression, a second annotation specifying its relationship with another event may also be added!!



### Pass 1: Setting up the temporal superstructure

Temporal superstructure represents the top levels of the dependency structure. It contains all **temporal expressions (timexs)** in the text and **pre-defined metanodes** and their temporal relations to each other.

- Create a **"metanode"**, typically corresponding to `DCT` (= document creation time) or to the  `ROOT` (for absolute time expression, like May 2015);   
  
  - In fact, there are 3 other types of metanodes in the Guidelines: `past/present/future-reference` -- we will only use them for vague time expressions (as _nowadays_), see below.
  - Any metanode is (by definition) connected directly  to the `root` by the generic `:depends-on` relation (thus, it is not necessary to annotate it). 

- Add one node for each **locatable temporal expression** (from the text) and relate it to the existing structure: 
  
  - for **concrete relative** values (as _today_, _two days later_): 
    - indicate their relation to the metanode `DCT` **!!!** or to another (already annotated) concrete time expression; 
    - use one of the "normal"  relations;  
  - for **concrete absolute** values (as _May 15, 2024_): 
    - relate them to the  `ROOT`  **!!!** 
    - use the `:depends-on` relation;
  - for **vague** values (as _nowadays_): 
    - relate them to  `past/present/future-reference` **!!!** 
    - use one of the "normal" relations;

- For **unlocatable temporal expression** (as _every month_): they are not represented in the temporal structure (but they influence, e.g., the aspect value)).   

> **Decision:**  There should be "a generic `:depends-on` relation between all nodes in the temporal superstructure". However, this relation appears only sporadically in the data (typically, "normal" temporal relations are used, see below).  
> Thus, we will limit its use to concrete absolute time expressions, unless we find contexts where "normal" ones seem to be inadequate.

**Choosing the right temporal relation ("normal" relations)**

- `:contained`: child is entirely contained within the parent; parent begins before child and parent ends after child; use this also for <u>subevents!</u>

- `:after`... child is after parent; use also for <u>purpose clauses</u> and <u>causally-related events</u>; for <u>modals</u> if they indicate futre event (_he wants to come_).

- `:before` ... child is before parent.

- `:overlap` ... child and parent overlap (but one is not fully contained in the other); use this also for <u>perfectly simultaneous events</u> and for <u>phase verbs</u> (_začal křičet_)!  

Note that the <span>labels</span> characterize the relation **from a child to its parent** !!!



### Pass 2: Adding events

Now add all events to the temporal annotation -- each event is annotated as **the child of either a time expression** in the superstructure **or another event** (or both). In other words, each event (child) is related to a time expression (which is already anchored) OR to other already anchored event.   

> Guidelines: As a backup (no time expression, no relevant parent event), it should be added to the appropriate tense metanode.    

Process in the following way: 

- If necessary, update **the timeline** with all detected time expressions and all events (if possible, Pass 0); this will help you to select the "main" event to which you will relate the other events in the given sentence (not anchored in a time expression). 

- Add the **"main" event** to the temporal annotation (the one which is "closest" to the referential time expression) -- relate it:
  
  - to the referential **time expression** (esp. to those in the same line as the event); if no such timex exists, use one of the **metanodes** (as a backup);
  - use one of the following relations: `:contained` (preferred), `:overlap`, `:after`, `:before`.

- Step by step, add all **other events** -- relate them:     
  
  - <u>primarily</u> to the relevant **time expression** (esp. to those in the same line as the event), 
  
  - use one of the following relations: `:contained` (preferred), `:before`, `:after`, `:overlap`;
  
  - if <u>no such times exists</u>, relate it **to other event(s)**   ... this parent event 
    
    - must be <u>a process</u> (i.e., NOT habitual or state) and 
    - either (i) has the same modal annotation OR (ii) has `:full-affirmative` relation to the `author`).
  
  - As a backup, events with NO such relations should be related to the appropriate tense metanode (e.g., `DCT`).
    
    > Guidelines: If an event does get a relation to a time expression, a second 
    > annotation that specifies its relationship with another event may also 
    > be added.

- **Exception**: In cases when an event overlaps with its referential expression (time or event), its temporal characteristics cannot be inferred. Thus, we should also add its relation to the metanode (typically `DCT`)  to express it explicitly. 
  
  

### Special cases

#### 1 Complement-taking predicates

All events under the scope of complement-taking predicates (exemplified by *see, want*) should be linked with `:modal-predicate`  to their parent. Then this parent (= the complement-taking predicate) serves as the parent/reference point for its complement. 

In cases of multiple events under the scope of a complement-taking predicate, at least one of them must be temporally related to the parent event (others may be linked to each other).     

Examples:

- [en] *I want to go to the city and visit a museum.*  
  timeline: ... **want** ... go ... visit ... *want* as being a complement-taking verb  

   ```
   :temporal ((present-reference :contained want)
              (want :after visit)) !!not city (as in the Guidelines)!!
   ```

- [en] *I saw him knock on the door.* ... *see* as a complement-taking verb  
  timeline: *seeing* and *knocking* overlap

   ```
   :temporal ((past-reference :contained see)
              (see :overlap knock)))
   ```

#### 2 Reporting predicates

The same principle as for complement-taking predicates, i.e., a reporting predicate serves as the tome reference for at least one reported event.

Example:

- [en] *Magdalena said she arrived home, ate dinner, and will meet us at the theater..* ... *say* as the reporting verb  
  timeline: ... arrive ... eat ... **say** ... meet ...

   ```
   :temporal ((past-reference :contained say)
              (say :before eat)
              (eat :before arrive)
              (say :after meet)))
   ```

#### 3 Purpose clauses

Always use the  `:after` temporal relation for events linked with the `:purpose` relation to the main predicate (the main clause as a parent, the purpose clause/infinitive as a child).

- [en] *He went home (in order) to wash the dishes.*  
   timeline: ... **go** ... wash ...

   ```
   :temporal ((past-reference :contained go)
              (go :after wash))
   ```

#### 4 Causally-related events

Always use the `:after` temporal relation for an event causally related to other event.

Examples:

- [en] *the crops grew well because it rained enough*  
  timeline: ... rain ... grow ...
  
  ```
  (rain :after grow)
  ```

- [en] *the opening of the food can prompted my cat to meow*  
    timeline: ... open ... promt ... meow
  
  ```
  (open :after prompt)
  (prompt :after meow)
  ```

---

### OUR Remarks

**Repeated mentions:**

Check whether **repeated mentions** of the same event got consistent annotation:

- the two (or more) mentions must have the same relation to `DCT`:
  - check that they do not specify colliding relations to `DCT`;
  - **Dan's comment:** Perhaps also check that none of them omits the relation?   
    This could be actually generalized: 
    Besides conflicts between explicit and inferred relations, we should also check that time expressions and events specify the minimally required relations
- if both of them specify their relation to a third node (or to a third and a fourth node which are coreferential), it must be the same relation.



**Mutual relations among temporal relations:**

As suggested by Dan:  
- the relations `:before`, `:after`, and `:contained` are transitive 
- `:before` is the opposite of `:after`
- if X is contained in Y and Z is `:before/:after` Y, then Z is also `:before/:after X` 
  
**Dan's comments:** The validator can use the above rules to infer temporal relations between other pairs of nodes, where the relation is not annotated explicitly. And it must never happen that two information sources lead to conflicting relations between a given pair of nodes.
  - `:overlap` does not provide information that can be used for inference but it is mutually exclusive with `:before`, `:after`, and `:contained`;
  - `:depends-on` does not provide useful information and it should be probably avoided because usually we can use one of the more specific relations.  
  

**Further remarks:**

- Markéta: _Na druhém místě je zatím blok Spolehlivý dům ..._ ... the temporal relation _zatím_ seems to depend on `DCT` but I am not sure about the appropriate relation -- what about to reserve `:depends-on` for such cases?  
