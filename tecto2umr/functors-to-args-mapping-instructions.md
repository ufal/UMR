## Mapování PDT valenčních rámců (a jednotlivých funktorů) na Rolesets v UMR / PropBank (a jejich argumenty)  

Dostupné mapování je uvedeno v [Google tabulce](https://docs.google.com/spreadsheets/d/1AuIASjkdAdKom7bgjDN5BxMKeRUefHlN/edit#gid=452142481): 
- v sloupci **CHANGE G** je návrh získaný automatickým převodem z SSC a CzEnVallexu, pokud byl tento převod víceméné spolehlivý (více viz níž);
- v sloupci **CHANGE** doplňte svůj návrh, pokud automatický návrh neexistuje či s ním nesouhlasíte; též zde můžete opravit návrh kolegy, pokud s ním nesouhlasíte;
- v případě jakékoliv úpravy okomentujte v sloupci **CHANGE**. 

### Struktura tabulky

##### sloupec A -- **UMR ID**
Udává ID pro valenční rámec českého slovesa. 

##### sloupec B -- **PDT frame**
 Jeden UMR rámec může odpovídat více PDT rámcům, pak mu odpovídá více záznamů (= několik řádků pro ramec a jeho funktory). 
Je tomu tak v následujících případech:
-  V CzEngVallexu a někde i v SSC jsou rámce, které byly v PDT-C nahrazeny novými; nahrazené rámce zde mají uvedeno "substituted" a odkaz na nový rámec (i řetězově nahrazovaný).   
Pro snazší orientaci mají takové rámce šedé pozadí a NEPRACUJEME s nimi.
-  Jeden PDT rámec může být navázán na více tříd -- pak je v tabulce samostatný záznam   pro každou třídu, ve které se rámec vyskytuje.

##### sloupec C -- **Role mapping**
Tento sloupec udává: 
- číslo **SSC třídy**, a to pokud se daný rámec vyskytuje v nějake SSC třídě, 
- **sémantické role** odpovídající jednotlivým funktorům (na řádcích odpovídajících jednotlivým funktorům)   
(EF: upozorňuji, že asi v 90 případech máme nejednoznačné mapování funktorů na role třídy -- tady jsem se o automatické mapování radši zatím vůbec nepouštěla; můžu kdyžtak poslat jejich seznam, jinak se daji vyfiltrovat (_měly by to být řádky, které ve sloupci C obsahují středník_)

##### sloupec D -- **Mapping**
Tento sloupec udává **PB argument**, u kterého jsme si "jisti" mapováním: 
- Buď existují mapování z **CzEngVallexu** i **SSC** a tahle dvě mapování jsou **shodná**.       
(Pracuje se pouze se SSC verze 5.1 - měla by být bohatší než verze 5.0 a bohatší a přesnější než ta stará, ale lze to přepočítat i pro verzi 5.0, kdybychom to chtěli mít nad nějakou fixní verzí.)
- Za "jisté" se též považuje, pokud existuje **jednoznačné mapování** (tj. funktor jen na jeden argument z PB) **jenom z jednoho zdroje** (jenom z CzEngVallexu nebo jenom ze SSC). 

##### sloupec E -- **Suggested mapping** ???TODO:OPRAVDU TO TAKTO CHCEME
Tento sloupec udává **PB argument**, který však není "jistý":
- Pokud nemá argument jednoznačné mapování ??TODO míra jistoty??, uvádí se jenom ten nejčetnější argument (_v případě více hodnot se stejnou četností uvedeny obě, oddělené znakem "#"_).

##### sloupec F -- **Mapping without CzEngVallex**
Tento sloupec udává **PB argument**, i když se liší návrhy mapování u CzEngVallexu a SSC:
- Uvádí se argument podle SSC, pokud má v SSC jednoznačné mapování (ignoruje se ??TODO:~~SSC~~CzEngVallex)   
Pokud se CzEngVallex a SSC liší a navíc má SSC nejednoznačné mapování, nenavrhuje se nic :).

##### sloupec G -- MAPPING
Tento sloupec obsahuje finální automatické mapování s odfiltrováním duplicit a nesouvislých indexů u argumentů (viz Info, sloupec CHANGE)
Tento sloupec udává finální návrh mapování v těch případech, kdy 
- automatické mapování dává s dostatečnou spolehlivostí mapování jednotlivých funktorů (sloupce D+E CHANGE), 
- argumenty se neopakují,
- TODO v argumentech nejsou diry a tvori souvislou radu TODO: to je jedna, nebo 2 podmínky??

##### sloupec (new CHANGE) -- Manual mapping

##### sloupec (new CHANGE) -- Comment on manual mapping

##### sloupec H -- Info on automatic mapping
Tento sloupec udává informaci o typu problému, který znemožnil návrh mapování: 
- nejednoznačné ... ve sloupci E CHANGE jsou pro nějaký funktor minimálně dva PB argumenty, tj. těch "nejčastějších" bylo víc neč jeden) TODO ??? (kde je míra "spolehlivosti")
- nesouvislé ... indexy u navržených funktorů netvoří souvislou řadu (nemusí začínat ARG0), tj. např. ARG0, ARG1, ARG2 nebo ARG1, ARG2 atd. (a to i když zdroje mapování jsou různé)   
(ARGM se při testování souvislosti řady zahazují)
- neúplné ... ne všechny funktory mají navržené mapování
- opakované ... některé (alespoň 2) funktory se mapuje na stejný argument  
- spor ... mapování přes CzEngVallex a přes SSC se sice liší, ale SSC má jednoznačné mapování (tj. je neprázdný sloupec F CHANGE)


##### sloupec I -- Source
Tento sloupec udává zdroj automatického mapování: 
- both ... pro alespoň jeden functor máme mapováni z CzEngVallexu i ze SSC   
(mapovani typu ACT->Speaker() se ignoruje)
- czengvallex ... alespoň pro jeden funktor máme mapování jenom z CzEngVallexu a pro žádný funktor nemáme mapování ze SSC
- ssc ... alespoň pro jeden funktor máme mapování ze SSC a pro žádný nemáme mapování z CzEngVallexu
- copy ... máme-li pro jeden UMR rámec více záznamů (viz výše info o sloupci B), může se stát, že aktuální záznam nemá mapování, ačkoli alespoň jeden z dalších záznamů mapování má (zejm. rámce "substituted", ale i rámce patřící do různých tříd);  PROTO maji-li všechny PDT-rámce odpovídající jednomu UMR ramci, které mají definované mapovani na PB, toto mapování shodné, PROPAGUJE se toto mapovani i pro všechny PDT-rámce tohoto UMR rámce, které dosud informace z CzEngVallexu ani z SSC nemají.
  


##### sloupec J - mapováni pres CzEngVallex

##### sloupce K, L, M - mapovani pres SSC5.1, SSC5.0 a stary SSC 
(EF: ten starý by tam byt asi ani nemusel)

