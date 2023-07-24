# Ellipsis

## Implicit events

**Implicit concepts** may have to be added when something can be inferred
from the context but the corresponding linguistic material is absent. [Part
3-1-1-4](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-1-4-implicit-events)
of the guidelines introduces **implicit events.** They are either copies of
events mentioned earlier (gapping), or just understood from other context.

Rule 1: Be conservative. When in doubt, do not add an implicit event.

Rule 2: Do not be unnecessarily specific. For example, when a movement is
understood in English, use the _go_ concept but not more specific ones like
_sail_ or _fly_, unless it is really clear that these are correct.

### Location at the beginning of a news article

* _ESTONSKO:_ “ESTONIA:” (meaning: “The location where the events described
below occurred is Estonia.”)

We should probably use the abstract concept `have-location-91` ([Part
3-1-1-3](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-1-3-states-and-entities)).
Its ARG1 is the theme (see Table 8 in [part
3-1-3-6](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-3-6-non-verbal-clauses)
and in
[3-2-1-1-1](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-2-1-1-1-non-verbal-clauses)),
its ARG2 is the location.

Examples of have-location-91: (2b) in
[3-1-6](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-1-6-discourse-relations),
(1d) in
[3-2-1-1-1](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-2-1-1-1-non-verbal-clauses),
(1c) and (1e) in
[3-3-1-3](https://github.com/umr4nlp/umr-guidelines/blob/master/guidelines.md#part-3-3-1-3-state).

Perhaps we should use an abstract event as the theme and later make it
coreferential with the actual events described in the article?

```
ESTONSKO:
(h/ have-location-91
    :ARG1 (e/ event)
    :ARG2 (c/ country
        :wiki "Q191"
        :name (n/ name :op1 "Estonsko")))
```

## Other implicit concepts?
