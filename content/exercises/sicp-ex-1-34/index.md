---
title: Sicp Ex 1.34
date: 29/1/2021
---

This is the $34^{th}$ Exercise in Sicp, Here, we explain what happens
when we we try to use a number as a procedure.

# The Question

**Exercise 1.34:** Suppose we define the procedure

```scheme
(define (f g)
  (g 2))
```

Then we have

```scheme
(f square)
4
```

```
(f (lamda (z) (* z (+ z 1))))
6
```

What happens is we (perversely) ask the interpreter to evaluate the
combination `(f f)` ? Explain.

# The Answer

The function `f`, applies the parameter `g` as a function. It passes
as the parameter 2.

Thus when we passed `square` as the parameter `(square 2)` is
evaluated. 

Let's use the substitution model and find out what happens when we
pass the `f` as the parameter to itself:

```scheme
(f f)
(f 2)
(2 2)
```

As you can see, we finally try to use the integer 2 as a
function. This will cause an error. In MIT Scheme at least, it returns
the error "The object 2 is not applicable".
