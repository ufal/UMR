## Transforming PDT-like frames onto PropBank-like frames: How to describe necessary changes


For Czech, necessary changes are described in the [pdt_pb_mapping table](https://docs.google.com/spreadsheets/d/1lVo7a8hPBReI4VrgNkUGem8uC_sCQCXJJvLFCbwPuok/edit?gid=1270330829#gid=1270330829), column E, Correction (please leave your initials and comments in row F).

For Latin ???


### T_lemma row

#### Change of t_lemma 

The **UMR concept is the same as the original t_lemma** -- in such case, either leave the corresponding cell in column E empty or repeat the t_lemma there (no change will be applied). 

Alternatively, **insert the appropriate UMR concept there** to the corresponding cell in column E, the original t_lemma will be substituted with this UMR concept.
 
- **simple change of t_lemma**   
  examples:   
  - `být-002 -->  být-002` (i.e., no change)  
  - `být-001 --> have-mod-91` (UMR "non-prototypical pred" will be used)  
  - `být-006 --> have-age-91` (UMR reification)  
  - `být-007 --> copula-91` (NEW UMR concept for "non-prototypical pred")   
  - `být-019 --> litovat-001` (the original t_lemma is substituted by the content verb)

- **the concept depends on the echild node of the verb** that is indicated by the functor (more precisely, on its t_lemma)  
  examples:  
  - `být-018 --> být-CPHR-018`  (in the given sentence, find the CPHR echild of the verb and insert its t_lemma between the verb itself and its number id:   
    `být-018` in _Je hanba, že …_  `--> být-hanba-018`;   
    `být-018` in _… a je mi to jedno_ `--> být-jedno-018`  
  - `být-012 --> být-ACT-012`:  
   `být-012` in _Je vidět.ACT (Sněžku.PAT)._ (= _Sněžka může být viděna (někým)_) `-->být-vidět-012`  
        (PLUS add modality AND indicate _Sněžka_ as `ARG1` of `být-vidět-012`, see below)

- **the concept depends on the echild node of the verb** (as above) **AND its t_lemma satisfies some condition(s)**    
   example:  
   - `být-CPHR-020:`  
     `if(CPHR:třeba,potřeba,zapotřebí)(potřebovat-001)` gives `--> potřebovat-001`  
     `if(CPHR:škoda)(litovat-001)` gives `--> litovat-001`  
     `else(být-CPHR-020)` gives  `--> být-???-020`  (depending on CPHR in individual sentences) 


- **the verb concept itself should be deleted** --- than, mark the `!delete` action PLUS indicate the root of the subtree which inherits the functor of the original verb  
   example:
  - for `být-021` (as in _Je nutné.CPHR odejít.ACT;Je možné.CPHR, že to dopadne.ACT jinak.)_:  
     `if(CPHR:možný,nutný)(!delete,ACT)` indicates that `být-021` is deleted;   
     instead, the `ACT` node (for activity) is promoted as the root of the subtree and gets the respective modal value (modal-strength attribute, value neutral-affirmative and partial-affirmative, respectively) 
  - for `být-159` (as in _Je možné.PAT odejít.ACT Je nutné.PAT odejít.ACT;Je možné.PAT, že to dopadne.ACT jinak._, should be with control (BEN)):  
     `if(PAT:možný,nutný)(!delete,ACT)`, the same as above.

#### Adding an attribute

If it is necessary to add/change an attribute of the verb under processing, please indicate this change AFTER the UMR concept in the same cell.

example:
  - `být-013 --> exist-91 !polarity(-)`  
    (for `být-013`, exemplified e.g. with _Když bylo po válce, ..._ (= _válka (už) nebyla_) or _A bylo po srandě_ (= _sranda (už) nebyla_): the verb is changed to `exist-91` AND the polarity attribute is set to `-`)  
  -	`být-081 !modal-strengt(neutral-affirmative)`  
    (for `být-081`, exemplified e.g. with _Je na Světové bance, aby se přizpůsobila._ (= _Světová banka by měla ..._): the verb remains `být-081` but the modal-strength attribute is changed) 
  

In addition, the change of the attribute can be marked for an echild of the verb as well (as in the case of modality  
  example:  
  - for `být-021`, the `ACT` row (for activity) gets:  
   `if(CPHR:možný)(!modal-strength(neutral-affirmative))`  
   `if(CPHR:nutný)(!modal-strength(partial-affirmative))`


---

### Rows with functors

Typically, each **functor is simply translated onto the UMR role** (argument or non-argument).

 


#### xxxx

#### xxxx

---

### Syntactic rules

#### xxxx

#### xxxx