# Specific verbal constructions and their rolesets

UMR, following AMR, represents some verbal constructions in a different way than we are used to in PDT-like annotations. 

- PDT distinguish 
  - lexical verbs (= autosemantic verbs as  action verbs like _jít, dělat, snídat, měnit_ but also phase verbs like _začít, skončit_ combined with infinite verbs (_Začal pracovat._) and copula _být_ (_Petr je doktor / chytrý._, _Jan bývá často nemocný._)) represented as t-nodes and 
  - auxiliary verbs (= synsemantic units, esp. auxiliary _být_, but also modal verbs like _muset, chtít_) represented as  attributes of respective t-nodes. 

- In UMR, there are also two types of "predicates" in UMR: 
  - those headed by "lexical" predicates (corresponding to particular verbs and their rolesets, as defined in PropBank) and 
  - sthose referred to as "abstract rolesets" of different types, which are meant to annotate the crosslinguistically stable meanings. 

However, they differ in distinction what should be considered a single event and what are two events (annotated as two verbs).

---

## Autosemantic _být_ (incl. copula verbs)

PDT distinguishes several types of constructions with _být_ "to be":
1. existential _být_,
2. substitute _být_, 
3. copula _být_, 
4. phrasal _být_, and
5. _být_ in constructions with a single constituent.

All of them are treated as lexical verbs in PDT and they should also be treated as a (single) eventive concepts in UMR.

#### 1. Existential _být_ 

**Existential** _být_ is designated as meaning that "something is/is not, exists/does not exist", as:  
 * [cs] _Strašidla.ACT na světě nejsou._   
        "There are no ghosts in the world." (PDT manual).  
 
It should correspond to `být-011` in PDT-Vallex.

