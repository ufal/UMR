## Documentation for UMR 2.0 release - Latin

The Latin subset consists of 50 sentences, each fully annotated with sentence-level graphs, alignment blocks, and document-level information.
The annotation has been performed manually, with careful adherence to the UMR guidelines.
Latin represents the first historical language to be incorporated into the UMR collection, marking an important expansion of its scope.

The annotated text corresponds to the first 50 sentences of _De Coniuratione Catilinae_, a historical monograph in 61 chapters written by Sallust in I century BC.
The source of the text is the Latin Dependency Treebanks (LDT) (Bamman and Crane, 2006), where it is annotated in the style of the Prague Dependency Treebank (PDT) (Hajič at al., 2020).
The selection of this text is indeed motivated by its availability in a PDT-like annotation format, which in the future could be leveraged for automatic conversion.

To define semantic concepts and participant roles, the annotation relies on the valency lexicon Vallex4UMR.
Vallex4UMR has been created ad hoc to be compatible with the UMR framework and annotation, by combining the two existing valency lexicons for Latin.
Indeed, the two resources, Vallex 1 (Passarotti et al., 2016) and Vallex 2 (Mambrini et al., 2021a), cannot be readily exploited for annotation purposes for the reasons described hereafter.

The first version of Vallex presents several limitations: first of all, the lack of definitions, which makes it hard to fully understand the intended meanings of the different frames, even more so in the case of a language with no native speakers.
Secondly, there appears to be a redundancy of entries, which are unnecessarily distinguished even when they clearly refer to the same frame and meaning of a verb.
Nevertheless, the resource cannot be completely overlooked, since it is directly linked to (and built upon) the tectogrammatical layer of the treebanks which could be exploited to automatically obtain annotated data, analogously to how PDT-Vallex has been built on top of PDT for Czech.

Latin Vallex 2 is a revision of the first version, but it adopts a different approach: it is intuition-based, which means that for each sense listed for a lemma or hypolemma, there is a valency frame, established on the basis of the dictionary meaning listed for that lemma.
It contains about eight times the entries of the first version, and through the link with WordNet (Franzini et al., 2019; Mambrini et al., 2021b) synsets it provides definitions, as entries in Latin Vallex 2 are linked to WordNet synsets through the LiLa Knowledge Base (Passarotti et al., 2020}.
However, the second version does not include examples, which would be very useful in understanding the definitions and distinguishing frames.
Moreover, the primary limitation of the resource is that many entries have extremely similar definitions as well as identical frames, making it impractical in terms of usability.

For the reasons highlighted above, the existing resources cannot be exploited as they are, and additional work has been necessary to obtain the kind of resource required for UMR annotation.
Therefore, a task of combination of the two resources has been carried out.
The output of this task is Vallex4UMR, a new resource that does not disregard information contained in the available resources, but improves it in terms of completeness and efficacy, at the same time by making it exploitable for UMR purposes.
Its coverage will be sufficient for the needs of UMR annotation, although it will not exhaustively cover the language.
It is openly available both as a machine-readable text file (link: https://github.com/fjambe/Vallex4UMR) and via a web-based search engine featuring a graphical user interface (link: https://quest.ms.mff.cuni.cz/vallex/).

