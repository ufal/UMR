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

**Principle**: Try to relate each event to **immediately preceding / following** event or time expression! (Guidelines: "*<u>[if an event is not linked to a time expression]... Often, the most appropriate parent is the event in the immediately preceding line or clause</u>*.")

Example (from the Guidelines, [Part 4-2-2-3](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#part-4-2-2-3-causally-related-events)):

- [en] *The opening of the food can prompted my cat to meow* ... first, I open a can (1), and this is a prompt (2) causing my cat to meow (3); thus the annotation should be the following:   
  timeline: open ... prompt ... meow

  ```
  :temporal ((present-reference :contained open)  
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
    - indicate their relation to the metanode  **!!!**  `DCT` **!!!** or to another (already annotated) concrete time expression; 
    - use one of the "normal"  relations;
  - for **concrete absolute** values (as _May 15, 2024_): 
    - relate them to the  **!!!**   `ROOT`  **!!!** 
    - use the `:depends-on` relation;   **??? ZKONTROLOVAT ???**
  - for **vague** values (as _nowadays, *in the old days*_): 
    - relate them to  **!!!** `past/present/future-reference` **!!!** 
    - use one of the "normal" relations;

- For **unlocatable temporal expression** (as _every month_): they are not represented in the temporal structure (but they influence, e.g., the aspect value)).

> **Decision:**  There should be "a generic `:depends-on` relation between all nodes in the temporal superstructure". However, this relation appears only sporadically in the data (typically, "normal" temporal relations are used, see below).  
> Thus, we will limit its use to concrete absolute time expressions, unless we find contexts where "normal" ones seem to be inadequate.

### Pass 2: Adding events

Now add all events to the temporal annotation -- **each event** is annotated as **the child of either a time expression** in the superstructure **or another event** (or both). In other words, each event (child) is related to a time expression (which is already anchored) OR to other already anchored event.   

> Guidelines: As a backup (no time expression, no relevant parent event), it should be added to the appropriate tense metanode.    

Process in the following way: 

1. If necessary, update **the timeline** with all detected time expressions and all events (if possible, Pass 0); this will help you to select the "main" event to which you will relate the other events in the given sentence (not anchored in a time expression). 

2. For each **event**: give it the most precise temporal location **!!!**

   <u>exception:</u> When A is `:contained` within B (A is a subevent) and B is `:contained` within a time expression --> the relation of A to the time expression is NOT annotated (as it logically implies)

   Event should be related:
- primarily to the referential **time expression**

  (a) esp. to those in the same line as the event; 

  (b) otherwise consider time expressions in other lines in the text);

- otherwise consider **another event in the text** (Guidelines: "*Starting with the immediately preceding event in the text and working back through the events in the preceding lines, find an event that is a good parent*"). 

  The parent must:

  (i) be <u>a process</u> (NOT, e.g., habitual or state),

  (ii) either (a) has the same modal annotation OR (a) has `:full-affirmative` relation to the `author`

  (iii) there is a clear temporal relation between the parent event and the child event

- as a backup: if no such timex or event exist, use one of the **metanodes** (e.g., `DCT`).

  - In cases when an event overlaps with its referential expression (time or event), its temporal characteristics cannot be inferred. Thus, we should also add its relation to the metanode (typically `DCT`)  to express it explicitly.use one of the following relations: `:contained` (preferred), `:overlap`, `:after`, `:before`.
4. Guidelines: *If an event does get a relation to a time expression, **a second annotation that specifies its relationship with another event may also be added.** This is the case when a set of events are all `:contained` within the same time expression. The first event in the set of events only needs to be linked to the time expression. Subsequent events can receive two temporal annotations: one that relates it to the time expression and one that relates it to another event in the set.*  

### Choosing the right temporal relation ("normal" relations)

- `:contained` ... child is entirely contained within the parent; parent begins before child and parent ends after child; use this also for <u>subevents!</u>

- `:after`... child is after parent; use also for <u>purpose clauses</u> and <u>causally-related events</u>; for <u>modals</u> if they indicate futre event (_he wants to come_).

- `:before` ... child is before parent.

- `:overlap` ... child and parent overlap (but one is not fully contained in the other); 

  - use this also for <u>perfectly simultaneous events</u>, 

  - for some <u>semi-modals</u> (*dokázat využít*),

  - <mark>!!! prototypical <u>phase verbs</u> (_začít_) are merged with their lexical verbs !!!</mark>

    (_začít křičet_ --> *křičet* with the `:inceptive` aspect value)

  - <mark>!!! deverbal nouns captured using the result-of relation (and similar) !!!</mark> 

  - ... event annotation only with verbs

Note that the <span>labels</span> characterize the relation **from a child to its parent** !!!

### Special cases

#### 1 Complement-taking predicates

All events under the scope of complement-taking predicates (exemplified by *see, want*) should be linked with `:modal-predicate`  to their parent. <u>Then this parent (= the complement-taking predicate) serves as the parent/reference point for its complement.</u>  

In cases of multiple events under the scope of a complement-taking predicate, at least one of them must be temporally related to the parent event (others may be linked to each other).     

Examples (from the guidelines):

- [en] *I want to go to the city and visit a museum.*  
  timeline: ... **want** ... go ... visit ... *want* as being a complement-taking verb  

  ```
  :temporal ((present-reference :contained want)
             (want :after go)     !!missing in the Guidelines??
             (want :after visit)) !!not city (as in the Guidelines)!!
  ```

- [en] *I saw him knock on the door.* ... *see* as a complement-taking verb  
  timeline: *seeing* and *knocking* overlap

  ```
  :temporal ((past-reference :contained see)
             (see :overlap knock)))
  ```

#### 2 Reporting predicates

The same principle as for complement-taking predicates, i.e., <u>a reporting predicate serves as the tome reference for at least one reported event.</u>

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

<u>Always use the  `:after` temporal relation for events linked with the `:purpose` relation to the main predicate</u> (the main clause as a parent, the purpose clause/infinitive as a child).

- [en] *He went home (in order) to wash the dishes.*  
   timeline: ... **go** ... wash ...

  ```
  :temporal ((past-reference :contained go)
             (go :after wash))
  ```

#### 4 Causally-related events

<u>Always use the `:after` temporal relation for an event causally related to other event.</u>

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
