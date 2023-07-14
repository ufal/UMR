# TERMINOLOGIE UMR (Uniform Meaning Representation)

[UMR](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md)
vychází z [AMR](https://github.com/umr4nlp/amr-guidelines/blob/master/amr.md)
a některé věci nevysvětluje možná proto, že předpokládá, že je uživatel zná z
AMR. V AMR se hned na začátku říká, že reprezentace věty je zakořeněný
orientovaný acyklický graf, ale není to pravda, protože i v témže dokumentu
na konci připouštějí, že asi 0,3 % grafů AMR obsahuje legitimní cykly.


## Koncept (concept) a proměnná (variable)

Podle AMR se vnitřním uzlům grafu říká **proměnné** a listům **koncepty**.
Každý koncept je připojen k nějaké proměnné hranou, která představuje relaci
**instance**. Říkáme, že koncept X je instancí proměnné Y. V textové
reprezentaci AMR i UMR se relace instance vyjadřuje lomítkem, před ním je
proměnná a za ním je koncept:

```
(b / boy)
```

Koncept je řetězec (typicky složený z písmen, pomlček a číslic, ale přesnou
specifikaci neznám). Může odpovídat lematu nebo posloupnosti lemat, může to
také být abstraktní koncept – ten je obvykle reprezentován anglickým slovem
bez ohledu na to, jaký jazyk anotujeme. Koncept lze chápat jako odkaz do
slovníku; v jednom grafu může být několik uzlů se stejným konceptem. U
proměnných je zvykem označovat je prvním písmenem z konceptu, v případě
potřeby doplněným rozlišovacím číslem (opět nevím, zda je to jen zvyk, nebo i
formální požadavek; nikde také není řečeno, zda může proměnná obsahovat
písmena, která nejsou v anglické abecedě). Příklady v AMR mají typicky mezeru
z obou stran lomítka, příklady v UMR ji obvykle mají jen za lomítkem,
software by doufejme měl umět načíst obojí, ale formální specifikace chybí
(resp. v guidelines na ni není odkaz).

Podle příkladů se zdá, že platí následující (ale nikde jsem nenašel jasné
vyjádření, že to musí platit):

* Každá proměnná má právě jednu instanci (koncept).
* Uzel s konceptem je připojen jako instance k právě jedné proměnné. Pokud
  je v grafu více proměnných, jejichž instancí je stejný koncept, budou tyto
  koncepty zobrazeny jako samostatné listy, přestože odpovídají téže položce
  ve slovníku. Reentrance (více než jedna příchozí hrana) je možná u
  proměnných, ale ne u konceptů.
* Z toho ovšem plyne, že můžeme zavést zjednodušený graf UMR, kde hrany
  instance neexistují a koncept byl se svou proměnnou stažen do jednoho uzlu.
  Proměnná slouží jako jednoznačný identifikátor takového uzlu v rámci grafu,
  zatímco koncept je ohodnocení uzlu a současně jednoznačný odkaz z proměnné
  do slovníku.

```
(w / want-01
   :ARG0 (b / boy)
   :ARG1 (b2 / believe-01
             :ARG0 (g / girl)
             :ARG1 b))
```

Příslušný (nezjednodušený) graf pak vypadá následně:
https://github.com/amrisi/amr-guidelines/blob/master/graph.png

Při tomto pojetí pak lze sémantiku zachytit jako konjunkci logických
predikátů  (neo-Davidsonian semantics):

```
instance(w, want-01) ^         /* w is an instance of wanting */
instance(b, boy) ^             /* b is an instance of boy */
instance(b2, believe-01) ^     /* b2 is an instance of believing */
instance(g, girl) ^            /* g is an instance of girl */
ARG0(w, b) ^                   /* b is the wanter in w */
ARG1(w, b2) ^                  /* b2 is the wantee in w */
ARG0(b2, g) ^                  /* g is the believer in b2 */
ARG1(b2, b)                    /* b is the believee in b2 */
```


## Událost (event), proces (process), stav (state) a entita (entity)

Tabulka 1 v části 3-1-1 anotačních pravidel rozlišuje koncepty na **entity**,
**stavy** a **procesy** („semantic type“), z nichž každý může být vyjádřen v
rámci „information packaging“ jako **reference**, **modifikace**, nebo 
**predikace**. 

Všechny procesy (v libovolném balení) a všechny predikace (procesů, stavů i 
entit), celkem tedy 5 z 9 polí tabulky, jsou považované za **události** 
(„events“, „eventive concepts“). 

ML: ***Rozlišení, co považovat za událost a co nikoli, se zdá dost 
komplikované a chybí nám jasná kritéria  :-((*** 


## Entita (entity), pojmenovaná entita (named entity), objekt (object)

Pojem „named entity“ se v pravidlech používá, aniž by byl řádně definován. 
Pojmenovaným entitám je věnována část 3-1-2 s Tabulkou 5, která vyjmenovává 
jejich třídy, typy a podtypy. Přitom hloupě střídá pomlčky a podtržítka a 
ponechává bez vysvětlení některé detaily (např. proč je ethnic-group ve třídě 
social_group, ale nationality je samostatná třída). Předtím už jsou 
pojmenované entity zmíněné v části 2-1 jako jeden z druhů konceptů v UMR. 
Taxonomie entit z Tabulky 5 se nepoužívá pouze pro pojmenované entity, ale i 
pro abstraktní entity, tj. uzly odpovídající osobním zájmenům (která mohou 
být ve větě jako slova, nebo mohou být vydedukována z valence a morfologie 
slovesa). Z některých příkladů v pravidlech vyplývá, že podobná taxonomie 
funguje i pro obecná substantiva (např. _teacher_ je vyjádřen abstraktním 
konceptem person, který je rozvitý dalším uzlem, ve kterém je teprve událost 
_teach_, tj. „person who teaches“), ovšem v jiných případech jsou přímo 
lemata těchto substantiv použita jako koncepty (např. _businessman_). Pozor, 
v textu pravidel se občas místo pojmu „entity“ používá pojem „object“, např. 
na začátku části 3-2-2-2 se mluví o „object concepts“. 


## Relace, vztah (relation)

Relace jsou vztahy mezi koncepty, jsou to tedy orientované hrany v grafu UMR, 
spolu s řetězcem (ohodnocením), který určuje typ relace. Ve formátu UMR 
vypadají jako dvojtečka následovaná typem a závorkou, za kterou začíná 
podřízený uzel. Jednotlivé typy relací lze rozdělit do dvou skupin: (i) 
participant roles (účastnické role v události, např. `:ARG0`) a (ii) sémantické 
relace (např. `:temporal`, `:ord`, `:range`). Jsou popsané v částech 3-2-1, resp. 
3-2-2. Do té druhé skupiny (sémantické relace) mají zřejmě patřit také 
rozvití (modifiers), popsaná v části 3-2-2-2. Pozor, text pravidel není 
důsledný a později mluví i o některých atributech jako o relacích (např. 
`:polarity`). 


## Atribut (attribute)

Libovolná další vlastnost konceptu (uzlu) - text mluví zejm. o (iii) UMR 
atributech (`:aspekt`, `:mode`, `:polarity`, `:quant`, (?`:value`,) `:ref`, `:degree`) a o (iv) anotaci modality (`:modstr`, `:modpred`, `:quot`). 

Podobně jako relace začínají dvojtečkou, za kterou následuje název atributu. 
Na rozdíl od relace je ale následuje řetězcová hodnota, nikoli závorky a 
podřízený uzel. Pojem atribut se zavádí v části 2-1 a některé jsou tam hned 
vyjmenované. Pozor, text pravidel není důsledný a o některých atributech 
později chybně mluví jako o relacích. Např. kvantita je už v části 2-1 jasně 
uvedena jako atribut `:quant`, ale v části 2-2-5 se najednou objeví sousloví 
„the `:quant` relation“, přestože se část 2-2-5 přímo jmenuje Attributes. 
