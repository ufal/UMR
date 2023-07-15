# Frame Files

UMR
[assumes](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-2-1-participant-roles)
that [events](eventive-concepts.md) are linked to **frame files** (valency
dictionaries), which describe the participants of the event and their
semantic roles. The default source of English frame files is PropBank. Other
languages may use a similar resource if there is one, or create a lexicon on
the fly when working on UMR annotation.

There is a minor terminological glitch: while all processes are events,
states and entities may or may not be events depending on how they are used
in the sentence. It would not make sense to identify a state with an entry in
a valency lexicon when it is used as an event (that is, in predication) and
to link it to a different entry in another lexicon when it is used in
modification or reference. We will thus assume that all processes and states
have entries in a valency lexicon, i.e., their frames are available. Entities
can be in a separate lexicon. This also relates to anchoring of concepts:
entities are primarily anchored in Wikipedia (Wikidata), while states and
processes would ideally be anchored in the frame file (valency lexicon).

In the long run, we want to use
[SynSemClass](https://lindat.mff.cuni.cz/services/SynSemClass40/) to anchor
processes and states in a cross-linguistically applicable manner. It
currently contains only samples of verbs from a few languages, but it can be
extended. At present it is not easy to identify a class for a verb (the
interface lists the verb that was selected in each language as the label for
the class, but it does not list the other verbs which have similar meaning
and belong to the same class). A better search tool is being developed
(http://ufallab.ms.mff.cuni.cz/~fucikova/public_html/SSC_classmembers/).

In the meantime, for Czech (and especially for data from PDT) we can use the
[PDT-Vallex](https://ufal.mff.cuni.cz/pdt-vallex-valency-lexicon-linked-czech-corpora),
searchable [here](http://lindat.mff.cuni.cz/services/PDT-Vallex/). There are
verbs (both active and stative) but not other parts of speech denoting
processes or states. We have [conversion files](../valency-frames-cs-verbs)
that map the PDT-Vallex frames to strings that can be used as eventive
concepts in UMR. The concept strings are lemmas of the verbs (infinitives),
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


## Non-verbal Clauses

UMR proposes seven abstract concept predicates for situations where states or
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

The 7 abstract predicates for non-verbal clauses are listed in [Tables 3 and
4](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-1-3-states-and-entities).

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

