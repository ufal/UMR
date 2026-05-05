#### Aspectual verbs ( ~ fázová slovesa)

##### 1. Tentative solution for Czech

> **Czech aspectual verbs:**
> 
> - For the time being, only **prototypical aspectual verbs** -- see the list below, i.e., verbs satisfying both aspectual semantics (1 above) and two morphosyntactic properties (2) -- are treated in the way required by the Guidelines in manual annotations.    
> 
> - Merge the pair (aspectual verb - lexical verb) **into a single node**.
> 
> - **Use the** `inceptive` **value**.  
>   (This is meant as a <u>temporary fix</u> to identify cases with aspectual verbs -- and similar constructions -- which require further attention!)
> 
> - In **more complicated cases**, use the `inceptive` value in the construction (to identify the problem) even if more nodes are used to represent the construction. 

---

---

##### 2. Aspectual verbs: Guidelines and English data

Guidelines, Part 3-1-3-3. **TAM categories**:

> "... some semantic categories such as (phasal) aspect, temporal relations, and modal relations, can be expressed cross-linguistically either through bound morphology or through separate words (often called "auxiliaries").
> 
> Phasal aspectual meanings such as inchoative, completive, and continuative, firstly, are never identified as separate events, even if they are expressed through independent words. Instead, they will simply inform the aspect attribute label of the event they modify (Part 3-3-1)."

 --> <u>aspectual (= phase) verbs</u> (*začít / přestat*) are never treated as separate events (they only inform the aspect attribute label)

**Examples from the Guidelines:**

```
3-1-3-3 (1)
ce    əsi    mu-re
paper    this    black-change
'This paper has become black.'
(h/ have-mod-91                    (h/ have-mod-91
    :ARG1 (c/ ce 'paper')                :ARG1 (p/ paper)
        :mod (s/ əsi 'this')                    :mod (t/ this)
    :ARG2 (m/ mu 'black')                :ARG2 (b/ black)
    :aspect performance)                :aspect performance)
```

```
3-3-1-4 (3a)
He started playing the violin.
(p/ play-01
    :ARG0 (p2/ person
        :refer-person 3rd
        :refer-number singular)
    :ARG2 (v/ violin)
    :aspect activity  --> inceptive ???
    :modal-strength full-affirmative)
```

```
3-3-1-4 (3b)
He kept on playing the violin.
(p/ play-01
    :ARG0 (p2/ person
        :refer-person 3rd
        :refer-number singular)
    :ARG2 (v/ violin)
    :aspect activity --> OK
    :modal-strength full-affirmative)
```

**English data** (UMR 2.2) ... the `inceptive` value serves as a <u>temporary fix</u> to identify incomplete annotation!!!

- There is just one occurrence of the inceptive value in the clean data (en-0007.umr):

```
He **began** serving a prison sentence ...
(s2s / serve-04
 :ARG0 (s2p2 / person)
 :ARG1 (s2s2 / sentence-01
               ARG1 s2p2
               ARG2 (s2p /prison)
 :aspect inceptive) --> OK
```

- Dirty data .. 9 occurrences

```
... we will probably **start** doing it ...
(s6d / do-02
       :ARG0 (s6p / person
                    :refer-person 1st
                    :refer-number plural)
        :ARG1 (s6e / event
                     :refer-person 3rd
                     :refer-number singular)
        :aspect inceptive
        :modal-strength partial-affirmative)
```

- verbs indicating `inceptive` value:
  
  - inceptive: *begin, start, take* 
    
    without aspectual verb: *... we switch on to the news and see breaking  news that ...*
    
    *.... recommended  that "the United States take the lead" in ...*
  
  - continuative: --
  
  - completive: *stop* (with `:polarity` -- )
    
    *and from this point on, Michael would reduce the project of his life...*

```
... so they **stop** sucking (english_umr-0042.umr)
(s13s5 / suck-01
         :polarity -
         :ARG0 s13p3
         :aspect inceptive
         :modal-strength full-negative)   ???
```

