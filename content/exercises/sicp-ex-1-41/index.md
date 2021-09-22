---
title: Exercise 1.41
date: 2021-09-22
weight: 141
id: 141
---

This is the $41^{th}$ question in SICP.

# The Question

**Exercise 1.41:** Define a procedure double that takes a procedure of one
argument as argument and returns a procedure that applies the original procedure
twice. For example, if `inc` is a procedure that adds 1 to its argument, then
`(double inc)` should be a procedure that adds 2. What value is returned by

```scheme
(((double (double double)) inc) 5)
```

# The Answer

`double` is very simple. So, if we give a procedure of `inc`, we would get `(inc
(inc x))`. This outlines the following procedure:

```scheme
(define (double f)
  (lambda (x) (f (f x))))
```

and testing:

```scheme
> ((double inc) 1)
3
```

So it works.

Now to see what would happen in the case what the authors propose:

```scheme
> (((double (double double)) inc) 5)
21
```

That's it!
