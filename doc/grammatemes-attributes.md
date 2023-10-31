# Comparison of PDT grammatemes and UMR attributes

### NUMBER (UMR: `refer-number`)
In PDT, number is assigned to semantic nouns and can take either `sg` or `pl` as value. With most semantic nouns, the value of the number grammateme corresponds to the value of the morphological number category. Exceptions, e.g.: pluralia tantum, polite form, indefinite pronouns (as in *kdo přišli*).
What are semantic nouns?
- denominating semantic nouns (`n.denot`): traditional nouns (*otec*, *Marta*, *dveře*) + possessive adjectives represented by the t-lemma of the corresponding nouns (*otcova*, *Martin*).
- denominating semantic nouns with which the negation is represented separately (`n.denot.neg`): denominating semantic deverbal nouns ending with *-ní / -tí*; denominating semantic deadjectival nouns ending with *-ost*.
- definite pronominal semantic nouns: demonstratives (`n.pron.def.demon`).
- definite pronominal semantic nouns: personal pronouns (`n.pron.def.pers`).
- indefinite pronominal semantic nouns (`n.pron.indef`): e.g. *kdo, co, který; někdo, některý*.
- definite quantificational semantic nouns (`n.quant.def`): cardinal numerals and fractional numbers.

N.B.: with “container” numerals (*sto, tisíc, milion*, etc.), and fraction numerals, the number grammateme corresponds to the value of the morphological category. For instance:\
*Přišlo sto studentů.* [`number=sg`] (en. *One hundred students came*)\
*Přišlo dvě stě studentů.* [`number=pl`] (en. *Two hundred students came*)

In theory **OK in UMR**: number is represented by `refer-number`. But is it widespread and consistent? Sparse considerations:

