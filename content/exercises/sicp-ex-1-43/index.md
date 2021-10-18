---
title: Exercise 1.43
date: 2021-09-23
weight: 143
id: 143
draft: true
---

This is the $43^{rd}$ question in SICP.

# The Question

**Exercise 1.43:** If $f$ is a numerical function and $n$ is a positive integer,
then we can form the $n^{th}$ repeated application of $f$, which is defined to
be the function whose value at $x$ is $f(f(...(f(x)) ...))$. For example, if $f$
is the function $x \mapsto x + 1$, then the $n^{th}$ repeated application of $f$
is the function $x \mapsto x + n$. If $f$ is the operation of squaring a number,
then the $n^{th}$ repeated application of $f$ is the function that raises its
argument to the $2^{n}$-th power. Write a procedure that takes as inputs a
procedure that computes $f$ and a postive integer $n$ and returns the procedure
that computes then $n^{th}$ repeated application of f. Your procedure should be
able to be uses as follows:

```scheme
((repeated square 2) 5)
625
```


Hint: You may find it convenient to use `compose` from Exercise 1.42

# The Answer

In this exercise, we need to write a procedure that apply it self $n$ times.
Much like Exercise 1.41's `double`, instead $n$ is not constant.

## Using `compose`

The authors hint that we may find `compose` useful. Let us start with that. How
would we manually write something like that? Simple! We just use `compose` and
input the same function twice:

```scheme
> ((compose inc inc) 0)
2
```

What about applying it thrice? We just compose another function supplying `inc`
and the above function:

```scheme
> ((compose inc (compose inc inc)) 0)
3
```

What would happen if we create a function using `(compose inc inc)` as `f` and
`g`? Well we will just get a function that applies the procedure 4 times:

```scheme
((compose (compose inc inc) (compose inc inc)) 0)
4
```

How about applying the procedure 8 times? We just compose a function with
`(compose (compose inc inc) (compose inc inc))`:

```scheme
((compose (compose (compose inc inc) (compose inc inc)) (compose (compose inc inc) (compose inc inc))) 0)
8
```

## Formulating a general rule

Now, the most easiest thing to do is write a recursive $\mathcal{0}(n)$

The above outlines a general rule. Let $n$ be the number of times a function is
applied. Every time we apply a function created by compose on itself, we square
$n$. This is very similar to how we computed exponents with `fast-expt` in
Exercise 16. Let us have a value `new-f` for any new function that is passed
every recursion. This gives us the following rule:

1. If `n` is 1, we return
```scheme
(lamda (x) (f x))
```

2. Else if `n` is odd, we do 

```scheme
(compose f (repeated f (- n 1)))
```

3. Else if `n` is even, we divide `n` by two and apply the `new-f` twice.

## Implementing our rule


