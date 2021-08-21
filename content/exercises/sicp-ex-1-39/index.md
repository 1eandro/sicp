---
title: Exercise 1.39
date: 2021-08-21
---

This is the $39^{th}$ exercise in Sicp. In this exercise we write a procedure for `tan`.

# The Question

**Exercise 1.39:** A continued fraction representation of the
tangent function was published in 1770 by the German mathematician J.H. Lambert:

$$
\tan x = \frac{x}{1 - \frac{x^{2}}{3 - \frac{x^{2}}{5 - ...}}}
$$

where $x$ is in radians. Define a procedure `(tan-cf x k)` that computes an approximation
to the largest tangent function based on Lambert's formula. `k` specifies the number of terms
to compute, as in Exercise 1.37.

# The Answer

Yet another problem based on the `cont-frac` procedure.

## Finding $N_{i}$

Let us first find a function for $N_{i}$. As you can see, only the first instance is $x$;
the rest $x^{2}$. This gives the following procedure:

```scheme
(lambda (i)(if (= i 1)x(* x x)))
```

We need to replace `x` with the value of well, x. That shouldn't be a problem because
`x` will be in scope.

## Finding $D_{i}$

Now we need to define a procedure for $D_{i}$. If you look closely they are consecutive
even numbers. This gives us the following procedure:

```scheme
(lambda (i)(- (* i 2) 1))
```

## Putting this all together

We now need to put this all together. Since we have the various bits and pieces ready,
all that's needed is writing a simple wrapper like below:

```scheme
(define (tan x k)
  (cont-frac (lambda (i)(if (= i 1)x(* x x))) (lambda (i)(- (* i 2) 1)) k))
```

Now all you need to do is copy the `cont-frac` code into this file.

And testing:

```scheme
(tan 0.2618 10)
0.2559783613322121
```

*Note:* 0.2618 radians is 15 degrees.

That's pretty close!
