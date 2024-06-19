# Notes from UMR Summer School (10-14.06.24)

GitHub page with materials: https://github.com/umr-summer-school/materials.

## UMR writer
-	It's better to use Google Chrome, because there are known issues with Firefox and Safari.
-	Inconsistencies between UMR Writer, guidelines, and released data. For instance, `Plural` is still capitalised in the Writer interface (vs released data); the same happens with `State` and `Aspect`. As of now, using the UMR Writer implies some necessary postprocessing.
-	Other issue: `Singular` and `3rd` show up in the Alignments as nodes to be aligned, when annotating with the Writer (despite not being nodes).
-	The UMR Writer would be useful, as e.g. parentheses are managed automatically. It would help also with alignments, because they wouldn't have to be figured out manually, but that doesn't seem to work very well. However, as of now it is very imprecise: cf. capitalised attributes, elements that are not supposed to be included in the alignments, etc. \
 Manual annotation in a text file still seems to be faster and easier.

## Document-level
-	It is possible to use `document-creation-time` in the first sentence only, and then all other events are anchored to previous events. However, if necessary `document-creation-time` can occur also in other sentences than the first one.
-	`PAST`/`FUTURE_REF`: basically never used. Maybe for some vague expressions (e.g., _once upon a time_).
-	Coreference: refer to the previous instance, not the first one (Julia said; but Benet said the opposite). But it actually should not matter because there is some postprocessing happening, and there the full chain is reconstructed (Julia said).
Question: what about this postprocessing? Asked Jin, who said that it's formal corrections (e.g. labels that changed, `modstr` to `modal-strength`), nothing too important. So, unclear.
-	Modal annotation: you start by annotating `modal-strength` at the sentence level, because it’s easier to figure out the modality of the event while you are already annotating the event. Then, during the postprocessing phase, it gets automatically converted for the document-level annotation: the value of `modal-strength` value becomes the role, e.g. `:full-aff`. Finally the modal annotation at the sentence level is removed: 

    !! **modality is NOT supposed to be annotated at the sentence level** !!

-	Abstract predicates (_-91_) do not qualify as references in the temporal document-level annotation. In other words, they are annotated with respect to temporal dependencies, but cannot be the item to which another event is anchored. We have to refer to the previous event.


## What is an event?
-	Roleset does not mean/imply event in UMR. Something can be annotated with a roleset without being an event.
-	Things that are not processes don’t have `aspect`, `modal-strength`, temporal dependency. For instance:
    _driver_ / _governor_: can be `:X-of` (e.g. `ARG0-of`) a roleset, but is not annotated with event information (aspect, modality, temporal dependencies).

-	_Floating hospital_: see slides from Tue 11. Cf. if we are talking about a boat designed to hold a floating (as in the event of _float_) hospital, but in the sentence it’s not actually serving that purpose and it’s not floating: NOT event. 

## Evaluator
AnCast, an intuitive and efficient tool for evaluating graph-based meaning representations. AnCast implements evaluation metrics such as
concept F1, unlabeled relation F1, labeled relation F1, and weighted relation F1. 
- Based on the "idea that we can align two graphs by identifying initial alignment anchors in a pair of graphs. Initial anchors are pairs of concepts, one from each graph, that can be aligned with a high level of confidence either because the two concepts match and they are also unique within each graph, or if they are aligned to the same word token(s) in a sentence. We can determine the alignment for the rest of the concepts in the pair of graphs by observing that concepts with aligned anchors as neighbors also have a higher probability of being aligned. We can thus align two graphs by first identifying initial anchors and then iteratively propagating the alignment to their neighbors through a process called
anchor broadcast."


- Paper (sentence level): ["Anchor and Broadcast: An Eﬀicient Concept Alignment Approach for Evaluation of Semantic Graphs"](https://aclanthology.org/2024.lrec-main.94.pdf) (Sun and Xue, 2024). \
The paper about document level evaluation is still unpublished, but the code is available.
- GitHub repo: https://github.com/sxndqc/ancast.
 
Tried it with `mf920922-133_estonsko-DZ/ML`. Few adjustments needed:
 - Multiple aligments not allowed: for the time being I kept the first alignment only.
 - Sentences must be identical (e.g. no multiple spaces), and no other information than the sentence text is allowed (e.g. words, no glosses, no morphemes, ...); otherwise it crashes.
 - No extra comments allowed (e.g. in DZ _# Spolehlivý dům = Kindel kodu (Valimisliit Kindel Kodu) Q31271882_)

 So, to run the evaluator I have copies of the original `mf920922-133_estonsko-DZ/ML.txt`. Output:

 ```
 6p / perso
 Ignoring Sentence 6 because a colon is missing in 6.
 Error encountered, skipping sentence 6
 Evaluating ['samples/estonci_dz.txt', 'samples/estonci_ml.txt']:
 Sent Micro:	Precision: 88.98%	Recall: 86.78%	Fscore: 87.87%
 These pairs of nodes have paradoxical relations in temporal in test file.
 (s5k, s5z)	(s5v, s5k)	(s5d, s5z)
 These nodes have erratic circular relations in temporal in gold file.
 s5d
 Modality:	Precision: 87.50%	Recall: 77.78%	Fscore: 82.35%
 Temporal:	Precision: 70.00%	Recall: 66.67%	Fscore: 68.29%
 Coref:		Precision: 64.71%	Recall: 64.71%	Fscore: 64.71%
 Comprehensive Score:	83.66%
 ```

To run it:

`python -m src.run test_file.txt gold_file.txt --output comparison_test1.csv --format umr`


## Other
-   Gender is not annotated in UMR, because it is hard to capture across different languages.
-	When annotating months, if you’re using the January-December calendar just use numbers (e.g., _February_ corresponds to _2_). Otherwise, with non-standard calendars, spell out the name of the month.
-	Up-to-date data available somewhere? Released data are not reliable, for instance some sentences still have `modal-strength` at the sentence level. Asked Julia: released data is still the reference.
-   Partial graphs obtained by converting other resources to UMR proved helpful. See [Bootstrapping UMR Annotations for Arapaho from Language Documentation Resources](https://aclanthology.org/2024.lrec-main.220/) (Buchholz et al., 2024), from IGT. 
- _publication-91_ for "Estonci volili parlament": \
Somebody made the observation that it is going to be redundant if we annotate it for every sentence in the document, and the whole corpus we are annotating is a newspaper. JH defended the need of attribution (saying who said it).
-   UMR parsing has to be pipelined now, but this implieas a high rate of error propagation. In general, it really depends on how much data we have: with more data an end-to-end approach (no pipeline) will be better.
