## Discourse relations

Discourse relations are annotated in three different ways? 

#### 1. Using an abstract concept with `:op1`, `:op2`, ... relations

For example, _and_ in (4b) in Part 3-1-6:
```
In addition to having your hand stamped, you have to show your ticket to get into the concert. / You have to have your hand stamped and show your ticket stub to get into the concert.
(a/ and	
   :op1 (h/ have-04	
   	:ARG0 (p/ person
		:ref-person 2nd	
		:ref-number Singular)
	:ARG1 (s/ stamp-01
		:ARG0 (p2/ person)
		:ARG1 (h2/ hand	
			:part p)
		:aspect Performance	
		:modstr PrtAff)	
	:aspect Performance	
	:modstr PrtAff)	
   :op2 (s2/ show-01
   	:ARG0 p	
	:ARG1 (t/ ticket
		:poss p	
		:ref-number Singular)
	:ARG2 (p3/ person)
   	:aspect Performance	
	:modstr PrtAff)	
   :purpose (g/ get-05	
   	:ARG0 p	
	:ARG2 (c/ concert
		:ref-number Singular)
	:aspect Performance	
	:modstr FullAff)
```

#### 2. Using an abstract roleset with `:ARG1`, `:ARG2`, ... 

For example,  _contrast-91_ in  4-1-1 (2):
```
He is very possessive and controlling but he has no right to be as we are not together.
(c/ contrast-01
      :ARG1 (a/ and
            :op1 (p/ possessive-03
                  :ARG0 (p/ person
		  	:ref-person 3rd
			:ref-number Singular)
                  :degree (v/ very)
		  :aspect State
		  :modstr FullAff)
            :op2 (h/ have-mod-91
                  :ARG1 p
		  :ARG2 (c2/ controlling)
                  :degree (v/ very)
		  :aspect State
		  :modstr FullAff))
      :ARG2 (r/ right-05
            :ARG1 p
            :ARG2 a
            :ARG1-of (c3/ cause-01
                  :ARG0 (h2/ have-mod-91
		  	:ARG1 (p2/ person
				:ref-person 1st
				:ref-number Plural)
			:ARG2 (t/ together)
			:aspect State
			:modstr FullNeg))
            :aspect State
	    :modstr FullNeg))
```

#### 3. Incorporating one event as child of another event via the relation `

For example, `:pure-addition` in (4b) in Part 3-1-6:
```
In addition to having your hand stamped, you have to show your ticket to get into the concert. / You have to have your hand stamped and show your ticket stub to get into the concert.
(h/ have-04
	:ARG0 (p/ person
	     :ref-person 2nd
	     :ref-number Singular)
	:ARG1 (s/ stamp-01
	     :ARG0 (p2/ person)
	     :ARG1 (h/ hand
	          :part p)
		 :aspect Performance
	     :modstr PrtAff)
    :aspect Performance
    :modstr PrtAff
    :pure-addition (s2/ show
	     :ARG0 p
         :ARG1 (t/ ticket
	          :poss p
              :ref-number Singular)
		 :ARG2 (p3/ person)
         :aspect Performance
         :modstr PrtAff)
    :purpose (g/ get-05
         :ARG0 p
	     :ARG2 (c/ concert
	            :ref-number Singular)
		 :aspect Performance
	     :modstr FullAff))
```
