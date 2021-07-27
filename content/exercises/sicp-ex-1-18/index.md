---
title: Sicp Ex 1.18
date: 24/11/2020
---

This is the $18^{th}$ question in Sicp. And it quite similar
to the 16th question.

# The Question

**Exercise 1.18:** Using the results of [Exercise 1.16](https://benjamin-philip.github.io/sicp/sicp-ex-1-16) and [Exercise 1.17](https://benjamin-philip.github.io/sicp/sicp-ex-1-17),
devise a procedure that generates an iterative process for multiplying two intergers in the form
of adding, doubling, halving, and uses a logarithmic number of steps.

# My Thoughts

This is quite direct. Write an iterative procedure that multiplies in
a logarithmic number of steps.  A combintation of Exercise 16 and 17.

## The program structure

Look at Ex 17 for more information on the logic of how it works. Also,
look at Ex 16 for the recursive to iterative logic. Here is the summary.


Iterative logic:

- We use the variable `base` to record the value of the multiplicant.
- We use the variable `b` to record any difference to add at the end.
- We use the variable `a` to record the change.
- We use the variable `n` to record the multiplier.

Procedure logic:

- If `n` is 1, we return `(+ a b)`.
- If `n` is odd, we add base to `b` and subtract 1 from `n`.
- If `n` is even, we double `a` and halve `n`

# The Answer

This gives us the following procedure:

```scheme
(define (fast-mult b n)
  (mult-iter b 1 n b))

(define (mult-iter a b n base)
  (cond ((= n 1)
	 (+ a b))
	((even? n)
	 (mult-iter (double a) b (halve n) base))
	(else (mult-iter a (+ b base) (- n 1) base))))

(define (double n)
  (+ n n))

(define (halve n)
  (/ n 2))
```
And that was pretty easy...
