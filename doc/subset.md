## Subset/superset relation (incl. a portion indicated as a percentage)

#### AMR: `:subset` and `subset-of` relations

The relation `subset` links the **whole** (represented as the head) and its **part** (child node). 

This means (as usual in UMR): the name of the relation should be read from the child's perspective = **the child is the subset !!!**

```
Four survivors had the disease, including three who were diagnosed.
(h / have-03
    :ARG0 (p4 / person
               :quant 4
               :ARG0-of (s / survive-01)
               :subset (p3 / person
                             :quant 3
                             :ARG1-of (d3 / diagnose-01)))
 :ARG1 (d / disease))
```

Features shared by a subset and its superset go into the superset only, e.g.,
“survive” above.

In the inverse relation `subset-of`,  a **part serves as the parent node** to which the **whole is attached as a child**.

```
Nine of the twenty soldiers died.
(d / die-01
    :ARG1 (s / soldier
               :quant 9
               :subset-of (s3 / soldier
               :quant 20)))
```

These relations are understood as "shortcuts" as they should e "automatically'' reified to the `include-91` predicate.

#### AMR:  `include-91` predicate/roleset

For indicating a subset relation,  AMR uses the `include-91` abstract predicate:   

- [en] _Nine of the twenty soldiers died._
  
  ```
  (d / die-01
   :ARG1 (s / soldier
            :quant 9
            :ARG1-of (i / include-91
                        :ARG2 (s3 / soldier
                                  :quant 20))))
  ```

The `include-91` predicate has three arguments:

- ARG1 for the subset

- ARG2 for the whole set

- ARG3 for the relative size of subset compared to superset (i.e., percentage), as is illustrated in the following sentence (from the [AMR Dictionary](https://amr.isi.edu/doc/amr-dict.html)):

- [en] _10% of smokers die of lung cancer._
  
  ```
  (i / include-91 
     :ARG1 (p / person 
          :ARG1-of (d / die-01 
               :ARG1-of (c2 / cause-01 
                    :ARG0 (d2 / disease 
                         :wiki "Lung_cancer" 
                         :name (n / name 
                              :op1 "lung" 
                              :op2 "cancer"))))) 
     :ARG2 (p2 / person 
          :ARG0-of (s2 / smoke-02)) 
     :ARG3 (p3 / percentage-entity 
          :value 10))
  ```

AMR exemplifies this relation on the following sentences: 

- _He sold two of his ten horses._  
- _26 of the 44 countries in Europe are members of NATO._
- _Canada is one of the largest countries in the world._ 
- _Thomas is one of the few boys in Kentucky who speak Latin._ ... with 2 instances of `include-91` 
  - (include-91 :ARG1 Thomas :ARG2 Latin speakers) ... i.e., _Thomas belongs to Latin speakers_
  - (include-91 :ARG1 Latin speakers :ARG2 boys in Kentucky :ARG3 few) ... i.e., _There are (only) few Latin speakers among boys in Kentucky_, with _few_ identified as :ARG3

#### UMR: `:subset-of` relation

The `subset-of` relation is used only at the document level annotation, with a subset as the head and the whole set as a child - i.e., it works in the same way as the `:subset-of` relation at the sentence level.    

#### UMR: `include-91` predicate/roleset

UMR does not explicitly comment on the use of the `include-91` predicate, the Guidelines present only 1 example -- with confused ARGs (at least as I understand it, ML) 

- [en] _... and one of the pears ..._
  
  ```
  (p / pear
     :quant 1
     :ARG2-of (2 / include-91
                   :ARG1 (p2 / pear
                               :refer-number plural)))
  ```

As for percentage example, the UMR Guidelines present just a simple fragment:

- [en] _30 percent_ =/= _30 percent (of the whole set)_
  
  ```
  (p / percentage-entity :value 30)
  ```
  
  Note that _30 percent_ is not understood as an ellipsis, i.e., it is not completed to something like _30 percent of xxx_!
