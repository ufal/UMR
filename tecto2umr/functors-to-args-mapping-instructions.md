## Mapování PDT valenčních rámců na UMR rámce

UMR předpokládá, že jednotlivé významy sloves jsou popsány pomocí tzv. **Rolesets** ze slovníku [PropBank](https://verbs.colorado.edu/propbank-development/), tedy obdobou valenčních rámců. Pro češtinu chceme pracovat s valenčním slovníkem [PDT-Vallex](https://ufal.mff.cuni.cz/pdt-vallex-valency-lexicon-linked-czech-corpora) (vyhledávání [zde](http://lindat.mff.cuni.cz/services/PDT-Vallex/) nebo v [Teitoku](https://lindat.mff.cuni.cz/services/teitok/pdtc10/index.php?action=vallex)), resp. se slovníkem [SynSemClass](https://lindat.mff.cuni.cz/services/SynSemClassSearch/?version=synsemclass5.0). Potřebujeme tedy mapování jednotlivých PDT rámců (a jednotlivých funktorů) na tyto Rolesets v UMR / PropBank (a jejich argumenty).  

Dostupné mapování je uvedeno v [Google tabulce](https://docs.google.com/spreadsheets/d/1AuIASjkdAdKom7bgjDN5BxMKeRUefHlN/edit#gid=452142481): 
- ve sloupci **D -- AUTOMATIC MAPPING** je návrh získaný automatickým převodem ze SynSemClass (dále též  SSC) a CzEnVallexu (dále též CEV), pokud byl tento převod víceméně spolehlivý (více viz níž);
- ve sloupci **E -- CORRECTION** doplňte svůj návrh, pokud automatický návrh neexistuje či s ním nesouhlasíte; též zde můžete opravit návrh kolegy, pokud s ním nesouhlasíte;
- v případě jakékoliv úpravy okomentujte v sloupci **F -- COMMENTS**. 

### Struktura tabulky

##### sloupec A -- **UMR ID**
Udává ID pro valenční rámec českého slovesa. 

##### sloupec B -- **PDT frame**
Jeden UMR rámec může odpovídat více PDT rámcům, pak mu odpovídá více záznamů (= několik řádků pro ramec a jeho funktory). 
Je tomu tak v následujících dvou případech:
-  V CzEngVallexu a někde i v SynSemClass jsou rámce, které byly v PDT-C nahrazeny novými (některé byly nahrazovány i řetězově); neaktuální (nahrazené) rámce zde mají uvedeno "substituted" a odkaz na nový rámec.   
Pro snazší orientaci mají neaktuální rámce šedé pozadí a NEPRACUJEME s nimi.
-  Jeden PDT rámec může být navázán na více tříd -- pak je v tabulce samostatný záznam   pro každou třídu, ve které se rámec vyskytuje.

##### sloupec C -- **Role mapping**
Tento sloupec udává: 
- číslo **SSC třídy**, a to pokud se daný rámec vyskytuje v nějake SSC třídě, 
- **sémantické role** odpovídající jednotlivým funktorům (vždy jednomu funktoru odpovídá jeden řádek)   
(EF upozorňuje, že asi v 90 případech je mapování funktorů na role třídy nejednoznačné -- tady automatické mapování není navržno (lze vyfiltrovat, _měly by to být řádky, které ve sloupci C obsahují středník_)

##### sloupec D -- **AUTOMATIC MAPPING (červeně)**
Tento sloupec je nejdůležitější, neboť obsahuje **finální automatické mapování** s odfiltrováním duplicit a nesouvislých indexů u argumentů (viz též sloupec J -- Info on automatic mapping a komentář k tomuto sloupci níž). 
Tento sloupec D tedy udává finální návrh mapování v těch případech, kdy: 
- automatické mapování dává s dostatečnou spolehlivostí mapování jednotlivých funktorů, a to na základě informací ve sloupcích G + H + I (viz níže popis jednotlivých sloupců)
- indexy u argumentů tvoří souvislou řadu (viz též vysvětlení hodnoty  "discontinuous ARGs" ve sloupci J -- Info on automatic mapping)
- všechny funktory jsou namapované na argumenty (viz též vysvětlení hodnoty "partial" ve sloupci J -- Info on automatic mapping) 
- argumenty se neopakují (viz též vysvětlení hodnoty "repeated ARGs" ve sloupci J -- Info on automatic mapping) 

##### sloupec E -- **CORRECTION (zeleně)**
Pokud sloupec D neobsahuje návrh automatického mapování nebo je tento návrh v rozporu s popisem argumentů u odpovídajícího slovesa v [PropBanku](https://verbs.colorado.edu/propbank-development/), uveďte zde vhodnější mapování (které bude v souhlasu s anotovanou větou). Toto mapování "přebije" automatická návrh. Každý návrh vždy okomentujte ve sloupci F -- COMMENTS.

##### sloupec F -- **COMMENTS (zeleně)**
Pokud navrhujete mapování do sloupce E, pak do sloupce E -- CORRECTIONS napište své iniciály a okomentujte navržené mapování!!

##### sloupec G -- **Unambiguous mapping - SSC and/or CEV**
Tento sloupec udává **PB argument**, u kterého jsme si "jisti" mapováním: 
- Buď existují mapování z **CEV = CzEngVallexu** i **SynSemClasses = SSC** (verze 5.1 (r.16488)) a tahle dvě mapování jsou **shodná**.       
- Za "jisté" se též považuje, pokud existuje **jednoznačné mapování** (tj. funktor jen na jeden argument z PB) **jenom z jednoho zdroje** (jenom z CEV nebo jenom ze SSC).   

Info o zdroji mapování je uvedeno ve sloupci K -- Source. !! TODO - KE KTEREMU sloupci (nebo sloupcům) se vztahuje info v K??

##### sloupec H -- **Prevailing SSC mapping (CEV ignored)** 
Tento sloupec uvádí návrh mapování funktoru na **PB argument** na základě SSC, které však není "jisté" (přičemž CEV mapování může, nebo nemusí existovat). TODO JE TO TAK ??
- SSC udává pro daný funktor několik možných argumentů -- ve sloupci F se pak uvádí: 
  - převládající argument, tj. argument, jehož četnost je alespoň o 10% vyšší než četnost jakéhokoli jiného argumentu;
  - více argumentů s vysokou četnost (oddělených znakem "#"), jde žádný z nich není převládající (jejich četnost se liší o méně než 10%).

##### sloupec I -- **Unambiguous SSC Mapping (other than CEV)**
Tento sloupec udává SSC **PB argument**, i když se liší návrhy mapování u SSC z CEV:
- Uvádí se argument podle SSC, pokud má v SSC jednoznačné mapování (ignoruje se CEV, neboť anotátoři při budování SSC k CEV přihlíželi a rozhodlli se ho nezohlednit) TODO JE TO TAK ??   
- Pokud se CEV a SSC liší a navíc má SSC nejednoznačné mapování, nenavrhuje se nic (a doplní se hodnote "disagree" do sloupce J -- Info on automatic mapping).


##### sloupec J -- Info on automatic mapping
Tento sloupec udává informaci o typu problému, který neumožnil automatické mapování s dostatečnou jistotou (sloupec D). TODO JE TO TAK (tj. je to jen u funktorů bez mapování v D?) A CO SE STANE, kdyby platilo několik z problémů níže (asi pro různé funktory)??
- **SSC ambiguous** (159 případů) - ve sloupci H udávajícím převládající SSC mapování jsou pro nějaký funktor minimálně dva PB argumenty (CEV mapování může či nemusí existovat), tedy ani jeden z nich není převládající; 
- **discontinuous ARGs** (371 případů) - indexy u navržených funktorů netvoří souvislou řadu (nemusí začínat ARG0), tj. např. ARG0, ARG1, ARG2 nebo ARG1, ARG2 atd. (a to i když zdroje mapování jsou různé) TODO KTERE SLOUPCE SE BEROU V POTAZ ??;   
(ARGM se při testování souvislosti řady zahazují)
- **partial** (1 390 případů) - ne všechny funktory mají navržené mapování TODO KTERE SLOUPCE SE BEROU V POTAZ (myslela jsem, ze je to info, proc neni navrzeno D)??;
- **repeated ARGs** (491 případů) - některé (alespoň 2) funktory se mapují na stejný argument TODO KTERE SLOUPCE SE BEROU V POTAZ ??;  
- **disagree** (1 101 případů) - mapování přes CEV a přes SSC se liší, navíc má SSC nejednoznačné mapování. 


##### sloupec K -- Source
Tento sloupec udává zdroj automatického mapování (sloupec D) TODO opravdu se tyka zdroje pro D (a ne pro jiné návrhy)??: TODO co se stane, kdyz pro ruzne funktory plati ruzne? 

- **both** (4 606 případů) - pro alespoň jeden functor máme mapováni z CEV i ze SSC (SSC mapovani typu ACT->Speaker() se ignoruje) TODO problém, viz ř. 156, 159, 175, 213, 304, ... hodnota "both", ale neni nic navrzeno v D, někde nic i v G, H, I??
- **czengvallex** (2 412 případů) - alespoň pro jeden funktor máme mapování jenom z CEV a pro žádný funktor nemáme mapování ze SSC (SSC mapovani typu ACT->Speaker() se ignoruje)  TODO problém, viz ř. 65, 238 ... hodnota "czengvallex", ale neni nic navrzeno v D??
- **ssc** (2 340 případů) - alespoň pro jeden funktor máme mapování ze SSC a pro žádný nemáme mapování z CEV TODO problém, viz ř. 550, 603, 737, 805 ... hodnota "ssc", ale neni nic navrzeno v D, někde nic i v G, H, I??
- **copy** ... máme-li pro jeden UMR rámec více záznamů (viz výše sloupec B -- PDT frame), může se stát, že aktuální záznam nemá mapování, ačkoli alespoň jeden z dalších záznamů mapování má (zejm. rámce "substituted", ale i rámce patřící do různých tříd);  PROTO maji-li všechny PDT-rámce odpovídající jednomu UMR ramci, které mají definované mapovani na PB, toto mapování shodné, PROPAGUJE se toto mapovani i pro všechny PDT-rámce tohoto UMR rámce, které dosud navržené automatické mapování z CEV ani z SSC nemají.
  


##### sloupec L -- Mapping via CzEngVallex

##### sloupce N -- Mapping via Mapping via SynSemClass5.1 (r.16488)

##### sloupce N, O, P -- skryté
Mapování přes starší verze SSC a technický sloupec pro formátování
(EF: ten starý by tam byt asi ani nemusel)
