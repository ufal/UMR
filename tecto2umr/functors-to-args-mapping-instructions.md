## Mapování PDT valenčních rámců na UMR rámce

UMR předpokládá, že jednotlivé významy sloves jsou popsány pomocí tzv. **Rolesets** ze slovníku [PropBank](https://verbs.colorado.edu/propbank-development/), tedy obdobou valenčních rámců. Pro češtinu chceme pracovat s valenčním slovníkem [PDT-Vallex](https://ufal.mff.cuni.cz/pdt-vallex-valency-lexicon-linked-czech-corpora) (vyhledávání [zde](http://lindat.mff.cuni.cz/services/PDT-Vallex/) nebo v [Teitoku](https://lindat.mff.cuni.cz/services/teitok/pdtc10/index.php?action=vallex)), resp. se slovníkem [SynSemClass](https://lindat.mff.cuni.cz/services/SynSemClassSearch/?version=synsemclass5.0). Potřebujeme tedy mapování jednotlivých PDT rámců (a jednotlivých funktorů) na tyto Rolesets v UMR / PropBank (a jejich argumenty).  

Dostupné mapování je uvedeno v [Google tabulce](https://docs.google.com/spreadsheets/d/1AuIASjkdAdKom7bgjDN5BxMKeRUefHlN/edit#gid=452142481): 
- v sloupci **D NEW** je návrh získaný automatickým převodem z SSC a CzEnVallexu, pokud byl tento převod víceméně spolehlivý (více viz níž);
- v sloupci **NEW CHANGE** doplňte svůj návrh, pokud automatický návrh neexistuje či s ním nesouhlasíte; též zde můžete opravit návrh kolegy, pokud s ním nesouhlasíte;
- v případě jakékoliv úpravy okomentujte v sloupci **NEW CHANGE**. 

### Struktura tabulky

##### sloupec A -- **UMR ID**
Udává ID pro valenční rámec českého slovesa. 

##### sloupec B -- **PDT frame**
Jeden UMR rámec může odpovídat více PDT rámcům, pak mu odpovídá více záznamů (= několik řádků pro ramec a jeho funktory). 
Je tomu tak v následujících případech:
-  V CzEngVallexu a někde i v SSC jsou rámce, které byly v PDT-C nahrazeny novými (některé nahrazovány i řetězově); neaktuální (nahrazené) rámce zde mají uvedeno "substituted" a odkaz na nový rámec.   
Pro snazší orientaci mají neaktuální rámce šedé pozadí a NEPRACUJEME s nimi.
-  Jeden PDT rámec může být navázán na více tříd -- pak je v tabulce samostatný záznam   pro každou třídu, ve které se rámec vyskytuje.

##### sloupec C -- **Role mapping**
Tento sloupec udává: 
- číslo **SSC třídy**, a to pokud se daný rámec vyskytuje v nějake SSC třídě, 
- **sémantické role** odpovídající jednotlivým funktorům (vždy jednomu funktoru odpovídá jeden řádek)   
(EF upozorňuje, že asi v 90 případech je nejednoznačné mapování funktorů na role třídy -- tady automatické mapování není (lze vyfiltrovat, _měly by to být řádky, které ve sloupci C obsahují středník_)

##### sloupec D -- **AUTOMATIC MAPPING**
Tento sloupec obsahuje finální automatické mapování s odfiltrováním duplicit a nesouvislých indexů u argumentů (viz též Info, sloupec CHANGE). 
Tento sloupec tedy udává finální návrh mapování v těch případech, kdy: 
- automatické mapování dává s dostatečnou spolehlivostí mapování jednotlivých funktorů (sloupce E+F+G), (TODO ... CO TO ZNAMENA ??)
- indexy u argumentů tvoří souvislou řadu (viz též "discontinuous ARGs" ve sloupci "Info CHANGE")
- všechny funktory jsou namapované na argumenty (viz též "partial" ve sloupci "Info CHANGE") 
- argumenty se neopakují (viz též "repeated ARGs" ve sloupci "Info CHANGE") 
- 
##### sloupec E -- **Unambiguous mapping - SSC and/or CEV**
Tento sloupec udává **PB argument**, u kterého jsme si "jisti" mapováním: 
- Buď existují mapování z **CEV = CzEngVallexu** i **SynSemClasses = SSC** (verze 5.1 (r.16488)) a tahle dvě mapování jsou **shodná**.       
- Za "jisté" se též považuje, pokud existuje **jednoznačné mapování** (tj. funktor jen na jeden argument z PB) **jenom z jednoho zdroje** (jenom z CEV nebo jenom ze SSC). 

##### sloupec F -- **Prevailing SSC mapping (CEV ignored)** 
Tento sloupec uvádí návrh mapování funktoru na **PB argument** na základě SSC, které však není "jisté" (přičemž CzEngVallex mapování může, nebo nemusí nenabízet TODO JE TO TAK ?? viz ř. 234).
- SSC udává pro daný funktor několik možných argumentů -- ve sloupci F se pak uvádí: 
  - převládající argument, tj. argument, jehož četnost je alespoň o 10% vyšší než četnost jakéhokoli jiného argumentu;
  - více argumentů s vysokou četnost (oddělených znakem "#"), jde žádný z nich není převládající (jejich četnost se liší o méně než 10%).

##### sloupec G -- **Unambiguous SSC Mapping (other than CEV)**
Tento sloupec udává SSC **PB argument**, i když se liší návrhy mapování u CzEngVallexu a SSC:
- Uvádí se argument podle SSC, pokud má v SSC jednoznačné mapování (ignoruje se CzEngVallex)   
- Pokud se CzEngVallex a SSC liší a navíc má SSC nejednoznačné mapování, nenavrhuje se nic ... spor v I CHANGE označeno jako spor).
TODO: toto by se mělo použít pro automatický návrh do G jen pokud by CzEngVallex měl marginální čísla (< 10%) ... Eva vyíše případy s velkýni CEV čísly??


##### sloupec H -- Info on automatic mapping
Tento sloupec udává informaci o typu problému, který neumožnil automatické mapování s dostatečnou jistotou (sloupec D) (případně finální mapování navrhne, ale s vyšší mírou nejistoty): 
- **SSC ambiguous** (159 případů) - ve sloupci F CHANGE udávajícím SSC mapování jsou pro nějaký funktor minimálně dva PB argumenty (CzEngVallex mapování může či nemusí existovat TODO je to tak???), tedy ani jeden z nich není převládající 
- **discontinuous ARGs** (371 případů) - indexy u navržených funktorů netvoří souvislou řadu (nemusí začínat ARG0), tj. např. ARG0, ARG1, ARG2 nebo ARG1, ARG2 atd. (a to i když zdroje mapování jsou různé) TODO KTERE SLOUPCE SE BEROU V POTAZ ??;   
(ARGM se při testování souvislosti řady zahazují)
- **partial** (1 390 případů) - ne všechny funktory mají navržené mapování TODO KTERE SLOUPCE SE BEROU V POTAZ ??;
- **repeated ARGs** (491 případů) - některé (alespoň 2) funktory se mapují na stejný argument TODO KTERE SLOUPCE SE BEROU V POTAZ ??;  
- **desagree** (1 101 případů) - mapování přes CzEngVallex a přes SSC se liší, navíc má SSC nejednoznačné mapování. 


##### sloupec I -- Source
Tento sloupec udává zdroj automatického mapování (sloupec D) TODO opravdu se tyka zdroje pro D??: 
- **both** (4 606 případů) - pro alespoň jeden functor máme mapováni z CzEngVallexu i ze SSC (SSC mapovani typu ACT->Speaker() se ignoruje)
- **czengvallex** (2 412 případů) ... alespoň pro jeden funktor máme mapování jenom z CzEngVallexu a pro žádný funktor nemáme mapování ze SSC (SSC mapovani typu ACT->Speaker() se ignoruje)
- ssc ... alespoň pro jeden funktor máme mapování ze SSC a pro žádný nemáme mapování z CzEngVallexu
- copy ... máme-li pro jeden UMR rámec více záznamů (viz výše info o sloupci B), může se stát, že aktuální záznam nemá mapování, ačkoli alespoň jeden z dalších záznamů mapování má (zejm. rámce "substituted", ale i rámce patřící do různých tříd);  PROTO maji-li všechny PDT-rámce odpovídající jednomu UMR ramci, které mají definované mapovani na PB, toto mapování shodné, PROPAGUJE se toto mapovani i pro všechny PDT-rámce tohoto UMR rámce, které dosud informace z CzEngVallexu ani z SSC nemají.
  


##### sloupec J - mapováni pres CzEngVallex

##### sloupce K, L, M - mapovani pres SSC5.1, SSC5.0 a stary SSC 
(EF: ten starý by tam byt asi ani nemusel)

