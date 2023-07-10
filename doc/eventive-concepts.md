## Eventive concepts

**Eventive concpets** (or **events**) constitute important building blocks in UMR annotation -- their identification is important for annotation  of participant roles (as well as for aspect and modality annotation).

(See also the short description in https://github.com/ufal/UMR/blob/main/doc/terminologie.md.)

According to the UMR Guidelines (Part 3-1-1.), identification of eventive concepts should be "based on a combination of semantic type and information packaging (Croft 2001)".
Criteria for identification of eventive concepts are largely based on the criteria used in TimeML (Pustejovsky et al. 2005)

>> (Pustejovsky et al. 2005): the following is classes of event expressions are identified:
>> - **tensed verbs** (*has left, was captured, will resign*),
>> - **stative adjectives and other modifiers** (*sunken, stalled, on board*), and
>> - **event nominals** (*merger, Military Operation, Gulf War*) are treated.


### Semantic type
Semantic type refers to the difference between:
- **entities** (or, objects) ... prototypically **nouns**, but also nominalizations as deadjectival or deverbal nouns or infinitives ... TO READ: Paducheva (1995) – types of (nominal) reference,
- **states** (or, properties) ... prototypically **adjectives**, but also other nominal modifiers as PPs, relative clauses, participles, and
- **processes**  ... prototypically (finite) **lexical verbs**, but also predicate nouns or adjectives, complements).


### Information packaging
Information packaging, on the other hand, concerns the way how the semantic content is 'expressed', i.e., whether it is packed as
- **reference** (what the speaker is talking about),
-  **modification** (additional information provided about the referent), or
- **predication** (what the speaker is asserting about the referents in a particular utterance).

***

### Identifying eventive concepts

> **RULE 1:** In UMR, the following should be annotated as an **eventive concept**:
> - whatever is a **process** (semantic type) or
> - whatever is expressed as **predication**.

Examples:
* (1a) [cs] *Muzeum **zaplatí** necelé 2 milióny korun za novou střechu.*<br>
    "The museum will **pay** almost 2 million crowns for a new roof." <br>
    ... a process in predication
* (2) [cs] *Než **šla** do školy, **opravila** mi kolo.* <br>
    [en] *Before she **went** to school, she **repaired** my bike.* (from the UMR Guidelines)<br>
    ... both processes in predication
* (3) [cs] ***Chtěl** **jít** do školy.* <br>
    [en] *She **wanted** to **go** to school.* (from the UMR Guidelines)<br>
    ... a process in predication (*want*, *chtít*) and in ??modification (*go*, *jít*)
* (4a) [cs] *Student **hrající** na housle **má rád** Bacha.*<br>
    [en] *The student **playing** the violin **likes** Bach.* (from the UMR Guidelines)<br>
    ... a process in modification (*play*, *hrát*) in predication (*like*, *mít_rád*)
* (4b) [cs] *Student, který **hraje** na housle **má rád** Bacha.* <br>
    [en] *The student, who is **playing** the violin, **likes** Bach.* (from the UMR Guidelines)<br>
    ... a process in modification (*play*, *hrát*) in predication (*like*, *mít_rád*)
* (5) [cs] *Jejího **příchodu** si nikdo **nevšiml**.*<br>
    [en] "Nobody **noticed** her **arrival**."<br>
    ... a process in predication (*arrive*, *(ne)všimnout*) and as an event nominal in reference (*arrival*, *příchod*).


> **RULE 1a:**
> - **Participles** (or other non-finite verb forms) are identified as events (unless they are part of a compound.)

Examples:
* (6a) [en] *firing squad* (from the UMR Guidelines)<br>
    ... compound, thus entity (not process)
* (6b) [en] *floating hospital* (from the UMR Guidelines)<br>
    ... *floating* as an event ... BUT "The Floating Hospital" is a non-profit organization ??? https://en.wikipedia.org/wiki/Floating_Hospital
* (7a) [cs] *???* <br>
    "???" <br>
    ... compound, thus entity (not process)
* (7b) [cs] *???* <br>
    "???" <br>
    ... as event ???


> **RULE 1b:**
> - **Stative verbs** should be annotated as events, even if not classified as processes.

Examples:
* (8a) [cs] *Moje kočka **nesnáší** granule.*
* (8b) [en] *My cat **loves** wet food.* (from the UMR Guidelines)<br>
    ... ??state in predication (*love*, *nesnášet*), thus should be annotated as an event

