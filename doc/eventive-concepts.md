## Eventive concepts

**Eventive concepts** (or **events**) constitute important building blocks in
UMR annotation – their identification is **important for annotation of
participant roles** (as well as for aspect and modality annotation).

(See also the short description in
[terminologie.md](https://github.com/ufal/UMR/blob/main/doc/terminologie.md).)

DZ: The guidelines are not clear enough about the consequences for the
annotation when a concept is or is not treated as an event. We can speculate
that the intended difference is that events have `:ARGX` roles and non-events
do not have them. At least it seems to indirectly follow from some parts of
the guidelines. The guidelines also seem to suggest that the part of the
lexicon that has frame files (i.e., the valency lexicon, defining the `:ARGX`
participants for each predicate) contains concepts that are always events
(eventive concepts), regardless the information packaging (see below);
furthermore, I suspect that the UMR crowd assumes that eventive concepts are
recognizable by a numeric suffix (e.g. `-01`), although no rule makes this
assumption explicit, and one may need the suffix to disambiguate other
concepts. In combination with the more clearly phrased parts of the
guidelines this means that the valency lexicon contains only processes.
States and entities, which may constitute events sometimes but not always,
will be annotated with the help of abstract eventive concepts whenever they
represent events. Even here the guidelines are not consistent because they
say that two-place statives, such as English _love_, will be annotated
without the abstract eventive concepts, that is, they have to be included in
the valency lexicon. It makes the impression that after the nice typological
introduction in [Part
3-1-1](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-1-eventive-concepts)
they slipped back to what is convenient for annotation of English,
distinguishing verbs from adjectives (and not processes from states).



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


#### Semantic type

Semantic type refers to the difference between:
- **entities** (or, objects) ... prototypically **nouns**, but also nominalizations as deadjectival or deverbal nouns or infinitives ... TO READ: Paducheva (1995) – types of (nominal) reference,
- **states** (or, properties) ... prototypically **adjectives**, but also other nominal modifiers as PPs, relative clauses, participles, and
- **processes**  ... prototypically (finite) **lexical verbs**, but also predicate nouns or adjectives, complements.


#### Information packaging

Information packaging, on the other hand, concerns the way how the semantic content is 'expressed', i.e., whether it is packed as
- **reference** (what the speaker is talking about),
- **modification** (additional information provided about the referent), or
- **predication** (what the speaker is asserting about the referents in a particular utterance).

#### Eventive concepts in UMR

> **RULE 1:** (UMR rule)  
> The following should be annotated as an **eventive concept**:
> - whatever is a **process** (semantic type) or
> - whatever is expressed as **predication**.

Putting it differently:

> **RULE 1a:** (based on the UMR rule and on examples provided in the Guidelines)  
> **Processes** packed as **predication** are events (esp. finite action verbs as predicates of main clauses)  
> **Processes** packed as **referents or modifiers** should also be identified as events, esp.:
> - **event nominals** (e.g., _storm, conference, ..._).
> - **complements, infinitives, gerunds** with action verbs (packed as reference, e.g., subject/object clauses, adverbial clauses, non-finite complement)
> - **relative clauses** with action verbs (packed as modification)
> - **participles** with action verbs (packed as modification)
> - **secondary predication** with action verbs (packed as modification)


> **RULE 1b:** (UMR rule)  
> **Entities and states** packed as **predication** are events, esp.
> - **predicate nominals/adjectives, complements** - **_what exactly are meant_**??  
> 
> In particular:
> - **stative verbs** as predicates of main clauses (e.g., _love_),
> - **so called non-verbal clauses** (expressing possession, location, property/object predication, equational)

It implies that states in modification (_The tall man..._; _The man, who is tall..._) and states in reference (_His happiness..._) are not events.

Similarly, entities in modification (_The man, who is a doctor..._) and entities in reference (_The doctor_), are not identified as events.


***

### Identifying eventive concepts – rules applied in annotation of Czech

> **RULE 2:** (internal criterion for Czech)  
> Whenever a **concept** 
> 1) denotes an **activity or a state** (in a broad sense) and  
> 2) **has a roleset**,  
> 
> then represent it as an **event**. i.e., anchor it to the (valency) lexicon (with its roleset)  
> 
> ... _**CONFLICT with UMR guidelines for stative verbs** (if not packed as predication)**!!**_

JH: ***Be conservative (at least for the time being)!***

