---
title: Sicp Ex 1.21
date: 26/11/2020
---

This is the 21 first question from Sicp and I feel this exercise is
very simple compared to the others after this.

# The Question

**Exercise 1.21**: Use the `smallest-divisor` procedure to find the
smallest divisor of each of the following numbers: 199, 1999, 19999

# The Answer

This question is quite simple: Evaluate this code in a REPL.

So here's the code for `smallest-divisor`:

```scheme
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))
```

Here's the evaluation:

```scheme
(smallest-divisor 199)

;Value: 199

1 (user) => (smallest-divisor 1999)

;Value: 1999

1 (user) => (smallest-divisor 19999)

;Value: 7
```

A quick google search proves all these answers are correct.

--

I think this was the most easiest exercise yet.
