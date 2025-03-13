# UMR meeting minutes


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

- **PDT evaluation data** - 6 documents (not from Faust)  
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

## Monday, March 3, 2025

(Dan, Federica, Hanka, Jan Š., Markéta)


#### TODO:
- for Dan, Hanka, Markéta:
   -  if not completed yet, complete the UMR annotation task (Federica's email from Jan 23);
   -  data validation 
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
  -   2nd period: 2 journal papers (WoS), 3 conference papers, 7 parsers (by participants in a shared task organized by us & the US UMR team), 1 dataset (CZ UMR)
  -   3rd period: 2 journal papers, 2 conference papers, 2 SW: (better parser and neurosymbolic LLM)
  -   total for 2+3 periods: 4 journal papers, 5 conf. papers, 9 SW results
  -   Copy from the project contract (but does not have to folowed to the letter...) below:
  -     2nd period:
  -       1 / J / UMR specification for multilingual annotation / Transactions of the
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
  -     3rd period:
  -       1 / J / Combined Language models in selected NLP tasks /
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
   -  feedback on Czech UD conversion (Federica's email from Jan 21);
   -  UMR annotation task (Federica's email from Jan 23);
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


## Monday, Feb 3, 2025

(Dan, Markéta)

#### TODO
- for Dan, Hanka, Markéta:
   -  feedback on Czech UD conversion (Federica's email from Jan 21)
   -  UMR annotation task (Federica's email from Jan 23)
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

