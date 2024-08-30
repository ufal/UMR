# PDT to UMR ... sentence level

## 1 Graph structure
1. **Základní pravidlo ... for each non-root node  (ITAT sect. 3.1)**: 	
   - retain the node with its id = variable (= a particular instance of some concept from the lexicon/ontology)
   - create a new node for lexical content = concept, which stands for  
   (based on Banarescu et al. 2013, \cite{amr-for-sembankimg-2013}):
      - **entity** (e.g., _man_)
      - **event** (e.g., _taste-04_) ... but also "abstract / non-verbal predicates" (now "non-prototypical pred rolesets" in the [UMR lists](https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit?gid=1927108453#gid=1927108453))
      - **keyword** for:
          - "entities" (e.g.,  `ordinal-entity` (_for the first time_)),
          - "quantities" (e.g., `temporal-quantity` (_8 months_)),
          - logical conjunctions (_and_) ... the same for "discourse rolesets" from the [UMR lists](https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit?gid=1927108453#gid=1927108453)   
            other paratactic structures **???**
          - **???** ALSO operators,  e.g., `more-than` 
   - ??? ZÁDRHELE ???


1. **Pořadí uzlů ... zachovat z PDT / z anotace ve vstupním souboru**   
Zatím asi má každý rodič má syny v opačném pořadí, než by měl mít :-))  
Zobrazovadlo, které dělal Míša, se nějak drželo povrchu (nejlevější alignované slovo?) - aby se to aspoň zhruba dalo porovnat.  
V PDT - pokud tomu dobře rozumím - se pořadí uzlů oproti povrchu mění: 
   - kvůli projektivitě 
   - jinak jen u "NB" uzlů, pokud je to relevantní z hlediska výpovědní dynamičnosti.
   - Kopírované uzly se dávají jako nejlevější děti, myslím?



1. **Má-li uzel 2 rodiče, struktura zůstane jako v anotaci / PDT**:  
 (Když je hodnota jméno proměnné, je to šipka, jinak je to uzel.)  
~~Jak se pozná typ šipky (tj. relace = typ hrany)?~~


1. **Nodes with a coreferential link** within a sentence  should **be merged** ... see also Sect. I.4 ``Further Structural Changes'' below.      
~~Jak se pozná typ šipky (tj. relace = typ hrany)?~~


1. **Abstraktní koncepty a strukturovaný text:**   ... zatím neřešeno!!   
UMR má řadu abstraktních konceptů pro zachycení strukturovaného textu (typu den v týdnu, množství čehosi, adresa See below, Sect. 6


1. **Named entities** (NE(s)), its type (= the abstract entity, as, e.g.,  `person`)  serves as the concept; it is instantiated using a variable (as for other concepts).   
NEs have their internal structure (esp. wiki, name)   
--> **suggestion: not now** (one of future necessary steps, I.5 below) 

1. **Named Entities**  ... see below (Sect. 5) 


1. **Jména relací (= hrany) mají začínat vždy dvojtečkou**?   
Trochu jsme si na to zvykli a věřím, že i ostatní, ostatně guidelines i tabulka UMR lists dvojtečku na začátek dávají.  
(Ignoruj tenhle návrh, jestli to má nějaké technické problémy.)


### Koordinace / apozice

Koordinace jsou v UMR v zásadě stejně jako v PDT - typicky se tam přidá uzel pro spojku a pod něj
- buď hrany op1, op2, ... (pro konjunkci (and), disjunkci (or) a další vztahy, které jsou považované za symetrické)


```
Pope was convinced last week and sentenced to...
(a / and
   :op1 (c / convict ...)
   :op2 (s / sentence ...)
)
```

- nebo ARG1 a ARG2 (pokud jsou asymetrické a je jasné, že třeba něco je příčina a něco následek apod.; ale i but-91)

```
Peter is diligent, but [contrast] Vanja is lazy.
(c / contrast-91
   :ARG1 ("be diligent")
   :ARG2 ("be lazy")
)
```

**ALE1:** Je v tom binec, třeba "but" se někdy přepisuje na contrast-01 (tedy jde o predikaci) a má argumenty, jindy je to diskurzní spojka a má opx.)

**ALE2:** Anotátor si může vybrat, jestli
- něco chápe např. jako podmínku (a pak je to prostě zanořené do stromu relací :condition)
- zachytí to pomocí predikátu, např. tedy have-condition-91 (s argumenty ARG1 pro tu událost hlavní věty a ARG2 pro tu podmínku)
- použije někderý z diskurzních implicitních rolí (aha, to je tedy asi také :condition, takže nevím, jak to rozliším)

**ALE3:** Anotátor může prostě připojit 2 totožné relace k témuž rodiči (tj. zapomenout, že to je asi nějaký koordinační vztah)

```
Pope who was convinced last week and sentenced to ... is a businessman
(i / identity-91
   :ARG1 (p / person ...
                :ARG1-of (c / convinct ...)
                :ARG1-of (s / sentence ...)
   :ARG2 (b / businessman)
)
```


> **Předběžný závěr:**
> 1) Mít dvě totožné relace připojené k rodiči možná přichází v úvahu pro apozice - prostě by se zapomněl ten apoziční uzel???
> 2) Jinak bych trvala na tom, že když je v PDT něco koordinace, tak to převedeme pomocí diskurzní relace (případně pomocí vhodného predikátu) - tedy budeme mít uzel pro spojovací výraz (ať už je to co to je). Aspoň než budeme vědět, že to neumíme udělat kvůli tomu, že máme společné rozvitá apod.

