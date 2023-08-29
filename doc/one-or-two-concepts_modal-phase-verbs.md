# One or two concepts?


## TODO Copula verbs - one event
**Slovesa sponová** (podle https://www.cestinadoma.cz/ucivo/slovesa-fazova-a-modalni)
být, bývat, stát se, stávat se (např. stal se učitelem)

**verbonominal predicates**

**non-verbal clauses**


## TODO temporal aux. … (pomocná have, be) jako atribut … OK, jako PDT


## TODO Modal verbs - one event

AMR represents syntactic modals with concepts like the following ones:  

`possible-01`
* [en] _The boy can go. --> It is possible that the boy goes._  
```
(p / possible-01
   :ARG1 (g / go-02
           :ARG0 (b / boy)))
```

* [en] _It may rain. / It might rain. --> Rain is possible. / It’s possible that it will rain._  
`likely-01`   
* [en] _The boy is likely to go. --> It is likely that the boy will go._  
`obligate-01`  
* [en] _The boy must go. --> The boy is obligated to go. / It is obligatory that the boy go._  
`permit-01`  
* [en] _The boy may go. --> The boy is permitted to go. / It is permissible that the boy go._  
`recommend-01`  
* [en] _The boy should go. --> It is recommended that the boy go._  
`prefer-01`  
* [en] _The boy would rather go. --> The boy prefers to go._  
??? `use-02`  
* [en] _I am used to working._  
etc.:

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


??? (might, should) jako atribut … OK, jako PDT

… podle gramatému deontmod (??? příp. omezit na muset, moci, mít, smět)
test negace, ALE: nesmím přijít – smím nepřijít


**Slovesa modální** (s infinitivem) (podle https://www.cestinadoma.cz/ucivo/slovesa-fazova-a-modalni)
moci, smět, muset, chtít, mít (ve smyslu mít povinnost) (např. musíme studovat)

ŠZ: just one semantic concept consisting of two words (want to go) (?) - based on the test of negation, similar to   Valency-changing operations (?), (https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-3-2-Valency-changing-operations)

 ML: According to [Part 3-1-3-3. TAM categories](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#Part-3-1-3-3-TAM-categories), _want_ is considered as a semi-modal concept and the fact that it can be modalized independently of the "go"-event on English indicates that desires are construed as independent events (in English), thus considered as independent events.
 This may be language-internal characteristics.

---

## TODO Semimodal verbs - one event or two events<

semi-modal:	… podle gramatému deontmod  
- desideratives (want to) … 2 koncepty v Eng
- conatives ('try to')
- optatives ('wish that'), and 
- frustratives ('fail to')
!! ASI nechat jako pomocná podle PDT, když to může být language specific !!!  
POZOR … pokud v PDT jako plnovýznamové, směr závislosti???   
o	PDT: něco přislíbit nemůže (tj. řídíví infinitive, závislé modální ve fokusu)  
o	UMR: “hlavní” predikát non-finite She wants to go to school … jak vytipovat ???


## Phasal aspect - one event with aspect attribute label indicating phasal meaning

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


Possible UMR Aspect values at the default level of granularity include:   
`Activity` - process that does not end,  
`Habitual` - occurs/occurred usually or habitually,  
`State` - unspecified type of state,  
`Endeavor` - process that ends without reaching a result state,  
`Performance` - process that ends and reaches a result state.  

### Aspect - conversion from PDT
As for available resources for Czech:
1) The PDT **grammateme for aspect** should be used. However, only 2 types are recognized (based on the morphological dictionary): 
- cpl=complex for perfective verbs --> TODO ??? `Perfective`, i.e., process that comes to an end (includes `Endeavor` and `Performance`),
- proc=procesual for imperfective verbs --> TODO ??? `Imperfective`, which is ambiguous between `State` and `Atelic process` (which includes `Activity` and `Endeavor`)
2) Further, the **diat grammateme** (for diathesis), value resultative should indicate the process that ends and reaches a result state, i.e. `Performance`.


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
The Guidelines does not describe their treatment (unless I missed something important)!








