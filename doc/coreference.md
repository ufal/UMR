# Annotation of coreference in UMR

## Intra-sentential coreference
It is represented by a reference to the antecedent concept, using its identifier.
It means that the first mention of the entity within a sentence is annotated as a concept and any consequent mention of the same entity is then represented by a reference.

## Inter-sentential coreference
It is represented by a document-level ":coref" relation.
It links two entities referred by identifiers that consist of a concatenation of the sentence identifier and the concept identifier.
In addition, a relation type declares what kind of relation is between the two entities (e.g. ":same-entity" for identity coreference, ":subset-of" for split antecedents).

## Coreference of relative pronouns
Relative clauses are primarily used as event concept modifiers.
In this case, an inversed numbered or general participant role is used to modify the parent concept.

# TODO
Try to identify specific cases that do not belong to any of the categories above.
The dichotomy between textual and grammatical coreference is not followed in UMR (apart from that the grammatical one is almost always intra-sentential).
Is there any kind of special treatment based on the type of the anaphor, i.e. nouns, verbs, personal pronouns (#PersPron), relative pronouns, unexpressed (#PersPron, #Cor, #QCor, #Rcp)?
