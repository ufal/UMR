# UMR relations for attributes

UMR distinguishes 2 types of modifiers:

**Anchoring** modifiers "situate the intended referent of the referring expression via reference to another object" (Croft); i.e., they provide referential grounding for a referent expression:
- `:poss` relation,
- `:part` relation,
- `have-rel-role-92` ... the predicate for kinship relation (as in _father of somebody_).

**Typifying** modifiers "enrich the referent description by subcategorizing it or selecting the quantity (cardinality, amount, proportion, piece) of the category or type denoted by the head noun." 
- `:mod` (_a women's magazine_ as a magazine belonging to some subclass of magazines), also for demonstrative determiners (_these shirts_), for property concept modifiers (without their own frame files as e.g. _quirky shirts_)
- `:age`, `:age-of`, `have-age-91` (_the thirty year-old man_)
- `:group`, `:group-of`, `:have-group-91` for indicating the membership of groups (_a swarm of bees_)
- `:topic`, `:topic-of`, `have-topic-91` for indicating what a referent is about as in (_Information about the case_), and 
- `:medium`, `:medium-of`, `have-medium-91` for indicating channels of communication, such as languages, ... (_a French song_)
 
**Quantification** ... [Part 3-2-2-5](https://github.com/ufal/umr-guidelines/blob/master/guidelines.md#part-3-2-2-5-quantification)
- `:ord` (always with an (o/ ordinal-entity) concept as a daughter, :value), `:quant`, `:range`, `:scale`, `:unit`, and `:value` 

**Others**
- `:example` is used to annotate illustrative examples of object categories (_countries like Germany and France_);
- `:name` introduces named entities. 

AMR: 
- `:consist-of` (UMR -->  `have-group-91`, `have-material-91`)   
   _a team of monkeys_   
   AMR: (team :consist-of (monkey)) --> UMR: have-group-91 (ARG1 entity, ARG2 group)  
    _a ring of gold_   
   AMR: (ring :consist-of (gold))   --> UMR: have-material-91 (ARG1 entity, ARG2 material) 
- `:subevent` (_presentation at a conference_) ... ???
- `:subset` (with `include-91` as reification) ...UMR --> `include-91`
```
AMR: nine of the twenty soldiers 
(s/soldier :quant 9   
               :subset-of (s3/soldier :quant 20))
```

---

# Possession

`:poss` (= `:possessor`) vs. `:poss-of` (`:possessor-of`) ... CHANGE of labels in UMR  

The Guidelines: 
> UMR uses :poss and :part relations with the possessum or part as the parent and the possessor or whole as the daughter, ...

!!! possessum as the parent and the possessor/owner as the daughter !!!  
```
(possessum                 
       :possessor (possessor))
```

**Summary:**
1. Use `:poss` (= `:possessor`) when talk about a thing that is possessed by someone (like in _Petrova kniha_)!!! 
2. Use `:poss-of` relation (= `:possessor-of`) when talk about an owner/possessor of something (like in _liščí majitel_, _majitel lišek_)) !!!
3. Use `have-poss-91` --> `have-91` when interpreted as predication, with `ARG1`=possessor and `ARG2`=possessum.
       
---

**`:poss` examples** (the Guidelines, English data):  
   - your stuff/ticket/dog   ... (stuff/ticket/dog :poss (person))  
   - aspects of the movement ... (aspect :poss (movement))  
   - our force			   ... (force :poss (person))  
   - from the country's companies ... (company :poss (country)) 
   (i.e., OK companies belonging to the country)  
   - his thing			...	(thing :poss (person))  
   - the kid’s hat		...	(hat :poss (kid))  
   - his (=Putin’s) special commission (commission :poss Putin)	  
   (i.e., commission belonging to Putin)
   - Russian torpedo			(torpedo :poss Russia))  

--> OK in the English data, OK in the Guidelines

**`:poss-of` examples:**  
Guidelines NO example  
English data just 1 example  
   - the goat man (= the man with goat) ... (man :possession-of (goat))  
ML: Based on context, I would interpret it as :mod (the attribute "goat" serves to identify the man (there are 2 men there)).

**`have-poss-91` examples:**  
NO example in the Guidelines nor in the English data.  
NO example and no mention in the UMR Guidelines.  
Just listed among UMR roles (as a reification of the poss relation; however, `have-91` also listed there as a reification of the poss relation) ... `have-poss-91` --> `have-91`?? (Ask Julia!!)


### Comparison to AMR 

OK, UMR and AMR relation `:poss` is the same.
(c / car
   :poss (h / he))
   


### TODO: Comparison to PDT
--- 
---
 
# Part-Whole relation

`:part` vs. `:part-of` 

The Guidelines: 
> UMR uses :poss and :part relations with the possessum or part as the parent and the possessor or whole as the daughter, ...

!!! part/fragment as the parent and the whole entity as the daughter !!!  
```
(part/fragment 
       :part (whole entity))
```

**Summary:**
1. Use `:part` when talk about a thing that belongs to some bigger entity (like in ...)
2. Use `:part-of` relation when talk about the whole entity (like in ...)
3. Use `have-part-91` when interpreted as predication, with `ARG1`=the whole entity and `ARG2`= its part/fragment
---

**`:part` examples** (the UMR Guidelines, the English released data):  

 - his blood/hand/string/car   ... (blood/hand/string/car :part (person)) ... from the UMR Guidelines
 - guitar's string ... (string :part (guitar) ... from the UMR Guidelines
 - blood pressure = pressure of his blood  ... (pressure-01 :ARG1 (blood :part person)) ... from the UMR Guidelines     
 - the government office (= the office is part of the government, the data)
                         ... (office :part (government))  
 
--> OK in the Guidelines, OK for some examples in the English data

**KO annotation** in the English data (2/5 plus 1 unclear):
 -  in the central Philippines ... (Philippines :part (center))
 -  like an apron with pockets (= thing [resembling apron] with pockets ) ... (thing :part (pocket))
Both should be annotated as `:part-of`!!

**`:part-of` examples:**  
UMR Guidelines NO example!!   
English data 4 examples, **all of them wrong** ... should be  (part :part whole)!!
  - in the south of Leyte ... (south :part-of (Leyte)	)	KO
  - at the top of the ladder ... (top :part-of (ladder))		KO
  - on the front ... (front :part-of (thing)) 	KO
  - to the side of the road ...	(side :part-of (road))		KO

**`have-part-91` examples:**  
UMR Guidelines NO example!!   
English data just 1 example:  
 -  And the movie had sound track.   (have-part-91
                                         :ARG1 (movie)         ... entity = whole
                                         :ARG2 (sound-track))  ... part
--> OK


### Comparison to AMR 

!!! UMR `:part` has and opposite direction compared to that in AMR, at least based on examples from the Guidelines!!! (in fact, UMR `:part` corresponds to AMR `:part-of`) !!!


UMR: (engine :part (car))                                                                                     
AMR: (engine :part-of (car))                                                                                 

<!-- :poss relation (generalized, rather belong to) ... possession as the parent and the possessor/owner as the daughter !!!
	his boat/team/house ... (boat/team/house :poss (he))
	Whose toy           ... (toy :poss (amr-unknown))
	the speed of sound  ... (speed :poss (sound))
    aircraft's velocity ... (velocity :poss (aircraft))

:part-of relation (part as the parent and the whole as the daughter)
	the engine of the car / the car’s engine   ... (engine :part-of (car))
    a unit of the company / the company’s unit ... (unit :part-of (company))
    the south of France / southern France      ... (south :part-of (France)) -->

### TODO: Comparison to PDT