See also [existential `be-02` in PropBank](https://verbs.colorado.edu/propbank-development/be.html).  

In UMR,  thetic location `exist-91` or  presentational location `have-place-91` are probably the best fit for the existential _být_.
 * [cs] _V pohádkách jsou různá strašidla.ACT._  ... ?? `exist-91` (thetic location)
 * [cs] _Strašidla.ACT jsou jen v pohádkách._ ... ?? `have-place-91` (predicative location) 


#### 2. Substitute _být_

**Substitute** _být_ stands for some full verb which can be substituted for it;    

- Typically, it is characterized by a valency frame with just `ACT`, possibly complemented with an optional free modification, as:  
       _Jirka je na zahradě.LOC_ "George is in the garden." (= George is located/appears in the garden)  

This type should correspond to `být-011` in PDT-Vallex (i.e., existential and substitute _být_ is not distinguished in PDT-Vallex).  

As for UMR, different types of UMR abstract predicates, other -91 substitutes, or even full verb predicates should be used. 

 * [cs] Jirka je na zahradě.LOC   "George is in the garden." ... ?? `have-place-91` (predicative location) 
 * [cs] Úkol byl na pátek.TOWH   "The assignment was for Friday." ...`???`
 * [cs] To je pro mě.BEN   "That is for me." ... `???`
 * [cs] Je pozdě. TWHEN cokoliv dělat. "It is too late to do anything." ...`???`
 * [cs] Vystoupení bude bez ohledu na počasí.REG "The performance will take place regardless of the weather." ...`???`
 * [cs] Zájezd byl prostřednictvím kanceláře.MEANS "The excursion was arranged by the office." ... `???`
 * [cs] To bylo schválně.CAUS "That was on purpose." ...`???`
 * [cs] To bylo o chlup.DIFF "That was close." ...`???`
 * [cs] Chaloupka je jako dlaň.CPR "The cottage is tiny." ... `have-mod-91`
 * [cs] Tento nástroj je na stáčení. AIM vína. "This instrument is for bottling wine." ...`???`
 * [cs] Byli jsme to obhlížet.INTT "We have been to inspect it." ...`???`
 * [cs] Zahrada je souseda.APP "The garden is the neighbour's." ...`???`

Rarely, valency frames with two (or more) arguments come into play, as in:  
* [cs]  _Rukavice.ACT mu.PAT nejsou._ "The gloves do not fit him."  ...`???`


#### 3. Copula verb

**Copula** verb as a part of verbonominal predicate, i.e. predicate constituted of: 

- a verbal part (_být, bývat, stát se, stávat se_, as _Stal se učitelem._"He became a teacher." and 

- a non-verbal part
     - typically a semantic adjective or a noun in the nominative or the instrumental, as:  
        _Kočka je savec.PAT._ "The cat is a mammal." -->  `have-mod-91`  
        _Jirka je hodný.PAT._ "George is good."  `have-mod-91`  
        _Dětí je pět.PAT_ "There are five children."  --> `have-quant-91`  
     - also a noun in the genitive, an infinitive, a dependent clause, an adverb or an interjection, as 
        _Je vidět.PAT Sněžka._ "Sněžka can be seen." -->  `??`    
        _Končit není umřít.PAT_ "To finish is not to die."  -->  `??  
        _Jeho výklad je, že zahrají.PAT_ "According to him, they will play."  
        _To je moc.PAT_ "That is too much."  --> `have-quant-91`     
        _To je fuk.PAT_ "That doesn't matter. -->  `??`    
     - a subtype with a noun or an adjective with modal meaning are also treated verbonominal predicates, like:  
         _být schopný.PAT_ (=to be capable), _být možné.PAT_ (=to be possible), _být povinností.PAT_ (=to be an obligation)  -->  `??`     

Copula verb _být_ corresponds to the `být-007` roleset (with 2 arguments, `ACT` and `PAT`).

See also [copula `be-01` in PropBank](https://verbs.colorado.edu/propbank-development/be.html).  

According to the UD guidelines:
> The copula verb _být_ "be" is used in equational, attributional, locative, possessive and benefactory nonverbal clauses. Purely existential clauses (without indicating location) use _být_ as well but it is treated as the head of the clause and tagged VERB.

The copula _být_ should correspond to `být-007` in PDT-Vallex.
However, this frame is assigned also to constructions with location meaning (e.g., _Jiřinka je tady, ta s tou tmavší mašlí_ `Jiřinka is here, the one with the darker bow' [= a comment on the photo]). 


#### 4. Phraseological _být_ 

These constructions are characterized by the `DPHR` functor in its valency frame.


#### 5.  _Být_ in constructions with a single constituent
 
- impersonal constructions ... `být-017` _je horko_ "It is hot."  -->  `??`     
- constructions of experience (with ACTor in dative) ... `být-009` _je mi horko_  -->  `??`    

---

## Temporal and modal auxiliaries - a single event

Czech is an inflective language so analytical verb forms are not so frequent as in English. However, auxiliaries are still used to create some verb forms, as simple past tense (just 1st and 2nd person) _Přišel jsem._ "I came." or future tense _Budu teprve obědvat_. "I'll have lunch only now." (imperfective verbs).

#### Temporal auxiliaries

In PDT, the following verbs are treated as (temporal) auxiliaries:
- _být_ "be" 
- in diatheses, also _mít_ "have" (resultative diathesis) and _dostat_ "get" (recipient diathesis) are used.

As a consequence, these verbs are not treated as separate t-nodes - instead, they contribute to values of selected grammatemes (esp. the grammatemes of tense, diatgram, and factual modality (condition).  

The treatment of temporal auxiliaries in UMR is similar: they are not identified independently as events - instead, they are treated within temporal dependency annotation, as in _She has gone/is going to school._ (treated as on going event). 

#### Modal auxiliaries

##### Modal auxiliaries in PDT
In PDT, modal auxiliaries are covered by the deontmod grammateme with the following values:
- deb (debitive) the event is understood as "necessary" ... _muset_ "must, have to",
- hrt (hortative) the event is understood as "obligatory (an obligation)" ... _mít_"be supposed to",
- vol (volitive) the event is understood as "wanted/intended" ... _chtít_"want", _hodlat_ "intent",
- poss (possibilitive) the event is understood as "possible" ... _moci_, _dát se_ "can, be possible",
- perm (permissive) the event is understood as "permitted" ... _smět_ "be allowed to",
- fac (facultative) the event is understood as "an ability (to do sth)" ... _umět_, _dovést_ "can, be able, ?could",
- decl (declarative) basic (unmarked) modality.


##### Modal auxiliaries in UMR

UMR treats modal auxiliaries in a similar way as temporal ones, they inform the modal dependency annotation (and are not identified as separate events), thus _He might/should go to school._ is identified as a single event.  

However, the class of English "true modal auxiliaries" is different - it comprises the following verbs, based on [4-3-2](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-4-3-2-english-modals):
- no modal verb, declarative sentences (also _will_, non-intentional _be going to_) 
-  strong epistemic modals: _must_, _have to_, also _should_, _ought to_, _need_
-  weak epistemic modals: _may_, _might_, ??_shall_, ??_would_  --> neutral affirmative

Comparing the two approaches, we can conclude that the modal verbs are treated in PDT and UMR  (more-or-less) in the same way. The only exception represents 

- vol (volitive) modals ... _chtít_"want", _hodlat_ "intent"

which are treated as semi-modals in UMR.


<!-- AMR represents syntactic modals with concepts like the following ones: `possible-01`
 [en] _The boy can go. -> It is possible that the boy goes._  
 [en] _It may rain. / It might rain. -> Rain is possible. / It’s possible that it will rain._  
`likely-01`   
 [en] _The boy is likely to go. -> It is likely that the boy will go._  
`obligate-01`  
 [en] _The boy must go. -> The boy is obligated to go. / It is obligatory that the boy go._  
`permit-01`  
 [en] _The boy may go. -> The boy is permitted to go. / It is permissible that the boy go._  
`recommend-01`  
 [en] _The boy should go. -> It is recommended that the boy go._  
`prefer-01`  
 [en] _The boy would rather go. -> The boy prefers to go._  
??? `use-02`  
 [en] _I am used to working._  
etc.: -->

## TODO Semi-modal verbs - separate events in UMR 

According to [Part 3-1-3-3. TAM categories](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#Part-3-1-3-3-TAM-categories), and [Part 3-3-1-3. State](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-1-3-state)  verbs like  _want_ , _need_, and _dread_ are categorized as semi-modal.

These verbs are annotated as separate events, they take an infinitive verb as a complement (i.e., an autosemantic verb is annotated as its child, :ARG1 in case of _want_ in the following example). In addition, `:modal-predicate` relation should be annotated between the semi-modal and the complement.  

```
(w/ want-01
    :ARG0 (p/ person
    	:refer-person 3rd
	:refer-number singular)
    :ARG1 (g/ go-01
    	:ARG1 p
        :ARG4 (s/ school)
        :aspect performance
	**:modal-predicate w)**
    :aspect state
    :modal-strength full-affirmative)
```

This `:modal-predicate` relation is applied also for other verbs with an infinitive complement, see the following example: 

```
I saw him knock on the door.

(s1s/ see-01
	:ARG0 (s1p/ person
		:refer-person 1st
		:refer-number singular)
	:ARG1 (s1k/ knock-01
		:ARG0 (s1p2/ person
			:refer-person 3rd
			:refer-number singular)
		:ARG1 (s1d/ door
			:refer-number singular))
		:aspect performance
		**:modal-predicate s1s)**
	:aspect state
	:modal-strength full-affirmative)

(s/ sentence
	:temporal ((past-reference :contained s1s)
		 (s1s :overlap s1k)))
```
 
The following types are  also considered as semimodals in some sources: 
- desideratives ('want to') 
- conatives ('try to')
- optatives ('wish that'), and 
- frustratives ('fail to')

ŠZ: just one semantic concept consisting of two words (want to go) (?) - based on the test of negation, similar to  Valency-changing operations (?), (https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-3-2-Valency-changing-operations)

!! ASI nechat jako pomocná podle PDT, když to může být language specific !!!  
POZOR … pokud v PDT jako plnovýznamové, směr závislosti???   
o	PDT: něco přislíbit nemůže (tj. řídící infinitive, závislé modální ve fokusu)  
o	UMR: “hlavní” predikát non-finite She wants to go to school … jak vytipovat ???



---

## Phasal aspectual meaning - one event with aspect attribute label

Phasal aspectual meanings such as  
- `inchoative` (denoting an aspect of a verb expressing the beginning of an action, typically one occurring of its own accord), 
- `completive` (adds a sense of completeness to a word or phrase (e.g. in the phrase _break up_,  _up_ is a completive)), and 
- `continuative` (relating to the durative aspect or a durative verb or verb form, i.e.,  that expresses action continuing unbroken for a period of time),
  
are **never identified as separate events**, even if they are expressed through independent words. Instead, they will simply inform **the aspect attribute label of the event** they modify [Part 3-3-1. Aspect] (https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-1-Aspect)

```
ce	əsi	mu-re
paper	this	black-change (Manipuri)
'This paper has become black.'
(h/ have-mod-91					(h/ have-mod-91
    :ARG1 (c/ ce 'paper')			    :ARG1 (p/ paper)
    	:mod (s/ əsi 'this')			        :mod (t/ this)
    :ARG2 (m/ mu 'black')			    :ARG2 (b/ black)
    :aspect Performance)			    :aspect Performance)
```


Possible UMR Aspect values at the **default level** of granularity include:   
`Activity` - process that does not end,  
`Habitual` - occurs/occurred usually or habitually,  
`State` - unspecified type of state,  
`Endeavor` - process that ends without reaching a result state,  
`Performance` - process that ends and reaches a result state.  

Further, `Process` value is used for event nominals.

### Phasal verbs in English

The UMR Guidelines provides several examples with phasal verbs in Part 3 with sentence -level annotation. However, the document-level annotation is not described there  :-((   
 
According to [Part 3-3-1-4 Aspect/Activity](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-1-4-activity), thus the following sentences will have same sentence-level annotation (regardless the phase verbs):
* [en] _He is playing the violin._  3-3-1-4 (2) 
* [en] _He started playing the violin._ 3-3-1-4 (3a) 
* [en] _He kept on playing the violin._ 3-3-1-4 (3b) 

```
He started playing the violin.
(p/ play-01
	:ARG0 (p2/ person
		:ref-person 3rd
		:ref-number Singular)
	:ARG2 (v/ violin)
	:aspect Activity
	:modstr FullAff)
```

The UMR Guidelines do not provide a list of English phasal verbs.  
(AMR does not elaborate this phenomenon.) 
 
### Phasal verbs in Czech

Mluvnice 3 ... nic :-((

Čas a modalita v češtině ??? 

In PDT, phasal verbs are conceived as lexical words (= autosemantics), thus they are represented as separate nodes in t-trees. 
 
Criteria for distinguishing phasal verbs in Czech [NESČ, Fázové sloveso](https://www.czechency.org/slovnik/F%C3%81ZOV%C3%89%20SLOVESO):  
(a) phasal meaning  
(b) phasal verb combines with infinitives (c) of imperfective verbs (no other forms!)  

NESČ lists the following verbs (not necessarily exhaustive):  
**inceptives**: _jmout se_, _začínat - začít_  
**terminatives**: _přestávat - přestat_  
**continuatives**: _zůstávat - zůstat_  

<!--([Slovesa fázová](https://www.cestinadoma.cz/ucivo/slovesa-fazova-a-modalni) the same list)-->

VALLEX provides a bit broader set of verbs (class of phase verbs / phase of action, both limited to those with an infinitive complementation):   
**inceptives**: _jmout se_, _počínat - počít_, _začínat - začít_, _započít_  
**terminatives**: _přestávat - přestat_, _ustávat - ustat_  
**continuatives**: _zůstávat - zůstat_  

<!-- VALLEX: problém s (b): infinitiv alternující s dalšími formami:   
počínat-počít, začínat-začít, započít ... 4,s+7,inf  
přestávat-přestat ... s+7,inf; ustávat1-ustat ... s+7,v+6,inf 
NE vrhat_se - vrhnout_se (nesplněné b, do+2,na+4,inf)-->

When these verbs combines with infinitives, they should NOT be identified as separate events (based on examples 3-3-1-4 (2) and 3-3-1-4 (3a), (3b)).  
Instead, they will be represented at the document level -- HOW? 
The Guidelines does not describe their treatment (unless I missed something important)! -->



### MOVE TO MODAL DEPENDENCY ANNOTATION 
UMR … modal dependencies moved to document-level annotation … esp. possible-01, obligate-01
[Part 3-1-3-3. TAM categories](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#Part-3-1-3-3-TAM-categories)

* [en] _The boy can go._, example 2 (2b)
```
(g/ go-01  
    :ARG0 (b/ boy
    	:ref-number Singular)
    :aspect State
    :modstr NeutAff)

(s0/sentence
  :modal (AUTH :NEUT s0g))
```  


The presence of modal verbs (or other verbs or expressions) also informs the attribute of epistemic strength `:modstr`and `:modpred`.
As for `:modstr`
- no modal verb; certainly, be sure, definitely, necessarily   
 -> `:modstr` FullAff / FullNeg   
 (complete certainty that the event occurs / does not occur )
- must/must have, have to, expect that, deduce; probably, likely; ...;   
 -> `:modstr` PartAff or PartNeg   
 (there is strong, but not definitive certainty that the event occurs / does not occur)
- can, may, might, possibly, likely  
 -> `:modstr` NeutAff or NeutNeg (there is neutral certainty that the event occurs / does not occur; event is expressed positively / negation of event is expressed)








