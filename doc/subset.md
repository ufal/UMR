## Subset/superset relation (incl. a portion indicated as a percentage)

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

(Note: This predicate is understood as a reification of the `:subset` relation. In fact, this relation is only a ``shortcut'' as it should be ``automatically '' reifies to the predicate by the AMR Editor.)



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


