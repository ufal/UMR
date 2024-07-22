# I. PDT to UMR ... sentence level

## I.1 Graph structure
1. each non-root node 	
   - retains id = variable (= a particular instance of some concept from the lexicon/ontology)
   - new node for lexical content = concept, which stands for  
   (based on Banarescu et al. 2013, \cite{amr-for-sembankimg-2013}):
      - **entity** (e.g., _man_)
      - **event** (e.g., _taste-04_)
      - **keyword** for:
          - "entities" (e.g.,  `ordinal-entity` (_for the first time_)),
          - "quantities" (e.g., `temporal-quantity` (_8 months_)),
          - logical conjunctions (_and_),
          - **???** ALSO operators,  e.g., `more-than` 

2. **Nodes** within a sentence that are connected with a **coreferential link** should **be merged** ... see also Sect. I.4 ``Structural Changes'' below

3. Má-li uzel 2 rodiče (Estonsko), jak se určí, co bude jeho rodič ve stromě a co jen šipka? Jak se pozná typ šipky (tj. relace = typ hrany)?

4. **Named entities** (NE(s)), its type (= the abstract entity, as, e.g.,  `person`)  serves as the concept; it is instantiated using a variable (as for other concepts).   
NEs have their internal structure (esp. wiki, name)   
--> **suggestion: not now** (one of future necessary steps, I.5 below) 

5.  **???** other paratactic structures **???**


6. **pořadí uzlů**:   
Není mi jasné, jak se určuje pořadí uzlů? (Evidentně ne podle pořadí anotace.)  
Na Tvém obrázku "výsledek" předchází "volit-001", v textu se ale napřed mluví o volbách a pak teprve o tom, že jde o předběžné výsledky.
Zobrazovadlo, které dělal Míša, se nějak drželo povrchu (nejlevější alignované slovo?) - aby se to aspoň zhruba dalo porovnat.  
Šlo by nějak ošetřit?  
(V PDT má "získat" děti  "volba", "výsledek", "hlas" a "blok" - pokud tomu dobře rozumím, pořadí se mění jen u "NB" uzlů, pokud je to relevantní z hlediska výpovědní dynamičnosti.
Kopírované uzly se dávají jako nejlevější děti, myslím?)


7. Zcela kosmetická záležitost - co kdyby **jména relací (= hrany)** **začínaly vždy dvojtečkou**?   
Trochu jsme si na to zvykli a věřím, že i ostatní, ostatně guidelines i tabulka UMR lists dvojtečku na začátek dávají.  
(Ignoruj tenhle návrh, jestli to má nějaké technické problémy.)


8.  **???** what else **???**

---


## I.2 Content words --> Events

### I.2.0 Events vs. entities

Consequences of being designated an ‘event’ in UMR - see [the summary here](..\doc\eventive-concepts.md):
 events should get:
- the **aspect annotation** (at the sentence level)
- the **modal-strength (= epistamic modality) annotation** (originally both at the sentence level AND the documentation level (more detailed), newly removed from the sentence level) 
- the **temporal annotation** (at the document level)

#### Events
For Czech, events should be finally anchored in SSC; for the time being, we use the mappings via SSC and EngVallex, as discussed in Sect. I.2.1 below.

[The summary](..\doc\eventive-concepts.md) mentioned above set tentative rules for distinguishing events (vs. non-events), 
1. **lexical verbs**:
   - action and stative verbs are treated in the same way --> **events**
