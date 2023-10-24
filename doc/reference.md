# Reference

UMR approaches  annotates pronominal reference and person/number marking through two attributes, `:ref-person` for grammatical person information, and `:ref-number` for grammatical number marking. These two attributes can apply to any entity concept - but in the available data annotation, these attributes appear only sporadically (if an explicit nominal is overtly marked for plural):

* [en] _Bill saw rare birds.plural today._ 
... the proper noun Bill is not marked wrt number - it seems that singular value, 3rd person is viewed as a default?

In particular, these attributes are used for implicit arguments and for arguments expressed only through verbal cross-referencing - then the NE category _person_ or _thing_ are used for these arguments (together with `:ref-person` and `:ref-number`, unless this info is available through the coreference relation annotated on the document level (as t/ thing in the following example)). 

* [Sanapaná] m-e-hl-t-om-o=hlta (example 3-3-5 (2))
```
m-e-hl-t-om-o=hlta 
NEG-2/3M.IRR-DSTR-eat-TI-IPFV=PHOD
'They did not eat it.'

(e/ entoma-00 'eat'
	:actor (p/ person
		:ref-person 3rd
		:ref-number Plural)
	:undergoer (t/ thing) 
	:aspect Performance
	:modstr FullNeg)
```


## Person

The `:ref-person` seems to be relevant only for  _person_ or _thing_ standing for implicit arguments/arguments expressed through verbal cross-referencing in the released data (!!`:refer-person` there!!).  
It appears only in those cases **where the number cannot be restored** via coreference.


The default level annotation (standard 1st, 2nd, and 3rd person values) is appropriate for Czech (and this value can be transferred from the PDT grammateme `person`).

## Number

The default level for `:ref-number` comprises the distinction between **singular** and **non-singular**, the latter covering paucal ('a few', a small inexactly numbered group of referents) and plural ('many').

For **English**, the released data use the `:refer-number` attribute (instead of `:ref-number`, as in the Guidelines). This attribute seems to be fully  annotated with  _person_ or _thing_ (used for implicit arguments/arguments expressed through verbal cross-referencing, see above) but only **in those cases where the number cannot be restored via coreference** (document level annotation).  

For other entity concepts (esp. unmarked nouns, NE, etc.), the `:refer-number` attribute is used only to mark for non-default value(s), i.e. other than singular number

As far as I can see, English data are covered be the singular and plural values. The same seems appropriate for Czech where the PDT grammateme `number` can be used. This grammateme correctly covers also 
- pluralia tantum (_jedny dveře.sg / dvoje dveře.pl_),
- polite forms of the 2nd person ("vykání", _Vy.sg jste se nepřihlásil?_)
- indefinite pronouns (_Řekněte, kdo.sg přišel / kdo.pl přišli_)
- "container" numerals (_Přišlo sto.sg studentů. / Přišlo dvě stě.pl studentů._; probably not relevant for UMR??)

### ??? pair/group meaning

PDT grammateme `typgroup` ... probably not relevant for UMR now

### Comments
[Wikipedia](https://en.wikipedia.org/wiki/Grammatical_number#Paucal) exemplifies paucal number (among others) on Russian: "In Russian, the genitive singular is also applied to two, three or four items (2, 3, 4 ка́мня – stones, gen. sg.; but 5...20 камне́й – stones, gen. pl.), making it effectively paucal[citation needed] (cf. э́тот ка́мень – this stone, nom. sg.; э́ти ка́мни – these stones, nom. pl.)."




 

