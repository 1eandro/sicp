---
title: Sicp Ex 1.5
comments: true
date: 2020/10/20
tags: [SICP, Scheme, Lisp]
---

This is the 5th Exercise of SICP. Here we compare a process 
when run on a Applicative order interpreter and when run on 
a Normal-order interpreter. 

# The Question

**Exercise 1.5:** Ben Bitdiddle has invented a test to determine
whether the interpreter he is faced with is using applicative-order
evaluation or normal-order evaluation. He defines the following
two procedures:

```scheme
(define (p) (p))
(define (test x y)
(if (= x 0) 0 y))
```
Then he evaluates the expression
`(test 0 (p))`

What behavior will Ben observe with an interpreter that uses
applicative-order evaluation? What behavior will he observe with
an interpreter that uses normal-order evaluation? Explain your
answer. (Assume that the evaluation rule for the special form if
is the same whether the interpreter is using normal or applicative
order: The predicate expression is evaluated first, and the result
determines whether to evaluate the consequent or the alternative
expression.)

# Thoughts 

The first function `(p)` returns the character "p".
The second function returns `0` if the the first parameter
`x` is equal to 0. Else, returns `y`, the second parameter.

In Ben's example `(test 0 (p))` the integer '0' will be returned 
whichever the interpreter whether Applicative or Normal Order.

## What is Normal order evaluation?

In Normal order evaluation, the interpreter only executes
a function until the return value is required by a primitive 
procedure. 

For example the function `sum-of-squares` will be run as follows:

$$ (sum-of-squares (square (+ 5 1))(/ 121 11)) $$
$$ \Rightarrow (+ (square (square (+ 5 1))) (square (/ 121 11))) $$
$$ \Rightarrow (+ (* (square (+ 5 1)) (square (+ 5 1))) (* (/ 121 11) (/ 121 11)) $$
$$ \Rightarrow (+ (* (* (+ 5 1) (+ 5 1))(* (+ 5 1) (+ 5 1)))(* 11 11)) $$
$$ \Rightarrow (+ (* (* 6 6) (* 6 6))(121)) $$
$$ \Rightarrow (+ (* 36 36) 121) $$
$$ \Rightarrow (+ 1296 121) $$
$$ \Rightarrow 1417 $$

Over here, (/ 121 1) is evaluated twice and (+ 5 1) A whopping 4 times!
So we come to the question:

## What is Applicative Order Evaluation?

In Applicative Order Evaluation, the Interpreter immediately evaluates an expression. 
So for example:

$$ (sum-of-squares (square (+ 51))(/ 121 11)) $$
$$ \Rightarrow (sum-of-squares (square 6) 11) $$
$$ \Rightarrow (sum-of-squares 36 11) $$
$$ \Rightarrow (+ (square 36) (square 11)) $$
$$ \Rightarrow (+ 1296 121) $$
$$ \Rightarrow 1417 $$

As we can see, Applicative Order takes 5 steps while Normal Order takes 7.

# The Answer

From Ben's Test, in normal order evaluation the behavior will be as follows:

$$ (test 0 (p)) $$
$$ 0 ;; 0 is returned because x = 0 $$

And for Applicative Order:

$$ (test 0 (p)) $$
$$ (test 0 p) $$
$$ 0 ;; 0 is returned because x = 0 $$

So here, p is evaluated but not used and hence in this case, 
Normal order evaluation will be more efficient.
