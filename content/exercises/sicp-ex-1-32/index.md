---
title: Sicp Ex 1.32
date: 21/1/21
---

This is the $32^{th}$ exercise from Sicp. Here we create a function
that creates functions like the `sum` and `product` procedures from
the previous exercises.

# The Question

**Exercise 1.32:**  

A) Show that `sum` and `product` [Exercise 1.31](/sicp/sicp-exercise-1-31) are both special cases of a still more
   general notion called `accumulate` that combines a collection of terms
   using some general accumulation functions:
   
   ```scheme
   (accumulate combiner null-value term a next b)
   ```
   
   `acumulate` take as arguments the same term and range
   specifications as `sum` and `product`, together with a `combiner`
   procedure (of two arguments) that specifies how the current term is 
   to be combined with the accumulation of the preceding terms
   and a `null-value` that specifies what base value to use when
   the terms run out. Write `accumulate` and show how `sum` and
   `product` can both be defined as simple calls to `accumulate`.
   

B) If your `accumulate` procedure generates a recursive process,
   write one that generates an iterative process. If it generates an
   iterative process, write one that generates a recursive process.
   
# Part A

This is pretty simple question. It's all very clear. Here's me
repeating everything:

1. `acumulate` generates a function similar to the procedures that
   `sum` and `product` generate.
2. `combiner` is the operation done on every term
3. `null-value` is the value returned when `a` is greater than `b`

So now we can write `accumulate`:

```scheme
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
         (accumulate combiner null-value term (next a) next b))))
```

And defining `sum` and `product` is simple:

```scheme
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
		(accumulate combiner null-value term (next a) next b))))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))
```

and testing:

```scheme
(define (sum-integers a b)
(sum identity a inc b))

;Value: sum-integers

1 (user) => (sum-integers 1 10)

;Value: 55
```

# Part B

This too is rather simple:

```scheme
(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
	result
	(iter (next a)(combiner result (term a)))))
  (iter a null-value))
```

There you go.
