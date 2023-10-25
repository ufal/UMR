# Aspect

The aspect attribute should be annotated for any eventive concept. The UMR Guidelines provide quite a rich aspect [lattice](https://github.com/umr4nlp/umr-guidelines/blob/master/Guidelines_figures/Aspect%20Lattice_2022.png) without any useful description (like `state` = unspecified type of state).

**Five values** at the default level of granularity, plud one for event nominals:
1. `habitual` (occurs usually; simple present, "used to+"),
2. `state` (no change takes place over the course of the event; also modals),
3. `activity` (process with **no evidence that it has come to an end**), which is either
   - still ongoing, or 
   - it is not clear whether or not the process continues
4. `performance` (**default** for process that **ends and reaches a result state**)
5. `endeavor` only in case of explicit marking that evidences non-reaching a result state (like terminative _stop_, durative adverbials)   
6. `process` for event nominals.


**Termonological note:** There are also more coarse-grained values, esp. 
- `imperfective`, which is ambiguous between state and atelic process, and 
- `perfective`, which covers both processes that ends without reaching a result state (`endeavor`) and process that ends and reaches a result state (`performance`)  
**Do not confuse these with the morpholiogical categories of aspect in Czech!**

## 1. `Habitual`

This aspect value marks events that occur/occurred usually or habitually:
* [en] _He bakes pies._ / _She rides her bike to work._ / _They vacation in Taos every winter._ / _They used to vacation in Taos every winter._  
The Guidelines rely on the **morphological category of tense** here (simple Present or "used to" construction for past tense habitual events).  
NOT for ability modals! 


## 2. `State`

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

According to the Guidelines, "Ability modals refer to a static state of affairs, i.e. an entity possesses the relevant ability." In such cases, UMR treats the modal verbs in the same way as we are used to in PDT (modals are reflected as attributes, here `aspect` = state, `modstr` = neutral-affirmative)
 
* [en] _She (is able to sing).state that aria._ ... NO separate node for modal verb
* [en] _This car (can go).state up to 150 mph._ ... NO separate node for modal verb

Several types of states can be annotated, see the Guidelines.
 

## 3. `Activity`

This aspect value marks such events where "there is no evidence that the event has come to an end" (in particular, it marks atelic processes, i.e., processes that does not reach a result state).  

* [en] _He is still writing his paper._ / _He was writing his paper yesterday._

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

 

## 4. `Performance`

This aspect value marks such events = processes that come/came to an end. This value is used "when the event reaches a result state distinct from the base (start) state, that is, a specific “natural” endpoint."  

**Back-up rule**:  This value should be used as a **"default" value for processes that come to an end**!  
When not sure whether an event reaches a (distinct) result state (performance) or not (endeavor), it can be annotate as `perfective`.

Several types and subtypes of the performance aspect can be annotated, see the Guidelines.


## 5. `Endeavor`

This aspect value marks such events which clearly end/ended **without reaching a (distinct) result state**. This value should be used only in the presence of explicit marking like terminative  _stop_, durative adverbials (as they cannot combine with completive marking like _finish_), or non-result paths. 

* [en] _Mary (stopped mowing).endeavor the lawn._ / _Mary mowed.endeavor the lawn for thirty minutes._  
... as it is not possible to use durative adverbials with completive aspectual marking, compare  _*Mary finished mowing the lawn for thirty minutes._

* [en] _They walked.endeavor along the river._ 
* [en] _They (finished walking).performance along the river._ / _They walked.performance along the river in 3 hours._  
... non-result path only weak indicator  of the endeavor (aspect) -- completitive markers (_finish_) and/or container adverbials  (_in 3 hours_) indicate that an event has reached a distinct result state (thus `performance`)

Several types of the endeavor aspect can be annotated, see the Guidelines.



## 6. `Process` (for event nominals)
Based on definition of eventive concepts [(UMR Guidelines)](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-1-eventive-concepts), event nominals denote processes (= semantic type) packed as references as opposed to entities and states). Thus their aspect value should be `process` (no further distinctions). 

Event nominals also include  underived nominals, nominalizations, and gerunds - all of them receive the `process` value. 


* [en] _He presented.performance his research at the **meeting** yesterday._ [meet-01, aspect: process]
* [en] _After the **game**, she went.performance home._ [game, aspect: process]
* [en] _The second **training** was cancelled.performance yesterday._ [train-01, aspect: process]
* [en] _The dog interrupted.performance the meeting with his barking._ [meet-01, bark-01, both aspect: process]


