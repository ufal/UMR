# TODO list (collected from previous meetings)

#### **I. Automatic conversion** (and conversion rules)

- <u>Honza</u>: ***mít*, *být* ... implement the translation valency frames --> UMR concepts and arguments**
  
  - 'language' for description of changes in valency frames (esp. for *být*, *mít* frames) [HERE](https://github.com/ufal/UMR/blob/main/tecto2umr/instructions-frame-change.md)
  - table with conversion / conversion rules [HERE](https://docs.google.com/spreadsheets/d/1lVo7a8hPBReI4VrgNkUGem8uC_sCQCXJJvLFCbwPuok/edit?gid=1270330829#gid=1270330829)

- <u>Honza - NEW</u>: conversion: **t_lemmas + CPHR** (other verbs than *být/bývat/bývávát/mít/mít_se/mívat*)

- <u>Honza - NEW</u>: conversion: **t_lemmas + DPHR**, [issue #25](https://github.com/ufal/UMR/issues/25) (both with *být/bývat/bývávát/mít/mít_se/mívat* and with other verbs)

- <u>Honza - NEW</u>: **personal pronouns** with 1st and 2nd person should be converted as `person` (rather than `entity`), [issue #24](https://github.com/ufal/UMR/issues/24)

- <u>Honza - NEW</u>: **reification** - which of (possible multiple) children with the specified functor should serve as the predicate, [issue #26](https://github.com/ufal/UMR/issues/26)

- <u>Markéta</u>: suggest what to do with the **polite attribute** (todo)

- <u>Markéta</u>: suggest what to do with the **mode attribute** (todo)

- <u>Markéta</u>: suggest more precise conversion of **t-lemma substitutes** (todo)

- <u>Markéta</u>: suggest what to do with questions: **UMR-unknown** (todo)
  
  - either as a concept, see ex. 3-1-3-5 (1), [Guidelines](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#Part-3-1-3-5-Light-verb-constructions),
  - or as a polarity value, see ex. 3-3-2 (1c) [Guidelines](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#part-3-3-2-mode)

- <u>FUTURE TASKs</u>: **action nouns**, **agent nouns** in noun-to-verbs conversion, see the description, see [the description](https://github.com/ufal/UMR/blob/main/tecto2umr/derivace-podklady/description.txt)

#### **II. Data** (and evaluation)

- *být/mít* - **conversion evaluation** (100+100 sentences; criteria: frequency + types)

- **--> UMR 2.2** ... together with action nouns (at least *-ní/-tí*), agent nouns

- **testing data** for the UMR shared task
  
  - checking and completing the unfinished files from 2.1 manual data
  
  - selecting new files

- **Possibility to annotate/re-arrange UMRs in TrEd?** ... postponed  
  (This would significantly speed up the annotation!)

#### **III. Papers**

- ~~LREC paper in [Overleaf](https://www.overleaf.com/project/68a3112a48c6e5855461ef59)~~ - **find a relevant workshop/conference** (when *být/mít* are converted)
- ??????
- **TR** - update (should reflect UMR v2.1)

---

---

# UMR meeting minutes

## Monday, ... template

(attendees)

#### Updates:

- xxx

#### TODO:

- xxx

#### NEXT meetings:

- Monday, ....

---

## Monday, December 1 and December 8, 2025

(Dan, Federica, Hana, Jan, Markéta)

#### Updates:

- **UMR parsing shared task:**
  
  - [UMR Parsing Shared Task](https://ufal.mff.cuni.cz/umr-parsing) ... to be held as part of the [DMR 2026 workshop](https://dmr2026.github.io/), collocated with [LREC](https://lrec2026.info/) (Palma de Mallorca, Spain)
  - we will need manually annotated data for testing
  - Federica: UMR editor

#### TODO:

- **testing data** for the UMR shared task
  
  - checking and completing the unfinished files from 2.1 manual data
  
  - selecting new files

- **automatic conversion** - low hanging fruits

#### Next meetings

- Monday, Dec 15, 2025 (S510)

- Monday, Jan 5, 2026 (S510)

---

## Monday, November 3, 2025

(Dan, Federica, Jan)

#### Updates:

- **testing data for UMR shared task:**
  
  - submitted for ACL 2026 San Diego, CA, from July 2-7, 2026) ... Federica: rejected (??)
  
  - submitted for ???
  
  - when accepted, we will need manually annotated testing data (how many sentences??) ...  **HOW MANY and WHEN** ??

#### TODO:

- moved above

### NEXT meetings:

- Monday, Nov 10 (S519)
- Monday, Nov 24 (S510)
- Monday, Dec 1 (S510)

---

## Monday, September 8, 2025 (and update from October 6, 2025)

(Dan, Federica, Jan Š., Markéta, ??)

#### Updates:

- Dan, Honza: UMR shared task submitted (San Diego, CA, from July 2-7, 2026)  
  if accepted, we will need manually annotated testing data (how many sentences??), **end of February, 2026** 
- Markéta, Honza: 'language' for description of changes in valency frames (esp. for *být*, *mít* frames) [HERE](https://github.com/ufal/UMR/blob/main/tecto2umr/instructions-frame-change.md)

#### TODO:

- Honza: _mít_, _být_ ... implement the translation valency frames --> UMR concepts and arguments
- ~~Markéta, Hanka: complete the translation rules for _mít_, _být_ [HERE](https://docs.google.com/spreadsheets/d/1ocs1-IG5JUebKFT0NjlO28WgxM6NANMc/edit?gid=171036479#gid=171036479) (instructions [here](https://github.com/ufal/UMR/blob/main/tecto2umr/instructions-frame-change.md))~~ (almost) completed
- ALL: LREC paper in [Overleaf](https://www.overleaf.com/project/68a3112a48c6e5855461ef59)
- PLUS: see the updated [TODO list from July 14](#todo-july-14)
- NEW: conversion: `t_lemmas + CPHR` (other verbs than _být/bývat/bývávát/mít/mít_se/mívat_)
- NEW: conversion: `t_lemmas + DPHR`, [issue #25](https://github.com/ufal/UMR/issues/25) (both with  _být/bývat/bývávát/mít/mít_se/mívat_ and with other verbs)

#### NEXT meetings:

- Monday, Oct 20 (S510)
- Monday, Oct 13 (S510) ... LREC deadline: Friday, October  17, 2025 !!
- ~~Monday, Oct 6~~  
- ~~Monday, Sept 29 - ITAT workshop~~
- ~~Monday, Sept 22 - Kira's defense at 14:00~~ 
- ~~Monday, Sept 15 (Vítkovice) - just after the lunch~~

---

## Monday, July 14, 2025 (and update from August 18 and 28)

(Dan, Federica, Jan Š., Markéta)

#### Updates:

- NEW:  LREC template in [Overleaf](https://www.overleaf.com/project/68a3112a48c6e5855461ef59)
- UMR 2.1 (Czech and Latin): ~~prepared for publication~~
  - UPDATE: published, [http://hdl.handle.net/11234/1-5951](http://hdl.handle.net/11234/1-5951)
- DMR 2025: ~~Honza will prepare a presentation - he will ask for a contribution of other authors~~
  - [slides](https://ufallab.ms.mff.cuni.cz/~stepanek/25dmr-slides)
  - [ACL Anthology](https://aclanthology.org/2025.dmr-1.1/) 
- ITAT 2025: 
  - UPDATE: [final version submitted](https://github.com/ufal/UMR/blob/main/papers/2025-ITAT-camera-ready.pdf),  [slides](https://github.com/ufal/UMR/blob/main/papers/2025-ITAT-slides-comp.pdf)
  - ~~version for reviewers submitted~~
  - ~~notification: July 29~~
  - ~~camera-ready version: August 20~~ 
    - ~~Honza available only before August 5~~ 
    - ~~Dan, Markéta: available August 4-7, August 18-20~~   

#### TODO: {#todo-july-14}

- ~~Markéta, Hanka: Check [UMR Schema Reference Pages](https://umr4nlp.github.io/web/UMRSchemaPages/index.html), which provide lists and lattices with definitions and examples.~~ 

- ~~Markéta, Hanka: Do we want to try [UMR Writer 3.0](https://umr-tool.cs.brandeis.edu/)~~? No :-)

- **Conversion:** 
  
  - ~~Markéta, Hanka: continue with _být_ and _mít_ frames, newly [HERE](https://docs.google.com/spreadsheets/d/1ocs1-IG5JUebKFT0NjlO28WgxM6NANMc/edit?gid=171036479#gid=171036479);~~ (almost completed)
  - ~~check AMR to UMR automatic conversion [here](https://aclanthology.org/2023.tlt-1.8/)!~~
  - Markéta: suggest what to do with the `polite` attribute (todo)
  - Markéta: suggest what to do with the `mode` attribute (todo)
  - NEW: Markéta: suggest what to do with questions: `UMR-unknown` (todo)
    - either as a concept, see ex. 3-1-3-5 (1), [Guidelines](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#Part-3-1-3-5-Light-verb-constructions), 
    - or as a polarity value, see ex. 3-3-2 (1c) [Guidelines](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#part-3-3-2-mode)

- **Automatic conversion** - further possible steps: 
  
  - ~~nodes for #Gen, #Unsp, [issue #23](https://github.com/ufal/UMR/issues/23)~~  Not planned any more!
  - **Personal pronouns** with 1st and 2nd person should be converted as `person` (rather than `entity`), [issue #24](https://github.com/ufal/UMR/issues/24)
  - ~~How to describe structural changes in valency frames in a machine-readable format, [issue #27](https://github.com/ufal/UMR/issues/27)?~~ See the [instructions](https://github.com/ufal/UMR/blob/main/tecto2umr/instructions-frame-change.md) and the conversion table [(= google sheet)](https://docs.google.com/spreadsheets/d/1lVo7a8hPBReI4VrgNkUGem8uC_sCQCXJJvLFCbwPuok/edit?gid=1270330829#gid=1270330829).
  - **Reification** - which of (possible multiple) children with the specified functor should serve as the predicate, [issue #26](https://github.com/ufal/UMR/issues/26)
  - ~~Convert _být_ and _mít_ frames as described [HERE](https://docs.google.com/spreadsheets/d/1ocs1-IG5JUebKFT0NjlO28WgxM6NANMc/edit?gid=171036479#gid=171036479)~~
  - **Action nouns**, **agent nouns** in noun-to-verbs conversion, see the description, see [the description](https://github.com/ufal/UMR/blob/main/tecto2umr/derivace-podklady/description.txt)
  - Fix **discourse rolesets with more than 2 ARGS** (as but-91)

- **Possibility to annotate/re-arrange UMRs in TrEd?** ...   postponed  
  (This would significantly speed up the annotation!)

- PDT 2.0 documentation - [APP parent-child relation](https://docs.google.com/spreadsheets/d/1_zHAK9LGdLsoPGuQOeyO05t7NmtdW9xJ/edit?gid=994881793#gid=994881793) ... see TODO from June 16, 2025

#### NEXT meetings

- July, August - based on availability :-)

---

## Monday, June 16, 2025

(Dan, Federica, Hanka, Jan Š., Markéta)

#### Updates:

- Federica: short report on the [UMR Summer School](https://umr4nlp.github.io/web/SummerSchool2025.html).

- Federica: [UMR Schema](https://umr4nlp.github.io/web/UMRSchemaPages/index.html) - lists and lattices with definitions and examples. It contains lists for:
  
  - Participant roles, non-participant roles, and attribute roles
  - The `:aspect` attribute
  - Modal attribute roles
  - Abstract concepts
  - Named Entity hierarchy
  - Nonprototypical Predication -91 rolesets
  - Discourse Relations
  - Abstract -91 rolesets

- Federica: [UMR Writer 3.0](https://umr-tool.cs.brandeis.edu/) works much better than 2.0.
    The tool supports the format described in the UMR Release 2.0 (see the README.md file). It can compare two files, compute the AnCast F1 score, and present their differences in a GitHub-style view.

- Markéta: [UMR 2.0 - Czech: Release Notes](https://github.com/ufal/UMR/blob/main/papers/2025-data-release-notes-2-0.md) as  [ÚFAL TR-2025-74](https://ufal.mff.cuni.cz/techrep/tr74.pdf).   
  **The markup version should be fixed** - internal links do not work!
  
  - most frequent _být_ frames prepared for conversion ... see the [pdt_pb table](https://docs.google.com/spreadsheets/d/1lVo7a8hPBReI4VrgNkUGem8uC_sCQCXJJvLFCbwPuok/edit?gid=1270330829#gid=1270330829)

- Honza: `refer-number`, `refer-person` conversion finalized (for the time being)

- Honza:  personal and some demonstrative pronouns converted as `event` (rather than `entity`) if they refer to verbs 
  
  - personal pronouns with 1st and 2nd person should be converted as `person` (rather than `entity`) ?? 

- Honza:  `FPHR`, Github [issue 21](https://github.com/ufal/UMR/issues/21) (NE introduced with common noun) solved

#### TODO:

- **Conversion:** 
  
  - Markéta, Hanka: continue with _být_ and _mít_ frames; 
  - check AMR to UMR automatic conversion [here](https://aclanthology.org/2023.tlt-1.8/)! 

- **Automatic conversion** - further possible steps: 
  
  - `FPHR` without #Forn.ID as its head, [issue 22](https://github.com/ufal/UMR/issues/22)  
  - nodes for #Gen, #Unsp, [issue 23](https://github.com/ufal/UMR/issues/23)
  - `polite` attribute (todo)
  - `mode` attribute (todo)
  - _být_ frames 
  - **action nouns**, **agent nouns** in noun-to-verbs conversion, see the description, see [the description](https://github.com/ufal/UMR/blob/main/tecto2umr/derivace-podklady/description.txt)
  - fix **discourse rolesets with more than 2 ARGS** (as but-91)

- **Possibility to annotate/re-arrange UMRs in TrEd?** ...   postponed  
  (This would significantly speed up the annotation!)

- PDT 2.0 documentation - [APP parent-child relation](https://docs.google.com/spreadsheets/d/1_zHAK9LGdLsoPGuQOeyO05t7NmtdW9xJ/edit?gid=994881793#gid=994881793)
  
  - more than 30k instances in PDT-C 2.0:  
    FAUST ... APP 2x  
    PCEDT ... APP 0x  
    PDTSC ... APP 46x  
    PDT ... APP 30034x 
  - based on the PDT 2.0 manual: 
    - (2) _příslušník armády_.APP: příslušnosti osoby k nějakému celku, instituci (člen/part je rodičem -- instituce/celek je dítětem) ... OK, UMR: possessor or whole as the daughter
    - (3) _tým brankářů_.APP: příslušnosti osoby k nějakému celku, instituci **instituce/celek je rodičem -- člen/part je dítětem) ... BUT UMR: possessor/whole as the daughter**
    - (6)  _střecha domu_.APP: vyjádření vztahu mezi částí a celkem (označení celku) (part je rodičem -- celek je dítětem) ... OK, UMR: possessor or whole as the daughter
    - ALSO: _můj_.APP _klobouk_ (rodič vlastněné -- dítě vlastník) ... OK, UMR: possessor or whole as the daughter
    - (ALE: _část Německa_.MAT (part je rodičem -- celek je dítětem) ... OK, UMR: possessor or whole as the daughter)

#### NEXT meetings

- Monday, June 23 - canceled 
- Monday, June 30, S510, 13:00
- July, August - based on availability :-)

---

## Monday, May 9, 2025

(Dan, Hanka, Jan Š., Markéta)

#### Updates:

- Honza: `refer-number` conversion, detected error fixed - conversion hopefully finalized;
- Markéta: **[Release notes 2.0](https://github.com/ufal/UMR/tree/main/papers)** hopefully finalized and pdf passed to Martin Popel.

#### TODO:

- [Release notes 2.0](https://github.com/ufal/UMR/tree/main/papers): 
  
  - the markup version should be fixed;
  - check the list of authors!

- PDT 2.0 documentation - [APP parent-child relation](https://docs.google.com/spreadsheets/d/1_zHAK9LGdLsoPGuQOeyO05t7NmtdW9xJ/edit?gid=994881793#gid=994881793)
  
  - more than 30k instances in PDT-C 2.0:  
    FAUST ... APP 2x  
    PCEDT ... APP 0x  
    PDTSC ... APP 46x  
    PDT ... APP 30034x 
  - based on the PDT 2.0 manual: 
    - (2) _příslušník armády_.APP: příslušnosti osoby k nějakému celku, instituci (člen/part je rodičem -- instituce/celek je dítětem) ... OK, UMR: possessor or whole as the daughter
    - (3) _tým brankářů_.APP: příslušnosti osoby k nějakému celku, instituci (instituce/celek je rodičem -- člen/part je dítětem) ... UMR: possessor as the daughter
    - (6)  _střecha domu_.APP: vyjádření vztahu mezi částí a celkem (označení celku) (part je rodičem -- celek je dítětem) ... OK, UMR: possessor or whole as the daughter
    - ALSO: _můj_.APP _klobouk_ (rodič vlastněné -- dítě vlastník) ... OK, UMR: possessor or whole as the daughter
    - (ALE: _část Německa_.MAT (part je rodičem -- celek je dítětem) ... OK, UMR: possessor or whole as the daughter)

- Markéta, Hanka: conversion of _být_, _mít_ frames; 
  
  - check AMR to UMR automatic conversion [here](https://aclanthology.org/2023.tlt-1.8/)! 

- conversion - further possible steps: 
  
  - `FPHR`, Github [issue 21](https://github.com/ufal/UMR/issues/21) and [issue 22](https://github.com/ufal/UMR/issues/22)
  - nodes for #Gen, #Unsp, [issue 23](https://github.com/ufal/UMR/issues/23)
  - `polite` attribute (todo)
  - `mode` attribute (todo)
  - selected  _být_ frames ... see the [pdt_pb table](https://docs.google.com/spreadsheets/d/1lVo7a8hPBReI4VrgNkUGem8uC_sCQCXJJvLFCbwPuok/edit?gid=1270330829#gid=1270330829)
  - **action nouns**, **agent nouns** in noun-to-verbs conversion, see the description, see [the description](https://github.com/ufal/UMR/blob/main/tecto2umr/derivace-podklady/description.txt)
  - fix **discourse rolesets with more than 2 ARGS** (as but-91)

- **Possibility to annotate/re-arrange UMRs in TrEd?** ...   postponed  
  (This would significantly speed up the annotation!)

#### NEXT meetings

- Monday, June 16, S510, 13:00
- Monday, June 23 - canceled 
- Monday, June 30, S510, 13:00
- July, August - based on availability :-)

---

## Monday, May 26, 2025

(Dan, Federica, Hanka, Jan Š., Markéta)

#### Updates:

- Honza: `refer-number` conversion, detected error fixed (conversion not final yet)
- Markéta: conversion for several  *být* frames (copula, existential)

#### TODO:

- **[Release notes](https://docs.google.com/document/d/1v0ou24nai8gPcJxIFbk1zMMYHgUCLSDD/edit)** ... Appendix: still missing examples; then publish as a technical report
- Markéta, Hanka: conversion of _být_, _mít_ frames; 
  - check AMR to UMR automatic conversion [here](https://aclanthology.org/2023.tlt-1.8/)! 
- conversion: 
  - **action nouns**, **agent nouns** in noun-to-verbs conversion, see the description, see [the description](https://github.com/ufal/UMR/blob/main/tecto2umr/derivace-podklady/description.txt)
  - `FPHR`, Github [issue 21](https://github.com/ufal/UMR/issues/21) and [issue 22](https://github.com/ufal/UMR/issues/22)
  - nodes for #Gen, #Unsp, [issue 23](https://github.com/ufal/UMR/issues/23)
  - `polite` attribute (todo)
  - `mode` attribute (todo)
  - fix **discourse rolesets with more than 2 ARGS** (as but-91)
- **Possibility to annotate/re-arrange UMRs in TrEd?** ...   postponed  
  (This would significantly speed up the annotation!)

#### NEXT meetings

- Monday, June 2, S510, 14:00 (not Dan)
- Monday, June 9, S510, 13:00
- Monday, June 16, S510, 13:00
- Monday, June 23, S510, 13:00
- ??? Monday, June 30 ???

---

## Monday, May 19, 2025

(Dan, Federica, Hanka, Jan Š., Markéta)

#### Updates:

- [UMR 2.0](http://hdl.handle.net/11234/1-5902) finally out
- Honza: conversion of the `refer-number` attribute almost final (ML will check the converted data), some improvements in the `refer-person` attribute (not final yet)
- Honza: fixed search in TrEd
- Hana: what to do with action nouns, agent nouns in [noun-to-verbs conversion](https://github.com/ufal/UMR/tree/main/tecto2umr/derivace-podklady), see [the description](https://github.com/ufal/UMR/blob/main/tecto2umr/derivace-podklady/description.txt)
- summary: conversion nouns that denote events (e.g., koncert from koncertovat, běh from běhat) identified based on annotation from previous project with Magda 
- manually annotated them for whether it is possible to assign them to a single verbs frame (that they would likely have in all occurrences) [annotation_file_conversion](https://github.com/ufal/UMR/blob/main/tecto2umr/derivace-podklady/conversion_action_nouns_annotation.tsv)
- 137 converted nouns were mapped to a single PDT-Vallex frame 
- out of them, those which are available in PDT-Vallex are also annotated for how the form of their valency slots (e.g., case, preposition) maps to PropBank-style arguments (with some, the mapping is unfortunately ambiguous, especially with the genitive form between ARG0 and ARG1)
- final file for conversion with all the mapping that was possible so far:[final_mapping_file_conversion]( https://github.com/ufal/UMR/blob/main/tecto2umr/derivace-podklady/conversion_action_nouns_final.tsv)

#### TODO:

- **[Release notes](https://docs.google.com/document/d/1v0ou24nai8gPcJxIFbk1zMMYHgUCLSDD/edit)** ... postponed  
  (Appendix: still missing examples); then publish as a technical report 
- Markéta, Hanka: conversion of _být_, _mít_ frames 
- Markéta: polite, mode attribute  (as Github issues)?
- Hanka: noun-to-verb conversion - next steps for Honza (as Github issues)?
- **Possibility to annotate/re-arrange UMRs in TrEd?** ...   postponed  
  (This would significantly speed up the annotation!)

#### NEXT meetings

- Monday, May 26, S510

---

## Monday, May 12, 2025

(Dan, Hanka, Jan Š., Markéta)

- Hanka: indentifying nouns denoting events - progress:
- conversion nouns that denote events (e.g., koncert from koncertovat, běh from běhat) and agent nouns identified based on annotation from previous project with Magda [conversion_source_file](https://github.com/ufal/UMR/blob/main/tecto2umr/derivace-podklady/summarisation.xlsx),  [agent_nouns_source_file](https://github.com/ufal/UMR/blob/main/tecto2umr/derivace-podklady/agent-nouns_GOLD.tsv), 
- for conversion nouns, we tok all that were annotated in all 50 occurrences as "action", for agent nouns, we took those that were never found to be inanimate (and therefore shouldn't be ambiguous between an agentive and intrumental reading)
- conversion nouns often have both perfective and imperfective verb available + the verbs often have multiple frames available (only 65 have a single verbal counterpart that has a single valency frame) -> for next time, try whether they could be mapped manually to a single verb frame that would likely apply to all the noun¨s occurrences 
- for agent nouns, there are 401 that map to a verb with a single valency frame and 384 that map onto a verb with multiple frames [agent_nouns_single_frame_file](https://github.com/ufal/UMR/blob/main/tecto2umr/derivace-podklady/agent_nouns_single_frame.tsv),  [agent_nouns_multiple_frames_file](https://github.com/ufal/UMR/blob/main/tecto2umr/derivace-podklady/agent_nouns_multiple_frames.tsv)
- I also searched NomVallex for nouns that only have one frame and that frame has the semantic category "action" - 91 such nouns, all of the -ní/-tí variety [NomVallex_action_nouns_single_frame_file](https://github.com/ufal/UMR/blob/main/tecto2umr/derivace-podklady/nomvallex_lexemes_single_frame_action.tsv)

---

## Monday, May 5, 2025

(Dan, Federica, Hanka, Jan Š., Markéta)

#### Updates:

- Honza:
  - conversion of the attributes `refer-number` and `refer-person` improved (not final yet)
  - inner participants --> arguments conversion, [table](https://docs.google.com/spreadsheets/d/1lVo7a8hPBReI4VrgNkUGem8uC_sCQCXJJvLFCbwPuok/edit?gid=1270330829#gid=1270330829)
    - column E newly considered;
    - problems with frames with alternations - if there are more children nodes with relevant functor(s), which of the should be considered argument?
    - the same problem may arise with more obligatory free modifications (LOC, MANN, ...) that are considered arguments in UMR;
    - the same problem may arise with reifications.
  - discourse relations `but-91`, `contrast-91`, `identity-91`, `have-cause-91` should have just 2 arguments (labeled `ARG1`, `ARG2`) 
- Hanka: plans to investigate the possibility to identify eventive nouns and mapped to respective verb frames (NomVallex, Magda's and Hanka's tables)
- Markéta: 
  - plans to work on _být_ frames and suggest conversion rules
  - conversion rules for the attributes `polite`and `mode`  

#### TODO:

- **[Release notes](https://docs.google.com/document/d/1v0ou24nai8gPcJxIFbk1zMMYHgUCLSDD/edit)** ... postponed  
  (Appendix: still missing examples); then publish as a technical report 
- **Possibility to annotate/re-arrange UMRs in TrEd?** ...   postponed  
  (This would significantly speed up the annotation!)

#### NEXT meetings

- Monday, May 12, **S519 !!**
- Monday, May 19, **S519 !!**
- Monday, May 26, S510

---

## Monday, April 28, 2025

(Dan, Federica, Hanka, Jan Š., Markéta)

#### Updates:

- **DMR workshop**: submitted
- Jirka Mírovský: the first version of PDT-C 2.0 searchable through [PML-TQ](https://lindat.mff.cuni.cz/services/pmltq/) available!

#### TODO:

- **[Release notes](https://docs.google.com/document/d/1v0ou24nai8gPcJxIFbk1zMMYHgUCLSDD/edit)** ... postponed  
  (Appendix: still missing examples); then publish as a technical report 
- **Possibility to annotate/re-arrange UMRs in TrEd?** ...   postponed  
  (This would significantly speed up the annotation!)
- Your UMR-related plans for near future?

#### NEXT meetings

- Monday, May 5, S510
- Monday, May 12, S519 !!!
- Monday, May 19, S519 !!!
- Monday, May 26, S510

---

## Monday, April 7, 2025

(Dan, Federica, Hanka, Jan Š., Markéta)

#### Updates:

- Dan: info on his new comparison metric
  - see also the Smatch metric [(Shu Cai and Kevin Knight, 2013)](https://aclanthology.org/P13-2131/)
  - Federika: see also AnCast [(Haibo Sun and Nianwen Xue, 2024)](https://aclanthology.org/2024.lrec-main.94/)
  - There is also an extension called AnCast++ that creates subscores for new document-level aspects of UMR including coreference, temporal dependencies and modal dependencies. As far as I know, the paper hasn’t been published yet—it was still under review the last time I heard.
- Honza: comparison in TrEd
- Markéta, Hanka: info on manual UMRs for PDT-C data 
  - completed 25 sentences from PDT (2 documents; 5 s. from each document  with parallel annotation)
  - completed 50 senteces from PDTSC (2 documents, 1/2 of each; 5 s. from each document  with parallel annotation)
  - to be completed: ??10 sentences from PCEDT (from 2 documents) 
- Federica: manual annotation for Latin data, should be also included in the paper  

#### TODO:

- **DMR workshop** ... plan to finish the paper before Easter
- **[release notes](https://docs.google.com/document/d/1v0ou24nai8gPcJxIFbk1zMMYHgUCLSDD/edit)** ... postponed  
  (Appendix: still missing examples); then publish as a technical report 
- **Possibility to annotate/re-arrange UMRs in TrEd?** ...   postponed  
  This would significantly speed up the annotation!
- Jirka Mírovský plans to prepare searchable PDT-C 2.0 in [PML-TQ](https://lindat.mff.cuni.cz/services/pmltq/) (Lindat)

#### NEXT meetings

- Monday, April 14, S510
- Monday, April 28, S510

---

## Monday, March 31, 2025

(Dan, Federica, Hanka, Jan Š., Markéta)

#### Updates:

- Federica works on UD --> UMR conversion (she plans to submit a paper to LAW)  

- Honza: Problems with PRED, INTF (and some other functors) fixed, 
  better conversion of CNCS, CSQ;   
  problems with the sempos grammateme --> problems with the refer attribute

- Markéta + Hanka: small progress in data preparation (10 parallel sentences + cca 30 sentences with a single annotation ready)

#### TODO:

- **DMR workshop**: We are supposed to submit at least 1 paper, deadline: April 21
  
  - Czech conversion - error analysis ... for (small number of) selected phenomena? 

- final check of [the release notes](https://docs.google.com/document/d/1v0ou24nai8gPcJxIFbk1zMMYHgUCLSDD/edit) (Appendix: still missing examples); then publish as a technical report 

- **PDT evaluation data** - 6 documents (not from Faust), 162 sentences   
  
  - current goal: at least 25 sentences written (PDT), 50 sentences spoken (PDTSC), ?? sentences business news (WSJ) --> at least 75 sentences
  - then the rest (PDTSC 50 sentences, WSJ < 37 sentences) --> up to 162 sentences in total

- **data comparison ... TrEd ??**
  
  - Ask Zdenka who compared the AMR annotations for (Urešová at al, 2014)!

- **How difficult it would be to make it possible to annotate/re-arrange UMRs in TrEd?** This would significantly speed up the annotation!

- ???Jirka Mírovský: searchable PDT-C 2.0 in [PML-TQ](https://lindat.mff.cuni.cz/services/pmltq/) (Lindat)

#### NEXT meetings

- Monday, April 7, S510
- Monday, April 14, S510
- Monday, April 28, S510

---

## Monday, March 10, 2025

(Dan, Federica, Hanka, Jan Š., Markéta)

#### Updates:

- Federica works on UD --> UMR conversion:  
  How to align graphs?  
  How to identify abstract predicates?   
  Checking inverse roles? 

- Honza:   
  Latin data can be converted in the same way as Czech data;  
  The problem with COMPL fixed.

#### TODO:

- DMR workshop: We are supposed to submit at least 1 paper, deadline: April 21
  
  - Czech conversion - error analysis ... for (small number of) selected phenomena? 

- Complete [the release notes](https://docs.google.com/document/d/1v0ou24nai8gPcJxIFbk1zMMYHgUCLSDD/edit) (publish as a technical report?) 

- **PDT evaluation data** - 6 documents (not from Faust), 162 sentences  
  
  - Dan: will hopefully pre-generate ids   
  - split between Markéta and Hanka (dtest data):  
    - **ML:** ln94210_111.t (14s.), pdtsc_093_3.02.t (50s.), wsj0013.cz.t (18s.)
    - **HH:** ln95046_093.t (11s.), pdtsc_146_2.05.t (50s.), wsj0072.cz.t (19s.)
    - ~~ML: PDT: mf930713_054.t (11 s.),~~   
      ~~PCEDT-CZ: wsj0676.cz.t (21 s.),~~  
      ~~PDTSC: pdtsc_106_3.03.t (50 s.);~~
      - ~~HH: PDT: ln94205_132.t (9 s.),~~  
        ~~PCEDT-CZ: wsj1251.cz.t (8 s.),~~   
        ~~PDTSC: pdtsc_093_3.02.t (50 s.)~~  

- ???Jirka Mírovský: searchable PDT-C 2.0 in [PML-TQ](https://lindat.mff.cuni.cz/services/pmltq/) (Lindat)

#### NEXT meetings

- Monday, March 17, S510
- Monday, March 24, S510
- Monday, March 31, S510

---

## Monday, March 3, 2025

(Dan, Federica, Hanka, Jan Š., Markéta)

#### TODO:

- for Dan, Hanka, Markéta:
  - if not completed yet, complete the UMR annotation task (Federica's email from Jan 23);
  - data validation 
- for Markéta, Honza (and others):
  - complete [the release notes](https://docs.google.com/document/d/1v0ou24nai8gPcJxIFbk1zMMYHgUCLSDD/edit) (publish as a technical report?) 
  - prepare an overview what has been done (based on Honza's [slides](https://ufallab.ms.mff.cuni.cz/~stepanek/2501-umr/) and with his support), see above the release notes;
- for Honza:
  - conversion of Latin data (almost done, missing list of statives)
- ??? searchable PDT-C 2.0 in [PML-TQ](https://lindat.mff.cuni.cz/services/pmltq/) (Lindat)

#### NEXT meetings

- Monday, March 10, S510
- Monday, March 17, S510
- Monday, March 24, S510
- Monday, March 31, S510

---

## Monday, Feb 24, 2025

(Dan, Federica, Hanka, Jan H., Markéta, Jan Š., Šárka, Minoo)

#### Expected outcomes (Jan H.)

**US UMR project (= infrastructure project):**

- multilingual DATA as main outcome (no research) --> **Czech UMR data** (see below);
- foster the cooperation;
- [6th DMR workshop](https://dmr2025.github.io/index), Prague,  August 4-5 2025.

**Czech [UMR-related projects](https://ufal.mff.cuni.cz/uniform-meaning-representation-czech):**

- publications (will be specified, including the required acknowledgement);
  
  - publications can be also on UMR for other languages than Czech, e.g., Latin or Persian (the project report will explain that it was important to gain a multi-lingual perspective)
  
  - Publication committment:
  
  - 1st period (until Dec. 2024): 3 conference papers (done),
  
  - 2nd and 3rd periods (2025-Sep. 2027, end of project, will be reported as one report in 2027/8):
  
  - 2nd period: 2 journal papers (WoS), 3 conference papers, 7 parsers (by participants in a shared task organized by us & the US UMR team), 1 dataset (CZ UMR)
  
  - 3rd period: 2 journal papers, 2 conference papers, 2 SW: (better parser and neurosymbolic LLM)
  
  - total for 2+3 periods: 4 journal papers, 5 conf. papers, 9 SW results
  
  - Copy from the project contract (but does not have to folowed to the letter...) below:
  
  - 2nd period:
  
  - 1 / J / UMR specification for multilingual annotation / Transactions of the
    
         ACL / IF 3,0, Q1 (předběžně)
    
       2 / J nebo Jsc / UMR and Slavic languages: use case of Czech / Künstliche
    
         Intelligenz nebo Slovo a Slovesnost / IF cca 1,0 resp. 0,8
    
       3 / D / UMR Shared Task overview / CoNLL conference (Shared Task volume)
       4 / D / Multilingual Annotation in the UMR framework / ACL nebo Coling nebo EACL nebo NAACL
    
         nebo EMNLP konference
    
       5 / D / Multilingual UMR dataset / LREC conference 2026
       6 / R / UMR parser by Abc team at UMR Shared Task
       7 / R / UMR parser by Xyz team at UMR Shared Task
       8-12 / R / UMR parser ... (podle počtu účastníků, 5-8 výsledků typu
    
         software, pouze od úspěšných účastníků)
  
  - 3rd period:
  
  - 1 / J / Combined Language models in selected NLP tasks /
    
         Transaction of ACL / IF 3,0 (Q1)
    
       2 / J / Extended multilingual UMR specification / Computational
    
         Linguistics / IF 2,5 (Q1)
    
       3 / D / Probing LLMs and its relation to symbolic knowledge
    
         representation / jedna z konferencí endorsovaných ACL v roce 2026/2027
    
       4 / D / Comparison of UMR and LUSyD knowledge
    
         representations for multiple languages / jedna z konferencí
         endorsovaných ACL v roce 2026/2027
    
       5 / R / Enhanced UMR parser and generator for Czech /
    
         Open Source, LINDAT/CLARIAH-CZ repository
    
       6 / R / UMR LLM [cs] / open source model pro češtinu (nebo
    
         vícejazyčný), LINDAT/CLARIAH-CZ repository
    
    - Czech data:
    - **goal: approx. 10,000 manually annotated sentences (~ 5% of PDT-C)**
      10 minutes per sentence (on average) ... **??? > 200 person-days ???**
    - start of (massive) manual annotation – end of 2025;
    - either selected phenomena OR all phenomena on a smaller sample;
    - some data for inter-annotator agreement;
    - annotation with SynSemClass in mid 2025 (SSC still under construction)
    - **automatic transfer**:
    - choice of phenomena and their granularity: up to us;
    - internal deadline for new version: mid June, 2025
      (2 internal data releases each year)

**Suitable evaluation data:**

- set of phenomena that should be covered (Honza: implemented)
- data for overall evaluation plus additional data for individual phenomena (and their combinations)?

#### TODO:

- for Dan, Hanka, Markéta:
  - feedback on Czech UD conversion (Federica's email from Jan 21);
  - UMR annotation task (Federica's email from Jan 23);
- for Markéta, Honza:
  - complete [the release notes](https://docs.google.com/document/d/1v0ou24nai8gPcJxIFbk1zMMYHgUCLSDD/edit);
  - prepare an overview what has been done (based on Honza's [slides](https://ufallab.ms.mff.cuni.cz/~stepanek/2501-umr/) and with his support), see above the release notes;
- for Honza:
  - conversion of Latin data
- ??? searchable PDT-C 2.0 in [PML-TQ](https://lindat.mff.cuni.cz/services/pmltq/) (Lindat)

#### NEXT meetings

- Monday, March 3, **!! S519 !!**
- Monday, March 10, S510
- Monday, March 17, S510
- Monday, March 24, S510
- Monday, March 31, S510

---

## Monday, Feb 3, 2025

(Dan, Markéta)

#### TODO

- for Dan, Hanka, Markéta:
  - feedback on Czech UD conversion (Federica's email from Jan 21)
  - UMR annotation task (Federica's email from Jan 23)
- for Markéta:
  - complete the release notes
  - prepare an overview what has been done (based on Honza's [slides](https://ufallab.ms.mff.cuni.cz/~stepanek/2501-umr/) and with his support)
  - collect information from JH
    - next release date
    - available funds for manual UMR annotation (if yes, when and how many?)
- for Honza:
  - conversion of Latin data (preparation)
  - suitable evaluation data for manual annotation
    - which phenomena should be covered? how many sentences?
      (coordination, copied nodes, CNCS, COMPL, coreference (both types), relative clauses, ...)
    - data for overall evaluation plus additional data for individual phenomena (and their combinations)?
    - discuss the selection with Federica (evaluation of the UD conversion)
- ??? searchable PDT-C 2.0 in the Lindat repository

#### NEXT meeting

- Monday, Feb 17, S510 (reservation needed)

---

## Monday, Jan 27, 2025

(Honza, Markéta, Šárka)

See above.

#### NEXT meeting

- Monday, Feb 3, S510

---

## Monday, Jan 13, 2025

(Dan, Federika, Hanka, Honza, Markéta)

- Honza: From PDT to UMR, [slides](https://ufallab.ms.mff.cuni.cz/~stepanek/2501-umr/)

#### TODO for next Monday

- for Markéta: complete the release notes
- for Markéta: collect information from JH
  - next release date
  - available funds for manual UMR annotation (if yes, when and how many?)
- for Honza: suitable evaluation data for manual annotation?

#### NEXT meeting

- Monday, Jan 20, S519

---

## Monday, Jan 6, 2025

(Dan, Federika, Hanka, Honza, Markéta)

- Federica: ["Making UMR annotation easier" document](https://docs.google.com/document/d/1oCQO_lSQ3kA1k-mpvFZ1akf_KkFBnv4nqKAN7M47j4Y/edit?tab=t.0),
  where, issues/unclear points in the guidelines are collected for discussion.

- Markéta: [Google drive for the PDT-C to UMR conversion](https://drive.google.com/drive/folders/1HbDbVAwPUTVbgzL-WoB74Y6G3pkw4Qni)

#### TODO for next Monday

- for Markéta: complete the release notes
- for Honza: prepare a short overview of the main ideas of the conversion
- for Honza: suitable evaluation data for manual annotation?
- for Markéta: collect information from JH
  - next release date
  - available funds for manual UMR annotation (if yes, when and how many?)
