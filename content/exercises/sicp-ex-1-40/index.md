---
title: Exercise 1.40
date: 2021-09-17
weight: 140
id: 140
---

This is the $40^{th}$ question in SICP.

# The Question

**Exercise 1.40:** Define a procedure `cubic` that can be used together with the
`newtons-method` procedure in expressions of the form:

```scheme
(newtons-method (cubic a b c) 1)
```

to approximate zeros of the cubic $x^{3} + ax^{2} + bx + c$.

# The Answer

In order to solve this question, we need to understand **what exactly** is
Newton's method.

## Newton's Method

In Newton's method, what essentially happens is a fixed point search to find
$g(x) = 0$. 

Inside, a derivative function $Dg$ of the form:

$$
Dg(x) = \frac{g(x + dx) - g(x)}{dx}
$$

where $g$ is the function the user inputs, and $d$x is a small number is used to
create a function of the form:

$$
f(x) = x - \frac{g(x)}{Dg(x)}
$$

A fixed point function is then done on **this** function $f(x)$
to find $g(x) = 0$

## Writing `cubic`

Now that we have got what Newton's method is in place, we can now start thinking
about about `cubic`.

Since, all we need to do is approximate zeros of the polynomial $x^{3} +
ax^{2} + bx + c$, we do not need to worry about anything other than writing a
function acceptable to Newton's Method as of right now.

`cubic` will be of the form `(cubic a b c)` to approximate $x^{3} + ax^{2} +
bx + c$. And because all we need to do is write a function of Newton's Method,
we just need return a `lambda` with `a`, `b`, and `c` hard coded. This means
cubic is the following:

```scheme
(define (cubic a b c)
  (lambda (x)(+ (cube x) (* a (square x)) (* b x) c)))
```

## Testing cubic

For simplicity's sake, let's just let `a`, `b`, `c` be 1. Thus, we get the
following simplification: $x^{3} + x^{2} + x + 1$. So a few example inputs for
`x`:

1. For $x = 1$, we will get 4.
2. For $x = 2$ we will get 15.
3. For $x = 3$ we will get 40.

Let us test the above scenarios:

```scheme
> ((cubic 1 1 1) 1)
4
> ((cubic 1 1 1) 2)
15
> ((cubic 1 1 1) 3)
40
```

## Writing a function to find the zero

Now that we have got `cubic`, all we need to do a procedure to find the zero.
This is as simple as:

```scheme
(define (zero a b c)
  (newtons-method (cubic a b c) 1))
```

## Testing

Let us take some random numbers for `a`, `b`, `c`. Perhaps 1, 2, and 3.
Let's see what is the result we get:

```scheme
1 *** 1
2 *** 5.714266429257542e-06
3 *** -1.4999839284734562
4 *** -1.3043428073335799
5 *** -1.276209090923146
6 *** -1.27568238137649
-1.2756822036498454
```

And now trying that with the function return by `cubic`:

```scheme
> ((cubic 1 2 3) -1.275)
0.002953125000000334
```

And that's it!
You can find my source file [here](cubic.scm) 