# PDT aspect annotation

**First**, the PDT `aspect` grammateme has two possible values (based on the morphological dictionary):
- `proc` (=procesual) for (morphologically) imperfective verbs,
- `cpl` (=complex) for (morphologically) perfective verbs

Biaspectual / double-aspect verbs are (partially) disambiguated based on the context. When this was not possible, the verns got the `nr` value. 

**Second**, the `iterativeness` grammateme (value `it1`) indicates verbs denoting multiple/iterated events. 
 
* [cs] _**Chodíval** k nám často._ [iterativeness=it1]

However, as a a temporary solution, only selected types of verbs are covered, namely those with one of the iterative suffixes _-ívat / -ávat, -ávávat / -ívávat_ (all other verbs have the `it0` value, despite of their possible multiple/iterative semantics).

* [cs] _**Chodí** plavat pravidelně / každé pondělí._ [iterativeness=it0]
* [cs] _**Zaplaval** si a **odešel**._ in both cases [iterativeness=it0]
* [cs] _**Plaval** dvě hodiny._ [iterativeness=it0]


**Third,**  resultative constructions might indicate events that end/ended and each/reached a resulting state (indicated by the  `diathesis` grammateme, values    `res1`, `res2.1` and `res2.1`).



## Conversion of the aspect annotation from PDT


- `proc` (=procesual) for (morphologically) imperfective verbs -- these verbs are supposed to present the denoted event as ongoing, thus should be in general converted to the `activity` UMR aspect value (by default);  
However,

> BUT examples ... spí nesedí!!!!
> 
> Nejraději kupuje / nakupuje nábytek. [aspect=proc] (=He likes to buy furniture best)
> 
> Na schůzky s přáteli mě Pavel nikdy nebral. [aspect=proc] (=Pavel never took me to his get-togethers with friends)

  - TODO in case of iteratives, the aspect value should be `habitual`
  -
- `cpl` (=complex) for (morphologically) perfective verbs -- these verbs are supposed to present the denoted event as completed/a whole, thus such events should (by default) get the `performance` UMR aspect value.  
However,  
  - in case of special terminative marking TODO --> `endeavor` 


> Koupil / nakoupil už vše potřebné. [aspect=cpl] (=He has already bought everything we needed)
> 
> Na schůzku s přáteli mě Pavel ještě nikdy nevzal. [aspect=cpl] (=Pavel has never taken me to a get-together with his friends)
> 

TODO:

> Double-aspect verbs. There are also so called double-aspect verbs, i.e. verbs that are both perfective and imperfective. They are mostly loan verbs but not only; cf. jmenovat, obětovat, věnovat (=name, sacrifice, devote). For some of the double-aspect loan verbs, prefixed (i.e. perfective) forms have been formed too (e.g.: zorganizovat, vydezinfikovat, zkonstruovat (=organize, disinfect, construct)); however, it does not mean that the non-prefixed forms ceased to be double-aspect verbs.
> 
> The proc value is assigned:


    in the cases when the event is understood as a once only event.

    For example:

    Celkově lze konstatovat, že vnější podmínky budou působit na českou ekonomiku mírně příznivěji ve srovnání s rokem 1993. [aspect=cpl] (=It is possible to say/state that...)

    in those cases when the result of the event is presented.

    For example:

    K 31. lednu 1995 registrovaly úřady práce v České republice celkem 75 659 nových pracovních míst. [aspect=cpl] (=By January 31st 1995, the employment agencies registered 75 659 new positions...)



> The cpl value is assigned:

    in the cases when the event is understood as a once only event.

    For example:

    Celkově lze konstatovat, že vnější podmínky budou působit na českou ekonomiku mírně příznivěji ve srovnání s rokem 1993. [aspect=cpl] (=It is possible to say/state that...)

    in those cases when the result of the event is presented.

    For example:

    K 31. lednu 1995 registrovaly úřady práce v České republice celkem 75 659 nových pracovních míst. [aspect=cpl] (=By January 31st 1995, the employment agencies registered 75 659 new positions...)


the process that ends and reaches a result state ... dále to potvrzují rezult.konstrukce (for gramatém diat, values ... )  --> `Performance`.


- aspect `nr` (biasp. slovesa) --> `process`

gramatém iter ... `habitual`

Habitual ... ???

State ... ???

