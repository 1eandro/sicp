---
title: Sicp Ex 1.4
date: 2020/10/20
tags: [Lisp, Scheme, SICP]
---
This the 4th Exercise in SICP

# The Question

**Exercise 1.4:** Observe that our model of evaluation allows for 
more combinations whose operators are compound expressions. Use this
observation to describe the behavior of the following procedure:

```scheme
(define (a-plus-abs-b a b)
  ((if (> b 0) + - ) a b))
```

# The Answer 

Now in this case, all that is being done is:

1. Check if b is positive or negative
2. And run (+ a b) if b is positive, or run (- a b) if negative.

In the if statement, notice that it is surrounded by two brackets 
instead of one. This is how the returned function is run.

So in short:

If b is larger than 0 (positive) (+ a b) is returned, Else (- a b) is returned.
