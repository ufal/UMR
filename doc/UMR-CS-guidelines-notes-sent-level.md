# UMR-CS Guidelines Notes
# Part 3. Sentence-Level Representation

https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md

###### Structure of chapters/sections:
1) **link to the guidelines**
2) **American approach – summary in Czech**
3) **our comments to the American approach**
4) **corresponding materials available on the Czech side** (corpora, dictionaries etc.)
5) **commentaries from the UMR Prague meeting**
6) **proposal of the general Czech approach**

* Part 1. Introduction: What is UMR and what does UMR annotation look like?
* Part 2. From AMR to UMR
* Part 2-1. Introduction
* Part 2-2. Introduction for field linguists 
* Part 2-2-1. Predicate-argument relations
* Part 2-2-2. Multi-word expressions
* Part 2-2-3. Abstract concepts
* Part 2-2-4. Non-participant role relations
* Part 2-2-5. Attributes
* Part 3. Sentence-Level Representation
* Part 3-1. UMR Concepts 
* Part 3-1-1. Eventive concepts ................................. ML 26.6.
* Part 3-1-1-1. Processes in predication ........................ ML 26.6.
* Part 3-1-1-2. Processes in modification and reference ...... ML 26.6.
* Part 3-1-1-3. States and entities ............................. ML 26.6.
* Part 3-1-1-4. Implicit events ................................. ML 26.6.
* Part 3-1-2. Named entities
* Part 3-1-3. Concept-word mismatches .............................. ŠZ 26.6.
* Part 3-1-3-1. Predicate and argument as one word ................. ŠZ 26.6.
* Part 3-1-3-2. Valency-changing operations ......................... ŠZ 26.6.
* Part 3-1-3-3. TAM categories
* Part 3-1-3-4. Associated motion
* Part 3-1-3-5. Light verb constructions
* Part 3-1-3-6. Non-verbal clauses
* Part 3-1-3-7. Multi-word concepts
* Part 3-1-3-8. Miscellaneous constructions
* Part 3-1-4. Word senses
* Part 3-1-5. Scope for quantification and negation
* Part 3-1-6. Discourse relations
* Part 3-2. UMR relations 
* Part 3-2-1. Participant roles 
* Part 3-2-1-1. Stage 0 
* Part 3-2-1-1-1. Non-verbal clauses
* Part 3-2-1-1-2. Valency alternations
* Part 3-2-1-2. Stage 1 
* Part 3-2-1-2-1. Valency alternations
* Part 3-2-1-3. Inverse participant roles
* Part 3-2-1-4. Table of verb meanings
* Part 3-2-2. Non-participant role UMR relations 
* Part 3-2-2-1. Temporal relations
* Part 3-2-2-2. Modifiers
* Part 3-2-2-3. Circumstantial temporals and locatives
* Part 3-2-2-4. Named entities
* Part 3-2-2-5. Quantification
* Part 3-2-2-6. Other relations
* Part 3-3. UMR attributes 
* Part 3-3-1. Aspect 
* Part 3-3-1-1. Event nominals
* Part 3-3-1-2. Habitual
* Part 3-3-1-3. State
* Part 3-3-1-4. Activity
* Part 3-3-1-5. Endeavor and Performance
* Part 3-3-2. Mode
* Part 3-3-3. Polarity
* Part 3-3-4. Quant
* Part 3-3-5. Ref
* Part 3-3-6. Degree
* _Part 4. Document-Level Representation ... see the other file_
* Part 5. Annotation Cheat Sheet
* Part 6. Integrated examples
* Part 7. Alphabetical Index of UMR Annotation Categories

***
***
***

# Part 3. Sentence-Level Representation

***

## Part 3-1. UMR Concepts 
### Part 3-1-1. Eventive concepts
Preparation: ML, 23/6/2023

1) **link to the guidelines**

https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-umr-concepts

2) **American approach – summary in Czech**

identification of events … criteria adopted from TimeML
- **semantic type:** 
- - **entities** (or, objects), 
- - **states** (or, properties), and 
- - **PROCESSES**