2. **abstract rolesets** from [the UMR lists](https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit?gid=1927108453#gid=1927108453):
   - **events: reification** (rows 3-101 ... we do not care much about it, BUT if they appear in the annotation, they should be treated as events (see also sect. I.4.2 Reification);
   - NOT events: discourse relations (rows 103-122)
   - **events: 9 abstract predicates** (called ``non-prototypical pred rolesets'' there, as exist-91, belong-91, row 124-148) --> events ... sect. I.2.3 Abstract predicates)
   - implicit rolesets ... ??? unclear boundary ???
    - NOT events: used as metadata (like _publication-91_, _hyperlink-91_, _street-address-91_) 
    - **events: used instead of predicates** (like _resemble-91_, _include-91_, _have-degree-91_, _have-quant-91_) --> events ... should be listed as special constructions, sect. I.3.5 Implicit rolesets

#### Entities
For Czech, entities should be finally anchored in wikidata whenever possible (the most specific wikidata item should be used in case of several possibilities).


### I.2.1 Nouns

#### -ní/-tí deverbal nouns

**Step 1.** Identify the relevant verb lexeme!  
Sources:  
   - **PDT-Vallex**, 
   - **MorfFlex**, 
   - **Derinet** 
   - another resource: **SynSemClass** ... Veronika Kolářová should know more about nominalizations

**Step 2.** Identify the relevant valency frame / list of arguments ... **???**

(See also Sect. I.4 ``Coreference: Inverse roles for nominalizations'' below.]


#### TODO: Agent nouns

#### TODO: Other deverbal nouns

### I.2.2 TODO: Adjectives ... NOT now

### I.2.3 TODO: Adverbs ... NOT now


---


## I.3 Valency frames (actants and free modifications) --> Rolesets (arguments and adjuncts)


### I.2.1 Core argument structure

#### Verb frames (senses) with mappings via SSC, EngVallex 
- [Google sheet](https://docs.google.com/spreadsheets/d/1lVo7a8hPBReI4VrgNkUGem8uC_sCQCXJJvLFCbwPuok/edit#gid=1270330829)


**BUT:**   
1. **phrasemes** (i.e., valency frames with the  `DPHR` functor) ... see I.2.3 below
2.  **light verbs**  (i.e., valency frames with the  `CPHR` functor) ... see I.2.3 below
3. **semi-modal verbs** ... see I.2.4 below
4. **modal verbs** ...  see I.2.4 below
5. other **implicit rolesets** ...  see I.2.5 below

#### Default mappings (verb non-specific)
- [Deault table](https://github.com/ufal/UMR/blob/main/tecto2umr/dafault-functors-to-umrlabels.txt)
  - as for actants, ONLY the following 3 should be converted in this way 
    - `ACT` (--> `ARG0`), 
    - `PAT` (--> `ARG1`), and  
    - `ADDR` (--> `ARG2`) 
  - for the rest two, ``non-lexicalized'' roles would rather be used (see the ITAT paper): 
    - `ORIG` --> `Source` ('entity from which the theme detaches', as in _oddělit hlavu od těla_)    
     ??  the same label for  _získat zprávy od někoho_ ??
    <!-- `animate entity that initiates the action' -->
    - `EFF` --> `Goal` 


### I.2.2 Non-Core arguments and adjuncts
- [Default table](https://github.com/ufal/UMR/blob/main/tecto2umr/dafault-functors-to-umrlabels.txt)


### I.2.3 TODO: Abstract predicates
**tabulka UMR lists, list "Abstract rolesets"**, [skupina "non-prototypical pred rolesets"](https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit#gid=1927108453)

#### _být_
TODO [tentative table](./byt.xlsx) ... a proposed mappings of individual valency frames (incl. those with the `CPHR`, `DPHR` functors)

#### other verbs that should be converted to abstract predicates
_mít_ ‘have’,  
_patřit_ ‘belong’,  
_vlastnit_ ‘own’,  
etc.

?? special constructions like _Mariina/její taška_, ‘Maria’s/her bag’

#### light verb constructions (valency frames with `CPHR`)
In theory, the respective noun with the `CPHR` label should serve as a predicate.    
--> it should be either converted to the relevant verb (with its valency structure), as in _je mu stydno za něco_ --> _stydí se za něco_, _je mu něčeho líto_ --> _lituje něčeho_, OR   
 it should be converted to a modal verb construction, as in _je možno přijít_ --> _může přijít_    
... will be covered in the table linked above  

### I.3.4 TODO: Semi-modal and modal verbs

#### semi-modal verbs
 ... ???
 
#### modal verbs
 ... ???
 
 
### I.3.5 TODO: Implicit rolesets

#### special constructions

---


## I.4 Further Structural Changes

### I.4.1  Coreference: 

#### Identification of coreferential chains in PDT

For each sentence, all nodes with a coreferential link indicating a node (or nodes) (within or outside) the sentence must be collected and the respective pairs (corefering node—coreferred node) added to the document-level part of the sentence annotation.


Further, the proper relation between the pair members must be identified, reflecting  
1. whether they refer to the same entity or to the same event and   
2. whether their mutual relation is a relation of the identity (both nodes represent the same referent)
or it is a relation between a set and its (proper) subset / event and its subevent.

The first **distinction (entity vs. event)** is crucial and as it can help us to correctly identify (or at least check) whether events have been correctly distinguished -- apparently, only concepts of the same type can form coreferential chains.


#### Coreference: Re-entrancy of a variable (intra-sentential)

see the ITAT paper, sect. 3.3.1

#### Coreference: Inverse roles for relative clauses (intra-sentential)

see the ITAT paper, sect. 3.3.1.A

#### Coreference: Inverse roles for nominalizations (intra-sentential)

see the ITAT paper, sect. 3.3.1.B


#### Coreference: Inverse roles for embedded interrogatives (intra-sentential)

to be done


### I.4.2  Reification (intra-sentential)

see the ITAT paper, sect. 3.2.4.:  
"Given the fact that AMR (and thus also UMR) relies on the data post-processing within which the
AMR/UMR representations are converted into the reified forms, we give up attempts to identify constructions in the PDT data that call for reification and leave them to be handled in the subsequent phases of the project."

---

## I.5 Named Entities

1. Matou mě uzly s **relací (= hranou) "name" (modře) a konceptem "name" (černě)** - chápu, že to je to teď "place holder", který zatím nenaplňuješ.

Ale je otázka, jak by to mělo ve výsledku vypadat.  
Nemělo by se s ":name" (= hranou, modře) zacházet stejně jako třeba s ":wiki"?  
UMR lists mluví o "subroles", kde je :name spolu s :wiki, :value, :unit apod.
https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit?gid=235257559#gid=235257559  
Z obrázku z panelu vlevo je zřejmé, že ":wiki" je atributem uzlu, stejně jako :refer-number (kde je uzavřená množina hodnot).  
Dávalo by to smysl?

---

## I.6 Abstraktní koncepty a strukturovaný text:

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


# II. PDT to UMR ... document level