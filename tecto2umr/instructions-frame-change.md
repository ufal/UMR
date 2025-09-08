## Transforming PDT-like frames onto PropBank-like frames: How to describe necessary changes


For Czech, necessary changes are described in the [pdt_pb_mapping table](https://docs.google.com/spreadsheets/d/1lVo7a8hPBReI4VrgNkUGem8uC_sCQCXJJvLFCbwPuok/edit?gid=1270330829#gid=1270330829), column E, Correction (please leave your initials and comments in row F).

**For Latin ???**


### T_lemma row

#### Change of t_lemma 

Typically, the **UMR concept is the same as the original t_lemma** -- in such case, either leave the corresponding cell in column E empty or repeat the t_lemma there (no change will be applied). 

Alternatively, **insert proper UMR concept there** to the corresponding cell in column E, the original t_lemma will be substituted with this UMR concept.
 
- a **simple change of the t_lemma**   
  examples:   
  - `být-002 -->  být-002` (i.e., no change)  
  - `být-001 --> have-mod-91` (UMR "non-prototypical pred" will be used)  
  - `být-006 --> have-age-91` (UMR reification)  
  - `být-007 --> copula-91` (NEW UMR concept for "non-prototypical pred")   
  - `být-019 --> litovat-001` (the original t_lemma is substituted by the content verb)

- the **concept depends on the verb's echild node**: The particular node is indicated by its functor.   
The UMR concept typically combines the original t_lemma and the t_lemma of the indicated node (then, the echild node is deleted, as described below).   
  examples:  
  - `být-018 --> být-CPHR-018`  (in the given sentence, find the CPHR echild of the verb and insert its t_lemma between the verb itself and its number id:   
    `být-018` in _Je hanba, že …_  `--> být-hanba-018`;   
    `být-018` in _… a je mi to jedno_ `--> být-jedno-018`  
  - `být-012 --> být-ACT-012`:  
    `být-012` in _Je vidět.ACT (Sněžku.PAT)._ (= _Sněžka může být viděna (někým)_) `--> být-vidět-012`  
        (PLUS add modality AND indicate _Sněžka_ as `ARG1` of `být-vidět-012`, see below)

- the **concept depends on the echild node of the verb** (as above) **AND its t_lemma satisfies some condition(s)**    
   example:  
   - `být-CPHR-020:`  
     `if(CPHR:třeba,potřeba,zapotřebí)(potřebovat-001)` gives `--> potřebovat-001`  
     `if(CPHR:škoda)(litovat-001)` gives `--> litovat-001`  
     `else(být-CPHR-020)` gives  `--> být-???-020`  (depending on CPHR in individual sentences) 


- the **verb concept itself should be deleted** -- than, use the `!delete` instruction PLUS **indicate the root of the subtree**, which will   
(i) inherit the functor of the original verb and   
(ii) serve as the parent of all the echildren of the deleted verb  
   example:
  - for `být-021` (as in _Je nutné.CPHR odejít.ACT;Je možné.CPHR, že to dopadne.ACT jinak.)_:  
     `if(CPHR:možný,nutný)(!delete,ACT)` indicates that `být-021` is deleted;   
     instead, the `ACT` node (for activity) is promoted as the root of the subtree and gets the respective modal value (modal-strength attribute, value neutral-affirmative and partial-affirmative, respectively) 
  - for `být-159` (as in _Je možné.PAT odejít.ACT Je nutné.PAT odejít.ACT;Je možné.PAT, že to dopadne.ACT jinak._, should be with control (BEN)):  
     `if(PAT:možný,nutný)(!delete,ACT)`, the same as above.  



#### Adding an attribute

If it is necessary to **add or change an attribute of the processed verb**, please indicate this change AFTER the UMR concept in the same cell.

examples:
  - `být-013 --> exist-91 !polarity(-)`  
    (for `být-013`, exemplified e.g. with _Když bylo po válce, ..._ (= _válka (už) nebyla_) or _A bylo po srandě_ (= _sranda (už) nebyla_): the verb is changed to `exist-91` AND the polarity attribute is set to `-`)  
  -	`být-081 !modal-strength(neutral-affirmative)`  
    (for `být-081`, exemplified e.g. with _Je na Světové bance, aby se přizpůsobila._ (= _Světová banka by měla ..._): the verb remains `být-081` but the modal-strength attribute is changed) 
  

In addition, the change of the attribute can be marked for a specified echild of the verb as well (as in the case of modality)  
  example:  
  - for `být-021`, the `ACT` row (`ACT` functor specifies an activity with this verb) indicates:  
   `if(CPHR:možný)(!modal-strength(neutral-affirmative))`  
   `if(CPHR:nutný)(!modal-strength(partial-affirmative))`


---

### Rows with functors

Typically, each **functor is simply translated onto the UMR role** (argument or non-argument) that is specified in the respective cell (column E) :

examples:
   - for `být-001 --> have-mod-91`:   
     `ACT --> ARG1`   
     `PAT  --> ARG2`  
     `ORIG --> causer` 

However, in some cases -- esp. with frames for light verb constructions (`CPHR` functor) and other multiword expressions (`DPHR` functor) -- **the specified functor should be combined/merged with the t_lemma** of the frame-evoking verb. This is indicated in the relevant cell (column E) by the `!delete` instruction.   
  example:
  - for `být-019 --> litovat-001`, the `CPHR` t_lemma _líto_ becomes part of the predicate and so its node is deleted    

Further, it must be specified **what to do with echildren of the deleted node**. Unless specified differently: 
- Nodes corefering with nodes of the frame-evoking verb are merged so these cases are solved automatically (just 1 node with the same functor as for the verbal argument/adjunct).   
   example:
   - `mít-028 --> mít-tušení-028`, as in  
    _[já].ACT mám [moje.ACT] tušení.CPHR, (že ...).PAT_   
    The coreferring #PersPron nodes are merged and remains just as verbal `ACT` (which is translated onto `ARG0`). 
- Try to specify nodes originally annotated as dependent on the `CPHR` node that should serve as arguments of the new concept: typically `PAT` modifying the `CPHR` node:  
   example:
   - ` mít-021 --> mít-CPHR-021` (as in `mít-příležitost-021`),  
   as in _Teprve nyní však [my].ACT-->ARG0 **máme příležitost**.CPHR sledovat.PAT-->ARG1 různé jemnosti, …_  
  (`if()()` instruction can be used for specification of functor, sempos etc., see below) 

- Other `CPHR`/`DPHR` echildren are (unless specified differently) transferred using the default functors mapping. In case of actants, `!error` will be reported.

- In case of deleting the original predicate (as in the case of the modality, `být-021` and `být-159`), the node that will serve as the new root gets the `!root` instruction in the functor row.

---

#### Syntactic rules

#### `!` ... introduce an action for the given row (t_lemma or functor)
examples:
  -	`!delete` ... delete the node for the given functor and hang its echildren on the frame-evoking verb  
     (if used in a t_lemma row (as in the case of modality, `být-021` and `být-159`), a new root must be indicated within the children of the deleted verb, e.g., `!delete,ACT`)
  -	`!polarity(-)` ... add the polarity attribute with the `-` value for the given concpet  
      (may be used both in t_lemma and functor rows)
  -	`!modal-strength(partial-affirmative)` ... set the modal-strength attribute value to `partial-affirmative`  
  (may be used both in t_lemma and functor rows)
  -	`!error` ... report an error  
      (may be used both in t_lemma and functor rows)
  -	`!root` (in the functor row) ... indicates the functor that will serve as a new root (as in the case of modality, `být-021` and `být-159`).


#### `$` ... introduce an abbreviation for a (complex) condition (esp. on sempos)
examples:  
  -	`$actant` ... stands actants (i.e. `functor:X`, with `X~'ACT|PAT|ADDR|ORIG|EFF'`)
  -	`$noun` ... stands for nominals (i.e.,  `gram/sempos:X`, with `X~'^n.*'`)
  -	`$noun,verb` ... stands for nominals and verbs (i.e., `gram/sempos:X`, with `X~'(^n.*|v)'`)
  - `$noun-not-adj` ... identifies nominals and excludes adjectives (i.e.,  `gram/sempos:X`, with  `X~'^n.*' & X!~'adj.*'`)	 


#### if()() else()  ... conditional instruction
- the first bracket contains the condition in the form `attribute:value`   
  more conditions are separated by comma  
  example:
  - `(functor:PAT),($not-adj)` ... indicates a node with the `PAT` functor that is NOT an adjective (gram/sempos) 

- the second bracket contains the instruction what to do; if not specified, the instruction is performed on the first attribute mentioned in the condition:   
  example:
  - `if(functor:RSTR,$not-adj)(ARG1)` ... a node with the `RSTR` functor that  is NOT an adjective gets the `ARG1` role ... **??? What about if more nodes meet the condition ???**

- `else` introduces instruction that is applied if the condition is not met (optional)  

 ```
CPHR !delete if(functor:ACT)(ARG1)  
              else (if(functor:RSTR,$n-not-adj)(ARG1))  
```

- more `if` instructions can be cumulated -- then, they are processed in a "procedural" way, as fdescribed by the following example:  
 
 ```
CPHR !delete if(functor:ACT)(ARG1)  
              else if(functor:RSTR,$n-not-adj)(ARG1)  
              if(functor:RSTR)(manner)  
              if($actant)(!error)  
```
When the first `if` instruction is applied, the `ARG1` is detected when `ACT` or nominal `RSTR` is found among `CPHR` children; then, any other potential  `RSTR` relation is translated to the `manner` relation.