> **RULE 1c:**
> - **Causal relationships** should be annotated as events if packaged as predication (and as non-events otherwise.

Examples:
* (9a) [cs] ***Exploze** **způsobila** **zhroucení** domu.*<br>
    [en] *The **explosion** **caused** the house **to collapse**.* (from the UMR Guidelines)<br>
    ... three eventive concepts: 1 causal verb in predication (*cause*, *způsobit*), 1 complement/nominalization (*collapse*, *zhroucení*), 1 event nominal in reference (*explosion*, *exploze*)
* (9b) [cs] *Dům se **zhroutil** kvůli **explozi**.*<br>
    [en] *The house **collapsed** because of the **explosion**.* (from the UMR Guidelines)<br>
    ... two eventive concepts: 1 process in predication (*collapse*, *zhroutit se*) and 1 event nominal in reference (*explosion*, *exploze*); causal relationship not expressed in predication

***

### Identifying non-eventive concepts

> **RULE 2:**
> - **Entities** and **states** (=properties) **in modification** and **in reference** are not identified as event!

Based on examples from the Guidelines:

> **RULE 2a - limitation:**
> - **relative clauses with lexical verb** (play, went, ...) considered as eventive concepts, but
> - **relative clauses falling under "non-verbal clauses"** considered as non-eventive concepts!

***

### Eventive vs. non-eventive concepts -- unclear cases

#### generic vs. specific mention

* (5) [cs] ***Bouře** **poničila** střechu.* <br>
    [en] *The **storm** **damaged** the roads.* (from the UMR Guidelines)<br>
    ... a process in predication (*damage*) and as an event nominal (*storm*, *bouře*)

#### agent nouns:
driver treated as an entity (ex.) but teacher as  ARG0-of teach-01 (ex.) even in mentions where there is mothing about teaching :-((

***

### Possible supporting criterion based on the type of "anchoring"???

>RULE 3
>- events/eventive concepts should be linked to frame files

**(1) PROCESSESS:**
- OK processes in predication ... prototypical case, lexical verb, but also predicate nouns or adjectives, complements) <br>
    *Peter **went** to school; The sharp thorns **scratched** me.*
- OK processes in modification ... participles, rel. clauses with lex. verbs<br>
     *The student **playing** the violin likes Bach.; The student, who is **playing** the violin, likes Bach. the thorns **that [scratched me]** / the thorns [**scratching** me]*
- processes in reference:
  - OK for nominalizations as deadjectival or deverbal nouns, for infinitives<br>
       *I said [**that** the thorns **scratched** me]*. / the **[scratching of the thorns]**
  - ??? for event nominals
      - **?? OK** for generic mentions ... *war, storm, ceremony, válka, bouře*??
      - **!! NO** for specific mentions ... rather anchored in wikidata/wikipedie/

Example: *válka na Ukrajině* ... ?? should be anchored to  https://www.wikidata.org/wiki/Q110999040


```
(w/ war
    :wiki "Q110999040"
    :name (n/ name
        :op1 "Ruská"
        :op2 "invaze"
        :op3 "na"
        :op4 "Ukrajině"))
```

 ... see [the document on entities](https://github.com/ufal/UMR/blob/main/doc/entities.md)

**(2) non-PROCESSESS packed as predication:**
- OK states in predication ...  prototypically adjectives, but also other nominal modifiers as PPs, relative clauses, participles<br>
    *Those thorns **are sharp**.*
    *My cat **loves** wet food.*
- OK entities in predication ... non-verbal clauses with predicate nouns or adjectives, complements<br>
    *It **is a thorn**.*


>RULE 4
>- non-eventive concepts should be linked to wiki

**(3) STATES:**
- **??** states in reference ... what to do with them? (sharpness https://www.wikidata.org/wiki/Q55433472 )
- **??** states in modification ... either without any mapping OR, contrary to the guidelines, as eventive concepts (being tall)

**(4) ENTITIES:**
- entities in reference (proototypical)
  - **??** for generic mention  (*the sharp **thorns***) ... what to do with them?
  - **OK** for specific mentions (***Barack Obama***)
- entities in modification
  - **??** generic mentions (*(any) **bush’s** thorns*) ... what to do with them?
  - **OK** for specific mentions (***Barack Obama's** cabinet*)


***
***

## Non-verbal clauses

***

#### TO READ
- Croft (2001) ??? *Radical Construction Grammar: Syntactic Theory in Typological Perspective*
- Pustejovsky et al. (2005) *The Specification Language TimeML*. https://www.researchgate.net/publication/242423032_The_Specification_Language_TimeML

About events expressed as MWE:
- J. Bonn et al (2023) *UMR Annotation of Multiword Expressions* (sent by HH)
- W. Croft (2021): *Eventive Complex Predicates and Related Constructions* (draft from June 2021, sent by DZ)
- ?? Paducheva














