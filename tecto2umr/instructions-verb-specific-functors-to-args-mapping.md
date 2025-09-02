## Mapování PDT valenčních rámců na UMR rámce

UMR předpokládá, že jednotlivé významy sloves jsou popsány pomocí tzv. **Rolesets** ze slovníku [PropBank](https://verbs.colorado.edu/propbank-development/), tedy obdobou valenčních rámců. Pro češtinu chceme pracovat s valenčním slovníkem [PDT-Vallex](https://ufal.mff.cuni.cz/pdt-vallex-valency-lexicon-linked-czech-corpora) (vyhledávání [zde](http://lindat.mff.cuni.cz/services/PDT-Vallex/) nebo v [Teitoku](https://lindat.mff.cuni.cz/services/teitok/pdtc10/index.php?action=vallex)), 
resp. s ontologií [SynSemClass](https://ufal.mff.cuni.cz/synsemclass) 
(vyhledávání [zde](https://lindat.mff.cuni.cz/services/SynSemClassSearch/?version=synsemclass5.0)). Potřebujeme tedy mapování jednotlivých PDT rámců (a jejich funktorů) na tyto Rolesets v UMR / PropBank (a jejich argumenty).  

Dostupné mapování je uvedeno v [Google tabulce](https://docs.google.com/spreadsheets/d/1lVo7a8hPBReI4VrgNkUGem8uC_sCQCXJJvLFCbwPuok/): 
<!-- stará nezamčená tabulka 
https://docs.google.com/spreadsheets/d/1AuIASjkdAdKom7bgjDN5BxMKeRUefHlN/edit#gid=452142481
https://docs.google.com/spreadsheets/d/1AuIASjkdAdKom7bgjDN5BxMKeRUef~~~~HlN/edit#gid=1231600085 -->
- ve sloupci **D -- AUTOMATIC MAPPING** je návrh získaný automatickým převodem ze SynSemClass (dále též  SSC) a CzEnVallexu (dále též CEV), pokud byl tento převod víceméně spolehlivý (více viz níž);
- ve sloupci **E -- CORRECTION** doplňte svůj návrh, pokud automatický návrh neexistuje či s ním nesouhlasíte; též zde můžete opravit návrh kolegy, pokud s ním nesouhlasíte;
- v případě jakékoliv úpravy okomentujte v sloupci **F -- COMMENTS**. 

V případě, kdy zpracovávané sloveso v tabulce nenajdete, lze se opřít o defaultní mapování, které je [zde](dafault-functors-to-umrlabels.txt) (zejména pro automatický převod).

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
- argumenty se neopakují (viz též vysvětlení hodnoty "repeated ARGs" ve sloupci J -- Info on automatic mapping).  

Pokud je mapování do sloupce D převzato ze sloupce I -- Unambiguous SSC Mapping (other than CEV), považujeme jeho spolehlivost za trochu nižší, proto je před ním otazník.

##### sloupec E -- **CORRECTION (zeleně)**
Pokud sloupec D neobsahuje návrh automatického mapování nebo je tento návrh v rozporu s popisem argumentů u odpovídajícího slovesa v [PropBanku](https://verbs.colorado.edu/propbank-development/), uveďte zde vhodnější mapování (které bude v souhlasu s anotovanou větou). Toto mapování "přebije" automatický návrh. Každý návrh vždy okomentujte ve sloupci F -- COMMENTS.

##### sloupec F -- **COMMENTS (zeleně)**
Pokud navrhujete mapování do sloupce E, pak do sloupce E -- CORRECTIONS napište své iniciály a okomentujte navržené mapování!!

##### sloupec G -- **Unambiguous mapping - SSC and/or CEV**
Tento sloupec udává **PB argument**, u kterého jsme si "jisti" mapováním, a to v následujících případech: 
- existují **jednoznačná** a **shodná mapování** daného funktoru v  **CEV = CzEngVallexu** i **SynSemClasses = SSC** (verze 5.1 (r.16488)),  tj. v obou zdrojích je tento funktor mapován na týž jediný PB argument;       
- existuje **jednoznačné mapování** jenom **z jednoho zdroje** (jenom z CEV nebo jenom ze SSC), a druhý zdroj mapování neudává.   

Info o zdroji mapování (sloupce G-I) je uvedeno ve sloupci K -- Source. V případě, že žádné mapování navrženo není, přestože mapování v SSC a/nebo CEV k dispozici je, je důvod uveden ve sloupci J -- Info. 

##### sloupec H -- **Prevailing mapping - SSC and/or CEV** 
Tento sloupec uvádí návrh mapování funktoru na **PB argument** na základě převažujícího mapování v SSC a/nebo CEV (tj. mapování neni "jisté"), a to podle následujících pravidel: 
- v H je uveden **převládající argument** (tj. argument, jehož četnost je alespoň o 10% vyšší než četnost jakéhokoli jiného argumentu), pokud lze v SSC a/nebo CEV identifikovat jediný takový argument (v případě mapování přes SSC i CEV se převládající argument musí rovnat);
- v H je uvedeno více argumentů (oddělených znakem "#"), pokud SSC a/nebo CEV udává pro daný funktor mapování na **více převládajících argumentů** (tj. argumentů, jejichž četnost se liší o méně než 10% od maximální četnosti).

Info o zdroji mapování (sloupce G-I) je uvedeno ve sloupci K -- Source. V případě, že žádné mapování navrženo není, přestože mapování v SSC a/nebo CEV k dispozici je, je důvod uveden ve sloupci J -- Info. 

##### sloupec I -- **Unambiguous SSC Mapping (other than CEV)**
Tento sloupec udává  **PB argument** podle SSC, i když se liší návrhy mapování u SSC z CEV:
- Uvádí se zde argument podle SSC, pokud má v SSC jednoznačné mapování (ignoruje se CEV, neboť anotátoři při budování SSC k CEV přihlíželi a rozhodli se ho nezohlednit).    
- Pokud se CEV a SSC liší a navíc má SSC nejednoznačné mapování, nenavrhuje se nic (a doplní se hodnote "disagree" do sloupce J -- Info on automatic mapping).

Info o zdroji mapování (sloupce G-I) je uvedeno ve sloupci K -- Source. V případě, že žádné mapování navrženo není, přestože mapování v SSC a/nebo CEV k dispozici je, je důvod uveden ve sloupci J -- Info. 

<!-- 1/ nemam namapovano SSC
        1a/ nemam namapovano CEV -> nevyplnuju nic
        1b/ mam namapovano CEV - source = "czengvallex"
            - CEV je jednoznacne -> vyplnuji sloupec G
            - CEV je nejednoznacne -> do H dam nejcetnejsi + blizka mapovani podle CEV -->

<!-- 2/ mam namapovano SSC
        2a/ nemam namapovano CEV - source = "ssc"
            - SSC je jednoznacne -> vyplnuji sloupec G
            - SSC je nejednoznacne -> vyplnuji sloupec H
        2b/ mam namapovano CEV - source = "both"
            - SSC a CEV mapovani je jednoznace a shoduji se -> vyplnuji sloupec G
            - SSC a CEV maji nejednoznacne mapovani, nicmene ta nejcetnejsi pro SSC a CEV se shoduji (tj. pokud ma SSC napr. ARG0#ARG1, musi mit CEV taky ARG0#ARG1, pokud ma CEV ARG0, tak to neberu jako shodu) - > vyplnuji sloupec H
            - SSC ma jednoznacne mapovani, ktere je ale odlisne od CEV -> SSC mapovani davam do sloupce I
            - SSC ma nejednoznacne mapovani, ktere je odlisne od CEV -> nedavam tam nic 
            (prislo mi, ze tam je "mira nejistoty" tak vysoka, ze bych to nechala radsi na anotatorovi) -->


##### sloupec J -- Info on automatic mapping
Tento sloupec udává informaci o typu problému, který neumožnil automatické mapování s dostatečnou jistotou (sloupec D), přestože SSC a/nebo CEV nějaké mapování mají: 
- **ambiguous** (159 případů) - ve sloupci H udávajícím převládající mapování jsou pro nějaký funktor minimálně dva PB argumenty, tedy ani jeden z nich není převládající;  
- **discontinuous ARGs** (371 případů) - indexy u navržených funktorů netvoří souvislou řadu (souvislá řada nemusí začínat ARG0; tj. např. ARG0, ARG1, ARG2 nebo ARG1, ARG2 atd.), zohledňují se všechny zdroje mapování (tj. sloupce - G, H, I);  
<!-- (hodnota je maximalne v jednom z nich pro každý funktor a v tomhle sloupci se zdůvodňuje, proč se hodnota z vyplněného sloupce G, H, I nepřepíše do sloupce D -->    
(ARGM se při testování souvislosti řady zahazují);
- **partial** (1 390 případů) - ne všechny funktory mají navržené mapování (i když se zohledňují se všechny sloupce - G, H, I); 
<!-- opet se divame na vsechny sloupce G, H a I, ale pokud mam pro nejaky funktor nevyplnenou hodnotu aspon v jednom z techto sloupcu, tak to beru, jakoze je mapovani celeho zpracovavaneho ramce na PB 'rozbite' a tudiz nic nedavam do sloupce -->
- **repeated ARGs** (491 případů) - některé (alespoň 2) funktory se mapují na stejný argument, zohledňují se všechny zdroje mapování;  
- **disagree** (1 101 případů) - mapování přes CEV a přes SSC se liší, navíc má SSC nejednoznačné mapování. 

<!-- Source i Info se vztahuji k celemu ramci, ne k jednotlivym funktorum. A ukladaji ruzne informace - ta Source je ten zdroj, odkud jsme mapovani ziskali, zatimco Info je informace o tom, proc se navrhovane mapovani ze sloupcu G, H a I nepresune do toho automatickeho mapovani ve sloupci D. -->

##### sloupec K -- Source
Tento sloupec udává zdroj automatického mapování (sloupec D): 

- **both** (4 606 případů) - pro alespoň jeden functor máme mapováni z CEV i ze SSC (SSC mapovani typu ACT->Speaker() se ignoruje); 
- **czengvallex** (2 412 případů) - alespoň pro jeden funktor máme mapování jenom z CEV a pro žádný funktor nemáme mapování ze SSC (SSC mapovani typu ACT->Speaker() se ignoruje);  
- **ssc** (2 340 případů) - alespoň pro jeden funktor máme mapování ze SSC a pro žádný nemáme mapování z CEV; 
- **copy** ... máme-li pro jeden UMR rámec více záznamů (viz výše sloupec B -- PDT frame), může se stát, že aktuální záznam nemá mapování, ačkoli alespoň jeden z dalších záznamů mapování má (zejm. rámce "substituted", ale i rámce patřící do různých tříd);  PROTO maji-li všechny PDT-rámce odpovídající jednomu UMR ramci, které mají definované mapovani na PB, toto mapování shodné, PROPAGUJE se toto mapovani i pro všechny PDT-rámce tohoto UMR rámce, které dosud navržené automatické mapování z CEV ani z SSC nemají.
  

<!-- V source je jenom informace o tom, kde jsme k tomu mapovani prisli, aby si mohl anotator rict, jak moc je ta informace "relevantni" - kdyz je to z obou zdroju, tak je ta informace nejhodnotnejsi, pak podle SSC a jako nejmene presnou vnimam tu z CEV (copy je pro pripad, ze dany ramec nemam ani v CEV ani v SSC, ale nejaky jeho predchudce, ktery byl timhle nahrazen, v CEV nebo SSC byl - ale protoze nevim, proc se ten ramec nahrazoval novejsim, k jakym zmenam tam doslo, davam tam informaci, ze je to jenom zkopirovane). -->




##### sloupec L -- Mapping via CzEngVallex

##### sloupce N -- Mapping via Mapping via SynSemClass5.1 (r.16488)

##### sloupce N, O, P -- skryté
Mapování přes starší verze SSC a technický sloupec pro formátování.