JH: Discussion on 31.7.2023, see the [31.7.2023 meeting
minutes](https://github.com/ufal/UMR/tree/main/doc/minutes-from-meetings):
“We do not want to add a big number of nouns / adjectives to the lexicon OR
represent them as verbs, unless we have a clear case of a deverbal noun
(ending with -ní/-tí) or deverbal adjective (see below) ... YES – morphological
criterion!!!”

Thus:

* _dělat_ “do” is an event because it is a verb, it denotes a process and it has a frame file.
* _mýt_ “wash” is an event because it is a verb, it denotes a process and it has a frame file.
* _milovat_ “love” is an event because it is a verb and it has a frame file; although it denotes a state, we will treat it always as an event, regardless information packaging **(conflict with UMR guidelines).**  
---
* _dělání_ “doing”, _mytí_ “washing”, _milování_ “loving, making love” are events if they denote an activity or state  because they are deverbal nouns, derived using the most productive _-ní/-tí_ suffixes;  
  * BUT: _mytí_ (lit. washing) as "a small hygienic bag", šití (lit. sewing) as "sewing kit" are (deverbal) nouns denoting things (in a strict sense) and as such, they should be annotated as entities ?
* _prodej_ “sale” is not an event – it is a deverbal noun but it is derived (from _prodávat_ “sell”) in a less productive way; ML: ??it has an entry and thus a roleset in PDT-Vallex - should it be annotated as event ??; note that the much less frequent _prodávání_ “selling” is an event **(conflict with UMR guidelines).**
* _válka_ “war” is a noun not derived from verb with the _-ní/-tí_ suffixes, despite denoting processes; ML: ??it has two entries (and thus rolesets) in PDT-Vallex - should it be annotated as event ??
* _koncert_ “concert” is a noun not derived from verb with the _-ní/-tí_ suffixes, despite it denotes a process. It is not annotated as an event **(conflict with UMR guidelines).**
---
* _myjící_ “washing” is an event because it is an active participial adjective derived from the present converb.  
ŠZ: what about conversions such as cestující (lit. the travelling) in the sense of the "passenger"? 
ML: ?? in the same way es e.g., teacher, thus ARG0-of _cestovat_??

* _mycí_ “to be used for washing” is not an event because it is a different type of derivation **(conflict with UMR guidelines?).**
  * Analogously, _dělající, milující, skládající, plovoucí, plnící_ are events while _skládací, plovací, plnicí_ are not.
* _udělavší_ “having done” is an event because it is an active participial adjective derived from the past converb.
* _udělaný_ “done” is an event because it is a passive participial adjective. Analogously, _mytý, umytý, milovaný_ are events.
* Derivations of adjectives from the l-participle are less productive. Therefore, _spadlý_ “fallen”, _vzrostlý_ “full-grown”, _bývalý_ “former” etc. are not events.
* Other deverbal adjectives are also not events: _kulhavý_ “limping”, _učenlivý_ “quick to learn”, _představitelný_ “imaginable”, _obstojný_ “passable”.

Examples:

* [cs] _Muzeum **zaplatí** necelé 2 milióny korun za novou střechu._  
  [en]  _The museum will **pay** almost 2 million crowns for a new roof._  
    ... process (_zaplatit, pay_) in predication --> 1 event (OK both rules)
* [cs] _Než **šla** do školy, **opravila** mi kolo._  
  [en] _Before she **went** to school, she **repaired** my bike._ (from the UMR Guidelines)  
    ... both processes in predication --> 2 events (OK both rules)
* [cs] _**Chtěla** **jít** do školy._  
  [en] _She **wanted** to **go** to school._ (from the UMR Guidelines)  
    ... state in predication (_want, chtít_) PLUS process in ?modification (_go, jít_)
    --> 2 events (UMR rule), 1 event in PDT ... see [One or two concepts?](https://github.com/ufal/UMR/blob/main/doc/one-or-two-concepts_modal-phase-verbs.md)  
    --> OK, annotate it as a single event in Czech (allowed by UMR guidelines)
  * **BUT:** [cs] _**Chtěla,** abych **šel** do školy._  
  [en] _She **wanted** me to **go** to school._  
    ... state in predication (_want, chtít_) PLUS process in reference/modification (_go, jít_)
    --> 2 events (OK both rules)

#### Annotation of (Lexical) Verbs -- action verbs vs. state verbs


DZ: Note that the [English state verbs](https://www.ecenglish.com/learnenglish/lessons/what-are-state-verbs)
are recognized by tests that are grammatical rather than semantic (you cannot use the progressive tense).
Other languages may not have similar tests, or the tests may result in a different set of verbs.
For example, [in Czech](https://www.czechency.org/slovnik/SLOVESO), examples of state verbs _(stavová slovesa)_ include _stát_ "stand", _mít_ "have", _patřit_ "belong";
_to stand_ would perhaps not be grammatically a state verb in English, but semantically it is a state both in Czech and in English.

There is a gray zone with verbs such as _sleep_ or _sit_.
They may not be "state verbs" according to the English grammar (it is grammatical to say _I am sleeping_ or _I am sitting on the couch_) but semantically they seem to be states rather than processes.
Sitting generally does not involve any activity or any changes; the only possible change is the end of this state by changing
to another state (_standing, lying, going..._)
_Sleeping_ might be different, although also almost constant from the perspective of an observer.
It may involve micro-sub-processes (_snoring, turning, dreaming_), and it may have a result at the end (compare it to _recharging battery_).
So maybe _sleeping_ is a process, even if not a frantic one.

ML: There is a simple Czech test for distinguishing state verbs (stavová slovesa) and action verbs (dějová / činnostní):
-  action verbs ... _Co dělám? Běžím._ "What am I doing? I'm running."
-  state/stative verbs ... _Co se děje se mnou? Mám dost peněz._ "What is happening to me? I have enough money."

The test illustrates also borderline cases like _stát_, as you can ask both questions  _Co dělám? Co se děje se mnou? Stojím._ "What am I doing? What is happening to me? I'm standing."

See also [SaS 17(4)](http://nase-rec.ujc.cas.cz/archiv.php?art=2685).

As there is no clear boundary between action and state verbs in Czech, we want to avoid distinguishing between these two classes -- both types should be anchored in SynSemClass (PDT-Vallex), regardless of their information packaging (predication, modification, or reference).


> **RULE 2a:** (internal criterion for Czech verbs)
> - **Verbs** denote processes (action verbs) and states (state verbs). Both types should be annotated as events (regardless of their information packaging) and thus anchored in the lexicon (with their rolesets).
> ... ***CONFLICT with UMR guidelines for state verbs!!***
> - **Verbonominal predicates** (predicate nominals/adjectives) - nouns/adjectives in predication; the whole predicate as a single predication (thus a single event) (see below Rules 2b for nouns and 2c for adjectives).
> - **Complex predicates** (= light verb constructions) should be identified as events (a single predication, thus a single event).
> - **Secondary predication** (= doplněk) should be annotated as an event.

##### Action and state verbs

Examples:

* [cs] _Moje kočka **nesnáší** granule._  
  [en] _My cat **loves** wet food._ (from the UMR Guidelines)
    ... state in predication (_nesnášet_ "hate"), thus should be annotated as an event, see [3-1-1-3](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-1-3-states-and-entities), where the guidelines explicitly acknowledge that there can be two-place states, and [en] _love_ is an example.
   --> event (OK both rules)

* [cs] _Student **hrající** na housle **má rád** Bacha._  
  [en] _The student **playing** the violin **likes** Bach._ (from the UMR Guidelines)  
    ... process in modification (_hrát_ "hrát") PLUS state in predication, thus eventive, see below (_mít_rád_ "like, ")
    --> 2 events (OK both rules)

* [cs] _Student, který **hraje** na housle, **má rád** Bacha._  
  [en] _The student, who is **playing** the violin, **likes** Bach._ (from the UMR Guidelines)  
    ... process in modification (_hrát_ "play") PLUS state in predication, thus eventive (_mít_rád_ "like")
    --> 2 events (OK both rules)

* [cs] _Nikdo si **nevšiml**, že **přišla**._  
  [en] _Nobody **noticed** that she **arrived**_  
    ... process/state in predication (_všimnout_si_ "notice") PLUS another process  (_přijít_ "arrive"), no matter how packed
    --> 2 events (OK both rules)

  * **BUT:** [cs] _Jejího **příchodu** si nikdo **nevšiml**._  
  [en] _Nobody **noticed** her **arrival**._  
    ... process/state in predication (_všimnout si_ "notice") PLUS process packaged as reference  (event nominal _příchod_ "arrival")  
    -->  just 1 event in Czech data (event nominal _příchod_ "arrival" not identified as event, see Rule 2b for nouns below)  
    --> **BUT:** 2 events (UMR rules)

* [cs] _**Zaskočilo** mě, jak rychle **se vrátila**._  
  [en] _It **surprised** me how quickly she **returned**._  
    ... process/state in predication (_zaskočit_ "surprise") PLUS another process (_vrátit_se_ "return"), no matter how packed
    --> 2 events (OK both rules)

  * **BUT:** [cs] _Její rychlý **návrat** mě **zaskočil**._  
  [en] _Her quick **return** **surprised** me._  
    ... process/state in predication (_zaskočit_ "surprise") PLUS process in reference (event nominal _návrat_ "return"0 - ML: BUT has a roleset in PDT-Vallex !!
    -->  ?? just 1 event in Czech data (event nominal _návrat_ "return" not identified as event, see Rule 2b for nouns below)
    --> **BUT:** 2 events (UMR rules)

* [cs] _Kdo **neriskuje**, **nevyhraje**._  
  [en] _He who **does not risk**, **does not win**._  
  ... this is a *relative* subject clause, although it lacks the governing nominal in the Czech version.
      It should be analyzed using the abstract concept `person` modified by the risking concept.  Risking is a process, hence it is still treated as event, despite being packaged as modification. There is another process there (_vyhrát_ "win") packed as predication (the main clause)
         --> 2 events by both rules OK

  * **BUT:** [cs] _Kdo **není mazaný**, **nevyhraje**._  
  [en] _He who **is not cunning** **does not win**._  
  ... a variant of the previous example. Now we have a state (not process) in modification (hence not event according ti the UMR Guidelines);  
  BUT the subject clause with a verbonominal predicate (with `have-mod-91`), thus should be annotated using this predicate (non-verbal clause); see also Rule 2c for adjectives
    -->  just 1 event (UMR rules)
    --> **BUT:** 2 events in Czech annotation

* [cs] _Moje dítě **sedí** na lavičce._  
  [en] _My child **is sitting** on a bench._  
       ... state in predication (_sedět_ "sit") PLUS modification (_můj_ "my")
       --> 1 event (OK both rules)
  * **BUT:** [cs] _Dítě sedící na lavičce **je moje**._  
  [en] _The child sitting on the bench **is mine**._  
         ... here the _sitting state_ is in modification, hence not an event based on original UMR rules (but anchored in the valency lexicon in Czech data in the same way as action verbs);  
       ... the other state (_můj_ "mine") is in predication, hence it is an event (if we consider _being somebody's_ as a verbonominal predicate, probably with *být-007* or its -91 analogy), see also Rule 2c for adjectives
--> 2 events in Czech annotation

* [cs] _Pokud teplota **klesne** pod 7 stupňů, **nasadíme** zimní pneumatiky._  
  [en] _If the temperature **drops** below 7 degrees, we **will put on** winter tires._  
  ... process in adverbial clause (_klesnout_ "drop") is an event.
--> OK both rules

* [cs] _Když **budeš hodný**, **koupíme** ti zmrzlinu._  
  [en] _If you **are nice**, we **will buy** you ice cream._  
  ... state in adverbial clause (_hodný_ "nice") is also an event because it is in predication.
--> OK both rules

* [cs] _Děti **jedly** zmrzlinu **sedíce** v autě._  
  [en] _**Sitting** in the car, the children **ate** ice cream._  
  ... the converb is a non-finite adverbial clause, hence a state in predication (_sedět_ "sit"), hence an event.
  --> OK both rules

##### TODO Verbonominal predicates
Nouns/adjectives in predication; the whole predicate as a single predication (thus a single event) (see below Rules 2b for nouns and 2c for adjectives)

##### TODO Complex predicates

##### Secondary predication
Examples:

* [cs] ***Koupala se** v jezeře **nahá**.*
  [en] *She **swam** in the lake **naked**.*
  ... state in secondary predication (*nahý*, *naked*) is an event.
   --> OK 2 events by both rules


##### Note on causal relationships
Causal relationship should be annotated as events if packaged as predication (and as non-events otherwise).

Examples:

* [cs] ***Exploze** **způsobila** **zhroucení** domu.*
  [en] *The **explosion** **caused** the house **to collapse**.* (from the UMR Guidelines)
    ... three eventive concepts: 1 causal verb in predication (*cause*, *způsobit*), 1 complement/nominalization (*collapse*, *zhroucení*), 1 event nominal in reference (*explosion*, *exploze*)
    Alternative rule 2 (deverbal noun but not ending with *-ní,-tí*): explosion probably not as an eventive concept?

* [cs] *Dům se **zhroutil** kvůli **explozi**.*
  [en] *The house **collapsed** because of the **explosion**.* (from the UMR Guidelines)
    ... two eventive concepts: 1 process in predication (*collapse*, *zhroutit se*) and 1 event nominal in reference (*explosion*, *exploze* - but see above); causal relationship not expressed in predication
* [cs] *Dům se **zhroutil**, protože v něm něco **explodovalo**.*
  [en] *The house **collapsed** because something **exploded** in it.*
        ... main clause and adverbial clause, each with one event (process in predication); the causal relationship (*protože*, *because*) is not an additional event.

Some languages (e.g., Basque) have morphological causative:
* [eu] (a) *Zopa izugarri **gustatzen zaio** mutilari.*
   lit. "soup greatly pleasing it.is.it to.boy"
  [en] "The boy likes the soup." (normal active voice)
* [eu] (b) *Goseak zopa izugarri **gustatuerazi zion** mutilari.*
   lit. "hunger soup greatly made.pleasing it.has.it.it to.boy"
  [en] "Hunger made the boy like the soup." (causative voice)
 ... (DZ) I suppose that both in (a) and in (b) there is just one event (*gustatzen* "like"). It is a state but it is packaged as predication. Or should we decompose (b) to two events (causing and liking)?


#### Annotation of nouns -- event nominals  vs. primary nouns

> **RULE 2b:** (internal criterion for Czech nouns)
> - **(Primary) nouns** typically denote entities (in reference), thus without a roleset.
> - **Event nominals ending with _-ní/-tí_** should be represented as coresponding verbs (e.g., _přijíždění_ "arrival")ŠZ: again - are all these nominal expressing an event? Cf. šití (lit. sewing) as a sewing kit.
> - **Agentive nouns** (e.g., _učitel_"teacher", _řidič_ "driver") represented as ARG0-of the respective noun
> - **Other event nominals** (e.g., _příjezd_ "arrival", _jídlo_ "food") represent as entities (unless they are already covered by the valency lexicon)
> ... ***CONFLICT with UMR guidelines with event nominals!!***
> - **Verbonominal predicates** (predicate nominals) - nouns in predication; the whole predicate as a single predication (thus a single event).

**JH: Discussion on 31.7.2023**, see the [31.7.2023 meeting minutes](https://github.com/ufal/UMR/tree/main/doc/minutes-from-meetings):
"We do not want to add a big number of nouns / adjectives to the lexicon OR represent them as verbs, unless we have a clear case of a deverbal noun (ending with -ní/-tí) / deverbal adjective (??). ... YES - morphological criterion!!!"

##### TODO (Primary) nouns

Examples:

##### TODO Event nominals ending with _-ní/-tí_**

Examples:

##### TODO Agentive nouns
BUT agentive nouns like teacher, driver … as ARG0 of the respective verb (teach-01, drive-01) even in context different than teaching, driving (intention of the speaker to use just these nouns)	
 a nekonzistence v guidelines
??? to be changed in the internal guidelines https://github.com/ufal/UMR/blob/main/doc/eventive-concepts.md

##### TODO Entities as non-agentive participants
According to the guidelines, *driver* treated as an entity ([ex.](https://github.com/umr4nlp/umr-guidelines/blob/cbcb2555b36e99c7dc296f4fb3264136a31db953/guidelines.md?plain=1#L961-L974))
but *teacher* as  ARG0-of teach-01 ([ex.](https://github.com/umr4nlp/umr-guidelines/blob/cbcb2555b36e99c7dc296f4fb3264136a31db953/guidelines.md?plain=1#L3339-L3341))
even in mentions where there is nothing about teaching :-((

DZ: See also [issue 16 in UMR guidelines](https://github.com/umr4nlp/umr-guidelines/issues/16).

**JH: Discussion on 31.7.2023**, see the [31.7.2023 meeting minutes](https://github.com/ufal/UMR/tree/main/doc/minutes-from-meetings):
"We do not want to add a big number of nouns / adjectives to the lexicon OR represent them as verbs, unless we have a clear case of a deverbal noun (ending with -ní/-tí) / deverbal adjective (??). ... YES - morphological criterion!!!"

Examples:
* [cs]  *jídlo* ([en] *food*)
 ... should not be represented as `ARG1-of jíst-001` ([en] *eat*) but as an entity (as it can be related also to other eventive concepts as, e.g., *vařit* ([en] *cook*)

BUT agentive nouns like *teacher*, *driver* should be annotated as `ARG0-of` the respective verb (`teach-01`, `drive-01`) even in context different than teaching, driving (intention of the speaker to use just these nouns)

* [la] *praefectus* (en. *prefect*).
Originally *praefectus* is a past participle of *praeficio* meaning 'to put in charge', but it also occurs as a substantive. This alternation is reflected in the grammatical case its dependents occur in. Examples:
  -    *praefectus praetorio* (en. praetorian prefect): *praetorio* in dative, because the verb requires dative case.
  -    *praefectus annonae* (en. prefect of the provisions): *annonae* unclear, could be either dative or genitive.
  -    *praefectus Alexandreae et Aegypti*, *praefectus classis* (en. prefect of navy), *praefectus vigilum* (en. prefect of the watchmen): genitive case is used,         as in any nominal modification.
-->  *Praefectus* behaves like a substanstive, like *driver*/*teacher* (main difference: it has passive meaning).

<!-- ##### Previous discussion:

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
food)` because there is no visible grammatical link between _food_ and _eat_.-->

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

##### TODO Other event nominals
Examples:
* [cs] _**Bouře** **poničila** střechu._
  [en] _The **storm** **damaged** the roads._ ([3-1-1-2 (1a)](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-1-2-processes-in-modification-and-reference))
    ... a process in predication (_poničit_ "damage"),
    ... the `:ARG0` of which is an event nominal (_bouře_ "storm", in reference) indicating another process
    --> 2 events (the UMR rule)
    Czech: There is the verb _bouřit_ in PDT-Vallex but (limiting event nominals to those with the _-ní/-tí_ endings) shall be annotate as non-eventive
    --> 1 event in Czech annotation

* **Compare also to [3-2-1-1 (7g)](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-2-1-1-stage-0):**
  [cs] _**Bouře** **poničila** elektrické vedení._
  [en] _The **storm** **damaged** the  power lines._ (3-2-1-1 (7g))
    ... analysed as a single event (_damage_), with an non-eventive concept (_storm_) as a `:force` role (**???** not in PropBank for damage-01)
    --> 1 event (both UMR for Eng and Czech)


ŠZ: other examples of possible processes: *Christmas, wind, (financial) inflation*

- **??** states in reference ... what to do with them? (sharpness https://www.wikidata.org/wiki/Q55433472 )

##### TODO Verbonominal predicates
Examples:


#### Annotation of adjectives -- event nominals  vs. primary nouns

> **RULE 2c:** (internal criterion for Czech adjectives)
> - **(Primary) adjectives** typically denote state (in modification), thus without a roleset (_chytrý_ "clever", _vysoký_ "tall").
> - **Deverbal adjectives (participles)** should be mapped onto coresponding verbs as ARGx-of (e.g., _přijíždějící_ "arriving"))
> - **Other deverbal adjectives** ... ??? should be mapped onto coresponding verbs as ARGx-of ??? )
> - **Verbonominal predicates** (predicate adjectives) - adjectives in predication; the whole predicate as a single predication (thus a single event)

***JH: Be conservative with reification (reification = converting a role into a concept)!***

**JH: Discussion on 31.7.2023**, see the [31.7.2023 meeting minutes](https://github.com/ufal/UMR/tree/main/doc/minutes-from-meetings):
"We do not want to add a big number of nouns / adjectives to the lexicon OR represent them as verbs, unless we have a clear case of a deverbal noun (ending with -ní/-tí) / deverbal adjective (??). ... YES - morphological criterion!!!"

##### TODO (Primary) adjectives

DZ: I think that primary anchoring of states should be in SynSemClass. It
should provide anchors for all processes and states, regardless whether they
are packaged as predication, modification, or reference.

ML: We do not want to **add primary adjectives** (like *chytrý*, *vysoký*, *clever*, *high*) to the SynSemClass lexicon, thus they will be annotated as non-eventive concepts (contrary to proposal by Dan).

Compare the UMR examples:
* [en] 3-1-1-3 (2a) *The tall man ...* (the UMR graph by ML, guidlines only says that this is not an event),
* [en] 3-1-1-3 (2b)  *The man, who is tall ...*
* [en] 3-3-1-3 (1b) *The doctor is tall.*

```
 3-1-1-3 (2a) The tall
 (m/ man
	:mod(t/ tall))		
```

```
The doctor is tall.
(h/ have-mod-91
	:ARG1 (d/ doctor
		:ref-number Singular)
	:ARG2 (t/ tall)
	:aspect State
	:modstr FullAff)
```


##### Deverbal adjectives (participles)
Examples:
* [cs] _Náměstí bylo plné **tančících** lidí._  
  [en] _The square was full of **dancing** people._  
    ... here we have a process (_tančit_ "dance") in modification; it will be annotated as an event
    --> OK both rules

* Similarly: [cs] _**válčící** strany_ (lit. warring/fighting parties, enemies)
... the parties are in a real fight as a process, thus the word _válčit_ is an event.
 --> OK both rules

##### TODO Other deverbal adjectives
?????
(e.g., _podobný_ "resembing" --> _podobat se_ "resembe" (based on the derivative morphology!)

Compare also the AMR guidelines, sect. [Adjectives that invoke predicates](https://github.com/amrisi/amr-guidelines/blob/master/amr.md#adjectives-that-invoke-predicates)
* [en] *the attractive man* = the man who is ARG0-of attract-01
 	the same solution for Eng. adjectives ending with *-ed* (*acquainted*)
	the same solution for other types of endings, like *-able* (*edible*), *-ful*,
	... OK for CZ (morphology!)
* [en] to be+adjectives … often exist natural corresponding verbal predicates
   *The soldier was aware of the battle.* ... be aware (of X) --> realize-01
   ... NOT for CZ ?
* [en] adjectives without natural verbal predicates … create predicate!!
 *be responsible (for X)* --> `responsible-01` (cause), `responsible-02` (trustworthy), `responsible-03` (duty)
*be nervous (about X)* --> `nervous-01`
*be serious (about X)*  --> `serious-01` (no kidding), `serious-02` (grave)
... NOT for CZ ??
* [en] adjectives like *sad*, *white*, and *free* … as predicates if there is an implied event or proces
... NOT for Czech ??

##### TODO Verbonominal predicates**

* [cs] _**Překvapilo** mě, jak **chytrý byl**._  
  [en] _It **surprised** me how **smart** he **was**._  
  ... subject clause is reference to a state (_chytrý_, "smart"), hence it is not an event; another ?state in predication (_překvapit_, "surprise"), thus event 
  _být chytrý_ as a predication (verbonominal predicate, probably with *být-007* or its -91 analogy)
  --> 2 events in Czech data

  * **BUT:** [cs] *Jeho **chytrost** mě **překvapila**.*  
  [en] *His **smartness** **surprised** me.*  
  ... subject clause is reference to a state in reference (deadjectival nouns _chytrý_, "smart"), hence it is not an event.; another ?state in predication (_překvapit_, "surprise"), thus event
   --> 1 event by both rules, OK

* [it] _ambasciatore **itinerante**_ (en. *ambassador-at-large*? check [wikipedia](https://en.wikipedia.org/wiki/Ambassador-at-large#:~:text=An%20ambassador%2Dat%2Dlarge%20is,country%20and%20its%20people%20internationally.))
    *itinerante* as event or entity ???
    ML: compound, thus entity (not process)?

* [cs] _**Řekl jsem,** že **je chytrý**._  
  [en] _I **said** that he **is smart**._  
  ... complement clause is reference to a state (_chytrý_ "smart"), hence it is not an event according to trhe UMR rules
     **BUT** there is a predication there (verbonominal predicate _být chytrý_ "be smart"), thus will be annotated as a "non-verbal clause" with the `have-mod-91` predicate (property)

* [cs] _Moje dcera **netouží** **být dospělá**._  
  [en] _My daughter **does not long** for **being adult**._  
  ... complement clause is reference to a state (_dospělý_ "adult"), hence it is not an event; another state in main predication (_toužit_ "long"), thus event
       **BUT** _být dospělá_ is a verbonominal predicate, thus will be annotated as a "non-verbal clause" with the `have-mod-91` predicate (property),

 **Compounds with adjectives:**
* [en] _**firing** squad_ (cs. "popravčí četa", from the UMR Guidelines)
    ... compound, thus entity (not process)
    --> OK both rules

* BUT [en] _**floating** hospital_ (from the UMR Guidelines)
    ... _floating_ as an event ... BUT "The Floating Hospital" is a non-profit organization ??? https://en.wikipedia.org/wiki/Floating_Hospital
    --> OK both rules

* [cs] _**Tančící** dům_  (en. "Dancing House")
    ... a name of a [building in Prague](https://cs.wikipedia.org/wiki/Tan%C4%8D%C3%ADc%C3%AD_d%C5%AFm); the house is not really dancing, hence _tančící_ does not denote a process in this context
    --> OK both rules

* Similarly: [cs] _**létající** pivovar_ ("gypsy brewery", lit. "flying brewery")
... a brewery company (society) working in different rental eqipped brewery houses - not an event
--> OK both rules



***

### Previous discussions

###### (1) OK PROCESSESS should be linked to frame files
- **NO for processes in reference with generic mentions** (*war, storm, ceremony, válka, bouře*)
      Add the `:wiki` attribute and the `:name` relation (similarly to named entities) whenever possible!
- **NO for processes in reference with specific mentions**
     Should be primarily anchored in wikidata/wikipedie/ !!

~~DZ: See also [issue 14 in UMR
guidelines](https://github.com/umr4nlp/umr-guidelines/issues/14), as well as
[the document on
entities](https://github.com/ufal/UMR/blob/main/doc/entities.md). Named
events are typically very complex processes that do not map easily to verbs
with one actor and one patient. Nevertheless, they are processes, which means
that the UMR guidelines want them annotated as events. At the same time, they
have their class and types in Table 5 (the taxonomy of named entities), which
means that the guidelines want them annotated as named entities. This is a
conflict between different parts of the guidelines, which must be resolved
somehow.~~
**ML: Based on the provisional solution for Czech annotation: this type of even nominals not anchored in the valency lexicon?** [31.7.2023 meeting minutes](https://github.com/ufal/UMR/tree/main/doc/minutes-from-meetings))

~~DZ: A possible compromise would be to annotate named events primarily as
events, but with the `:wiki` attribute and `:name` relation used similarly to
named entities. Hence [cs] _válka_ "war" would be mapped to the same concept
as the verb _válčit_ "wage war" (possibly to
[SynSemClass](https://lindat.mff.cuni.cz/services/SynSemClass40/SynSemClass40.html)
class `vec01002` _(fight, bojovat)_). The type `war` of class `event` in
[Table 5 of the
guidelines](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-2-named-entities)
would not be used as an abstract concept.~~
**ML: Based on the provisional solution for Czech annotation: this type of even nominals not anchored in the valency lexicon?** [31.7.2023 meeting minutes](https://github.com/ufal/UMR/tree/main/doc/minutes-from-meetings))

~~ML: How to add event annotation to event nominals?
Probably should be represented as some relevant verb, e.g., *válka* should be the same concept as *válčit* (which is contained in the PDT-Vallex with ACT=ARG0, ADDR=ARG1, PAT=ARG1 (ARGs according to *fight-01*)), see below for two proposed annotations (*válka mezi Indií a Pákistánem o Kašmír* *and Před 80 lety Německo přepadením Polska rozpoutalo druhou světovou válku.*).
But there is a problem with event nominals with no clear morphological verbal counterpart ... see the discusion on *jídlo* vs. *food* above and [the UMR guidelines issue](https://github.com/umr4nlp/umr-guidelines/issues/16).~~
**ML: Based on the provisional solution for Czech annotation: this type of even nominals not anchored in the valency lexicon?** [31.7.2023 meeting minutes](https://github.com/ufal/UMR/tree/main/doc/minutes-from-meetings))

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

**Proposed solution (at least for the time being)**: We will stick to the PDT criteria and will not represent event nominals (others than those ending with *-ní/-tí*) as verbs (see the alternative rules and the discussion above)!
 Thus the example above is too advanced :-)


Examples:
* [cs] *druhá světová válka*
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
 * [cs] Před 80 lety Německo přepadením Polska rozpoutalo druhou světovou válku.
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

~~DZ: _Válčit_ is an event and it could have :ARGX relations but it does not
have them because they are not expressed in the sentence. (One could deduce
that _Německo_ is one of the actors of _válčit_ but the sentence does not say
it explicitly.) Note that Wikidata
[Q7318](https://www.wikidata.org/wiki/Q7318) is the entry for Nazi Germany,
not for the current country, which has
[Q183](https://www.wikidata.org/wiki/Q183).~~
ML:  Thus the example above is too advanced :-)
**ML: Based on the provisional solution for Czech annotation: this type of even nominals not anchored in the valency lexicon?** [31.7.2023 meeting minutes](https://github.com/ufal/UMR/tree/main/doc/minutes-from-meetings))

CA: Some examples in Spanish/English of other named events with a link to Wikidata that could be also annotated as events:

* [spa] España recuerda el papel de Adolfo Suárez en la Transición.
* [en] Spain remembers the role of Adolfo Suarez in the [Spanish transition to democracy](https://www.wikidata.org/wiki/Q874209)

* [spa] Esta situación no va a cambiar tras el anuncio del cese definitivo de la actividad armada de ETA.
* [en] This situation is not going to change after the [announcement of the definitive cessation of ETA's armed activity](https://www.wikidata.org/wiki/Q5700633)

###### (2) OK non-PROCESSESS packed as predication should be linked to frame files


###### (3) OK STATES in modification or reference should be linked to wiki

###### (4) OK ENTITIES in modification or reference should be linked to wiki:**

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

We also want to anchor the generic type of the entity.
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
- Elena Paducheva, 1995

