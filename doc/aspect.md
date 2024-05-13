# Aspect

#### Quick HowTo for annotating Czech sentences:

1. **event nominals** --> `process` (like _After the **game.process**, she went.performance home._)
2. events presented as **occurring usually** or **habitually** --> `habitual` (as in  _Pekař **peče.habitual** housky_; maybe also for **agentive nouns?**)
3. **NOT processes** (no changes) like statives, modals and similar verbs --> `state` (_He **likes.stat** fish and chips, she **prefers.state** cheesburgers._)
4. **processes, imperfective verbs** (morphologically)  --> `activity` (by default),  
or `habitual` (if the denoted event occurs usually/repeatably);  
also `performance` may be considered (with stressed result)
5. **processes, perfective verb** (morphologically) --> `performance` (by default);  
also `endeavor` may be considered (if it is clear that the process stopped/was interrupted without reaching a result state)
6. **processes, double aspect verbs** --> `process` (as a back-up) if it is hard/ impossible to distinguish 

Typically, we adhere to surface marking - e.g.,  the sentence _Estonci volili parlament._ should get the `activity` aspect value due to the imperfective verb _volit_ (and we do not imply that it means their parliament is renewed).

---
## Aspect in UMR

The aspect attribute should be annotated for any eventive concept. The UMR Guidelines provide quite a rich aspect [lattice](https://github.com/umr4nlp/umr-guidelines/blob/master/Guidelines_figures/Aspect%20Lattice_2022.png) without any useful description (like `state` = unspecified type of state).

**Five values** at the default level of granularity (plus one for event nominals):
1. `habitual` (occurs usually; simple present, "used to+"),
2. `state` (no change takes place over the course of the event; also modals),
3. `activity` (process with **no evidence that it has come to an end**), which is either
   - still ongoing, or 
   - it is not clear whether or not the process continues
4. `performance` (**default** for process that ends and **reaches a result state**)
5. `endeavor` only in case of explicit marking that evidences non-reaching a result state (like terminative _stop_, durative adverbials)   
6. PLUS `process` for event nominals.


**Terminological note:** There are also more coarse-grained values, esp. 
- `imperfective`, which is ambiguous between state and atelic process, and 
- `perfective`, which covers both processes that ends without reaching a result state (`endeavor`) and process that ends and reaches a result state (`performance`)  
**Do not confuse these with the morphological categories of aspect in Czech!**

### 1. `Habitual`

This aspect value marks events that occur/occurred usually or habitually:

* [en] _He bakes pies._ / _She rides her bike to work._ / _They vacation in Taos every winter._ / _They used to vacation in Taos every winter._  

The Guidelines rely on the **morphological category of tense** here (simple Present or "used to" construction for past tense habitual events).  
NOT for ability modals! 


### 2. `State`

This aspect value marks unspecified type of `states` (i.e., no change takes place over the course of the event). 

According to the UMR Guidelines, states are only identified as events when predicated (incl. all cases of abstract predicates), like: 

* [en] _My cat loves tuna._ ... love-01 predicate
* [en] _The doctor is tall._  ... have-mod-91 predicate
* [en] _The book is on the table._ ... have-place-91 predicate 
* [en] _She is an architect._ ... have-role-91 predicate  

#### Modal verbs
Those modals in English that are recognized as separate events get the `state` value as well: 

* [en] _He wants.state to travel.performance to Albuquerque._ ... Why _to travel_ as performance?
* [en] _The cat needs.state to be fed.performance_ ... Why _to be fed_ as performance (I would suppose habitual)? 
* [en] _He’s dreading.state their decision.process_ ... ?? _to dread_ as a modal verb?


#### Events under the scope of ability modals

According to the Guidelines, "Ability modals refer to a static state of affairs, i.e., an entity possesses the relevant ability." In such cases, UMR treats the modal verbs in the same way as we are used to in PDT (modals are reflected as attributes, here `aspect` = state, `modstr` = neutral-affirmative)
 
* [en] _She **(is able to sing).state** that aria._ ... NO separate node for modal verb
* [en] _This car **(can go).state** up to 150 mph._ ... NO separate node for modal verb

Several types of states can be annotated, see the Guidelines.
 

### 3. `Activity`

This aspect value marks such events where "there is no evidence that the event has come to an end" (in particular, it marks atelic processes, i.e., processes that does not reach a result state).  

* [en] _He **is still writing** his paper._ / _He was writing his paper yesterday._

This aspect value covers both 
- cases where it is clear that the process is still ongoing and
- cases where it is ambiguous whether or not the process continues.

The Guidelines mention **grammatical clues** for distinguishing such processes: 
- present tense cont., _He is playing the violin._
- inceptive and continuative aspectual marking, _He started / kept on playing the violin._

**Back-up rule**: When not sure whether an event ended or not, use `atelic process` value (process that does not reach a result state), as it covers both 
- process that does not end, i.e., **activity**, and
- process that ends BUT without reaching a result state, i.e., **endeavor**

Two types of activity can be annotated, directed and undirected activity, see the Guidelines.

 

### 4. `Performance`

This aspect value marks such events = processes that **come/came to an end**. This value is used "when the event reaches a result state distinct from the base (start) state, that is, a specific “natural” endpoint."  

**Back-up rule**:  This value should be used as a **"default" value for processes that come to an end**!  
When an event under consideration clearly ended but it is not sure whether it reaches a (distinct) result state (performance) or not (endeavor), it can be annotate as `perfective`.

Several types and subtypes of the performance aspect can be annotated, see the Guidelines.


### 5. `Endeavor`

This aspect value marks such events which clearly end/ended **without reaching a (distinct) result state**. This value should be used only in the presence of explicit marking like terminative  _stop_, durative adverbials (as they cannot combine with completive marking like _finish_), or non-result paths. 

* [en] _Mary **(stopped mowing).endeavor** the lawn._ / _Mary **mowed.endeavor** the lawn for thirty minutes._  
... as it is not possible to use durative adverbials with completive aspectual marking, compare  _*Mary finished mowing the lawn for thirty minutes._

* [en] _They **walked.endeavor** along the river._ 
* [en] _They (finished walking).performance along the river._ / _They walked.performance along the river in 3 hours._  
... non-result path only weak indicator  of the endeavor (aspect) -- completive markers (_finish_) and/or container adverbials  (_in 3 hours_) indicate that an event has reached a distinct result state (thus `performance`)

Several types of the endeavor aspect can be annotated, see the Guidelines.



### 6. `Process` (for event nominals)
Based on definition of eventive concepts [(UMR Guidelines)](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-1-eventive-concepts), event nominals denote processes (= semantic type) packed as references as opposed to entities and states). Thus their aspect value should be `process` (no further distinctions). 

