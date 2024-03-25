**Differences in the annotation of the Estonian file - Šárka and Markéta**

In general:
- Šárka's heading of the sentences includes the levels of Morphemes and Morpheme Gloss. (ŠZ: Where does it come from? I didn't do it.)

- publication-91: in both annotation (ŠZ and ML) with aspect and modal strength. According to the meeting on the March 18, 2024, publication should not have these features.
- Proposed solution: correct both annotations



######################################################

snt1

Estonci volili parlament

- ŠZ: s1v / volit 

ML: s1v / volit-001

Proposed solution: ŠZ - write there a better specification



- ŠZ: volit - no wiki

ML: volit-001 wiki "Q372557"

Proposed solution: ŠZ - add wiki (do we write wikipages to actions?)


- ŠZ: Estonci - person

:mod (s1n / nationality, :wiki..., :name (...Estonsko))

ML: :mod (s1c / country... the same)

ie., difference: modified by nationality or country?

Proposed solution: ???


- ŠZ: :refer-person 3rd

ML: --

Proposed solution: do we write refer-persons with sentences / verbs?


- ŠZ: aspect process

ML: aspect activity

Proposed solution: ???


- ŠZ: :temporal (s1b/ before :op1 (s1n3 / now))

ML: --

Proposed solution: do we assign temporality at every sentence?

_________________________________________________________


Alignment:
- ŠZ: aligned groups from :temporal - before now (s1b - before aligned to the verb which expresses the tense; s1n3 0-0 - now)

ML: -- (no temporal annotation)

Proposed solution: depends on the temporality - will it be a part of sentence /clause annotation?


Document level annotation
- the same


#################################################################

snt2
Estonsko 

- ML: typo - ESONSKO

_______________________________________________________

Sentence level graph:

- ML: :ARG3 (s2t / thing)
ŠZ: --
Proposed solution: ŠZ: don't understand - why a thing here?


- ML: refer-number singular

ŠZ: --

Proposed solution: ŠZ - add the number there

_______________________________________________________

Alignment:
- ŠZ: country 0-0, named entity below (Estonsko) 1-1. Probably wrong

ML: country 1-1, named entity 0-0

Proposed solution: ŠZ - correct it 

_______________________________________________________

Document level annotation

- ML: :temporal

ŠZ: --

Proposed solution: ??? "Estonia" has no temporality. 




- ML: modal (root, author)

ŠZ: --

Proposed solution: no "modal" annotation with publication-91? Delete by ML?

########################################################

snt3

Estonci volili parlament

- the same differences as in snt1

________________________________________________________

Document level annotation

- ML: coref s2p - s3p (publication-91 - publication-91) Error?

ŠZ: --

Proposed solution: ???

- ML: coref s1v - s3v same event (volili - volili)

ŠZ: coref s1v - s3v same entity (volili - volili)

Proposed solution: ??? Do we annotate coreference with events, especially if expressed by verbs? On the other hand, single events can be coreferential. 

- ML: coref s2c - s3c (Estonsko - Estonsko in the word Estonci)

ŠZ: --

Proposed solution: ŠZ: add this link. The question is, where to add it exactly in the structure of the sentence 3 (nationality? Probably not the named entity itself.)


- ML: coref s1p2 - s3p2 (person Estonci - person Estonci)

ŠZ: --

Proposed solution: ŠZ: add this link. 

############################################################

NEXT: snt5 V nedělních parlamentních volbách...