```
The government **stopping** the recognition of a spouse ... (english_umr-0065.umr)
(s13r / recognize-01
        :polarity -
        :ARG0 (s13g / government-organization
                      :ARG0-of (s13g2 / govern-01))
        :ARG1 (s13s3 / spouse)
                      :ARG3-of (s13h / have-rel-role-92)
        :aspect inceptive
        :modal-strength full-affirmative)
```

---

---

##### 3. Czech aspectual verbs

**Czech grammars and LRs:**

- Mluvnice 3 ... nothing  

- <mark>Čas a modalita v češtině ???</mark>

- In PDT, phasal verbs are conceived as lexical words (= autosemantics), thus they are represented as separate nodes in t-trees.

[NESČ]([FÁZOVÉ SLOVESO | Nový encyklopedický slovník češtiny](https://www.czechency.org/slovnik/F%C3%81ZOV%C3%89%20SLOVESO)): "fázové sloveso" - a verb with the following 3 features:

1. It has **special semantics** denoting phase of action/state: 
   
   - <u>inceptive / inchoative</u>: 
     
     - *začít - začínat (číst / pršet)*
     - *započít - započínat (číst / pršet)*
     - *počít - počínat (číst / pršet)*
     - *jmout se*;
   
   - <u>continuative</u>: 
     
     - *zůstat - zůstávat (sedět / pracovat)* (partially)
       
       ... NOT combined with adverbs like *postupně* ("phases within the phase")
   
   - <u>terminative / completive</u>: 
     
     - *přestat - přestávat (číst / pršet)*
     - *ustat - ustávat (číst / pršet)*.

2. It has special **morphosyntactic properties**:
   
   - It is combined with an **infinitive** of a lexical verb 
   
   - The lexical verb (infinitive) must have **imperfective** feature (*začal blednout* vs. **začal zblednout*)

**Broader list of aspectual verbs** - including verbs with relevant semantics (1 above) but not necessarily with both morphosyntactic properties (2):

- <u>inceptive / inchoative </u>:  
  - *dát se - dávat se (do čtení / do deště)*
  - *chápat se (čtení / *do deště)*
  - *chystat se (malovat / že bude malovat)*
  - *jít (spát / *pršet)*
  - ***jmout se***
  - ***počít - počínat (číst / pršet)***
  - *pustit se - pouštět se (do čtení)*
  - *stát se - stávat se* (??)
  - *vrhat se - vrhnout se (číst / do čtení / *do deště)*
  - ***začít - začínat (číst / pršet)***
  - ***zahájit - zahajovat (čtení / *pršení)***
  - ***započít - započínat (číst / pršet)***  
- <u>continuative</u>: 
  - *pokračovat (ve čtení)* 
  - *nepřestat - nepřestávat (číst)*
  - ***zůstat - zůstávat (sedět / pracovat)***
- <u>terminative / completive</u>: 
  - ***přestat - přestávat (číst / pršet)***
  - *skončit (se čtením /  *s deštěm)*
  - ***ustat - ustávat (číst / pršet)***.



##### Known problems

###### Perfective vs. imperfective aspectual verbs

Czech aspectual verbs have usually both perfective forms (*začít, přestat*) and imperfective forms (*začínat, přestávat*), whereas infinitives are (typically) imperfective verbs. Thus, it is the aspectual verb which brings about 

- Should UMR annotation consider this nuance? Or just ignore it and use a single node with suitable `:aspect` value (for the time being, `inceptive` for all types of aspectual verbs)?

- Alternatively, how to represent it in UMR graphs?

###### Negation and aspectual verbs

One can negate either aspectual verb (*nezačal podávat informace*) or the lexical verb (*začal nepodávat informace*) (or both)

- *nezačal podávat informace* --> ?? *nepodával informace*

- *začal nepodávat informace* --> ?? *přestal podávat*

- *... nebo nezačít nesnášet své lepší spolužáky* (SYN v14) --> ??

###### Combination of two aspectual verbs

*Žít a nechat žít, **nezačínat přestávat** a **napřestávat začínat**.*  (SYN v14)

###### Combination of modal and aspectual verbs (and negation)

*Nemohu nezačít pochybovat.* (SYN v14)
