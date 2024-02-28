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
3. Use `have-poss-91` when interpreted as predication, with `ARG1`=possessor and `ARG2`=possessum.
       
**??? is it the same predicate as :have-91 ???**

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
NO example in the Guidelines nor in the English data

**Summary:**
1. Use `:poss` (= `:possessor`) when talk about a thing that is possessed by someone (like in _Petrova kniha_)!!! 
2. Use `:poss-of` relation (= `:possessor-of`) when talk about an owner/possessor of something (like in _liščí majitel_, _majitel lišek_)) !!!
3. Use `have-poss-91` when interpreted as predication, with `ARG1`=possessor and `ARG2`=possessum.
       
**??? is it the same predicate as :have-91 ???**


### Comparison to PDT

### Comparison to AMR 

OK, UMR and AMR relation `:poss` is the same.
(c / car
   :poss (h / he))
   
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
2. Use `:poss-of` relation when talk about the whole entity (like in ...)
3. Use `have-poss-91` when interpreted as predication, with `ARG1`=the whole entity and `ARG2`= its part/fragment

See ale `:group`, `:group-of`, `:have-group-91`
       
*
---

**`:part` examples** (the Guidelines, English data):  

**`:part-of` examples:**  

**`have-part-91` examples:**  


### Comparison to PDT

### Comparison to AMR 

!!! UMR `:part` has and opposite than that in AMR, at least based on examples from the Guidelines!!! (in fact, UMR `:part` corresponds to AMR `:part-of`) !!!


UMR: (engine :part (car))                                                                                     
AMR: (engine :part-of (car))                                                                                     