## Latin annotated sample

(1)   _Haec ubi dixit, paululum conmoratus signa canere iubet atque instructos ordines in locum aequom deducit._ \
[en]   When he had thus spoken, he ordered, after a short delay, the signal for battle to be sounded, and led down his troops, in regular order, to the level ground. \
[lit.] When he said these things, having waited for a bit, he orders the battle standards to sing and moves the deployed ranks to a flat area.

```
(s1i/ iubeo-03
    :ACT (p/person
        :ref-person 3rd
        :ref-number Singular)
    :PAT (c/cano-12
            :ACT (p2/person
                    :ref-person 3rd
                    :ref-number Plural)
            :PAT (s/signum
                    :ref-number Plural)
            :aspect Activity
            :modstr PrtAff)                        
    :temporal (d/dico2-08
                :ACT p
                :PAT (h/hic
                        :ref-number Plural)
                :aspect Performance
                :modstr FullAff)    
    :temporal (c2/commoror-01
                :ACT p
                :duration (t/temporal-quantity
                            :quant (p3/paululum))
                :aspect Performance
                :modstr FullAff)
    :pure-addition (d2/deduco-11
                        :ACT p
                        :PAT (o/ordo
                                :PAT-of(i2/instruo-04
                                         :ACT p
                                         :aspect Performance
                                         :modstr FullAff)
                                :ref-number Plural)
                        :DIR3 (l/locus
                                :mod (a/aequus)
                                :ref-number Singular)
                        :aspect Performance
                        :modstr FullAff)
    :aspect Performance
    :modstr FullAff)
```

(2)  _Dein remotis omnium equis, quo militibus exaequato periculo animus amplior esset, ipse pedes exercitum pro loco atque copiis instruit._ \
[en] Having then sent away the horses of all the cavalry, in order to increase the men's courage by making their danger equal, he himself, on foot, drew up his troops suitably to their numbers and the nature of the ground.

```
(s2i/ instruo-04
        :ACT (p/person
                :ref-person 3rd
                :ref-number Singular)
        :PAT (e/exercitus
                :ref-number Singular)
        :manner? [CRIT] (e2/et
                            :op1 (l/locus
                                     :ref-number Singular)
                            :op2 (c/copia
                                    :ref-number Plural))        
        :COMPL? (h/have-role-91
                    :ACT (i2/ipse
                            :ref-person 3rd    
                            :ref-number Singular)
                    :WHAT? (p2/pedes
                                :ref-number Singular)
                    :aspect State
                    :modstr FullAff)                
        :temporal (r/removeo-04
                    :ACT p
                    :PAT (e3/equus
                            :poss (p3/person
                                    :ref-person 3rd
                                    :ref-number Plural
                                    :quant (o/omnis))
                            :ref-number Plural)
                    :purpose (h2/have-mod-91
                                :ACT (a/animus
                                        :ref-number Singular)
                                :PAT (a2/amplus
                                        :degree Intensifier?)
                                :manner (e4/exaequo-03
                                            :ACT p
                                            :PAT (p3/periculum
                                                    :ref-number Singular)
                                            :BEN (m/miles
                                                    :ref-number Plural)
                                            :aspect Performance
                                            :modstr FullAff)
                                :aspect State
                                :modstr FullAff)            
                    :aspect Performance
                    :modstr FullAff)
    :temporal(d/dein)    
    :aspect Performance
    :modstr FullAff)
```

(3) _Nam, uti planities erat inter sinistros montis et ab dextrā rupe asperă, octo cohortis in fronte constituit, reliquarum signa in subsidio artius conlocat._ \
[en] As a plain stretched between the mountains on the left, with a rugged rock on the right, he placed eight cohorts in front, and stationed the lest of his force, in close order, in the rear.

```
(s3c/ constituo-16
        :ACT (p/person
                :ref-person 3rd
                :ref-number Singular)
        :PAT (c2/cohors
                :ref-number Plural
                :quant 8)
        :location (f/frons
                    :ref-number Singular)
        :pure-addition(c3/conloco-11
                        :ACT p
                        :PAT (s/signum
                                :ref-number Plural
                        :poss (r/reliquus
                                :ref-number Plural))
                        :location (s2/subsidium
                                    :ref-number Singular)
                        :manner (a/artus
                                 :degree? Intensifier)
                        :aspect Performance
                        :modstr FullAff)
        :cause (h/have-location-91
                :ACT (p2/planities
                        :ref-number Singular)
                :LOC (m/mons
                        :ref-number Plural
                        :mod(s3/sinister))
                :pure-addition (h2/have-mod-91
                                :ACT p2
                                :property (a/asper)
                                :cause(r2/rupes
                                        :ref-number Singular)
                                :location(d/dextra)
                                :aspect State
                                :modstr FullAff)
                :aspect State
                :modstr FullAff)
    :aspect Performance
    :modstr FullAff)
```
[...]

(5) _C. Manlium in dextrā, Faesulanum quendam in sinistrā parte curare iubet._ \
[en] He ordered Caius Manlius to take the command on the right, and a certain officer of Fæsulæ on the left.

```
(s5i/ iubeo-03
    :ACT (p/person
            :ref-number Singular
            :ref-person 3rd)
    :PAT (c/curo-14
            :ACT (p2/person
                    :name (n/name :op1 "Caius" :op2 "Manlius"))
            :PAT? (something?)
            :location (p3/pars
                         :mod (d/dexter))
            :aspect Activity
            :modstr PrtAff)
            :pure-addition(c2/curo-14
                            :ACT(p4/person
                                    :mod (c3/city
                                            :wiki "Q82670"
                                            :name "Faesulae"
                                    :mod (q/quidam))
                            :PAT? (something?)
                            :location (p5/pars
                                         :mod (s/sinister))
                            :aspect Activity
                            :modstr PrtAff))
    :aspect Performance
    :modstr FullAff)
```
