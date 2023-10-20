# Mode

This attribute, adopted from AMR  represents a semantic counterpart of syntactic mood -- it serves for distinguishing statements (indicative mood) from commands (imperative mood), exclamations and questions (interrogative).

The UMR Guidelines suggest that the `:mode` attribute is annotated only for marked usages, i.e., other than statements:
- `mode` -- (not annotated) ... _Studenti přišli.ind na schůzi včas._ "The students came to the meeting in time"
- `mode` imperative ... _Přijďte.imp na schůzi včas!_ "Come to the meeting in time!"
- `mode` expressive ... in AMR, limited to marking exclamational words such as _ah, ha, hmm, oh, wow, yippee_; just two examples in the UMR guidelines but they suggest a bit wider usage of this value (e.g., _There will even be many VIPs!_ is annotated as expressive)
- `mode` interrogative ... _Přišli.ind včas?_ "Did they come in time?"



In PDT, the relevant information is stored in the **sentmod grammateme**.
- **enunc** ... indicative clauses, `mode` not annotated;
- **excl** ... exclamatory clauses, `mode` typically not annotated OR `mode` expressive;
- **desid** ... ??? optative clauses in PDT,   
 _Ať se vám daří!_ "I wish you all the best; lit. OPT REFL you.DAT do_well",  
 _Kéž by nepřišli!_ "I wish they didn't come; lit. OPT COND didn't_come.3pl",  
 _Hodně štěstí!_ "Good luck",   
 _Ať Petr pracuje na zahradě a Hanka ať se učí doma._ "Let Petr work in the garden and Hanka learn at home."
- **imper** = `mode` imperative,
- **inter** = `mode` interrogative.  

The sentmod grammateme is assigned to 
- sentence roots 
- roots of subtrees for direct speech (but should be propagated to effective roots);
- roots of subtrees of parenthetical sentences. 


In addition, PDT offers the **verbmod grammateme**, which is a tectogrammatical correlate of the morphological category of (verbal) mood.
It is assigned to all nodes representing finite verb forms (and its value is  usually on the mood category as indicated by the particular verb form): 
- **ind** for indicative (both for declarative sentences, _Studenti přišli.ind na schůzi včas._ "The students came to the meeting in time" and interrogative ones,  _Přišli.ind včas?_ "Did they come in time?"), 
- **imp** for imperative (_Přijďte.imp na schůzi včas!_ "Come to the meeting in time!"),  
- **cnd** for conditional (_My (bychom přišli).cnd určitě včas._ "We would definitely come in time"), and 
- **nil** for nodes representing infinitives, participles or transgressives (gerunds).   