Event nominals also include  underived nominals, nominalizations, and gerunds - all of them receive the `process` value. 


* [en] _He presented.performance his research at the **meeting.process** yesterday._ 
* [en] _After the **game.process**, she went.performance home._ 
* [en] _The second **training.process** was cancelled.performance yesterday._ 
* [en] _The dog interrupted.performance the **meeting.process** with his **barking.process**._ 


## PDT aspect annotation

**First**, the PDT `aspect` grammateme has two possible values (based on the morphological dictionary):
- `proc` (=procesual) for (morphologically) imperfective verbs,
- `cpl` (=complex) for (morphologically) perfective verbs

Biaspectual / double-aspect verbs are (partially) disambiguated based on the context. When this was not possible, the verbs got the `nr` value. 

**Second**, the `iterativeness` grammateme (value `it1`) indicates verbs denoting multiple/iterated events. 
 
* [cs] _**Chodíval** k nám často._ [iterativeness=it1]

However, as a a temporary solution, only selected types of verbs are covered, namely those with one of the iterative suffixes _-ívat / -ávat, -ávávat / -ívávat_ (all other verbs have the `it0` value, despite of their possible multiple/iterative semantics).

* [cs] _**Chodí** plavat pravidelně / každé pondělí._ [iterativeness=it0]
* [cs] _**Zaplaval** si a **odešel**._ in both cases [iterativeness=it0]
* [cs] _**Plaval** dvě hodiny._ [iterativeness=it0]


**Third,**  resultative constructions might indicate events that end/ended and each/reached a resulting state (indicated by the  `diathesis` grammateme, values    `res1`, `res2.1` and `res2.1`).



### Conversion of the aspect annotation from PDT

#### PDT `proc` aspect value (possibly combined with `it1`  iterativeness value) 
The PDT aspect grammateme `proc` is assigned to verbs that denoted event as ongoing -- thus these events should get the `activity` UMR aspect value (by default).  

* [cs] _Radnice **hledá.activity** vhodné místo s ohledem na bezpečnost._  
  [en] _The town hall is looking for a suitable place with safety in mind._

The PDT aspect grammateme `proc` may be combined with the `it1` value of the `iterativeness` grammateme, which mark multiple/iterated events (disclaimer: this distinction is applied only for limited class of verbs with clear morphological marking, see above).  Each verb with the `it1` value should be annotate as `habitual`.

* [cs] _**Chodíval.habitual** k nám často._ [iterativeness=it1]  
... _chodívat_ as "it1" verb gets the `habitual` aspect value in UMR. 

However, as noted above, many Czech imperfective verbs annotated as non-iteratives in PDT (see above) may denote also repeated/usual events where the `habitual` aspect value would be more appropriate:

* [cs] _**Beru.activity** za kliku a **odcházím.activity**._  
  [en]  _**I am taking** the handle and **leaving**_.  
    ... _brát_ and _odcházet_ as "impf" verbs get `proc` in PDT and they denote ongoing events.   
   
