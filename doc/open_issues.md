# Open Issues

## Sentence level annotation

### 1. (Grammatical) number

The attribute `:refer-number` is used to annotate "grammatical number marking". According to the guidelines, both `:refer-number` and `:refer-gender` "can apply to any entity concept." (Part Part 3-3-5. Ref) 

For Czech, we have decided **to enter it explicitly even for the singular values** with all nouns and (personal) pronouns. We apply this also with abstract entities and with named entities (their abstract concepts, not with names).

**BUT:** What about a NE denoting 1 entity with a plural :name (as in Zbabělci)                                                      or Philippines (1 country) (no number is given in the English data)  
 - Dan proposes the following solution: 
   -  if the form says you the number and you agree with that from the semantic point of view, write there the number as you feel it.
   -  if you are not sure, write there “?” so that these examples can be found later.

--> base the refer-number annotation on **grammatical form** (following the UMR Guidelines)  
 - PDT ... number grammateme based on semnatics ... for future use!!!

### 2. Gender
Dan: Do we need a gender as a semantic feature?   
Šárka: yes, we (in Czech) need it to be able to imagine the situation!  
Dan: yes, if we know the biologic gender, we should annotate it.  
Julia: NOT annotated so far - need of deeper typological analysis.  

### 3. How to annotate apposition? 
Compare ex. 4-1-2 (2b):  
* [en] _The loan, a sum of 12.5 million US dollars, is an export credit …_
```
(i/ identity-91                              #the loan is an export credit
    :ARG1 (t/ thing
        :ARG1-of (l/ loan)                   #the loan
        -------
        :ARG0-of (i2/ identity               #[the loan] = a sum of 12.5 million US dollars
			:ARG1 (m/ monetary-quantity
				:quant 12500000
				:unit (d/ dollar
					:mod (c/ country
						:wiki "United_States"
						:name (n/ name :op1 "US")))))
        -------)
    :ARG2 (c2/ credit 		                 #export credit
		:mod (e/ export-01)
		...)
...)
```

### 4. How to annotate parenthesis?

## Document level annotation

### 1. 1st person corresponding to `author` in modal annotation?
In sentences like "I do something" we have a 1st person node, represented by the personal pronoun for 1st person (either singular or plural).
In doc-level annotation, and specifically in modal annotation, does it correspond to `author` or not?

Examples from guidelines and released data are not clear. See `English_umr-0004.txt`:


```
Snt13: But I don’t think you see the apron at first.

modal ((root :modal author)
        (author :neutral-negative s13s))
```
There is no node for the first person. `s13s` is the *see-01* event, which depends directly on `author`.

BUT:

```
Snt14: I don’t know it that’s important or not.

modal ((root :modal author)
        (author :full-affirmative s14p)
        (s14p :NEG s14k))
```
`author` is explicitly linked to `s14p`, the node for *I* (person, 1st singular).

More examples of 1st person can be found in `English_umr-0005.txt` (e.g. snt14, snt21, snt28). However it is an interview, so everything is embedded in a *say* event. Hence, `author` does not correspond to the 1st singular pronoun but points to *Marsha*, the interviewee.
