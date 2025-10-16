## Transforming PDT-like frames onto PropBank-like frames: How to describe necessary changes


For Czech, necessary changes are described in the [pdt_pb_mapping table](https://docs.google.com/spreadsheets/d/1lVo7a8hPBReI4VrgNkUGem8uC_sCQCXJJvLFCbwPuok/edit?gid=1270330829#gid=1270330829), column E, Correction (please leave your initials and comments in row F).

For Latin, changes are described directly in the [Vallex4UMR](https://raw.githubusercontent.com/fjambe/Vallex4UMR/refs/heads/main/Vallex4UMR.txt) text file.


### I. T_lemma row

#### Change of t_lemma 

Typically, the **UMR concept is the same as the original t_lemma** of the frame-evoking verb -- in such case, either leave the corresponding cell (column E for the Czech data) empty or repeat the t_lemma there (no change will be applied). 

Alternatively, **insert proper UMR concept there** to the corresponding cell (column E for the Czech data), the original t_lemma will be substituted with this UMR concept.
 
##### 1. A simple change of the t_lemma:   

  Examples:
  - `být-002 -->  být-002` ... i.e., no change  
  - `být-001 --> have-mod-91` ... UMR "non-prototypical pred" will be used  
  - `být-006 --> have-age-91` ... UMR reification  
  - `být-007 --> copula-91` ... NEW UMR concept for "non-prototypical pred"   
  - `být-019 --> litovat-001` ... the original t_lemma is substituted by the content verb


##### 2. A combination of the t_lemmas of the verb and its echild

The  concept arises as a combination of the t_lemmas of the frame-evoking verb  and its echild. Then, the particular echild node is indicated by its functor. 
In such cases, the echild node is deleted (as described below) and its echildren must be properly processed (see the section on structural changes below). 
  
  For simplicity, the convention concerning a node identification as not applied here (we do not explicitly specify that the node with the CPHR functor is the echild of the verb-evoking verb (and NOT the processed verb node)).      
 
  Examples:  
   - `být-018 --> být-CPHR-018`  (in the given sentence, find the CPHR echild of the verb and insert its t_lemma between the verb itself and its number id;   
       `být-018` (in _Je hanba, že …_ ) `--> být-hanba-018`;   
       `být-018` (in _… a je mi to jedno_) `--> být-jedno-018`)  
  - `být-144 --> mít-ACT-040`:  
    `být-144` (in _Naše štěstí.ACT bylo (v tom, že ...).PAT_ (= _My máme štěstí(, že ..._)) `--> mít-štěstí-040`. 
  
  The concept arising as a combination of the verb and its echild may vary, **typically depending on the t_lemma of the latter node**.    

  Example:
   - `být-CPHR-020:`  
     `if(echild.CPHR:třeba,potřeba,zapotřebí)(potřebovat-001)` gives `--> potřebovat-001`  
     `else if(echild.CPHR:škoda)(litovat-001)` gives `--> litovat-001`  
     `else (být-CPHR-020)` gives  `--> být-???-020`  (depending on the t_lemma of the `CPHR` node in individual sentences) 


##### 3. Deletion of the verb node
 
When the verb concept itself should be deleted, use the `!delete`.  
In such case, **a new root of the subtree must be indicated** - this node will  (i) inherit the functor of the original verb and  (ii) become (by default) the parent node for all echildren of the deleted verb (see section on structural changes below).  
 
   Example:
  - for `být-021` (as in _Je nutné.CPHR odejít.ACT;Je možné.CPHR, že to dopadne.ACT jinak.)_, the verb row contains:  
     `if(echild.functor:CPHR,t_lemma:možný,nutný)(!delete,ACT)` ... this indicates that `být-021` is deleted; instead, the `ACT` node (for activity) is promoted as the root of the subtree and gets the respective modal value (modal-strength attribute, value neutral-affirmative and partial-affirmative, respectively) 
  - for `být-159` (as in _Je možné.PAT odejít.ACT Je nutné.PAT odejít.ACT;Je možné.PAT, že to dopadne.ACT jinak._, should be with control (BEN)):  
     `if(echild.functor:PAT,t_lemma:možný,nutný)(!delete,ACT)`, the same as above.  



#### Adding an attribute - a verb row

If it is necessary to **add or change an attribute of the processed verb**, please indicate this change AFTER the UMR concept in the same cell.

Examples:
  - `být-013 --> exist-91, !polarity(-)`  
    (for `být-013`, exemplified e.g. with _Když bylo po válce, ..._ (= _válka (už) nebyla_) or _A bylo po srandě_ (= _sranda (už) nebyla_): the verb is changed to `exist-91` AND the polarity attribute is set to `-`)  
  -	`být-081, !modal-strength(neutral-affirmative)`  
    (for `být-081`, exemplified e.g. with _Je na Světové bance, aby se přizpůsobila._ (= _Světová banka by měla ..._): the verb remains `být-081` but the modal-strength attribute is changed) 
  
  

 
---

### II. Rows with functors


Typically, each **functor is simply translated onto the UMR role** (argument or non-argument) that is specified in the respective cell (column E for Czech):  

  Examples:
   - for `být-001 --> have-mod-91`:   
     `ACT --> ARG1`   
     `PAT  --> ARG2`  
     `ORIG --> causer` 


However, in some cases -- esp. with frames for light verb constructions (`CPHR` functor) and other multiword expressions (`DPHR` functor), see section 2 above -- **the specified functor should be combined/merged with the t_lemma** of the frame-evoking verb. This is indicated in the relevant cell (column E for Czech) by the `!delete` instruction.   
 
 Example: 
   - for `být-019 --> litovat-001`  
      the `CPHR` t_lemma _líto_ becomes part of the predicate and so its node is deleted    
  

#### Merging 2 nodes: what to do with echildren of the deleted node 

In case of deleting the original predicate (as in the case of the modality, `být-021` and `být-159`), **the node that will serve as the new root** gets the `!root` instruction in the functor row.

Unless specified differently, the following rules are applied: 

##### (i) Nodes coreferring with nodes of the frame-evoking verb

These nodes are merged (just 1 node), the functor is by default inherited from the verb. 

 
 Example:
   - `mít-028 --> mít-tušení-028`, as in  
    _[já].ACT mám [moje.ACT] tušení.CPHR, (že ...).PAT_   
    The coreferring #PersPron nodes are merged; as they have the same functor (`ACT`), no problem arises (`ACT` is translated onto `ARG0`).   
    
   - `mít-055` --> `mít-využití-055`, as in  
   - _Program.v-ACT má.PRED využití.v-CPHR (při léčbě).n-COND_ (with #Gen.n-ACT #Cor.n-PAT --> program)  
     _Program.ARG1 má-využití.PRED (při léčbě).n-COND_ (n-PAT corefers with v-ACT, thus it is translated as ARG1)

##### (ii) General actants (#Gen, #Unsp) are deleted

##### (iii) Other actants / frame elements that should be translated as ARGs

Some nodes originally annotated as dependent on the deleted node (typically `CPHR` or `DPHR` node)  should **serve as arguments of the new concept** - it is typically `PAT` modifying the `CPHR` node -- see below how to specify such node (typically using the `if()()` instruction).
 
   Example:
   - ` mít-021 --> mít-CPHR-021` (as in `mít-příležitost-021`),  
   as in _Teprve nyní však [my].ACT-->ARG0 **máme příležitost**.CPHR sledovat.PAT-->ARG1 různé jemnosti, …_  

##### (iv) Whenever two nodes are combined/merged, check that all actants are properly processed 
That is: the given rule must treat all actants of both nodes. The only exception concerns actants with t_lemma `#Gen` and `#Unsp` (or obligatory free modifications with  `#Oblfm`) -- these are deleted (just in the case of merging nodes). 
 
Otherwise, `!error` should be reported.

##### (v) Default processing

Other echildren of the deleted node (typically `CPHR` or `DPHR`) are (unless specified differently) 
- hanged on the frame-evoking verb 
- their functors translated **using the default functors mapping**.   
In case of actants, `!error` should be reported.

#### Adding an attribute - a functor row

If it is necessary to add or change an attribute of a verb's descendant node, the change is indicated in the respective row. By default, it is applied to the processed node (if the node has its own functor row in the table). Alternatively,  the particular node must be properly identified (using echild/esibling) notation.   

  Example:
  - for `být-021` (modality, with `ACT` denoting activity),  
  as in _Je možné.CPHR odejít.ACT_; _Je nutné.CPHR (, aby přišli).ACT_:
     - the `ACT` row  indicates:  
      `if(esibling.functor:CPHR,t_lemma:možný)(!modal-strength(neutral-affirmative))` ... i.e., the node for _odejít.ACT_ gets `neutral-affirmative` modality 
      `if(esibling.functor:CPHR,t_lemma:nutný)(!modal-strength(partial-affirmative))` ... i.e., the node for _přijít.ACT_ gets `partial-affirmative` modality  
  - for `mít-028` (as in _měli možnost.CPHR (pozorovat spoluhráče),PAT_, _všichni členové.ACT měli povinnost.CPHR se dostavit.RSTR_);  
  here, an activity (which should bear the modal attribute) is represented as `PAT` or `RSTR` hanging on the `CPHR` node:    
      - the `CPHR` row indicates:  
       `if(t_lemma:možnost,echild.functor:PAT)(echild.functor:PAT,!modal-strength(neutral-affirmative)),`  
       `if(t_lemma:povinnost,(echild.functor:RSTR,$n.denot-v))(echild.functor:RSTR,!modal-strength(partial-affirmative))`  

---

### III. Syntactic rules

#### Node identification

**A.** By default, **a condition/instruction is applied to the processed node** (i.e., the node in column B for the Czech data). This means:
  -  a row with a verb lemma describes what to do with this verb node   
     (e.g., change its t_lemma, add an echild node (with some given properties), set an attribute, delete it (and specify the new root), etc.)
  -  a row with a functor describes what to do with this node  
     (e.g., change the functor to an UMR argument, add an echild node (with some given properties), find an echild node with some given properties and do something with this node, set an attribute, delete it (and specify what to do with its echildren)

**B.** Otherwise, **specify to which node a condition/instruction should be applied** - so far, we have identified only cases when the affected node is either an echild of the processed verb OR echild of its frame member (which has its own row in the table):  

Example:  
 - `if(t_lemma:třeba)` ... the condition is applied to the processed node and checks its t_lemma
 - `if(t_lemma:třeba,potřeba)` ... a list of values may be here
 - `if(functor:CPHR,t_lemma:třeba,potřeba)` ... conditions on more attributes can be here as well, see below
 - `if(echild.functor:RSTR)` ... the condition is applied to an echild of the processed node and checks its functor
 
**C. Negative condition:** One might need specify that NONE of a node's echildren meet some condition - in such case, `no-echild` abbreviation should be used.  

Example:  
- `if(no-echild.functor:BEN)` ... the condition is applied when a given node has NO echild with BEN functor

#### Attribute identification

By default, **an attribute in a condition/instruction is the same one as the one specified by the row** (column B for Czech), i.e.:
- for rows with t_lemmata, the default attribute is t_lemma
- for rows with functors, the default attribute is functor

**Otherwise, you must specify the relevant attribute** explicitly in a condition/instruction.   
(Feel free to specify a default attribute as well it if you want to be more explicit :-)

#### Node/Attribute identification for multiple conditions/instructions

In the case of combined conditions/instructions of the type `if(cond1,cond2)(instr1,instr2)`
- if both conditions/instructions affect the same node/attribute, it is enough to specify the node/attribute just with the first condition/instruction 
- instructions are by default applied to the node and attribute defined in the first condition.  

    Example:
    - `if(echild.functor:RSTR,REG,$n-not-adj)(ARG1)`... both conditions are applied to the echild of the processed node; if they are satisfied, its `RSTR` and/or `REG` functor is changed to `ARG1` 


#### `!` ... introduce an action for the given row (t_lemma or functor)  

##### !delete

- `!delete` (in a functor row) ... delete the processed node and hang its echildren on the frame-evoking verb (unless specified differently)   


- `!delete,X` (in a t_lemma row) ... delete the verb node; a new root (identified by its functor `X`) must be indicated among the children of the deleted verb, e.g., `!delete,ACT`   
    (as in the case of modality, `být-021` and `být-159`)  

- deleting a node with a functor that is not in the frame (so there is no row for it) ... this would be specified in the row of the functor that governs the echild (=eparent of the node that should be deleted).  
Example: 
   - `if(echild.functor:MANN)(!delete)` ... if a MANN node is found among echildren of the processed node, it is deleted.  


##### !root 

-	`!root` (in the functor row) ... indicates the functor that will serve as a new root (as in the case of modality, `být-021` and `být-159`).   

##### !move

- `!move(node2 = new parent,relation)` (in the functor row) ... indicates that the processed node (given by the row) should be moved to become an echild of `node2` (the first parameter) using the relation `relation` (the second parameter)   

- `!move(node which should be moved, new parent, relation)` ...  if the moving node is different than the one indicated by the row, add an optional first argument indicating the moving node!!   

Example:  
  - `!move(echild:PAT, esibling:ACT, possessor)` ... find the PAT echild of the processed node, find the ACT esibling node of the processed node and hang the former (`PAT`) to the latter (`ACT`) using the possessor relation (meaning, the `PAT` node represents a possesor of the `ACT` node)  

##### !add

- `!add(echild.t_lemma(person),functor(mod))` ... add an echild to the processed node, with the specified attributes  
    (can be used both in a t_lemma and a functor row)  

##### !polarity

 -	`!polarity(-)` ... add the polarity attribute with the `-` value to the processed node  
 (can be used both in a t_lemma and a functor row)  

##### !modal-strength

-`!modal-strength(partial-affirmative)` ... set the given modal-strength attribute value to the processed node (by default); 

-`!modal-strength(echild.functor:PAT, neutral-affirmative)` ... if the instruction should apply to a different node, the node must be specified as an optional first argument (in this case,  the attribute is set to the echild of the processed node with `PAT` functor)  
(can be used both in a t_lemma and a functor row)  

##### !ok and !error

-	`!ok` ... nothing to do  
    (esp. `if(cond)(instr) else !ok` ... when no activity is required when the condition is not satisfied; can be used both in a t_lemma and a functor row)
 - `!error` ... report an error  
      (can be used both in a t_lemma and a functor row)



#### `$` ... introduce an abbreviation for a (complex) condition (esp. on sempos)  

Examples:
  -	`$actant` ... stands for actants (i.e. `functor:X`, with `X~'ACT|PAT|ADDR|ORIG|EFF'`)
  - `$any-functor` ... stands for any functor
  -	`$noun` ... stands for nominals (i.e.,  `gram/sempos:X`, with `X~'^n.*'`)
  -	`$noun,verb` ... stands for nominals and verbs (i.e., `gram/sempos:X`, with `X~'(^n.*|v)'`)
  -	`$n.denot-v` ... stands for nominals with sempos starting with n.denot and verbs
  - `$noun-not-adj` ... identifies nominals and excludes adjectives (i.e.,  `gram/sempos:X`, with  `X~'^n.*' & X!~'adj.*'`)	 
  - `$form:s+7` ... indicates nodes with the given form at the analytical layer 

#### negation

  -	`no-child.functor:BEN` ... check the functor of all echildren - the condition is met if NO echild with BEN functor is found 
 

#### `if()() else ` ... conditional instruction
- **the first bracket** contains the condition in the form `attribute:value`;   
   - by default, the condition is applied to the node specified by the particular row (i.e., to the verb or to the particular functor, column B for Czech);   
   - another node may be specified (esp. echild of the processed verb);  
   - more conditions are separated by comma; they can be applied either to a single node or several nodes may be specified (see the last example).

  Example:
  - `if (echild.functor:PAT,$not-adj)(...) else ...` the condition indicates an echild of the processed node with the `PAT` functor that is NOT an adjective (gram/sempos, as indicated by the abbreviation) 
  - `if(t_lemma:možnost,echild.functor:PAT)(...) else ...` the condition specifies the t_lemma of the processed node and checks whether it has an echild with `PAT` functor hanging on it
  -  `if(t_lemma:možnost,echild.functor:RSTR,$n.denot-v)(...) else ...` the condition specifies **the t_lemma of the processed node** and checks whether it has an **echild with `RSTR` functor and the prescribed sempos** hanging on it (i.e., all conditions following the node identification apply to this node, here both `RSTR` and `$n.denot-v` to an echild of the processed node).


- **the second bracket** contains the instruction what to do;   
   - if not specified differently, the instruction is performed on the node and attribute defined by the row (t_lemma for a verb row, functor for a functor row);  
   - another node may be specified (esp. echild of the processed node);  
   - more instructions are separated by comma.  

  Example:
  - `if(echild.functor:RSTR,$not-adj)(ARG1) else ...` the instruction specifies that an echild node of the processed node with the `RSTR` functor that  is NOT an adjective (if exists) gets the `ARG1` role  
   **TODO: What about if more nodes meet the condition - reification ??**
  - `if(t_lemma:možnost,echild.functor:PAT)(!modal-strength(echild.functor:PAT, neutral-affirmative)) else ...` the action is applied to the echild node with `PAT` functor hanging on the processed node

- `else` introduces instruction that is applied when the condition is not met ~~(optional)~~;  
  if no action is required, use `!ok` there.

 ```
CPHR !delete, if(echild.functor:PAT)(ARG1)  
              else if(echild.functor:RSTR,$n-not-adj)(ARG1)  
                   else !ok
```


- more `if` instructions can be cumulated -- then, they are processed in a "procedural" way, as described by the following example.  

  Example:
  -   In the following example,  the first `if` instruction searches for `ARG1` (`ARG1` is detected when `PAT` or nominal `RSTR` is found among `CPHR` children).  
  Then (be `ARG1` detected or not), any other potential REMAINING `RSTR` relation is translated to the `manner` relation. If there is still any actant among echildren of the deleted node, error is reported  

```
CPHR !delete,
      if(echild.functor:PAT)(ARG1)
      else if (echild.$actant)(!error)
             else if(echild.functor:RSTR,$n-not-adj)(ARG1)
                    else if(echild.functor:RSTR)(manner)
                           else !ok
```


### More examples

   Example: 
   - Change t_lemma to `exist-91` if there in not `BEN` among its echildren.
     Otherwise use `pred-possession-91`, find its BEN echild and change its role to `ARG2.`

```
esse-0x if(no-child.functor:BEN)(!t_lemma(exist-91))
            else (!t_lemma(pred-possession-91), if(echild:BEN)(ARG2) else !ok)
```


Example:
  - `mít-028`, with the valency frame `ACT(1) CPHR(ambice,cíl,čas,...,možnost, ...; zapotřebí)` ... this LVC covers many different constructions, including modality (e.g., _Petr má možnost přijít._ ~ _Petr může přijít._).  
   As a tentative solution , we use an artificial predicate merging the verb and the predicative noun, namely `mít-CPHR-028` (i.e., `mít-ambice-028` / `mít-cíl-028` / `mít-čas-028` / ...  `mít-možnost-028` / ... / `mít-zapotřebí-028`), with the `ACT` --> `ARG0` mapping.   
   Then, we try to identify `ARG1`  (`PAT` or `RSTR` with the specified sempos hanging below `CPHR`), see the first `if` instruction.  
   Further, if `CPHR` is filled with _možnost_, `ARG1` typically denotes an event which is modalized (_přijít_ in _Petr má možnost přijít_.); we change/add the `modal-strength` attribute respectively (`neutral-affirmative` in this case). Similarly for other  `CPHR`s expressing modality (e.g., _povinnost_ indicates `partial-affirmative` modality). Note that we have to stick to PDT-C relations/attributes, see the second `if` instruction referring to `PAT` and `RSTR` (not to `ARG1`)! 
    
 
```
mít-028 --> mít-CPHR-028
ACT --> ARG0
CPHR --> !delete,
         if(echild.functor:PAT)(ARG1)
            else if(echild.functor:RSTR,$n.denot-v)(ARG1) else !ok,
         if(t_lemma:možnost,echild.functor:PAT)(!modal-strength(echild.functor:PAT, neutral-affirmative))
            else if(t_lemma:možnost,echild.functor:RSTR,$n.denot-v)(!modal-strength(echild.functor:RSTR, neutral-affirmative)) else !ok
         ...
```

### New problems

#### NOT: Adding an additional predicate
  Example:
  - `mít-003` někdo má tanky jako hračky = "somebody has tanks as toys"
  - PDT: to have=PRED, somebody=ACT, tanks=PAT, as toys=EFF
  - Ideally in UMR:

```
have-possession-91
  :ARG1 somebody
  :ARG2 tanks
      :ARG1-of have-role-91
          :ARG3 toys
```

  - What needs to be added is a whole new predicate `have-role-91` and state that "tanks" are its ARG1 (via an ARG1-of relation) and its ARG3 is "toys".
  - Sometimes the added predicate is `have-role-91` (má za manžela Fina "she has a Finn for a husband").
  - So far I did a different solution, because adding a predicate is too complex - I simply labelled "toys" as :manner on the `have-possession-91` predicate, so the
    implemented (incorrect) solution looks like this:

```
have-possession-91
  :ARG1 somebody
  :ARG2 tanks
  :manner toys
```

**Proposed solution:** Adding a predicate is too complex so use the solution with `manner`.

#### OK: Changing the parent node of an actant

  = Turning an actant (of the predicate) into an attribute/role for a different node
  - `mít-005` někdo má svíčky zapálené "somebody has the candles lit"
  - Actually says "somebody's candles are lit" = modification, and somebody is the possessor of the modified entity
  - PDT: to have=PRED, somebody=ACT, candles=PAT, lit=EFF
  - Ideally in UMR:

```
have-mod-91
  :ARG1 candles
      :possessor somebody
  :ARG2 lit
```

  - This requires turning the original ACT into a :possessor on a different parent node than the original predicate. Namely, it needs to have "candles", the original PAT, as parent.
  - How do I specify this? Do I do this in the line for ACT, or in the line for PAT?
  - The same re-structuring applies to `mít-006` ("mít něco v pořádku", "mít školu daleko","mít něco povinně") and may possibly apply to `mít-007` if we consider the main meaning to be `have-place-91`, rahter than `have-possession-91` (mít něco u sebe, mít doma fotky, mít rodinu v zahraničí, mít kolem krku hada)

**Proposed solution:** Use the newly introduced `!move` instruction, see the example: 

Example: 
 - `mít-005` (as in _někdo.ACT má svíčky.PAT zapálené.EFF) --> `have-mod-91`
   já.`ACT` --> `!move(esibling:ARG1,possessor)`  
   svíčky.`PAT` --> `ARG1`  
   zapálené.`EFF` --> `ARG2`  
   I.e., 


#### ??: Preposition and noun into different nodes
- for `mít-013` někdo má po svatbě "somebody has after wedding", we would like to split "po" and "svatbě" into two nodes
- the preposition can be either "po" or "před", which would map to either "before" or "after"
- the desired UMR representation would be:

```
have-temporal-91
    :ARG1 (p / person)
    :ARG2 (a / after
        :op1 (s / svatba
            :ARG0 p))
```

- I can add ARG2 as after/before with the !add operation, but don't know how to state that the main noun of PAT (svatba) should be :op1 of this ARG2 (this is again the "Changing the parent node of an actant" problem)
- Another complication is that ACT needs to be both ARG1 of the predicate (have-temporal-91) and ARG0 of the :op1 (svatba), so we have on PDT actant mapping onto two arguments in UMR
- Solution so far is simply mapping the predicate onto "have-temporal-91", ACT onto ARG1 and PAT onto ARG2
