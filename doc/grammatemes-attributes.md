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

3.	Assumption: maybe plural needs to be annotated since it is a non-default value, as opposed to singular (marked/unmarked)? BUT cf. [file4](https://ufallab.ms.mff.cuni.cz/~mnovak/umr/graphs/umr-v1.0/english/english_umr-0004.txt/visualization.html): 177 occurrences of `refer-number singular` vs 41 of `plural`. Plus, this is the only file that has so many instances of `refer-number` (significant difference!) &rarr; different annotator?

4.	Found no NEs with annotation of `number`.

5.	General impression: very inconsistent, hard to infer any pattern.


What do the guidelines ([3-3-5](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-5-ref)) say?\
'UMR annotates person and number through two attributes `:ref-person` for grammatical person information, and `:ref-number` for grammatical number marking. These attributes **<u>can</u> apply to any entity concept**. If an explicit nominal is marked for plural or dual number, for instance, the node for this entity concept can take the relevant attribute value label.
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
<u>Já</u> už jdu. [person=1] (=I am coming)\
<u>Tvůj</u> názor nesdílím. [person=2] (=I don't share your view)\
<u>Vy</u> jste se už přihlásili. [person=2] (=You have already registered)\
<u>Oni</u> se ještě nepřihlásili. [person=3] (=They haven't registered yet)

Indefinite pronouns\
They usually have value `3`. Values `1` and `2` are assigned when the semantic noun is the subject of a predicate with first or second person agreement morphology. Examples:\
Zachraň se, <u>kdo</u> můžeš. [person=2] (=lit. Save yourself who can.2.sg)\
Verše, které <u>kdekdo</u> známe. [person=1] (=Poems which everybody/whoever know.1.pl)


In UMR: **OK**. The attribute `refer-person` can take more values for crosslingual reasons (see lattice in [3-3-5](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-5-ref)). What has been mentioned from the guidelines about `refer-number` applies to `refer-person` as well.

The use of `refer-person` appears to be more consistent, and aligned to the PDT grammateme in its use for pronouns. E.g.: in snt10 *she* is annotated as
```
     :ARG0 (s10p / person\
        :refer-person 3rd\
        :refer-number singular)
```
            


### ASPECT (UMR: `aspect`)
See Market's document about [aspect](https://github.com/ufal/UMR/blob/main/doc/aspect.md).