Dává to smysl?


---


## 2 Content words --> Events

### 2.0 Events vs. entities

Consequences of being designated an ‘event’ in UMR - see [the summary here](..\doc\eventive-concepts.md):
 events should get:
- the **aspect annotation** (at the sentence level)
- the **modal-strength (= epistamic modality) annotation** (originally both at the sentence level AND the documentation level (more detailed), newly removed from the sentence level) 
- the **temporal annotation** (at the document level)

#### Events
For Czech, events should be finally anchored in SSC; for the time being, we use verb-specific mapping via SSC and EngVallex (whenever available) and the default mapping (for other verb senses), as discussed in Sect. I.3 below.

[The summary](..\doc\eventive-concepts.md) mentioned above set tentative rules for distinguishing events (vs. non-events), 
1. **lexical verbs**:
   - action and stative verbs are treated in the same way --> **events**
2. **abstract rolesets** from [the UMR lists](https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit?gid=1927108453#gid=1927108453) ... see below (Sect. 3.6 and 3.7)
 
#### Entities
For Czech, entities should be finally anchored in wikidata whenever possible (the most specific wikidata item should be used in case of several possibilities).


ITAT, Sect. 3.2.3:
UMR employs a set of **abstract entities identifying entity types**. 
They serve several purposes:
1. They stand for **arguments** in case of not overtly present arguments (or arguments present just as pronouns).
2. They are used for **classification of named entities** (e.g., _Lennart Meri_ is classified as a person), see Sect. 5 below.
3. They provide an **identification of structured data** as 
   - special “entities” (as, e.g., date-entity, further structured with attributes like day, month, year, century, etc.) or 
   - “quantities” (as, e.g., monetary-quantity, temporal-quantity-quantity, both
with the attributes quant and unit).  
See Sect. 6 below.


### 2.1 Nouns that should be converted to verbal predicates

#### -ní/-tí deverbal nouns ... 1,690 such nouns are identified in PDT-Vallex

**Step 1.** Identify the relevant verb lexeme!  
Sources:  
   - **PDT-Vallex**, 
   - **MorfFlex**, 
   - **Derinet**   
--> Only for 15 nouns source verb NOT identified!
   - another resource: **SynSemClass** ... Eva Fučíková should know more about nominalizations

**Step 2.** Identify the relevant valency frame / list of arguments ... see below Sect. 1.3  
(See also Sect. I.4 ``Coreference: Inverse roles for nominalizations'' below.)


**PROBLEM:**
**Either more than one OR no verbal valency frame as a possible base frame**  
JŠ: Email from July 15, 2024 ... (without forms)
- almost 30% without valency frames
- almost 50% with a single valency frame
- almost 25% with more frames   
?? A kdyby se zohlednily formy:
- nom --> gen, poss, instr, od+2
- acc --> gen, poss, instr, od+2
- ostatní formy by měly zůstat beze změny, příp. může nějaká u substantiva chybět či naopak přebývat.

 

#### TODO: Agent nouns

#### TODO: Other deverbal nouns

### 2.2 TODO: Adjectives ... NOT now

### 2.3 TODO: Adverbs ... NOT now


---


## 3 Valency frames (actants and free modifications) --> Rolesets (arguments and adjuncts)


### 3.1 Core argument structure

#### Verb frames (senses) with mappings via SSC, EngVallex 
- verb/frame-specific mapping [Google sheet](https://docs.google.com/spreadsheets/d/1lVo7a8hPBReI4VrgNkUGem8uC_sCQCXJJvLFCbwPuok/edit#gid=1270330829)


**PROBLEM:**   
**A single valency frame belonging to two (or more) classes with different mappings**    
JŠ: e-mail from May 9, 2024 ... about 25 valency frames


#### Default mappings (verb non-specific)
- [Deault table](https://github.com/ufal/UMR/blob/main/tecto2umr/dafault-functors-to-umrlabels.txt) for cases without verb/frame-specific mappings
  - as for actants, ONLY the following 3 should be converted in this way 
    - `ACT` (--> `ARG0`), 
    - `PAT` (--> `ARG1`), and  
    - `ADDR` (--> `ARG2`) 
  - for the rest two, ``non-lexicalized'' roles would rather be used (see the ITAT paper): 
    - `ORIG` --> `Source` ('entity from which the theme detaches', as in _oddělit hlavu od těla_)    
     ??  the same label for  _získat zprávy od někoho_ ??
    <!-- `animate entity that initiates the action' -->
    - `EFF` --> `Goal` 


### 3.2 Non-Core arguments and adjuncts
- [Default table](https://github.com/ufal/UMR/blob/main/tecto2umr/dafault-functors-to-umrlabels.txt)


### 3.3 Light verb constructions (valency frames with `CPHR`)
In theory, the respective noun with the `CPHR` label should serve as a predicate.    
It should be either 
- converted to the relevant verb (with its valency structure), as in _je mu stydno za něco_ --> _stydí se za něco_, _je mu něčeho líto_ --> _lituje něčeho_, OR   
-  converted to a modal verb construction, as in _je možno přijít_ --> _může přijít_    


##### _být_ 
- [tentative table](./byt.xlsx) ... a proposed mappings of individual valency frames, incl. those with the `CPHR` functor (frames with `DPHR` functor ignored for now)

##### TODO: other verbs with CPHR

### 3.4 TODO: Modal and semi-modal verbs

#### TODO: modal verbs
 ... ???
 

#### TODO: semi-modal verbs
 ... ???
 

### 3.5 TODO: Phasal aspectual meaning
 

 
### 3.6 Abstract predicates (být, mít a další slovesné rámce)

#### _být_ 
- [tentative table](./byt.xlsx) ... a proposed mappings of individual valency frames, incl. those with the `CPHR` functor (frames with `DPHR` functor ignored for now)

#### other verbs that should be converted to abstract predicates
_mít_ ‘have’ ... TODO  

_patřit_ ‘belong’:
  - patřit-001 (v-w3411f6_ZU, which substitutes v-w3411f2, v-w3411f5_ZU ... náležet, přináležet, příslušet, být ve vlastnictví)   
  --> _belong-91_ ... `ACT` (possessum) --> `ARG1`, `PAT` (possessor) --> `ARG2`
  - patřit-002 (v-w3411f3) ... frazem, ponechat (_To ti patří!_)
  - patřit-003 (v-w3411f1 ... náležet, řadit se, přináležet, být součást, spadat)  
  -->  _include-91_ ... `ACT` (subset) --> `ARG1`, `DIR3` (superset) --> `ARG2`
  - patřit-004 (v-w3411f4 ... dát, umístit)  
  --> _have-place-91_ ... `ACT` (entity) --> `ARG1`, `DIR3` (location) --> `ARG2`
  - patřit-005 (v-w3411f7_ZU) ... patří na+4 (asi význam zírat, nevidím v Teitoku), ponechat   

_vlastnit_ ‘own’: 
 - vlastnit-001 (v-w7650f1, držet, spravovat)   
 --> _have-91_ ... `ACT` (possessor) --> `ARG1`, `PAT` (possessum) --> `ARG2`
etc.

#### TODO:  special constructions like _Mariina/její taška_, ‘Maria’s/her bag’
 
### 3.7 TODO: Implicit rolesets (=other abstract predicates)
**tabulka UMR lists, list "Abstract rolesets"**, [list Abstract rolesets](https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit#gid=1927108453) ... see above Sect 2.0 for individual subtypes (which of them should be considered events), excluding 

**abstract rolesets** from [the UMR lists](https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit?gid=1927108453#gid=1927108453):
   - **events: reification** (rows 3-101 ... we do not care much about it, BUT if they appear in the annotation, they should be treated as events (see also sect. 4.2 Reification below);
   - NOT events: discourse relations (rows 103-122) ... paratactic structures
   - **events: 9 abstract predicates** (called ``non-prototypical pred rolesets'' there, as exist-91, belong-91, row 124-148) ... see also Sect. 3.6 above)
   - implicit rolesets ... ??? unclear boundary ???
     - NOT events:  in structured texts, used as metadata (like _publication-91_, _hyperlink-91_, _street-address-91_) 
     - **events: rolesets for special linguistic constructions ... used instead of predicates** (like _resemble-91_, _include-91_, _have-degree-91_, _have-quant-91_) --> events ... should be listed as special constructions
    - 
#### TODO: special constructions


### 3.8 TODO: Phrasemes (valency frames with DPHR) ... postponed

---


## 4 Further Structural Changes

### 4.1  Coreference: 

#### Identification of coreferential chains in PDT

For each sentence, all nodes with a coreferential link indicating a node (or nodes) (within or outside) the sentence must be collected and the respective pairs (corefering node—coreferred node) added to the document-level part of the sentence annotation.


Further, the proper relation between the pair members must be identified, reflecting  
1. whether they refer to the same entity or to the same event and   
2. whether their mutual relation is a relation of the identity (both nodes represent the same referent)
or it is a relation between a set and its (proper) subset / event and its subevent.

The first **distinction (entity vs. event)** is crucial and as it can help us to correctly identify (or at least check) whether events have been correctly distinguished -- apparently, only concepts of the same type can form coreferential chains.


[PDT: koreference a t_lemmata](https://ufal.mff.cuni.cz/pdt2.0/doc/manuals/cz/t-layer/html/ch08s04.html)

#### Coreference: Re-entrancy of a variable (intra-sentential)

see the ITAT paper, sect. 3.3.1

#### Coreference: Inverse roles for relative clauses (intra-sentential)

see the ITAT paper, sect. 3.3.1.A

#### Coreference: Inverse roles for nominalizations (intra-sentential)

see the ITAT paper, sect. 3.3.1.B


#### TODO: Coreference: Inverse roles for embedded interrogatives (intra-sentential)

to be done


### 4.2   Reification (intra-sentential)

see the ITAT paper, sect. 3.2.4.:  
"Given the fact that AMR (and thus also UMR) relies on the data post-processing within which the
AMR/UMR representations are converted into the reified forms, we give up attempts to identify constructions in the PDT data that call for reification and leave them to be handled in the subsequent phases of the project."

---

## 5 TODO Named Entities

- classified using "abstract entities"

ML: TrEd: Matou mě uzly s  **relací (= hranou) "name" (modře) a konceptem "name" (černě)** - chápu, že to je to teď "place holder", který zatím nenaplňuješ.  
   - Ale je otázka, jak by to mělo ve výsledku vypadat ... nemělo by se s ":name" (= hranou, modře) zacházet stejně jako třeba s ":wiki"?
     - UMR lists mluví o "subroles", kde je :name spolu s :wiki, :value, :unit apod. ([UMR lists](https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit?gid=235257559#gid=235257559))   
   - Z obrázku z panelu vlevo je zřejmé, že ":wiki" je atributem uzlu, stejně jako :refer-number (kde je uzavřená množina hodnot). Dávalo by to smysl?  
ŘEŠENÍ: Zatím jsem to udělal jednoduše podle formátu souboru: 
     - Když je hodnota v závorce, je to uzel, jinak je to řetězec, na názvy hran se při rozhodování vůbec nedívám. 
     


---

## 6 TODO Abstraktní koncepty a strukturovaný text:

UMR má řadu abstraktních konceptů pro zachycení strukturovaného textu (typu den v týdnu, množství čehosi, adresa apod.)
https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit?gid=0#gid=0
Je otázka, zda má smysl toto zachycovat jako stromovou strukturu (samostatné uzly na několika úrovních, viz i :name, "wiki" apod výš), nebo jako páry atribut-hodnota patřící jedinému uzlu=konceptu.
Podle toho jejich seznamu:
- **concepts** (person, thing apod.):
    - OK uzly, které nemají lexikální obsazení (nebo jde o zájmena) - jediný uzel (případně s atributy zachycujícími např. číslo či osobu).
    - ??? uzly s abstraktními koncepty, které tvoří "obálku" pro pojmenovanou entitu, viz výš o :name ... má smysl pokusit s stáhnout do jediného uzlu??? 
- **entities** (date-entity apod., viz "nedělní") ... asi by se dalo řešit jako "subroles", tedy jako jediný uzel (s atributy)
- **quantities** (volume-quantity apod.) ... asi by se dalo řešit jako "subroles", tedy jako jediný uzel (s atributy)
- **others** (date-interval, slash, emoticons apod.) ... ???
- **maths** (less-than, at-least, su-of apod.) ... ???

**ALE:**
- **discourse relations** ... koncepty (and, or, but-91 apod.) mají stejnou roli jako PDT uzel pro koordinaci/apozici, pod nimi jako děti by tedy měly být uzly pro koordinované výrazy (podstromy)   

---
---
---


# TODO PDT to UMR ... document level