BUT:
* [cs] _Na schůzky s přáteli mě Pavel nikdy **nebral.habitual**._   
  [en] _Pavel never took me to his get-togethers with friends._  
  ... _brát_ as "impf" verb gets `proc` and as such it may denote not only ongoing but also usually occurred events   

* [cs] _**Kupuji/?nakupuji.activity** mléko a rychle **mizím.activity**._   
  [en] _I'm buying milk and disappearing fast._  
    ... _kupovat_ and _mizet_ as "impf" verbs get `proc` in PDT and they denote ongoing events.   
    
* [cs] _Nejraději **kupuje / nakupuje.habitual** nábytek._   
    (= He likes shopping for furniture the most.)
  ... _kupovat_ and _nakupovat_ as "impf" verbs get `proc` in PDT and as such it may denote not only ongoing but also usually occurred events   

Unfortunately, this ambiguity is not reflected in the UMR aspect lattice.

#### PDT `cpl` aspect value   

The PDT aspect grammateme `cpl` (=complex) is assigned to presenting the event as **completed/a whole**. In practice, this is used for (morphologically) perfective verbs. 
As such, the default corresponding UMR aspect value is `performance` (used for processes that come/came to an end, i.e. “when the event reaches a result state distinct from the base (start) state, that is, a specific “natural” endpoint.”).

The adequacy of the `performance` value is further supported by the   dále to potvrzují rezult.konstrukce (for gramatém diat, values ... ) 

?? However, in case of special terminative marking (like _stop_) --> `endeavor` 

* [cs] _**Koupil / nakoupil.cpl** už vše potřebné._  (= He has already bought everything we needed)
* [cs] _Na schůzku s přáteli mě Pavel ještě nikdy **nevzal**._ (= Pavel has never taken me to a get-together with his friends)

* [cs] _Podle předběžných ujednání by hlavní město **poskytlo.cpl** na vybudování čtvrti svůj pozemek._ (= According to preliminary arrangements, the capital city would provide its land to build the district.)



#### Double-aspect verbs

In PDT, one of the `proc/cpl` values is typically assigned also to the so called double-aspect verbs. In those cases, when it is impossible to choose one of the values, the assigned value is nr.

> Double-aspect verbs. There are also so called double-aspect verbs, i.e. verbs that are both perfective and imperfective. They are mostly loan verbs but not only; cf. _jmenovat, obětovat, věnovat_ (=name, sacrifice, devote). For some of the double-aspect loan verbs, prefixed (i.e. perfective) forms have been formed too (e.g.: _zorganizovat, vydezinfikovat, zkonstruovat_ (=organize, disinfect, construct)); however, it does not mean that the non-prefixed forms ceased to be double-aspect verbs.
 
<!-- The `proc` value is assigned:  
- in those cases when the event is understood as ongoing/as a process:  
* [cs] _Právě tato operace **byla** i v některých západních zemích **blokována.proc** až do konce 80. let._  (= It was this operation that was blocked until the end of the 80's even in some of the western countries)  
- in those cases when the event is iterated:  
* [cs] _Císaři tam po dosažení určitého věku dobrovolně **abdikovali.proc**, vstupovali.proc do mnišského stavu..._  (= The Emperors abdicated after reaching certain age, became monks...)  
- in the cases when the event is not limited in its temporal duration.  
* [cs] _V případě asociace jde o sdružení firem v daném oboru, které chce **garantovat.proc** serióznost vůči zákazníkům._ (= It is an association, which wants to guarantee...) -->

<!-- The cpl value is assigned:  
- in the cases when the event is understood as a once only event:  
* [cs] _Celkově lze **konstatovat.cpl**, že vnější podmínky budou působit na českou ekonomiku mírně příznivěji ve srovnání s rokem 1993._ [aspect=cpl] (= It is possible to say/state that...)  
- in those cases when the result of the event is presented:  
* [cs] _K 31. lednu 1995 **registrovaly.cpl** úřady práce v České republice celkem 75 659 nových pracovních míst._  (= By January 31st 1995, the employment agencies registered 75 659 new positions...) -->


In those cases when it is hard or impossible to choose one of the basic values of the grammateme, the `nr` value is assigned. In these cases, the UMR aspect valus `process` seems as the most relevant.  

* [cs] _Kniha je výborem z esejů, které autor **publikoval.process** v letech 1986-1991 v renomovaných periodikách._  (= The book is a collection of essays which the author published between 1986 and 1991 in renowned journals)  

* [cs] _Blažek odmítl návrh strany na své vystoupení **komentovat.process** s tím, že je to věcí vedení strany._  (= Blažek refuted to comment on the party's proposal...)

* [cs] _Podle předběžných informací by zájemci měli mít možnost **investovat.process** do 15 podniků._ (= According to the preliminary information, the interested people should have the possibility to invest in 15 companies)



