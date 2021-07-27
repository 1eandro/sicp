---
title: Sicp Ex 1.33
date: 21/1/22
---

This is the $33^{rd}$ exercise from Sicp. Here, we write an even more
general version of `accumulate`.

# The Question

**Exercise 1.33:** You can obtain an even more general version of
`accumulate` [Exercise 1.32](/sicp/sicp-ex-1-32) by introducing the
notion of a *filter* on the terms to be combined. That is, combine
only those terms derived from values in the range that satisfy a
specified condition. The resulting `filtered-accumulate` abstraction
takes the same arguments as accumulate, together with an additional
predicate of one argument that specifies the filter. Write
`fitered-accumulate` as a proceedure. Show how to express the
following using `filtered-accumulate`:

A) the sum of the squares of the prime numbers in the interval `a` to
   `b`(assuming that you have a `prime?` predicate already written)

B) the product of all the positive integers less than *n* that are
   relatively prime to *n* (i.e., all positive integers *i* < *n* such
   that GCD(*i*, *n*) = 1)
   

# `filtre-accumulate`

`filtre-accumulate` is basically `accumulate` but combine `(term a)`if a
term satisfies a certain condition or combine the null-value with the
next recursion. It will have an extra parameter called `filtre` which
is the test we perform on every term.

```scheme
(define (filtre-accumulate filtre combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (if (filtre a)
		    (term a)
		    null-value)
		(filtre-accumulate filtre combiner null-value term (next a) next b))))
```

# Part A

This is rather simple as well. Here, we have `prime?` as `filtre`,
`+` as `combiner` and `square` as term.:

```scheme
;; some prerequisites

(define (inc x)(+ x 1))
(define (square x)(* x x))

(define (filtre-accumulate filtre combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (if (filtre a)
		    (term a)
		    null-value)
		(filtre-accumulate filtre combiner null-value term (next a) next b))))

;; functions for prime?

(define (prime? n)
   (define (smallest-divisor n)
      (define (find-divisor n test-divisor)
         (define (next x)
            (if (= x 2) 3 (+ x 2)))
         (define (divides? a b)
            (= (remainder b a) 0))
         (cond ((> (square test-divisor) n) n)
               ((divides? test-divisor n) test-divisor)
               (else (find-divisor n (next test-divisor)))))
      (find-divisor n 2))
   (= n (smallest-divisor n)))

;; sum-of-squares-of-primes

(define (sum-of-squares-of-primes a b)
  (filtre-accumulate prime? + 0 square a inc b))
```

## Testing

Let's take a few examples:

1. $2^{2} + 3^{2} = 13$
2. $2^{2} + 3^{2} + 5^{2} + 7^{2} = 87$

```scheme
(sum-of-squares-of-primes 2 4)

;Value: 13

1 (user) => (sum-of-squares-of-primes 2 9)

;Value: 87
```

# Part B

Here, we need to find all the positve integers less than `b` that
together form
[coprimes](https://en.wikipedia.org/wiki/Coprime_integers).

This is rather simple. We just use the `gcd` procedure given to us by
the authors sometime before. If `(gcd a b)` equals to 1, it's coprime.
If they are coprime, we multiply them.

## `coprime?`

Let's start by defining `coprime?`

```scheme
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (coprime? a b)
  (= (gcd a b) 1))
```

Let's test it. Here are few numbers that have no common factors
(coprimes):

1. 3, 4
2. 4, 5
3. 5, 6

```scheme
(coprime? 3 4)

;Value: #t

1 (user) => (coprime? 4 5)

;Value: #t

1 (user) => (coprime? 5 6)

;Value: #t

1 (user) => (coprime? 3 6)

;Value: #f
```


## The whole picture

Now we can define `product-of-coprimes`. `product-of-coprimes` will
have one parameter `b`. We will give 1 as `a` to
`filtre-accumulate`. (All positive integers less than *n* remember ?)

**Note:** Here, `coprime?` will not have the second parameter as
`filtre` is only given oneparameter that is `a`. So, I am going to
access the value of `b` via lexical scoping.

```scheme
(define (filtre-accumulate filtre combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (if (filtre a)
		    (term a)
		    null-value)
		(filtre-accumulate filtre combiner null-value term (next a) next b))))

(define (id a )
  a) ;; identity

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (product-of-coprimes b)
  (define (coprime? a)
    (= (gcd a b) 1))
  (filtre-accumulate coprime? * 1 id 1 inc b))
```

## Testing

Here is a few test.

1. Coprimes less than 3 are 2. So 2 is the product 
2. Coprimes less than 4 are 3. So 3 is the product
4. Coprimes less than 5 are 2, 3, 4. So 24 is the product.
5. Coprimes less than 10 are 3, 7, 9. So 189 is the product

```scheme
(product-of-coprimes 3)

;Value: 2

1 (user) => (product-of-coprimes 4)

;Value: 3

1 (user) => (product-of-coprimes 5)

;Value: 24

1 (user) => (product-of-coprimes 6)

;Value: 5

1 (user) => (product-of-coprimes 10)

;Value: 189
```

So there you go. Ex 1.33. Next we will work on Lamda the ultimate, and let.