[Disclaimer: all the examples mentioned in this doc, unless specified otherwise, come from [file 1](https://ufallab.ms.mff.cuni.cz/~mnovak/umr/graphs/umr-v1.0/english/english_umr-0001.txt/visualization.html) of UMR released data.]

1.	At a first glance, it seems that `refer-number` is assigned to nouns and pronouns.\
    a.	However, when they are `ARGX-of` a verb, `refer-number` is (almost) never found. However, it does not seem like an intentional annotation choice, but more like something which has not been strictly regulated and thus annotators  annotate in different manners.\
    Exceptions, where `refer-number` is found in an ARGX-of structure: snt17, two relative clauses (*earthquake which struck before the landslide*; *wall that crashed*).\
    b. “hallucinated” (def from the guidelines) `person` nodes never have `refer-number` if they are `ARGX-of`! Snt21: *officials* as person having role of official, but there is no sign of plurality (no `refer-plural` assigned to `person`). Same in snt23 for *survivors*, `person` (with no `refer-plural`) `ARG0-of` *survive*.

2. At a second glance, it does not seem to be an issue related to `ARGX-of`, but quite common: e.g. in snt24 *helicopter* has no `refer-number`.

3.	Assumption: maybe plural needs to be annotated since it is a non-default value, as opposed to singular (marked/unmarked)? BUT cf. [file 4](https://ufallab.ms.mff.cuni.cz/~mnovak/umr/graphs/umr-v1.0/english/english_umr-0004.txt/visualization.html): 177 occurrences of `refer-number singular` vs 41 of `plural`. Plus, this is the only file that has so many instances of `refer-number` (significant difference!) &rarr; different annotator?

4.	Found no NEs with annotation of `number`.

5.	General impression: very inconsistent, hard to infer any pattern.


What do the guidelines ([3-3-5](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-5-ref)) say?\
'UMR annotates person and number through two attributes `:ref-person` for grammatical person information, and `:ref-number` for grammatical number marking. These attributes **_can_ apply to any entity concept**. If an explicit nominal is marked for plural or dual number, for instance, the node for this entity concept can take the relevant attribute value label.
For arguments expressed only through verbal cross-referencing, or arguments that are implicit, both `:ref-person` and `:ref-number` can be used to represent their pronominal features. In such cases where there is no overt nominal expression to attach those values to, UMR "hallucinates" a concept (typically a named-entity category, e.g. person, thing) to attach the attribute labels to in order to facilitate cross-lingual compatibility.'


### GENDER (UMR: *NA*)
The `gender` PDT grammateme is a tectogrammatical correlate of the morphological category of gender. It is assigned to all nodes of semantic nouns and can take the following values: `anim`, `inan`, `fem`, `neut`.

In UMR there is no attribute for gender. See Julia's email to Šárka.\
Probable temporary solution (by Dan): annotate it, as it can be easily removed later automatically.\
TODO: agree on some internal guidelines about gender annotation.


### PERSON (UMR: `person`)
The person PDT grammateme is relevant for pronouns that may refer to an object of communication (third person) as well as to the speaker or hearer (first and second person). That is: definite pronominal semantic nouns (personal pronouns; sempos = `n.pron.def.pers`) and indefinite pronominal nouns (sempos = `n.pron.indef`).\
Basic values: `1` for first person (speaker), `2` for second person (hearer), `3` for third person (what is talked about).

Personal pronouns - examples:\
_Já_ už jdu. [person=1] (=I am coming)\
_Tvůj_ názor nesdílím. [person=2] (=I don't share your view)\
_Vy_ jste se už přihlásili. [person=2] (=You have already registered)\
_Oni_ se ještě nepřihlásili. [person=3] (=They haven't registered yet)

Indefinite pronouns\
They usually have value `3`. Values `1` and `2` are assigned when the semantic noun is the subject of a predicate with first or second person agreement morphology. Examples:\
Zachraň se, _kdo_ můžeš. [person=2] (=lit. Save yourself who can.2.sg)\
Verše, které _kdekdo_ známe. [person=1] (=Poems which everybody/whoever know.1.pl)


In UMR: **OK**. The attribute `refer-person` can take more values for crosslingual reasons (see lattice in [3-3-5](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-5-ref)). What has been mentioned from the guidelines about `refer-number` applies to `refer-person` as well.

The use of `refer-person` appears to be more consistent, and aligned to the PDT grammateme in its use for pronouns. E.g.: in snt10 *she* is annotated as
```
     :ARG0 (s10p / person\
        :refer-person 3rd\
        :refer-number singular)
```
            
As for indefinite pronouns: examples still to be found (suggestions?).


### NEGATION (UMR: `polarity`)
Basic values in PDT are `neg0` for affirmative and `neg1` for negative. The grammateme applies to:
- certain denominating semantic nouns (`n.denot.neg`),
- denominating semantic adjectives (`adj.denot`),
- gradable and non-gradable denominating semantic adverbs that can be negated (`adv.denot.grad.neg`; `adv.denot.ngrad.neg`).

Examples:\
otázka _bytí_ [`negation=neg0`] a _nebytí_ [`negation=neg1`] vysokých škol (=lit. question (of) being and non-being (of) universities)\
_nezralost_ dítěte [`negation=neg1`] (=lit. immaturity (of) child)\
_nepěkný_ zážitek [`negation=neg1`] (=lit. not_nice experience)\
_nepříliš_ vydařený výlet [`negation=neg1`] (=lit. not_very successful trip)

In UMR we have the attribute `polarity`. See guidelines ([3-3-3](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-3-polarity)):\
"UMR mainly treats propositional negation at the document-level in the modal dependency annotation. However, the AMR attribute `:polarity` is also maintained in the UMR sentence-level annotation. It is used to flag any morphosyntactic indicators of negation that are present in the clause. These do not necessarily signal semantic negation. This is the case, for example, for some instances of derivational negation of adjectives in English.

```
3-3-3 (1a)

Unhealthy food.

(t/ thing
	:ARG1-of (e/ eat-01)
	:mod (h/ healthy
		:polarity -))
```

Only marked (negative) polarity is annotated in UMR, i.e. affirmative polarity is not annotated. The UMR `-` polarity value roughly corresponds to PDT `negation=neg1`.

In the released data there are not many instances of `polarity`. The occurrences that were retrieved only concern clausal negation. Example from [file 4](https://ufallab.ms.mff.cuni.cz/~mnovak/umr/graphs/umr-v1.0/english/english_umr-0004.txt/visualization.html):
```
I don't know .
(s87k / know-01
  :ARG0 (s87p / person
          :refer-person 1st
          :refer-number singular)
  :ARG1 (s87t / thing)
  :polarity -
  :aspect state)
```

Additionally, cases of **unknown** polarity are found (  `:polarity (s14u / umr-unknown)`  ). 3 occurrences in [file 4](https://ufallab.ms.mff.cuni.cz/~mnovak/umr/graphs/umr-v1.0/english/english_umr-0004.txt/visualization.html) + 3 occurrences in [file 4](https://ufallab.ms.mff.cuni.cz/~mnovak/umr/graphs/umr-v1.0/english/english_umr-0005.txt/visualization.html). Example:
```
I don't know if that's important or not .

(s14k / know-01
        :ARG0 (s14p / person
                :refer-person 1st
                :refer-number singular)
        :ARG1 (s14i / important-01
                :ARG1 (s14t / thing
                        :mod (s14t2 / that)
                        :refer-number singular)
                :aspect state
                :polarity (s14u / umr-unknown))
        :polarity -
        :aspect state)
```

In the guidelines only one instance of unknown polarity is found, but no explanation is provided.

```
3-3-2 (1c)

Did you see that?
(s/ see-01
      :ARG0 (p/ person
      	:ref-person 2nd
	:ref-number Singular)
      :ARG1 (t/ that)
      :aspect State
      :modstr NeutAff
      :mode interrogative
      :polarity umr-unknown)
```
What the two examples (from the guidelines and from released data) have in common is that they both are interrogative sentences. The approach of marking questions with `unknown` polarity seems to be inherited from AMR. \
Cf. AMR guidelines: "AMR uses the concept `amr-unknown` to indicate questions."

```
What did the girl find?

(f / find-01
   :ARG0 (g / girl)
   :ARG1 (a / amr-unknown))
```

 Plus: "AMR also uses `amr-unknown` for yes-no questions. For such yes-no questions, the `amr-unknown` bears the `:polarity` relation, essentially asking *what is the truth of this assertion?*".

```
Did the girl find the boy?

(f / find-01
   :ARG0 (g / girl)
   :ARG1 (b / boy)
   :polarity (a / amr-unknown))
```

AMR (and UMR inherits this approach) "also uses inverse roles for embedded interrogative clauses, such as those that start with *whether*". Instead of `amr-unknown`, the `truth-value` concept is used to refer to whether or not an event happened. \
See an example from UMR guidelines:

```
3-2-1-3 (1b)

I didn't see whether he bought the sweater.
(s/ see-01
	:ARG0 (p/ person
		:ref-person 1st
		:ref-number Singular)
	:ARG1 (t/ truth-value
		:Polarity-of (b/ buy-01
			:ARG0 (p2/ person
				:ref-person 3rd
				:ref-number Singular)
			:ARG1 (s2/ sweater
				:ref-number Singular)
			:aspect Performance
			:modstr NeutAff))
	:Aspect State
	:Modstr FullNeg)﻿
```

### ASPECT (UMR: `aspect`)
See Marketa's document about [`aspect`](https://github.com/ufal/UMR/blob/main/doc/aspect.md).



### DEGCMP (not UMR `degree`)
The `degcomp` grammateme has four possible values: `pos` for positive, `comp` for comparative, `sup` for superlative, `acomp` for elative (absolute comparative). It is relevant for denominating semantic adjectives (`adj.denot`) and gradable denominating semantic adverbs that can/cannot be negated (`adv.denot.grad.nneg`; `adv.denot.grad.neg`). All non-comparative/non-superlative forms of semantic adjectives have the `pos` value in the grammateme.

UMR has the attribute `degree`, which however does not analyse comparison. See Marketa's document about [`degree`](https://github.com/ufal/UMR/blob/main/doc/degree.md).\
Cf. the abstract predicate `have-degree-91`.


### VERBMOD/SENTMOD
See Marketa's document about [`mode`](https://github.com/ufal/UMR/blob/main/doc/mode.md).


### DEONTMOD (UMR ~ `modal-strength`)
The grammateme is used to express the fact that the event (thus, assigned to verbs) is understood as necessary, possible, permitted, etc. The value of the grammateme follows from the used modal verb. Values: `deb` (event understood as "necessary"); `hrt` (event understood as "obligatory, obligation"); `vol` (as "wanted/intended"); `poss` (as "possible"); `perm` (as "permitted"); `fac` (as "an ability (to do sth)"); `decl` (basic, unmarked modality).

NO exact, direct correspondence with `modal-strenght` values, but it should be possible to establish a correspondence through some heuristics. Possibly, TODO.


### TENSE (UMR ~ *NA*)
The `tense` grammateme is a tectogrammatical correlate of the morphological category of tense. Values: `sim` for a simultaneous event, `ant` for a preceding (anterior) event, `post` for a subsequent (posterior) event.

It does not correspond directly to any UMR attribute. However, there is a partial overlap with information that UMR expresses in document-level annotation (e.g., `:after`, `:before`). It might be exploited to automatically derive/validate temporal document-level relations. (Possibly, TODO.)  


### NUMERTYPE
The PDT grammateme can take five values: 
- `basic`: cardinal numeral (*tři (=three)*, *kolik (=how_many)*)
- `frac`: fraction numeral (*třetina (=one_third)*, *šestina (=one_sixth)*)
- `kind`: sort numeral (*trojí (=three_kinds_of)*, *kolikerý (=how_many_kinds_of)*)
- `ord`: ordinal numeral (*třetí (=the_third)*, *šestý (=the_sixth)*, *kolikátý (=how_many.ord)*)
- `set`: set numeral (*troje (=three_sets_of)*, *šestery, kolikery (=six_sets_of, how_many_sets_of)*)


Treatment in UMR:
- `basic` &rarr; cardinal numbers tendentially appear as `:quant` + numerical values. Example form the guidelines:
```
Three houses
(h/ house
	:quant 3)
```

However, the `:quant` relation is used for annotating not exact quantities (as in the previous example), but also approximate cardinalities of sets of countable objects, as well as for the number of "units" of non-countable substances. Cf. *some* in the following example, taken again from the guidelines:

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

- `frac` &rarr; could not find examples.
- `kind` &rarr; no specific relation. Most probably, the `:quant` relation would be used to express the quantity of kinds.
- `ord` &rarr; The `:ord` role is used to express ordinals. It always takes an `(o/ ordinal-entity)` concept as its daughter, which in turn takes a `:value` relation to express the ordinal position. It may furthermore take a `:range` relation to indicate a specific time period in which the relevant ordinal position holds, as in this example:
```
I visited New York for the third time in six months.
(v/ visit-01
	:ARG0 (p/ person
		:ref-person 1st
		:ref-number Singular)
	:ARG1 (c/ city
		:name (n/ name
			:op1 "New"
			:op2 "York")
		:wiki "New_York_City")
	:ord (o/ ordinal-entity
		:value 3
		:range (t/ temporal-quantity
			:quant 6
			:unit (m/ month)))
	:aspect Performance
	:modstr FullAff)
```
- `set` &rarr; no specific relation. Most probably, the `:quant` relation would be used to express the quantity of sets.

### OTHER GRAMMATEMES
- **`politeness`**: non relevant for UMR.

- **`indeftype`**: it seems quite grammatical and not really relevant for UMR purposes.

- **`dispmod`**: very specific.

- **`resultative`**: quite specific. This kind of information is expressed in UMR by `aspect`.

- **`iterativeness`**: same as above (`resultative`). This kind of information is expressed in UMR by `aspect`.


### Grammatemes in Latin PDT
Grammatemes are regularly found in Latin PDT.
