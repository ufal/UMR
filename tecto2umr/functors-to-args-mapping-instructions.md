## Mapování PDT valenčních rámců (a jednotlivých funktorů) na Rolesets v UMR / PropBank (a jejich argumenty)  

Dostupné mapování je uvedeno v [Google tabulce](https://docs.google.com/spreadsheets/d/1AuIASjkdAdKom7bgjDN5BxMKeRUefHlN/edit#gid=452142481): 
- v sloupci **TODO:???** je návrh získaný automatickým převodem z SSC a CzEnVallexu, pokud byl tento převod "jistý" (více viz níž);
- v sloupci **TODO:???** doplňte svůj návrh, pokud automatický návrh neexistuje či s ním nesouhlasíte; též zde můžete opravit návrh kolegy, pokud s ním nesouhlasíte;
- v případě jakékoliv úpravy okomentujte v sloupci **TODO:???**. 

### Struktura tabulky

##### sloupec A -- **UMR ID**:  
Udává ID pro valenční rámec českého slovesa. 

##### sloupec B -- **PDT frame**:  
 Jeden UMR rámec může odpovídat více PDT rámcům, pak mu odpovídá více záznamů (= několik řádků pro ramec a jeho funktory). 
Je tomu tak v následujících případech:
-  V CzEngVallexu a někde i v SSC jsou rámce, které byly v PDT-C nahrazeny novými; nahrazené rámce zde mají uvedeno "substituted" a odkaz na nový rámec (i řetězově nahrazovaný).   
Pro snazší orientaci mají takové rámce šedé pozadí a NEPRACUJEME s nimi.
-  Jeden PDT rámec může být navázán na více tříd -- pak je v tabulce samostatný záznam   pro každou třídu, ve které se rámec vyskytuje.

##### sloupec C -- **Role mapping**: 
Tento sloupec udává: 
- číslo **SSC třídy**, a to pokud se daný rámec vyskytuje v nějake SSC třídě, 
- **sémantické role** odpovídající jednotlivým funktorům (na řádcích odpovídajících jednotlivým funktorům)   
(EF: upozorňuji, že asi v 90 případech máme nejednoznačné mapování funktorů na role třídy -- tady jsem se o automatické mapování radši zatím vůbec nepouštěla; můžu kdyžtak poslat jejich seznam, jinak se daji vyfiltrovat (_měly by to být řádky, které ve sloupci C obsahují středník_)

##### sloupec D -- **Mapping**: 
Tento sloupec udává **PB argument**, u kterého jsme si "jisti" mapováním: 
- Buď existují mapování z **CzEngVallexu** i **SSC** a tahle dvě mapování jsou **shodná**.       
(Pracuje se pouze se SSC verze 5.1 - měla by být bohatší než verze 5.0 a bohatší a přesnější než ta stará, ale lze to přepočítat i pro verzi 5.0, kdybychom to chtěli mít nad nějakou fixní verzí.)
- Za "jisté" se též považuje, pokud existuje **jednoznačné mapování** (tj. funktor jen na jeden argument z PB) **jenom z jednoho zdroje** (jenom z CzEngVallexu nebo jenom ze SSC). 

##### sloupec E -- **Suggested mapping**: ???TODO:OPRAVDU TO TAKTO CHCEME
Tento sloupec udává **PB argument**, který však není "jistý":
- Pokud má argument jednoznačné mapování ??TODO:ODKUD??, uvádí se jenom ten nejčetnější argument (_v případě více hodnot se stejnou četností uvedeny obě, oddělené znakem "#"_).

##### sloupec F -- **Mapping without CzEngVallex**
Tento sloupec udává **PB argument**, i když se liší návrhy mapování u CzEngVallexu a SSC:
- Uvádí se argument podle SSC, pokud má v SSC jednoznačné mapování (ignoruje se ??TODO:~~SSC~~CzEngVallex)   
Pokud se CzEngVallex a SSC liší a navíc má SSC nejednoznačné mapování, nenavrhuje se nic :).

##### sloupec G -- Finální mapování s odfiltrováním duplicit a nesouvislých indexů u argumentů 
TODO:???

##### sloupec I -- Informace o typu problému, který znemožnil návrh mpování 
TODO:???


##### sloupec H --> J - mapováni pres CzEngVallex
##### sloupec I, J, K --> K, L, M - mapovani pres SSC5.1, SSC5.0 a stary SSC 
(EF: ten starý by tam byt asi ani nemusel)

