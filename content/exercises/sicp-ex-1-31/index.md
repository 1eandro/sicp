---
title: Sicp Ex 1.31
date: 21/1/21
---

This is the $31^{th}$ Exercise from Sicp. Here, we define a procedure
call `product` analogous to a `sum`. Using `product`, we define
`factorial` and compute approximations of $\pi$

# The Question

**Exercise 1.31:**  
A) The sum procedure is only the simplest of a vast number of
   similar abstractions that can be captured as higher-order
   procedures. Write an analogous procedure called product
   that returns the product of the values of a function at points
   over a given range. Show how to define factorial in terms of
   product . Also use product to compute approximations to π
   using the formula

$$ \frac{\pi}{4} = \frac{2 \cdot 4 \cdot 4 \cdot \cdot 6 \cdot 6 \cdot
8 ...}{3 \cdot 3 \cdot 5 \cdot 5 \cdot 7 \cdot 7 ...} $$

B) If your `product` procedure generates a recursive process, write
   one that generates an iterative process. If it generates an iterative
   process, write a recursive process.

# Part b

`product` is basically sum, but instead of summing, we multiply. So
all we need to do is replace "+" with "*" and "0" with 1.

The recursive `sum`:

```scheme
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))
```

The recursive `product`:

```scheme
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))
```

The iterative `sum`:

```scheme
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
	result
	(iter (next a)(+ result (term a)))))
  (iter a a))
  ```
  
The iterative `product`:

```scheme
(define (product term a next b)
  (define (iter a result)
    (if (> a b)
	result
	(iter (next a)(* result (term a)))))
  (iter a a))
```

# Part A

Now that we have `product`, we can define `factorial` and approximate
$\pi$. 

## `factorial`

Factorial is similar to the `sum-integers` the authors showed us. It
is essentially the product of a range of integers as opposed to the sum
of a range.

```scheme
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (id x) x)
(define (inc x)(+ x 1))

(define (factorial x)
  (product id 1 inc x))
```

On testing:

```scheme
(factorial 2)

;Value: 2

1 (user) => (factorial 3)

;Value: 6

1 (user) => (factorial 20)

;Value: 2432902008176640000
```

## Aproximating $\pi$

This was the formula given to us:

$$ \frac{\pi}{4} = \frac{2 \cdot 4 \cdot 4 \cdot \cdot 6 \cdot 6 \cdot
8 ...}{3 \cdot 3 \cdot 5 \cdot 5 \cdot 7 \cdot 7 ...} $$

We can rewrite it as this:

$$
\begin{align}
  \frac{\pi}{4} &= \frac{2 \cdot 4 \cdot 4 \cdot \cdot 6 \cdot 6 \cdot 8 ...}{3 \cdot 3 \cdot 5 \cdot 5 \cdot 7 \cdot 7 ...} \\
  \pi &= 4 \times \frac{2 \cdot 4 \cdot 4 \cdot \cdot 6 \cdot 6 \cdot 8 ...}{3 \cdot 3 \cdot 5 \cdot 5 \cdot 7 \cdot 7 ...} \\
  &= 4 \times 2 \times \frac{(4 \cdot 6)^{2} \times 8}{(3 \cdot 5 \cdot 7)^{2}} \\
  &= 8 \times \frac{(4 \cdot 6)^{2} \times 8}{(3 \cdot 5 \cdot 7)^{2}} \\
\end{align}
$$

## Writing a Procedure to find the fraction

Now all we need to do is, write a procedure that finds the product of
a range, incrementing by 2. This is similar to the factorial
implementation, except that we supply the "ending point" and we
increment by 2.

```scheme
(define (inc x)(+ x 2))
(define (id x) x)
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (product-range a b)
  (product id a inc b))
```

### Testing the above procedure:

Testing the procedure proves that it works prefectly fine:

```scheme
1 (user) => (product-range 1 7)

;Value: 105

1 (user) => (product-range 4 8)

;Value: 192

1 (user) => (product-range 1 9)

;Value: 945

1 (user) => (product-range 6 10)

;Value: 480
```

However:

```scheme
1 (user) => (product-range 1 10)

;Value: 945

1 (user) => (product-range 2 11)

;Value: 3840
```

