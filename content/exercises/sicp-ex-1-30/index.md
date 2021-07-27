---
title: Sicp Ex 1.30
date: 20/1/2021
---

This is the $30^{th}$ Exercise from Sicp. Here, we write an iterative
version of `sum**.

# The Question

**Exercise 1.30:** The `sum` procedure above generates a linear
recursion. The procedure can be rewritten so that the sum is performed 
iteratively. Show how to do this by filling in the missing expressions
in the following definition:

```scheme
(define (sum term a next b)
  (define (iter a result)
    (if 〈 ?? 〉
	〈 ?? 〉
	(iter 〈 ?? 〉 〈 ?? 〉 )))
  (iter 〈 ?? 〉 〈 ?? 〉 ))
```

# The Answer

This is a rather simple question so I am just gonna quickly give an
explanation and an answer:

## How `sum` works

The `sum` procedure is simple:

- if `a` is less than `b`, we apply `term` on the current result and
`next` on `a`.
- if `a` is greater than `b`, we return `result` (which is `a` in the
  recursive version)
  
## The Solution

Knowing that, we can now write the iterative procedure:

```scheme
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
	result
	(iter (next a)(+ result (term a)))))
  (iter a a))
```

## Testing

Here is what I got testing:

```scheme
(define (id x) x)

;Value: id

1 (user) => (define (inc x)(+ x 1))

;Value: inc

1 (user) => (define (sum-int a b)(sum id a inc b))

;Value: sum-int

1 (user) => (sum-int 0 10)

;Value: 55
```