- **information packaging** … discourse / information structure: 
- - **reference** (what the speaker is talking about)
- - **modification** (additional information provided about the referent)
- - **PREDICATION** (what the speaker is asserting about the referents in a particular utterance)

Prototypical combinations of semantic type and information packaging IN CAPS in table 2.

**EVENTS** (annotated in UMR) ... in **bold** in table 2
- prototypically: process in predication
- plus whatever is a _process_ (semantic type) or is expressed as _predication_ 

<div id="tab:eventive_concepts">
	
|               |                   Reference                   |                    Modification                    |                  **Predication**                  |
| :-----------: | :-------------------------------------------: | :------------------------------------------------: | :-----------------------------------------------: |
|   Entities    | UNMARKED NOUNS |                 relative clauses, PPs on nouns                  |              **predicate nominals,** **complements**             |
|    States     |              deadjectival nouns               | UNMARKED ADJECTIVES |             **predicate adjectives,** **complements**           |
| **Processes** |       **event nominals, complements,** **infinitives, gerunds**        |         **participles, relative clauses**          | **UNMARKED VERBS** |

Table 2: Constructions identified as events
</div>

3) **our comments to the American approach** 

... see below 3-1-1-1 and 3-1-1-2

4) **corresponding materials available on the Czech side** (corpora, dictionaries etc.)

... see below 3-1-1-1 and 3-1-1-2

5) **commentaries from the UMR Prague meeting**

... see below 3-1-1-1 and 3-1-1-2

6) **proposal of the general Czech approach**

TO DO LATER, AFTER FINISHING ALL THE SUBPARTS BELOW

***

#### Part 3-1-1-1. Processes in predication 
Preparation: ML, 23/6/2023

1) **link to the guidelines**

https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-1-1-processes-in-predication

2) **American approach – summary in Czech**

Predicated processes are the most prototypical subcategory of events, corresponding cross-linguistically to unmarked verbs --> always identified as events

3) **our comments to the American approach**

What about auxiliary, modal and phase verbs? 

What about LVC (CPHR)

What about copula, existential "to be", ...?

4) **corresponding materials available on the Czech side** (corpora, dictionaries etc.)

- resources:
- - SynSemCLass (SSC) ... verbs
- - PDT-Vallex ... verbs not covered in SSC
- problems:
- - mapping of actants to AMR ARG labels 

*default*: mapping using simple table (2014 table should be updated);

*possible improvements*:<br>
(i) heuristics for individual groups of verbs (e.g., causative verbs), ...<br>
(ii) verb-specific mapping from SSC

- - mapping of free modifications to AMR non-core labels

default: mapping using simple table (2014 table should be updated)


5) **commentaries from the UMR Prague meeting**

    TO DO DURING THE MEETING
 
6) **proposal of the general Czech approach**

    TO DO DURING THE MEETING / LATER

***

#### Part 3-1-1-2. Processes in modification and reference
Preparation: ML, 23/6/2023

1) **link to the guidelines**

https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-1-2-processes-in-modification-and-reference

2) **American approach – summary in Czech**

**Processes** packaged as *modifiers* or *referents* should also be identified as events - various forms, such as:
- event nominals *The **storm** damaged the roads*, 
- non-finite complements *She wanted **to go** to school.*, 
- participles *The student **playing** the violin likes Bach*, or 
- relative clauses *The student, who is **playing** the violin, likes Bach*

3) **our comments to the American approach**

**Problem with nouns**: 

not clear how event nominals are defined ... (should be based on semantic type) ... BUT seems as not consistent in the guidelines examples:

   *The bus **driver** turned the corner too sharply.* ... bus driver as agent name (not process)

   vs. *The dog is the **teacher**'s.* ... teacher as ARG0-of teach-01, i.e., process (3-2-1-1-1 (1b))

   *The **final exam** began at 8:00* ... process

   vs. *One student threw their **final exam** in the trash.* ... physical object

**Problem with compounds**:

