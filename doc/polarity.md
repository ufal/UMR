# Polarity

The UMR Guidelines treat polarity in two ways: 
- **propositional negation** is annotated within the modal dependency annotation at the document level), and
- the `polarity` attribute (adopted from AMR) marks any morphosyntactic indicators of negation within a sentence (which do not necessarily signal semantic negation!!)

* [en] _unhealthy food_ (3-3-3 (1a))

```
(t/ thing
	:ARG1-of (e/ eat-01)
	:mod (h/ healthy
		:polarity -))
```


ad food-related discussion:

* [en] 3-2-1-1 (6a) _He gave the cat some wet **food**._
```
He gave the cat some wet food.
(g/ give-01  
	:actor (p/ person
		:ref-person 3rd
		:ref-number Singular)  
	:theme (f/ food
		:mod (w/ wet)
		:quant (s/ some))  
	:recipient (c/ cat
		:ref-number Singular)
	:aspect Performance
	:modstr FullAff)
```