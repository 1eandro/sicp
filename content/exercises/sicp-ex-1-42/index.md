---
title: Exercise 1.42
date: 2021-09-22
weight: 142
id: 142
---

This is the $42^{th}$ question in SICP.

# The Question

**Exercise 1.42:** Let $f$ and $g$ be two one-argument functions. The
*composition* $f$ after $g$ is defined to be the function $x \mapsto f(g(x))$.
Define a procedure `compose` that implements composition. For example, if `inc`
is a procedure that adds 1 to its argument,

```scheme
((compose square inc) 6)
49
```

# The Answer

The above proposed `compose` is similar to the last exercise's `double`.
However, rather than applying the same function twice, we apply 2 different
functions, the first after the second. This description gives us the following
function:

```scheme
(define (compose f g)
  (lambda (x) (f (g x))))
```

and testing:

```scheme
> ((compose square inc) 6)
49
> ((compose square inc) 1)
4
> ((compose square inc) 3)
16
```

And it works!
