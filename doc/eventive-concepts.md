## Eventive concepts

**Eventive concepts** (or **events**) constitute important building blocks in
UMR annotation – their identification is important for annotation  of
participant roles (as well as for aspect and modality annotation).

(See also the short description in
[terminologie.md](https://github.com/ufal/UMR/blob/main/doc/terminologie.md).)

According to the [UMR Guidelines (Part
3-1-1.)](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-1-eventive-concepts),
identification of eventive concepts should be "based on a combination of
semantic type and information packaging (Croft 2001)". Criteria for
identification of eventive concepts are largely based on the criteria used in
TimeML (Pustejovsky et al. 2005)

>> (Pustejovsky et al. 2005): the following is classes of event expressions are identified:
>> - **tensed verbs** (*has left, was captured, will resign*),
>> - **stative adjectives and other modifiers** (*sunken, stalled, on board*), and
>> - **event nominals** (*merger, Military Operation, Gulf War*) are treated.


### Semantic type

Semantic type refers to the difference between:
- **entities** (or, objects) ... prototypically **nouns**, but also nominalizations as deadjectival or deverbal nouns or infinitives ... TO READ: Paducheva (1995) – types of (nominal) reference,
- **states** (or, properties) ... prototypically **adjectives**, but also other nominal modifiers as PPs, relative clauses, participles, and
- **processes**  ... prototypically (finite) **lexical verbs**, but also predicate nouns or adjectives, complements.


### Information packaging

Information packaging, on the other hand, concerns the way how the semantic content is 'expressed', i.e., whether it is packed as
- **reference** (what the speaker is talking about),
- **modification** (additional information provided about the referent), or
- **predication** (what the speaker is asserting about the referents in a particular utterance).

***

### Identifying eventive concepts

> **RULE 1:** In UMR, the following should be annotated as an **eventive concept**:
> - whatever is a **process** (semantic type) or
> - whatever is expressed as **predication**.

Examples:
* [cs] *Muzeum **zaplatí** necelé 2 milióny korun za novou střechu.*<br>
  [en]  *The museum will **pay** almost 2 million crowns for a new roof.* <br>
    ... a process in predication
* [cs] *Než **šla** do školy, **opravila** mi kolo.* <br>
  [en] *Before she **went** to school, she **repaired** my bike.* (from the UMR Guidelines)<br>
    ... both processes in predication
* [cs] ***Chtěla** **jít** do školy.* <br>
  [en] *She **wanted** to **go** to school.* (from the UMR Guidelines)<br>
    ... a state in predication (*want*, *chtít*)<br>
    ... a process in reference/modification (*go*, *jít*) (not sure which of them?)
 
 ŠZ: just one semantic concept consisting of two words (want to go) (?) - based on the test of negation, similar to   Valency-changing operations (?), (https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-3-2-Valency-changing-operations)  
 
 ML: According to [Part 3-1-3-3. TAM categories](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#Part-3-1-3-3-TAM-categories), *want* is considered as a semi-modal concept and the fact that it can be modalized independently of the "go"-event on English indicates that desires are construed as independent events (in English), thus considered as independent events.  
 This may be language-internal characteristics. 
 
* [cs] ***Chtěla,** abych **šel** do školy.* <br>
  [en] *She **wanted** me to **go** to school.* <br>
    ... a state in predication (*want*, *chtít*)<br>
    ... a process in reference/modification (*go*, *jít*) 

* [cs] ***Bouře** **poničila** střechu.* <br>
  [en] *The **storm** **damaged** the roads.* (from the [UMR Guidelines](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-1-2-processes-in-modification-and-reference))<br>
    ... a process in predication (*damage*, *poničit*), the `:ARG0`of which is an event nominal (in reference) indicating another process (*storm*, *bouře*)  
ŠZ: other examples of possible processes: *Christmas, wind, (financial) inflation*

* [cs] *Student **hrající** na housle **má rád** Bacha.*<br>
  [en] *The student **playing** the violin **likes** Bach.* (from the UMR Guidelines)<br>
    ... a process in modification (*play*, *hrát*)<br>
    ... state in predication, thus eventive, see below (*like*, *mít_rád*)
* [cs] *Student, který **hraje** na housle, **má rád** Bacha.* <br>
  [en] *The student, who is **playing** the violin, **likes** Bach.* (from the UMR Guidelines)<br>
    ... a process in modification (*play*, *hrát*)<br>
    ... state in predication, thus eventive (*like*, *mít_rád*)
* [cs] *Jejího **příchodu** si nikdo **nevšiml**.*<br>
  [en] *Nobody **noticed** her **arrival**.*<br>
    ... a process in predication (*notice*, *všimnout si*)<br>
    ... another process in reference (event nominal) (*arrival*, *příchod*).
* [cs] *Nikdo si **nevšiml**, že **přišla**.*<br>
  [en] *Nobody **noticed** that she **arrived**.*<br>
    ... a ??process in predication (*notice*, *všimnout*)<br>
    ... another process in ~~predication~~ ?reference, see [Table 1](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-1-eventive-concepts) (*arrive*, *přijít*).
* [cs] *Její rychlý **návrat** mě **zaskočil**.*<br>
  [en] *Her quick **return** **surprised** me.*<br>
    ... main ??process in predication (*surprise*, *zaskočit*)<br>
    ... subject process in reference (*return*, *návrat*)
* [cs] *Zaskočilo mě, jak rychle se vrátila.*<br>
  [en] *It **surprised** me how quickly she **returned**.*<br>
    ... main ??process in predication (*surprise*, *zaskočit*)<br>
    ... subject process in ~~predication~~?reference, see RULE 1b below (*return*, *vrátit*)


> **RULE 1a: processes vs. states**
> - **Adjectives** typically denote states, **verbs** typically denote processes – unless they are [stative verbs](https://www.ecenglish.com/learnenglish/lessons/what-are-state-verbs).
> - **Stative verbs** can still be annotated as events if they are packaged as predication. In contrast, active verbs are processes, hence events regardless of information packaging.

Examples:
* [cs] *Moje kočka **nesnáší** granule.*
* [en] *My cat **loves** wet food.* (from the UMR Guidelines)<br>
    ... a state in predication (*love*, *nesnášet*), thus should be annotated as an event, see [3-1-1-3](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-1-3-states-and-entities), where the guidelines explicitly acknowledge that there can be two-place states, and [en] _love_ is an example.

DZ: There is a gray zone with verbs such as _sleep_ or _sit_. They may not be
"state verbs" according to the English grammar (it is grammatical to say _I
am sleeping_ or _I am sitting on the couch_) but semantically they seem to be
states rather than processes. Sitting generally does not involve any activity
or any changes; the only possible change is the end of this state by changing
to another state (_standing, lying, going..._) _Sleeping_ might be different,
although also almost constant from the perspective of an observer. It may
involve micro-sub-processes (_snoring, turning, dreaming_), and it may have a
result at the end (compare it to _recharging battery_). So maybe _sleeping_
is a process, even if not a frantic one.

DZ: Note that the [English state
verbs](https://www.ecenglish.com/learnenglish/lessons/what-are-state-verbs)
are recognized by tests that are grammatical rather than semantic (you cannot
use the progressive tense). Other languages may not have similar tests, or
the tests may result in a different set of verbs. For example, [in
Czech](https://www.czechency.org/slovnik/SLOVESO), examples of state verbs
_(stavová slovesa)_ include _stát_ "stand", _mít_ "have", _patřit_ "belong";
_to stand_ would perhaps not be grammatically a state verb in English, but
semantically it is a state both in Czech and in English.

ML: There is a simple Czech test for distinguishing state verbs (stavová slovesa) and action verbs (dějová činnostní): 
-  action verbs ... *Co dělám? Běžím.* "What am I doing? I'm running."
-  state/stative verbs ... *Co se děje se mnou? Mám dost peněz.* "What is happening to me? I have enough money."  
The test illustrates also borderline cases like *stát*, as you can ask both questions  *Co dělám? Co se děje se mnou? Stojím.* "What am I doing? What is happening to me? I'm standing." 

See also [SaS 17(4)](http://nase-rec.ujc.cas.cz/archiv.php?art=2685).

ML: I suppose we should anchor both action and state/stative verbs in SynSemClass (PDT-Vallex), regardless they are packaged as predication, modification, or reference -- even in clear cases of state verbs as _stát_ "stand", _mít_ "have", _patřit_ "belong". It is still not clear (to me) whether there is any difference in UMR annotation of stative verbs when they are regarded as eventive concepts (i.e., in predication) and when they are non-eventive concepts (i.e., in reference and modification). 



* [cs] *Moje dítě **sedí** na lavičce.* <br/>
  [en] *My child **is sitting** on a bench.* <br/>
       ... a state in predication (*sedět*, *sit*) <br/>
* [cs] *Dítě sedící na lavičce **je moje**.* <br/>
  [en] *The child sitting on the bench **is mine**.* <br/>
       ... here the sitting state is in modification, hence not an event;
           the other state (*můj*, *mine*) is in predication, hence it is an event.


> **RULE 1b: predication vs. modification or reference**
> - **Predicates of main clauses** (finite verbs, or nonverbal predicates with finite copula) are predication.
> - **Subjects (finite clauses, infinitives, verbal nouns)** are reference. If their predicate is a process, they are still annotated as events; but states as subjects are not events.
> - **Objects / complements (finite clauses, infinitives, verbal nouns)** are reference. If their predicate is a process, they are still annotated as events; but states as objects are not events.
> - **Relative clauses** (modifying a nominal) are modification. If their predicate is a process, they are still annotated as events; but stative relative clauses are not events.
> - **Participles** are typically used in modification. They are annotated as events if they denote processes. They are not events if they denote states or if they are used in a compound or a name where the process cannot be automatically assumed.
> - **Secondary predication** is predication.
> - **Predicates of adverbial clauses** are predication. The term modification in the context of this page probably means modification of entities but not of processes, so adverbial clauses are different from relative clauses.

Examples:
* [en] *firing squad* (cs. popravčí četa, from the UMR Guidelines)<br>
    ... compound, thus entity (not process)
* [en] *floating hospital* (from the UMR Guidelines)<br>
    ... *floating* as an event ... BUT "The Floating Hospital" is a non-profit organization ??? https://en.wikipedia.org/wiki/Floating_Hospital
* [cs] *Tančící dům* <br>
  [en] *Dancing House* <br>
    ... a name of a [building in Prague](https://cs.wikipedia.org/wiki/Tan%C4%8D%C3%ADc%C3%AD_d%C5%AFm); the house is not really dancing, hence _tančící_ does not denote a process in this context.
    
* Similarly: [cs] ***létající** pivovar* (gypsy brewery. lit. flying brewery)<br>
... a brewery company (society) working in different rental eqipped brewery houses - not an event.
* [cs] *Náměstí bylo plné **tančících** lidí.* <br>
  [en] *The square was full of **dancing** people.* <br>
    ... here we have a process (*tančit*, *dance*) in modification; it will be annotated as an event.
* Similarly: [cs] ***válčící** strany* (lit. warring/fighting parties, enemies)  
... the parties are in a real fight as a process, thus the word *válčit* is an event.
* [it] *ambasciatore itinerante* (en. *ambassador-at-large*? check [wikipedia](https://en.wikipedia.org/wiki/Ambassador-at-large#:~:text=An%20ambassador%2Dat%2Dlarge%20is,country%20and%20its%20people%20internationally.)) <br>
    *itinerante* as event or entity ???
* [cs] ***Překvapilo** mě, jak **chytrý byl**.* <br>
  [en] *It **surprised** me how **smart** he **was**.* <br>
  ... subject clause is reference to a state (*chytrý*, *smart*), hence it is not an event; another ?state in predication (*překvapit*, *surprise*)
* [cs] *Jeho **chytrost** mě **překvapila**.* <br>
  [en] *His **smartness** **surprised** me.* <br>
  ... subject clause is reference to a state (*chytrý*, *smart*), hence it is not an event.
* [cs] *Kdo **neriskuje**, **nevyhraje**.* <br>
  [en] *He who **does not risk**, **does not win**.* <br>
  ... this is a *relative* subject clause, although it lacks the governing nominal in the Czech version.
      It should be analyzed using the abstract concept `person` modified by the risking concept.
      Risking is a process, hence it is still treated as event, despite being packaged as modification.
* [cs] *Kdo **není mazaný**, **nevyhraje**.* <br>
  [en] *He who **is not cunning** **does not win**.* <br>
  ... a variant of the previous example. Now we have a state (not process) in modification, hence it is not event.
* [cs] ***Řekl jsem,** že **je chytrý**.* <br>
  [en] *I **said** that he **is smart**.* <br>
  ... complement clause is reference to a state (*chytrý*, *smart*), hence it is not an event.
* [cs] *Moje dcera **netouží** **být dospělá**.* <br>
  [en] *My daughter **does not long** for **being adult**.* <br>
  ... complement clause is reference to a state (*dospělý*, *adult*), hence it is not an event; another state in main predication (*toužit*), thus event
* [cs] ***Koupala se** v jezeře **nahá**.* <br>
  [en] *She **swam** in the lake **naked**.* <br>
  ... state in secondary predication (*nahý*, *naked*) is an event.
* [cs] *Pokud teplota **klesne** pod 7 stupňů, **nasadíme** zimní pneumatiky.* <br>
  [en] *If the temperature **drops** below 7 degrees, we **will put on** winter tires.* <br>
  ... process in adverbial clause (*klesnout*, *drop*) is an event.
* [cs] *Když **budeš hodný**, **koupíme** ti zmrzlinu.* <br>
  [en] *If you **are nice**, we **will buy** you ice cream.* <br>
  ... state in adverbial clause (*hodný*, *nice*) is also an event because it is in predication.
* [cs] *Děti **jedly** zmrzlinu **sedíce** v autě.* <br>
  [en] ***Sitting** in the car, the children **ate** ice cream.* <br>
  ... the converb is a non-finite adverbial clause, hence a state in predication (*sedět*, *sit*), hence an event.


> **RULE 1c:**
> - **Causal relationships** should be annotated as events if packaged as predication (and as non-events otherwise).

Examples:
* [cs] ***Exploze** **způsobila** **zhroucení** domu.*<br>
  [en] *The **explosion** **caused** the house **to collapse**.* (from the UMR Guidelines)<br>
    ... three eventive concepts: 1 causal verb in predication (*cause*, *způsobit*), 1 complement/nominalization (*collapse*, *zhroucení*), 1 event nominal in reference (*explosion*, *exploze*)
* [cs] *Dům se **zhroutil** kvůli **explozi**.*<br>
  [en] *The house **collapsed** because of the **explosion**.* (from the UMR Guidelines)<br>
    ... two eventive concepts: 1 process in predication (*collapse*, *zhroutit se*) and 1 event nominal in reference (*explosion*, *exploze*); causal relationship not expressed in predication
* [cs] *Dům se **zhroutil**, protože v něm něco **explodovalo**.* <br/>
  [en] *The house **collapsed** because something **exploded** in it.* <br/>
        ... main clause and adverbial clause, each with one event (process in predication); the causal relationship (*protože*, *because*) is not an additional event.

Some languages (e.g., Basque) have morphological causative:
* [eu] (a) *Zopa izugarri **gustatzen zaio** mutilari.* <br/>
   lit. "soup greatly pleasing it.is.it to.boy" <br/>
  [en] "The boy likes the soup." (normal active voice)
* [eu] (b) *Goseak zopa izugarri **gustatuerazi zion** mutilari.* <br/>
   lit. "hunger soup greatly made.pleasing it.has.it.it to.boy" <br/>
  [en] "Hunger made the boy like the soup." (causative voice) <br/>
 ... (DZ) I suppose that both in (a) and in (b) there is just one event (*gustatzen* "like"). It is a state but it is packaged as predication. Or should we decompose (b) to two events (causing and liking)?

***

### Identifying non-eventive concepts

> **RULE 2:**
> - **Entities** and **states** in **modification** and in **reference** are not identified as events!

Based on examples from the Guidelines:

> **RULE 2a - relative clause is modification:**
> - **relative clauses with active verb** (play, went, ...) considered as eventive concepts (because active verb denotes a process), but
> - **relative clauses with stative verb or non-verbal predicate** considered as non-eventive concepts (because they denote a state in modification)!

(see below for four semantic types of non-verbal clauses: possession, location, property, and object ... [guidelines, part 3-1-1-3](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-1-3-states-and-entities) )

***

### Eventive vs. non-eventive concepts – unclear cases


#### agent (or, more generally, participant) nouns:

driver treated as an entity ([ex.](https://github.com/umr4nlp/umr-guidelines/blob/cbcb2555b36e99c7dc296f4fb3264136a31db953/guidelines.md?plain=1#L961-L974))
but teacher as  ARG0-of teach-01 ([ex.](https://github.com/umr4nlp/umr-guidelines/blob/cbcb2555b36e99c7dc296f4fb3264136a31db953/guidelines.md?plain=1#L3339-L3341))
even in mentions where there is nothing about teaching :-((

DZ: See also [issue 16 in UMR guidelines](https://github.com/umr4nlp/umr-guidelines/issues/16).

DZ: Supposedly the _teacher_ should receive the same annotation as _the
person who teaches_, which might be the way how it is expressed in some
languages. Note that the latter can occur also in utterances that are not
(mainly) about teaching: _The person who teaches my daughter English has been
sick for three weeks_ vs. _My daughter's English teacher has been sick for
three weeks_. In both sentences, the teaching event is somehow present, even
though it is not the main proposition. The teaching should probably be
annotated with habitual aspect. As for the _driver_, it may be a mistake of
the authors of the guidelines, but maybe not. They say that it does not refer
to a process. That is correct even if we decompose it analogously to the
_teacher_: it does not refer to a process, it refers to an entity involved in
a process. The driver example is in a section where they do not show full UMR
graphs, so we actually do not know whether they would decompose it as `(p/
person :ARG0-of (d/ drive-01))`. [Nathan
suggests](https://github.com/umr4nlp/umr-guidelines/issues/16#issuecomment-1631807454)
that such decomposition should be done whenever a noun denoting a participant
of a process is morphologically derived from the word denoting the process.
And the participant does not have to be the agent. So, according to Nathan,
Czech _jídlo_ "food" would be decomposed as `(t/ thing :ARG1-of (j/
jíst-01))` (a thing that is eaten) while English _food_ would be simply `(f/
food)` because there is no visible grammatical link between _food_ and _eat_.

* [la] *praefectus* (en. *prefect*). <br>
Originally *praefectus* is a past participle of *praeficio* meaning 'to put in charge', but it also occurs as a substantive. This alternation is reflected in the grammatical case its dependents occur in. Examples: <br>
    *praefectus praetorio* (en. praetorian prefect): *praetorio* in dative, because the verb requires dative case. <br>
    *praefectus annonae* (en. prefect of the provisions): *annonae* unclear, could be either dative or genitive. <br>
    *praefectus Alexandreae et Aegypti*, *praefectus classis* (en. prefect of navy), *praefectus vigilum* (en. prefect of the watchmen): genitive case is used,         as in any nominal modification. *Praefectus* behaves like a substanstive, like *driver*/*teacher* (main difference: it has passive meaning). <br>

#### How to recognize event nominals:

https://github.com/umr4nlp/umr-guidelines/issues/16

Compare the annotation of *food* in 3-3-3 (1a) and in 3-2-1-1(6a)

[Part 3-3-3](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-3-polarity)
``` 
Unhealthy food.  
(t/ thing
	:ARG1-of (e/ eat-01)
	:mod (h/ healthy
		:polarity -))
```

[3-2-1-1(6a)](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-2-1-1-stage-0)
```
He gave the cat some wet food.
(g/ give-01  
	:actor (p/ person
		:ref-person 3rd
		:ref-number Singular)  
	:theme (f/ food
		:mod (w/ wet)
		:quant (s/ some))  
	:recipient (c/ cat
		:ref-number Singular)
	:aspect Performance
	:modstr FullAff)
```


***

### Possible supporting criterion based on the type of "anchoring"???

>RULE 3
>- events/eventive concepts should be linked to frame files

**(1) PROCESSESS should be linked to frame files:**
- **OK processes in predication** ... prototypical case, lexical verb, but also predicate nouns or adjectives, complements) <br>
    *Peter **went** to school; The sharp thorns **scratched** me.*
- **OK processes in modification** ... participles, rel. clauses with lex. verbs<br>
     *The student **playing** the violin likes Bach.; The student, who is **playing** the violin, likes Bach. the thorns **that [scratched me]** / the thorns [**scratching** me]*
- processes in reference:
  - **OK for nominalizations** as deadjectival or verbal nouns, for infinitives<br>
       *I said [**that** the thorns **scratched** me]*. / *the **[scratching of the thorns]***
  - for event nominals
      - **generic mentions ... BOTH annotations**  (*war, storm, ceremony, válka, bouře*)  
      ... annotate them primarily as events (to map them primarily to the same concept as corresponding verb)  
      BUT add also the `:wiki` attribute and the `:name` relation similarly to named entities
      - **specific mentions ... ALSO as an event ???**  
      ... primarily anchored in wikidata/wikipedie/  

DZ: See also [issue 14 in UMR
guidelines](https://github.com/umr4nlp/umr-guidelines/issues/14), as well as
[the document on
entities](https://github.com/ufal/UMR/blob/main/doc/entities.md). Named
events are typically very complex processes that do not map easily to verbs
with one actor and one patient. Nevertheless, they are processes, which means
that the UMR guidelines want them annotated as events. At the same time, they
have their class and types in Table 5 (the taxonomy of named entities), which
means that the guidelines want them annotated as named entities. This is a
conflict between different parts of the guidelines, which must be resolved
somehow.

DZ: A possible compromise would be to annotate named events primarily as
events, but with the `:wiki` attribute and `:name` relation used similarly to
named entities. Hence [cs] _válka_ "war" would be mapped to the same concept
as the verb _válčit_ "wage war" (possibly to
[SynSemClass](https://lindat.mff.cuni.cz/services/SynSemClass40/SynSemClass40.html)
class `vec01002` _(fight, bojovat)_). The type `war` of class `event` in
[Table 5 of the
guidelines](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-2-named-entities)
would not be used as an abstract concept.

ML: How to add event annotation to event nominals?  
Probably should be represented as some relevant verb, e.g., *válka* should be the same concept as *válčit* (which is contained in the PDT-Vallex with ACT=ARG0, ADDR=ARG1, PAT=ARG1 (ARGs according to *fight-01*)), see below for two proposed annotations (*válka mezi Indií a Pákistánem o Kašmír* *and Před 80 lety Německo přepadením Polska rozpoutalo druhou světovou válku.*).  
But there is a problem with event nominals with no clear ??morphological verbal counterpart ... see the discusion on *jídlo* vs. *food* above and [the UMR guidelines issue](https://github.com/umr4nlp/umr-guidelines/issues/16).

```
válka mezi Indií a Pákistánem o Kašmír "the war between India and Pakistan for Kashmir"
(v/ válčit-003
    :pdt-vallex "v-w7509f1"
    :wiki "Q198"
    :ARG0 (c/ country
        :wiki "Q668"
        :name (n/ :op1 "Indie"))
    :ARG1 (c/ country
        :wiki "Q843"
        :name (n/ :op1 "Pákistán"))
    :ARG2 (c/ local-region
        :wiki "Q43100"
        :name (n/ :op1 "Kašmír"))
```

Examples:
* [cs] *druhá světová válka* <br>
  [en] WW II ... ?? should be anchored to https://www.wikidata.org/wiki/Q362
* [cs] *válka na Ukrajině*  ... ?? https://www.wikidata.org/wiki/Q110999040
* [cs] _Benátská noc_ (https://www.wikidata.org/wiki/Q11131287)


```
(w/ war
    :wiki "Q110999040"
    :name (n/ name
        :op1 "Ruská"
        :op2 "invaze"
        :op3 "na"
        :op4 "Ukrajině"))
```




Examples:
 * [cs] Před 80 lety Německo přepadením Polska rozpoutalo druhou světovou válku.<br>
 * [en] 80 years ago, Germany started World War II by invading Poland.

```
(r/ rozpoutat-01
    :ARG0 (c/ country
        :synsemclass "???"
        :wiki "Q7318"
        :name (n/ :op1 "Německo"))
    :ARG1 (v/ válčit-01
        :synsemclass "vec01002"
        :wiki "Q362"
        :name (n2/ :op1 "druhá" :op2 "světová" :op3 "válka")))
```

DZ: _Válčit_ is an event and it could have :ARGX relations but it does not
have them because they are not expressed in the sentence. (One could deduce
that _Německo_ is one of the actors of _válčit_ but the sentence does not say
it explicitly.) Note that Wikidata
[Q7318](https://www.wikidata.org/wiki/Q7318) is the entry for Nazi Germany,
not for the current country, which has
[Q183](https://www.wikidata.org/wiki/Q183).

CA: Some examples in Spanish/English of other named events with a link to Wikidata that could be also annotated as events:

* [spa] España recuerda el papel de Adolfo Suárez en la Transición.
* [en] Spain remembers the role of Adolfo Suarez in the [Spanish transition to democracy](https://www.wikidata.org/wiki/Q874209)

* [spa] Esta situación no va a cambiar tras el anuncio del cese definitivo de la actividad armada de ETA. 
* [en] This situation is not going to change after the [announcement of the definitive cessation of ETA's armed activity](https://www.wikidata.org/wiki/Q5700633)

**(2) non-PROCESSESS packed as predication should be linked to frame files:**
- OK states in predication ...  prototypically adjectives, but also other nominal modifiers as PPs, relative clauses, participles<br>
    *Those thorns **are sharp**.*
    *My cat **loves** wet food.*
- OK entities in predication ... non-verbal clauses with nouns as predicates<br>
    *It **is a thorn**.*


>RULE 4
>- non-eventive concepts should be linked to wiki

**(3) STATES in modification or reference should be linked to wiki:**
- **??** states in reference ... what to do with them? (sharpness https://www.wikidata.org/wiki/Q55433472 )
- **??** states in modification ... either without any mapping OR, contrary to the guidelines, as eventive concepts (being tall)

DZ: I think that primary anchoring of states should be in SynSemClass. It
should provide anchors for all processes and states, regardless whether they
are packaged as predication, modification, or reference.

**(4) ENTITIES in modification or reference should be linked to wiki:**

- **specific entities**  (***Barack Obama***, ***Barack Obama's** cabinet*)

Specific entities (instances) should be linked to Wikidata if they have
an entry there. Regardless of information packaging. And even if the specific
mention does not use the name (e.g., if the mention is _president_ but it is
clear that it refers to Barack Obama, it should be linked to [Barack
Obama](https://www.wikidata.org/wiki/Q76)).  
If the entity does not have an entry in Wikidata, we must create an entry for it in our local database, so
that we can cross-reference that entity from various places even in different
documents.

- **generic entities** (*sharp **thorns***, *(any) **bush’s** thorns*, *(any) **president***) 

Furthermore, we also want to anchor the generic type of the entity.  
This is relatively easy for **generic mentions**. If the sentence is _One day I want
to be president_, we can link _president_ to the [corresponding Wikidata
entry](https://www.wikidata.org/wiki/Q30461). Again, in the unlikely case
that there is no such entry, we can create one in our local database.  
DZ: For **specific mentions** it is trickier. In theory, the specific Wikidata entry
should contain information that gives us the type. But if we linked the word
_president_ to the entry of Barack Obama, we will not get a one-click way to
the entry of president. According to Wikidata, Barack Obama is an instance of
a [human](https://www.wikidata.org/wiki/Q5). In the list called `position
held`, we learn that he was [President of the United
States](https://www.wikidata.org/wiki/Q11696), which is an instance of [head
of state](https://www.wikidata.org/wiki/Q48352) (among other things of which
it is an instance), and also a `subclass` of
[president](https://www.wikidata.org/wiki/Q30461) (and also of _politician_).
Given all this, maybe we want two anchors for a _president_ in a specific
context: one for the individual (Barack Obama) and another for the type that
is closest to the word used in the mention (president).  
ML: If I mention *president* having in mind *president Obama* - is it still a generic entity? I would suppose this falls under specific entities? Or do you mean a context like *Mr. Obama was a president.*? But this will be annotated using the abstract predicate `have-role-91` (based on 3-1-2 (1)), with  *Mr. Obama* mapped to the [Barack
Obama](https://www.wikidata.org/wiki/Q76) and *president* to the respective [Wikidata entry](https://www.wikidata.org/wiki/Q30461). Or do we want to distinguish that we mean *US president* in this case [President of the United States](https://www.wikidata.org/wiki/Q11696)?

```
Mr. Obama was a president.
(h/ have-role-91
      :ARG1 (p/ person :wiki "Q76"
            :name (n/ name :op1 "Mr." :op2 "Obama"))
      :ARG3 (p2/ president
      	    :wiki "Q30461")  ??? OR :wiki "Q11696"
      :aspect State
      :modstr FullAff) 
```

***
***


#### TO READ

- William Croft (2001) *Radical Construction Grammar: Syntactic Theory in Typological Perspective*
- James Pustejovsky et al. (2005) [The Specification Language TimeML](https://www.researchgate.net/publication/242423032_The_Specification_Language_TimeML).

About events expressed as MWE:
- Julia Bonn et al. (2023) *UMR Annotation of Multiword Expressions* (sent by HH)
- William Croft (2021): *Eventive Complex Predicates and Related Constructions* (draft from June 2021, sent by DZ)
- Elena Paducheva?

