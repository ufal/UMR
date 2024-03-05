# Open Issues

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
