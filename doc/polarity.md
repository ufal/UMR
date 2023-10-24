# Polarity

The UMR Guidelines treat polarity in two ways: 
- **propositional negation** is annotated within the modal dependency annotation at the document level), and
- the `polarity` attribute (adopted from AMR) marks any morphosyntactic indicators of negation within a sentence (which do not necessarily signal semantic negation!!)

[en] _unhealthy food_ (3-3-3 (1a))

```
(t/ thing
	:ARG1-of (e/ eat-01)
	:mod (h/ healthy
		:polarity -))
```


