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
          - **???**ALSO operators,  e.g., `more-than` 

2. For **named entities** (NE(s)), its type (= the abstract entity, as, e.g.,  `person`)  serves as the concept; it is instantiated using a variable (as for other concepts).   
NEs have their internal structure (esp. wiki, name).

3. **Nodes** within a sentence that are connected with a **coreferential link** should **be merged** ... see also Sect. I.4 ``Structural Changes'' below

4.  **???** other paratactic structures **???**

5.  **???** what else **???**


---


## I.2 Content words --> Events

### I.2.1 Nouns

#### -ní/-tí deverbal nouns

1. Identify the relevant verb lexeme!  
Sources:  
   - **PDT-Vallex**, 
   - **MorfFlex**, 
   - **Derinet** 
   - another resource: **SynSemClass** ... Veronika Kolářová should know more about nominalizations

2. identify the relevant valency frame / list of arguments ... **???**

... see also Sect. I.4 ``Coreference: Inverse roles for nominalizations'' below!!


#### TODO: Agent nouns

#### TODO: Other deverbal nouns

### I.2.2 TODO: Adjectives

### I.2.3 TODO: Adverbs


---


## I.3 Valency frames (actants and free modifications) --> Rolesets (arguments and adjuncts)


### I.2.1 Core argument structure

#### Verb frames (senses) with mappings via SSC, EngVallex 
- [Google sheet](https://docs.google.com/spreadsheets/d/1lVo7a8hPBReI4VrgNkUGem8uC_sCQCXJJvLFCbwPuok/edit#gid=1270330829)


**BUT:**   
1. phrasemes with _být_ (i.e., valency frames with the  `DPHR` functor) ... TODO
2.  _být_ as light verb  (i.e., valency frames with the  `CPHR` functor) ... TODO

#### Default mappings (verb non-specific)
- [Deault table](https://github.com/ufal/UMR/blob/main/tecto2umr/dafault-functors-to-umrlabels.txt)
  - as for actants, ONLY the following 3 should be converted in this way 
    - `ACT` (--> `ARG0`), 
    - `PAT` (--> `ARG1`), and  
    - `ADDR` (--> `ARG2`) 
  - for the rest two, ``non-lexicalized'' roles would rather be used: 
    - `ORIG` --> `Source`,
    - `EFF` --> `Goal` 


### I.2.2 Non-Core arguments and adjuncts
- [Default table](https://github.com/ufal/UMR/blob/main/tecto2umr/dafault-functors-to-umrlabels.txt)


### I.2.3 TODO: Abstract predicates
**tabulka UMR lists, list "Abstract rolesets"**, [skupina "non-prototypical pred rolesets"](https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit#gid=1927108453)


### I.3.4 TODO: Implicit rolesets


---


## I.4 Structural Changes


### I.4.1 Coreference: Re-entrancy of a variable

### I.4.2 Coreference: Inverse roles for relative clauses

### I.4.3 Coreference: Inverse roles for nominalizations

### I.4.4 TODO: Coreference: Inverse roles for embedded interrogatives

### I.4.5  Reification


---
---
---


# II. PDT to UMR ... document level