Participles (or other non-finite verb forms) are identified as events, unless they are part of a compound:

   ***floating** hospitals* ... event ... (I saw the floating hospitals --> the seer witnessed the floating event)

   ***firing** squad* ... not event (compound) ... even in the situation of no actual firing event

**Criterion for compounds**: the event described by the participle must be ongoing at the reference time


4) **corresponding materials available on the Czech side** (corpora, dictionaries etc.)
- dictionaries:
- - PDT-Vallex, Nom-Vallex ... only small number of frames, not systematic
- - the list from 2014:  doc\seznamy-a-poznamky-z-amr-prevodu\Silvie\verbalization_list.cs.txt (perhaps extracted from PDT with some heuristics - not clear :-((
- - the list of predicative nouns from VALLEX ... only those appearing in LVC
- - nouns with CPHR label from PDT ???
- corpora:
- - nouns in PDT without assigned valency frames (even in the case with actant modifiers, as in *prognóza ekonomiky*.PAT `the prognosis of economic') 

5) **commentaries from the UMR Prague meeting**

    TO DO DURING THE MEETING 

6) **proposal of the general Czech approach**

    TO DO DURING THE MEETING / LATER

***

#### Part 3-1-1-3. States and entities  (AND also Part 3-2-1-1-1 Non-verbal clauses)
Preparation: ML, 23/6/2023

1) **link to the guidelines** 

https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-1-3-states-and-entities

2) **American approach – summary in Czech**

!!! Anything that is **predicated** is identified as **an event, even if it is not a process** !!!

(**BUT:** States and entities in modification or reference packaging are not identified as events :-)

**Type A**: Statives are annotated in the same way as processes ... *My cat **loves** wet food*.

**Type B**: **non-verbal clauses** ... 4 semantic types distinguished

**Nine special abstract UMR Predicates**
- **possession**:  ‘thetic’ (have-91 ... *The teacher **has** a dog.*) or ‘all-new’ (predicational = belong-91 ... *The dog **is** the teacher's*.)
- **location**:  ‘thetic’ (exist-91 ... *On the rock **was** a symbol.*) or ‘all-new’ (have-location-91 ... *The symbol *was** on the rock.*)
- **property** (have-mod-91 ... *The cat **is** black.*
- **object**:  ‘predicational’ (ISA, part of a category of objects = have-role-91 ... *Panda **is** a cat.*) or  ‘equational’ (two referents are the same = identity-91 ... *Panda **is** my cat.*)

<div id="tab:nonverbal_arguments">

<table>  
<tr>  
<th>Clause Type</th>  
<th>Predicate</th>  
<th>ARG1</th>  
<th>ARG2</th>  
<th>ARG3</th>  
<th>ARG4</th>  
<th>ARG5</th>  
<th>Example</th>  
</tr>  
<tr>  
<td>Thetic Possession</td>  
<td>have-91</td>  
<td>possessor</td>  
<td>possessum</td>  
<td>---</td>  
<td>---</td>  
<td>---</td>  
<td>The teacher has a dog.</td>  
</tr>  
<tr>  
<td>Predicative Possession</td>  
<td>belong-91</td>  
<td>possessum</td>  
<td>possessor</td>  
<td>---</td>  
<td>---</td>  
<td>---</td>  
<td>The dog is the teacher's.</td>  
</tr>  
<tr>  
<td>Thetic Location</td>  
<td>exist-91</td>  
<td>location</td>  
<td>theme </td>  
<td>---</td>  
<td>---</td>  
<td>---</td>  
<td>On the rock was a symbol.</td>  
</tr> 
<tr>  
<td>Predicative Location</td>  
<td>have-location-91</td>  
<td>theme</td>  
<td>location</td>  
<td>---</td>  
<td>---</td>  
<td>---</td>  
<td>The symbol was on the rock.</td>  
</tr>  
<tr>  
<td>Property Predication</td>  
<td>have-mod-91</td>  
<td>theme</td>  
<td>property</td>  
<td>--- </td>  
<td>---</td>  
<td>---</td>  
<td>The cat is black.</td>  
</tr> 
<tr>  
<td rowspan="3">Object Predication</td>  
<td>have-role-91</td>  
<td>theme</td>  
<td>reference point</td>  
<td>object category, arg1</td>  
<td>object category, arg2</td>  
<td>---</td>  
<td>Panda is a cat.</td>  
</tr>  
<tr>  
<td>have-org-role-92</td>  
<td>theme</td>  
<td>organization</td>  
<td>title of role</td>  
<td>job description</td>  
<td>---</td>  
<td>???</td>  
</tr>  
<tr>  
<td>have-rel-role-92</td>  
<td>theme</td>  
<td>relative</td>  
<td>theme's role</td>  
<td>relative's role</td>  
<td>relationship basis</td>  
<td>???</td>  
</tr>  
<tr>  
<td>Equational</td>  
<td>identity-91</td>  
<td>theme</td>  
<td>equated referent</td>  
<td>---</td>  
<td>---</td>  
<td>---</td>  
<td>Panda is my cat.</td>  
</tr>  
</table>

Table 8: Argument structure of non-verbal clause predicates
</div>

**BUT NOT AS EVENTS**
- states in modification (*The tall man.*, *The man, who is tall...*), and 
- states in reference (*His happiness..*.),
- entities in modification (*The man, who is a doctor*),
- entities in reference (*The doctor*).

3) **our comments to the American approach**

Seems very complicated :-((

4) **corresponding materials available on the Czech side** (corpora, dictionaries etc.)

abstract predicates:

- ??? mapping valency frames from PDT-Vallex onto individual abstract predicates
- ??? mapping classes from SSC onto individual abstract predicates ... seems too sparse yet :-((
- ??? the list from 2014:  doc\seznamy-a-poznamky-z-amr-prevodu\Silvie\verbalization_list.cs.txt ... some nouns mapped onto LVC
- ??? LVCs from PDT-Vallex


5) **commentaries from the UMR Prague meeting**

    TO DO DURING THE MEETING
 
6) **proposal of the general Czech approach**

    TO DO DURING THE MEETING / LATER
 
***

#### Part 3-1-1-4. Implicit events 
Preparation: ML, 23/6/2023

1) **link to the guidelines**

https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-1-4-implicit-events

2) **American approach – summary in Czech**

Two types:
- **A.** the implicit event corresponds to an event mentioned earlier in the text … annotated as coreferential

    (1a) John was smoking on the corner of the street, but when he saw me, he stopped [**smoking**].

    (1b) They told me “a card was left on Tuesday” (no it wasn’t [**left**] of course)...

- **B.** the implicit event corresponds to an event NOT mentioned earlier in the text … they refer to generic events which can be filled in from context … the most abstract, least specific event should be identified

    (2a) Phoned Amtrak on Wednesday, [**they said**] “We need a consignment number”.

**rule**: be conservative – when in doubt, don’t add an implicit event

3) **our comments to the American approach**

Not clear to which extent type B can be identified (semi-)automatically ... example:

*I have ordered the Coast Guard and our entire naval force in the (Central Philippines) region [**to go**] to the area.*
 
4) **corresponding materials available on the Czech side** (corpora, dictionaries etc.)

- PDT: restored ellipses
- PDT: verbs of communication; direct or indirect speech (how annotated in PDT??)
- ???

5) **commentaries from the UMR Prague meeting**

    TO DO DURING THE MEETING

6) **proposal of the general Czech approach**

    TO DO DURING THE MEETING / LATER


***
***

### Part 3-1-2. Named entities


***
***

### Part 3-1-3. Concept-word mismatches
Preparation: ŠZ, 21/6/2023

1) **link to the guidelines**

https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-3-concept-word-mismatches

2) **American approach – summary in Czech**

Počet konceptů na slovo se může v různých jazycích lišit. Co nějaký exotický jazyk vyjadřuje jedním slovem, vyjadřuje angličtina více slovy. 
UMR nerozkládá vícekonceptová slova na morfémy, ale jako celek je vztahuje k více konceptům. 

3) **our comments to the American approach**

    TO DO LATER, AFTER FINISHING ALL THE SUBPARTS BELOW

how is “a word” understood in the UMR approach? 

_Possible problematic cases in Czech:_ 
  + analytic verbal forms, 
  + copula + nominal part of the predicate, 
  + phrasemes, 
  + composites (kolemjdoucí – kolem + jdoucí, lit. around + passing, i.e. passersby), 
  + words with clear semantic internal structure (leta-dlo: lit. fly-instrument, i.e. air plane)

4) **corresponding materials available on the Czech side** (corpora, dictionaries etc.)

-	František Čermák – analysis of phrasemes (many words, 1 concept) – theoretical description in the introduction to the Slovník české frazeologie a idiomatiky
-	Studies on composition (Nový encyklopedický slovník češtiny and their references)
-	Tectogrammatic manual – approach to the multi-word phrases: 
-	CPHR (compound predicates, složené predikáty: mít dojem – to have an 
impression)
-	DPHR (phraseme)
- … 

5) **commentaries from the UMR Prague meeting**

    TO DO DURING THE MEETING

6) **proposal of the general Czech approach**

    TO DO DURING THE MEETING / LATER



#### Part 3-1-3-1. Predicate and argument as one word 
Preparation: ŠZ, 21/6/2023

1) **link to the guidelines**

https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-3-1-predicate-and-argument-as-one-word

2) **American approach – summary in Czech**

Některé predikáty v sobě vyjadřují i argumenty, např. v jazyce Arapaho jeden slovesný tvar znamená “uřízl jsem mu hlavu nožem”, ve slovesu je tak inkorporována i hlava, i aktor, i nůž atd.

Takové argumenty, i když nejsou vyjádřeny třeba dalším zájmenem ve větě, se anotují jako argumenty slovesa (s konceptem named entity, zde třeba person nebo thing).
V tomto případě se tedy anotuje oddělený koncept „hlava“, protože je plně integrován do tvaru slovesa.

Jindy nejde o tak pevné vazby. Ve slovese je pouze obecný odkaz na argument (verbal classifier), argument sám je pak vyjádřen zvlášť plnou NP. V tom případě se nezavádí zvláštní koncept pro argument inkorporovaný ve slovese, ale zavádí se participant pro vyjádřenou NP.

Proto je potřeba se v každém jazyce u každého typu inkorporace předem rozhodnout, jestli se bude anotovat jako argument u slovesa, nebo jako NP zvlášť. 

Řešení UMR:

TYP KONSTRUKCE: PRONOMINÁLNÍ AFIXY
* Definice: Slovesné afixy vyjadřující osobu / číslo argumentů
* Anotace UMR: Pokud je koreferenční s povrchově vyjádřenou NP: neanotujeme.
Pokud není NP vyjádřena: anotujeme jako argument s konceptem relevantní named entity.

TYP KONSTRUKCE: INKORPOROVANÁ SUBSTANTIVA
* Definice:Ve větě se nemůže vyskytnout NP koreferenční s inkorporovaným subst.
* Anotace UMR:Anotujeme zvláštní koncept pro inkorporované subst. jako argument. 

TYP KONSTRUKCE: VERBAL CLASSIFIER (tj. obecné subst. coby odkaz na argument inkorporovaný ve slovese)
* Definice: Ve větě se může vyskytnout NP, která specifikuje typ obejktu vyjádřený inkorporovaným substantivem
* Anotace UMR:Neanotujeme zvláštní koncept pro inkorporované subst. 


3) **our comments to the American approach**

possible parallels in Czech:
- pronominal affixes: 
- - pro-droped subjects. Person and number expressed at all VFs 
- - number and gender expressed at all verbal forms including any participle (n, t, l, s, nt – viděn, bit, viděl, viděv, vida). The UMR annotation is similar to the PDT reconstruction of ellipses. (*Doporučil mu být slyšen.* *He recommended him to be heard*.MASC.ANIM.SG.)
- incorporated nouns: what about words like *okotit se* (give birth to kitten – kotě), where the noun is a root of the word? Is this a case of an incorporated noun? – general question: _borders of the word formation and concepts_
- Verbal classifier: no parallels in Czech with nouns (?)
- BUT: generally: this chapter speaks of verbs and nominal expressions (NPs) only. What about verbs and prefixes/adverbs? Is it the same case of “Predicate and argument as one word”? E.g., *vy-jít*, lit. *out-go* (*go ou*t) which could be understood as a verbal classifier, even with the double expression (prefix – full adverb): *vy-jít ven* (*out-go outside*), *ve-jít dovnitř* (*in-go inside*). Such double expressions are possible with direct meanings of the verbs, but impossible with metaphorical meanings (* *vy-jít ven z předpokladu, že…*, lit. * *out-go outside from the assumption that…*; En: *on the assumption that*) 


4) **corresponding materials available on the Czech side** (corpora, dictionaries etc.)

-	tectogrammatic layer in the PDT – reconstruction of elided arguments


5) **commentaries from the UMR Prague meeting**

    TO DO DURING THE MEETING

6) **proposal of the general Czech approach**

    TO DO LDURING THE MEETING / LATER
 

#### Part 3-1-3-2. Valency-changing operations
Preparation: ŠZ, 22/06/2023
 
1) **link to the guidelines**

https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-3-2-Valency-changing-operations

2) **American approach – summary in Czech**

Operace, které mění valenci: např. 
-	kauzativa (působit, aby se něco stalo – věšet – působit, aby něco viselo), 
-	aplikativa (naložit vůz hnojem, z původního naložit hnůj na vůz), 
-	reflexiva (oblékat se) 

(význam termínů a příklady dohledány jinde)

U těchto konstrukcí jsou dva koncepty buď ve dvou slovech (I **made** him **eat**), nebo v jednom (totéž v jazyce Sanapaná; ŠZ: č. příklad *rozplakat někoho*). Aby bylo možné rozhodnout, jestli jde o jeden koncept, nebo dva, používá se test s negací, a to takto:

*Grandmother made the kid drink water.* ... Made drink – 1 koncept, nebo 2?

Test s negací:

*Grandmother did **not mak**e the kid drink water.*

*Grandmother made the kid **not drink** the water.*

Negace na dvou místech, tudíž:... Dva koncepty, „cause“-event a „drink“-event 

**Protipříklad – 1 koncept**

Jazyk Kukama – sloveso *kurata-ta* (přinutit_pít) ... 1 koncept, nebo 2?

Test s negací: ne-přinutit_pít. 

Nelze negovat jen 1 vybraný děj, proto je to v tomto jazyce chápáno jako 1 děj dohromady, proto 1 koncept (*přinutit_pí*t).

ŠZ: totéž české sloveso *rozplakat někoho*

Řešení UMR:

EVENT A KATEGORIE MĚNÍCÍ VALENCI MOHOU BÝT NEGOVÁNY NEZÁVISLE
* Identifikujeme je a anotujeme jako zvláštní eventy, 
* Uveden příklad: za slovesem se anotuje :cause, v jeho rámci :actor

POKUD NEMOHOU...
* Identifikujeme 1 event, 
* Uveden příklad: za slovesem se anotuje rovnou :causer, potom :actor

3) **our comments to the American approach**

-	are there any other valency-changing categories?
-	Are reflexives a valency-changing caagory in Czech? 
-	Two kinds of valency-changing constructions in Czech – causatives 
- -	One-word constructions: *rozplakat* (to make cry), *pověsit* (to hang something somewhere)
- -	Two-words constructions (?): *donutit zametat* (to force to sweep) – ŠZ: to je asi něco jiného, nebo ne?

4) **corresponding materials available on the Czech side** (corpora, dictionaries etc.)

-	nesting of verbs on dictionaries – Vallex? SynSemclass?

5) **commentaries from the UMR Prague meeting**

    TO DO DURING THE MEETING
 
6) **proposal of the general Czech approach**

    TO DO DURING THE MEETING / LATER