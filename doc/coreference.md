# Coreference

Relations that are in the Tecto theory annotated as coreference, i.e. those captured in 
`coref_gram.rf` and `coref_text` (or `coref_text.rf` in older versions) attributes,
are represented in three different ways in UMR:
1. inversed participant role
2. reference to an already specified concept variable
3. the `:coref` attribute in the document-level annotation

## Inversed participant role
This annotation style is used for capturing coreference of relative pronouns and arguments
of participles. According to the theory underlying UMR, relative clauses and participles 
primarily serve as event concept modifiers. In such cases, an inversed numbered or general
participant role (`:Stimulus-of` in the following example) is used to modify the parent concept:
```
I bought the sweater that you saw.
(b/ buy-01
	:actor (p/ person
		:ref-person 1st
		:ref-number Singular)
	:theme (s/ sweater
		:Stimulus-of (s2/ see-01
			:experiencer (p2/ person
				:ref-person 2nd
				:ref-number Singular)
			:aspect State
			:modstr FullAff)
		:ref-number Singular)
	:aspect Performance
	:modstr FullAff)
```

In the Tecto style, such coreference relations are annoted with grammatical coreference
(the `coref_gram.rf` attribute). However, not all relations of grammatical coreference
can be converted to this UMR style of annotation.

## Reference to a concept variable
This annotation style has been adopted from AMR and is one of the reasons that makes the
UMR representation a graph, not just a tree. Reference to a variable is strictly used
within a single sentence. An example is a reference to the entity under the `p` variable
in the ARG1 argument of the concept `arrest-01`:

```
Snt7: Pope was in remission from a rare form of bone cancer when he was arrested in Russia.

(h/ have-mod-91
      :ARG1 (p/ person :wiki "Edmond_Pope"
            :name (n/ name :op1 "Pope"))
      :ARG2 (r/ remission-02
            :ARG1 (d/ disease :wiki -
                  :name (n2/ name :op1 "bone" :op2 "cancer")
                  :ARG1-of (r2/ rare-02))
            :temporal (a/ arrest-01
                  :ARG1 p
                  :place (c/ country :wiki "Russia"
                        :name (n3/ name :op1 "Russia")))
   	   :aspect Performance
   	   :modstr FullAff)
   :aspect State
   :modstr FullAff)
```

However, not all intra-sentential links (set aside those covered by a previous annotation style)
are represented in this way; some should be annotated with the style to be presented in the
following section.

## The `:coref` attribute

The `:coref` attribute is a document-level attribute to capture coreference links. 
In general, the attribute links two entities referred to by identifiers that consist of a concatenation of the sentence identifier and the concept variable. 
In addition, a relation type declares the kind of relation between the two entities.

### Entity coreference
UMR focuses on pronouns (as anaphorical expression). 
However, we would like to generalize it to cover all coreference relations as identified in PDT.

Two types of relations are recognized:
- identity relation, marked with the `:same-entity` relation (two expressions have the same referent), see examples Snt5 and Snt6 and their annotation below:   
   - [en] Snt5: _Pope was flown to the U.S. military base at Ramstein, Germany._
   - [en] Snt6: _He will spend the next several days at the medical center there before he returns home with his wife Sherry._
-  `:subset-of` relation for split antecedents (relates sets of entities to entities belonging to such a set), UMR exemplifies it by the following sentence:
   - [en] _He is very possessive and controlling but he has no right to be as we are not together._   
   ... UMR describes as "_he_ (p2) is annotated with a `:subset-of` relation to the _we_ (p3) node".  
   **In schema, there is  `:coref (he :subset-of we)`   !!  
   ML: should be rather  `:coref (we :subset-of he)` ... "he" is a subset of "we"**, compare to examples for event coreference below??
```
Snt5: Pope was flown to the U.S. military base at Ramstein, Germany.
(f/ fly-01
      :ARG1 (p/ person :wiki "Edmond_Pope"
            :name (n/ name :op1 "Pope"))
      :goal (b/ base
            :mod (m/ military
            :mod (c/ country :wiki "United_States"
                  :name (n2/ name :op1 "U.S.")))
            :place (c2/ city :wiki "Ramstein_Air_Base"
                  :name (n3/ name :op1 "Ramstein")
                  :place (c3/ country :wiki "Germany"
                        :name (n4/ name :op1 "Germany"))))
      :aspect Performance
      :modstr FullAff)

(s5/ sentence
    :temporal(s4p :after s5f)
    :modal(AUTH :FullAff s5f)
    :coref(s4p4 :same-entity s5p))

Snt6: He will spend the next several days at the medical center there before he returns home with his wife Sherry

(s/ spend-02
      :ARG0 (p/ person
         :ref-person 3rd
	 :ref-number Singular)
      :ARG1 (t/ temporal-quantity
         :quant (s2/ several)
	 :unit (d/ day
	 	:mod (n/ next)))
      :temporal (b/ before
         :op2 (r/ return-01
	    :ARG1 p
	    :ARG4 (h/ home)
	    :companion (p2/ person :wiki -
	       :name (n2/ name :op1 "Sherry")
	       :ARG1-of (h2/ have-role-91
	          :ARG2 p
		  :ARG3 (w/ wife)))
	    :aspect Performance
	    :modstr FullAff))
      :place (c/ center
          :mod (m/ medical)
	  :place (t2/ there))
      :aspect State
      :modstr FullAff)

(s6/ sentence
  :temporal((DCT :after s6s)
            (s6s :after s6r))
  :modal((AUTH :FullAff s6s)
         (AUTH :FullAff s6r))
  :coref((s5p :same-entity s6p)
         (s5b :same-entity s6t2))
```



It must be used to represent inter-sentential relations. 
It can be also used within a single sentence, but it is not clear from the guidelines in which cases to use it.

### Event coreference

Two types of relations are recognized:
- identity relation `same-event`
- subset relation `subset-of`
  - [en] _1 **arrest** took place in the Netherlands and another **[arrest]** in Germany. **The arrests** were ordered by anti-terrorism judge fragnoli._   
  ... _the arests_ (2nd sentence) annotated as the parent of _each of arrests_ from the first sentence (children) 
```
(:coref ((s2a :subset-of s1a2) 
         (s2a :subset-of s1a3)))
```

# TODO
Try to identify specific cases that do not belong to any of the categories above.
The dichotomy between textual and grammatical coreference is not followed in UMR (apart from that the grammatical one is almost always intra-sentential).
Is there any kind of special treatment based on the type of the anaphor, i.e. nouns, verbs, personal pronouns (#PersPron), relative pronouns, unexpressed (#PersPron, #Cor, #QCor, #Rcp)?
