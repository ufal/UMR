# UMR-related links

[Czech UMR](https://ufal.mff.cuni.cz/uniform-meaning-representation-czech)

[Google Drive](https://drive.google.com/drive/folders/1HbDbVAwPUTVbgzL-WoB74Y6G3pkw4Qni?ths=true)

## Guidelines
[UMR Guidelines](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md)

[AMR Guidelines](https://github.com/amrisi/amr-guidelines/blob/master/amr.md)

[Issues in UMR Guidelines](https://docs.google.com/document/d/1oCQO_lSQ3kA1k-mpvFZ1akf_KkFBnv4nqKAN7M47j4Y/edit?tab=t.0)


## UMR lists/mappings/...
[**!!! UMR lists !!!**](https://docs.google.com/spreadsheets/d/1PVxgXW3ED3OWLieie9scr6iq_xuQ5RAA8YJKwbLwJ2E/edit#gid=1927108453) - the document provides lists of:
- **abstract concepts**, which subsumes:
  - _basic concepts_ (as person, thing, place, name, event, etc.)
  - _discourse relations_ (as multi-sentence, and, or, inclusive-disj, and-but, ...)
  - _entities_ (as date-entity (i.e., :calendar, :day, ...), ordinal-entity (i.e., :value, :range, :range-start), url-entity, percentage-entity, ...)
  - _quantities_ (as distance-quantity, volume-quantity, etc.)
  - _maths_ (as less-than, at-most, sum-of, ratio-of, etc)
  - _other_ (as date-interval, emoticons, etc.)

- **abstract rolesets** (=abstract predicates) with a **roleset description**, **ARGx roles** and **role descriptions**; the rolesets/predicates are grouped into:
  - _-91: reifications_
  - _-91: discourse relation rolesets/reifications_ (as but-91, contrast-91, have/condition-91, have-concession-91, etc.)
  - _non-prototypical pred rolesets_, i.e., 9 predicates for the so-called non-verbal clauses, as defined by [UMR Guidelines 3.2.1.1.1](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-2-1-1-1-non-verbal-clauses)
  - _-91: implicit rolesets_  (as have-degree-91, include-91, resemble-91, but also e.g. hyperlink-91, street-address-91, weather-91, etc)

- the definitive list of **roles**, divided into:
  - _participent roles_ (with 23 labels like :actor, :undergoer, :cause, :manner ... and their reifications)
  - _non-participant roles_ (with 16 roles like :direction, :path, :quant, :ord, etc. and their reifications)
  - _sub-roles_ (:name, :wiki, :value, :unit, :scale, :range)
  - _date-entity role_ - just :time
  - _attribute roles_(:polite, :aspect, :polarity, :mode, :degree, :refer-person, :refer-number)
  - _modal roles_(:modstr, :modpred, :quot)
  - _numbered ARGs/ops_
  - _discourse relation roles_(as :apprehensive, :condition, :concession, :subtraction and their re§ifications)

- (AMR -> UMR roleset/arg mappings incl. type of change)
- (AMR -> UMR role mappings)
- (AMR -> UMR NE mapping)
- (NE types to review ... concrete examples on NEs and their annotation)


**PDT-Vallex to ARG roles conversion:** 
 
- verb-specific conversion
  - [instructions](../tecto2umr/functors-to-args-mapping-instructions.md)
  - [conversion table](https://docs.google.com/spreadsheets/d/1AuIASjkdAdKom7bgjDN5BxMKeRUefHlN/)
- verb-nonspecific [default mapping](../tecto2umr/dafault-functors-to-umrlabels.txt)

**NE classes / types** ... do we have access to the googlesheet with revised EN classes/types **???**


## Dictionaries
[PropBank - development](https://verbs.colorado.edu/propbank-development/)

[PDT-Vallex in Teitok - version 4.0](https://lindat.mff.cuni.cz/services/teitok/pdtc10/index.php?action=vallex)  (i.e., "all the verbs in the PDT3.5 that have a PDT-Vallex id. Those are mostly verbs, but there are also other word classes in PDT-Vallex. The occurrences are taken from PDT3.5, and the frame information is taken from PDT-Vallex 4.0, released as part of [PDT-C](https://lindat.mff.cuni.cz/repository/xmlui/handle/11234/1-3185). If the verb is furthermore present in Vallex 3.0, a link is provided to that as well.")

[PDT-Vallex - version 3.0](https://lindat.mff.cuni.cz/services/PDT-Vallex/) (version from PCEDT 2.0)

[PDT-VALLEX to PropBank mapping](https://github.com/ufal/UMR/blob/main/tecto2umr/pdt_pb_mapping_via_czengvallex_ssc-merged.xlsx)

[SynSemClass - Search](https://lindat.mff.cuni.cz/services/SynSemClassSearch/?version=synsemclass5.0) - SSC version 5.0

~~[SynSemClass - Search](https://quest.ms.mff.cuni.cz/SynSemClassSearch/) (under development, SSC version 4.0)~~

[SynSemClass Search - working data](http://ufallab.ms.mff.cuni.cz/~fucikova/public_html/SSC_classmembers/) (SSC 4.0 and updates)




## Data

[Julia's UMR annotation github](https://github.com/cu-clear/UMR-Annotation)

## Tools

[Mišo's visualizations](https://ufallab.ms.mff.cuni.cz/~mnovak/umr/graphs/)

[On-line visualization at Colab](https://colab.research.google.com/drive/1pbmJ3k3_qFuVM44neVHikiJKe81xsAHD?usp=sharing) (no local installation needed)

0.	Sign in
1.	Initialize the environment – press the button (triangle in a circle)
2.	Move to Title below – press the button (triangle in a circle). It will run till you browse there and choose a file.
3.	Move to Import below – press the button (triangle in a circle). You will find the visualization below.

The issues and questions should be written in the [UMRGraphViz issue tracker](https://github.com/ufal/UMRGraphViz/issues).

[UMR Writer](http://umr-tool.cs.brandeis.edu/)

