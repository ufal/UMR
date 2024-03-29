# Frame Files (for verbs) and Rolesets (for verb senses)

UMR [assumes](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-2-1-participant-roles)
that **[events](eventive-concepts.md) are linked to frame files** (also referred to as **rolesets**, might be viewed as composing a valency dictionary) that describe the **participants of the event and their
semantic roles**. The default source of English frame files is PropBank ([version 3.4](http://propbank.github.io/v3.4.0/frames/index.html)). Other
languages may use a similar resource if there is one, or create a lexicon on
the fly when working on UMR annotation.  
The same is also valid for non-eventive concepts related to an event, see the next paragraph.

There is a minor terminological glitch: while all processes are events (even if nominalized, cf. event nominals), states and entities may or may not be events depending on how they are used in the sentence. 
It would not make sense to identify a state with an entry in
a valency lexicon when it is used as an event (that is, in predication) and
to link it to a different entry in another lexicon when it is used in
modification or reference. 
We will thus we assume that **all processes and (some of) states have entries in a valency lexicon**, i.e., their frames are available. 
Entities can be in a separate lexicon. This also relates to anchoring of concepts:
entities are primarily anchored in Wikipedia (Wikidata), while states and
processes would ideally be anchored in the frame file (valency lexicon).  
In addition, **all non-eventive concepts related to an event** (as, e.g., agentive nouns like _teacher_) **are also linked to the respective frames** (via the so-called reification, e.g., _teacher_ is treated as `ARG0-of` the teaching event and thus linked to the respective frame of the verb _teach_ in the lexicon). 

In the long run, we want to use
[SynSemClass](https://lindat.mff.cuni.cz/services/SynSemClassSearch/?version=synsemclass5.0) to anchor
processes and states in a cross-linguistically applicable manner. It
currently contains only samples of verbs from a few languages, but it can be
extended. At present it is not easy to identify a class for a verb (the
interface lists the verb that was selected in each language as the label for
the class, but it does not list the other verbs which have similar meaning
and belong to the same class). A better [search tool is now available](https://lindat.mff.cuni.cz/services/SynSemClassSearch/?version=synsemclass5.0), contains version SynSemClass 5.0 as it is stored in Lindat repository). For the latest version of the data (under development), see http://ufallab.ms.mff.cuni.cz/~fucikova/public_html/SSC_classmembers/.

In the meantime, for Czech (and especially for data from PDT) we can use the
[PDT-Vallex](https://ufal.mff.cuni.cz/pdt-vallex-valency-lexicon-linked-czech-corpora),
searchable [here](http://lindat.mff.cuni.cz/services/PDT-Vallex/) or in Teitok [here](https://lindat.mff.cuni.cz/services/teitok/pdtc10/index.php?action=vallex). 
There are
verbs (both active and stative) but only a small number of other parts of speech denoting processes or states. 
We have [MUST BE RREVISED conversion files](../tecto2umr/pdt_pb_mapping_via_czengvallex_ssc-merged.xlsx) that map the PDT-Vallex frames (column B) to strings that can be used as eventive
concepts in UMR (column A). The concept strings are lemmas of the verbs (infinitives),
always followed by a hyphen and a numeric index. This seems to be required
for eventive concepts in UMR (although the guidelines do not say explicitly
that it is needed). The examples in the guidelines use two-digit indexes (-01
for most predicates) but we use three-digit indexes because some Czech verbs
have more than 99 frames. For the time being, we will use these strings as
concepts. When the usage of SynSemClass is clarified in the future, it will
be possible to automatically map them to SynSemClass. We will create concepts
for states and processes that are not in PDT-Vallex (e.g. states expressed as
adjectives) and take note of them so they can be later added to the lexicon.

Note that some words will be mapped to concepts that are not their lemmas.
Participial adjectives will typically be mapped to verbal concepts. Verbal
nouns will be mapped to corresponding verbal concepts. This holds also about
some deverbal nouns that denote states or processes and are not derived using
the standard _-ní/-tí_ suffixes, such as _dřímota_ “slumber”, _objev_
“discovery”, _ochrana_ “protection” etc.

* _dodělávající_ “finishing” → `dodělávat-001`
* _dodělavší_ “having finished” → `dodělat-001`
* _dodělaný_ “finished” → `dodělat-001`
* _dušení_ “choking” → `dusit-se-001`
* _dřímota_ “slumber” → `dřímat-002`
* _válka_ “war” → `válčit-003`
* _jídlo_ “food” → `jíst-001`


## Verb-specific frames = argument rolesets

Argument roles is another name used for some of the relations under eventive
concepts. UMR [inherits them from AMR](https://amr.isi.edu/doc/roles.html),
which in turn follows OntoNotes (PropBank) conventions. There are six
argument roles: `:ARG0`, `:ARG1`, `:ARG2`, `:ARG3`, `:ARG4`, `:ARG5`. Their
exact meaning depends on each
verb, see the [AMR final list of frames](https://amr.isi.edu/doc/propbank-amr-frames-arg-descr.txt) but there
are still some general tendencies of the correspondence between role number
and the semantic role. Hence not all frames will start with `:ARG0` and use
the subsequent numbers in order.

* `:ARG0` ... typically agent, experiencer. It often corresponds to `ACT` in
PDT.
* `:ARG1` ... typically patient, theme. It often corresponds to `PAT` in PDT.
* `:ARG2` ... typically recipient (besides `:ARG2`, it could also use the
relation `:beneficiary`). It often corresponds to `ADDR` in PDT.

An example of a verb-specific (frame-specific) definition of roles:

* receive-01 ([cs] získat-001) `ARG0`: receiver; `ARG1`: thing gotten; `ARG2`: received from; `ARG3`: price, in exchange for; `ARG4`: attribute of `ARG1`  
e.g., *(The company).ARG0 hadn't yet **received** (any documents).ARG1 (from OSHA).ARG2
(regarding the penalty or fine).ARG4.*

### Argument Roles for Czech verbs

For some Czech verbs, their arguments have already been mapped onto ARGx roles - either within the  SynSemClass project, or within CzEngVallex - the mapping can be found in the [conversion files](../tecto2umr/pdt_pb_mapping_via_czengvallex_ssc-merged.xlsx), column C (via CzEngVallex) and D (via CzEngVallex).  

For verbs without a frame-specific mapping, the default [conversion table](../tecto2umr/functors-to-umrlabels.txt) will be used.

## "Non-verbal Clauses" and their arguments

UMR proposes seven abstract concept predicates (plus two subclasses) for situations where states or
entities are predicated (i.e., they are events), and, as they say, “there is
no overt predicate-word”. They do not say what qualifies as an overt
predicate word. The term _non-verbal clauses_ seems to suggest that predicate
words should be verbs. But they can hardly require it because verb is a
part-of-speech category, and as they say [in the beginning of part
3](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-1-eventive-concepts),
“event identification is not based on parts of speech or word classes, since
these vary greatly across languages.” Indeed, languages such as Chinese
practically do not distinguish state verbs from adjectives.

Therefore, we should not take the word _non-verbal_ too strictly. If we can
create frame files for all processes and states (including states expressed
primarily by adjectives), we can treat all these events as “verbal”.

On the other hand, entities are prototypically not used in predication, we
will not have frames for them and they will be listed in a different lexicon
than a valency lexicon. Nominal predicates where the noun denotes an entity
may be treated as “non-verbal”.

The 7 (or 9) abstract predicates for non-verbal clauses are listed in [Tables 3 and
4](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-1-3-states-and-entities). See also [Lists for UMR tools, sheet Abstract Rolesets](https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit#gid=1927108453) (under non-prototypical pred rolesets): 

* [cs] _Vltava je řeka._ “Vltava is a river.” ... predicational `have-role-91`
* [cs] _Tato řeka je Vltava._ “This river is Vltava.” ... equational `identity-91`

Strictly speaking, such sentences are not completely non-verbal in Czech or
English because they have a verbal copula. In Czech, the copula _být_
corresponds to frame `být-007` (v-w243f80_ZU substituted with v-w243f187_MM).
But in Polish the copula is not verbal, and in Russian there is no copula in
the present tense at all.

* [pl] _Wełtawa to rzeka._ “Vltava is a river.”
* [pl] _Ta rzeka to Wełtawa._ “This river is Vltava.”
* [ru] _Влтава — река._ “Vltava is a river.”
* [ru] _Эта река — Влтава._ “This river is Vltava.”

To ensure cross-linguistically more consistent treatment of such sentences,
the abstract predicates `have-role-91`, resp. `identity-91`, are used in all
languages, regardless whether a copula is used. That is shown in the
guidelines since [part
1](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-1-introduction-what-is-umr-and-what-does-umr-annotation-look-like)
in examples like (2) _Pope is the American businessman who..._
(`identity-91`), or 3-1-2 (1) _Edmond Pope is an American businessman._
(`have-role-91`). The distinction between identity and having role is another
advantage of the abstract predicates: the copula in Czech and English is the
same in both situations. It could be distinguished by different frames, but
for example the Czech valency lexicon (PDT-Vallex) does not distinguish them
and uses `být-007` for both of them.

```
(h/ have-role-91
    :ARG1 (r/ river
        :wiki "Q131574"
        :name (n/ name :op1 "Vltava"))
    :ARG3 (ř/ řeka
        :wiki "Q4022"))
```

```
(h/ have-role-91
    :ARG1 (r/ river
        :wiki "Q131574"
        :name (n/ name :op1 "Wełtawa"))
    :ARG3 (r2/ rzeka
        :wiki "Q4022"))
```

```
(h/ have-role-91
    :ARG1 (r/ river
        :wiki "Q131574"
        :name (n/ name :op1 "Влтава"))
    :ARG3 (р/ река
        :wiki "Q4022"))
```


## Arguments in other "abstract rolesets"

UMR works with a list of so called abstract predicates (each of which has their semantic roles). These predicates are used in annotation to ensure cross-linguistically more consistent treatment of specific constructions. 

Although these abstract predicates are not systematically listed in the Guidelines, we can work with the [Lists for UMR tools, sheet Abstract Rolesets](https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit#gid=1927108453).

There are 4 types abstract rolesets specified in the above lists, serving for:
- non-prototypical pred rolesets (= rolesets for non-verbal clauses), see above;
- implicite roles for specific syntactic constructions;
- reification, and
- discourse relations.

### 1. Implicite roles - Specific semantic concepts and specific syntactic constructions

Examples:

* [en] _"It was **like** mud running down the mountain and it covered the village in seconds," she said, quoting survivors._ (english_umr-0001.txt)  
... with `resemble-91` relation with 2 roles, `ARG1` (for copy, here "thing" as an abstract concept) and `ARG2` (original, here _mud_). 

* [en] _Military helicopters were able to reach the area despite *heavy clouds* but the flights ceased after nightfall because the aircraft did not have night - flying capabilities._ (english_umr-0001.txt)  
* .. where the abstract predicate `weather-91` is used to annotate _heavy clouds_.
 
 * [en] _**The more** I read your stuff, **the more** I am convinced that you have a black heart._  
... where the abstract predicate `correlate-91` is used to annotate the "the X-er, the Y-er" construction and `have-degree-91` to annotate the comparative construction.

```
 (c2 / correlate-91
       :aspect Habitual
       :ARG1 (m / more
                  :frequency-of (r / read-01
                        :ARG0 (p / person
			         :ref-person  1st
				 :ref-number Singular)
                        :ARG1 (s2 / stuff
                              :poss (p2 / person
			                :ref-person 2nd
					:ref-number Singular))))
        :ARG2 (m2 / more
                  :ARG3-of (h3 / have-degree-91
                        :ARG1 0
                        :ARG2 (c / convince-01
                              :ARG1 p
                              :ARG2 (h / have-03
                                    :ARG0 p2
                                    :ARG1 (h2 / heart
                                          :ARG1-of (b / black-06)))))))
```



### 2 Reification

Further, abstract predicates are used for so-called reification, i.e., converting a role into a concept -- e.g., the relation `:cause` might be replaced by `cause-01`; instead of `x :cause y`, we have `x :ARG1-of (c / cause-01 :ARG0 y)` (AMR quidelines).  
The AMR Guidelines provides the following example:

* [en] _The torpedo struck, causing the ship to be damaged. / The torpedo struck, causing damage to the ship. / The torpedo struck, damaging the ship._

```
 (s / strike-01
   :ARG0 (t / torpedo)
   :cause-of (d / damage-01
                :ARG1 (s2 / ship)))
```

* [en] _The girl left because the boy arrived._
```
AMR without reification:        AMR with reification:
(l / leave                      (l / leave
   :ARG0 (g / girl)                :ARG0 (g / girl)
   :cause (a / arrive              :ARG1-of (c / cause-01
             :ARG0 (b / boy)))                 :ARG0 (a / arrive
                                               :ARG0 (b / boy))))
```


### 3 TODO Discourse relation rolesets

These rolesets when multiple events are expressed in a complex sentence (combines also with reification).