We can't have odd and even integers together. So our program is not
foolproof:

We can however, implement a wrapper to the procedure to deal with this.

### Writing a wrapper for our procedure

I chose to favour `b`. So, if `a` is of the opposite type, I
incremented `a` by 1. This how everything looks like in the end: 

```scheme
(define (inc x)(+ x 2))
(define (id x) x)
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (product-range a b)
  (product id a inc b))

(define (fact-range a b)
  (if (or (and (even? a)(even? b))(and (odd? a)(odd? b)))
      (product-range a b)
      (product-range (+ a 1) b)))
```

and testing:

```scheme
(fact-range 1 4)

;Value: 8

1 (user) => (fact-range 2 7)

;Value: 105
```

Great! It works!

## Writing a procedure to a approximate $\pi$

Now that we have a got a script to find the product of a range, we can
now write a procedure to approximate $\pi$.

Some things to note before we start:

1. We need to make to sure the diffrence between `a` and `b` in `fact-range`for
   the denominator is greater than the numerator's diffrence by 2.

2. After finding the square of `fact-range` we have to multiply the numerator by `n` (or
   `n + 1` if odd)

2. We will multiply the numerator by 8.0 so as to avoid scheme
   registering the division as a rational fraction, which may lead to
   some complications (So we are going to get our approximations in
   decimals). **note:** also notice that I have changed all the
   instances of integer to float. This is so that scheme will not have
   to make an integer to float conversion.

3. We will input an integer `n` from which we will find the range.

Here is the entire script in the end:

```scheme
(define (inc x)(+ x 2.0))
(define (id x) x)
(define (product term a next b)
  (if (> a b)
      1.0
      (* (term a)
         (product term (next a) next b))))
p
(define (product-range a b)
  (product id a inc b))

(define (fact-range a b)
  (if (or (and (even? a)(even? b))(and (odd? a)(odd? b)))
      (product-range a b)
      (product-range (+ a 1.0) b)))

(define (pi n)
  (/ (* (square(fact-range 4 (- n 2.0)))
	8.0
	(if (even? n)
	    n
	    (+ n 1.0)))
   (square (fact-range 3 (- n 1.0)))))
```

### Testing

So far it has been great. 

```scheme
(/ 22.00 7.00) ;; This is the value of pi

;Value: 3.142857142857143

1 (user) => (pi 10)

;Value: 3.3023935500125976

1 (user) => (pi 100)

;Value: 3.1573396892175696

1 (user) => (pi 150)

;Value: 3.1520820239779646

1 (user) => (pi 170)

;Value: 3.1508461800759857
```

However:

```scheme

1 (user) => (pi 185)

It's been nice interacting with you!
Press C-c C-z to bring me back.
```

By the time we cross 170, we crash. Though, I am not sure why this is
happening (probably the float is becoming to large).

## Optimizing `pi`

Instead of computing the square of both the numerator and denominator
and then dividing, we can divide and then square, and then multiplying
by 8.0. We can also replace most of the floats with integers.

```scheme
(define (inc x)(+ x 2))
(define (id x) x)
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (product-range a b)
  (product id a inc b))

(define (fact-range a b)
  (if (or (and (even? a)(even? b))(and (odd? a)(odd? b)))
      (product-range a b)
      (product-range (+ a 1) b)))

(define(pi n)
  (* (square (/ (fact-range 4 (- n 2))
	      (fact-range 3 (- n 1))))
	8.0
	(if (even? n)
	    n
	    (+ n 1.0))))

```

testing:

```scheme
(/ 22.0 7.0) ;; This is the value of pi

;Value: 3.142857142857143

1 (user) => (pi 10)

;Value: 3.3023935500125976

1 (user) => (pi 100)

;Value: 3.1573396892175656

1 (user) => (pi 1000)

;Value: 3.143163842419198

1 (user) => (pi 100000)

;Value: 3.1416083615923305
```

However, too high a value

```
1 (user) => (pi 100000000)

;Aborting!: maximum recursion depth exceeded
```

If you look carefully, you will notice that the ***depth*** has been
exceeded. This is probably because we use the recursive `sum`. We
probably will be able manage higher values with the iterative version
of `sum`. (Though is will good long time cause this way of computing
pi is rather inefficient)


