---
title: Sicp Ex 1.29
date: 16/1/2021
---
This is the $29^{th}$ exercise in Sicp. Here, we a write a procedure
to compute integrals using (Homer) Simpson's rule. 

# The Question

**Exercise 1.29:** Simpson’s Rule is a more accurate method of
numerical integration than the method illustrated above. Using
Simpson’s Rule, the integral of a function f between a and b is
approximated as

$$\frac{h}{3}\big(y_{0} + 4y_{1} + 2y_{2} + 4y_{3} + 2y_{4} +
... 2y_{n - 2} + 4y_{n - 1} + y_{n} \big) $$

where $h = (b - a)/n$, for some even integer $n$, and $y_ {k} =
f (a + kh)$. (Increasing $n$ increases the accuracy of the ap
proximation.) Deﬁne a procedure that takes as arguments
$f$ , $a$, $b$, and $n$ and returns the value of the integral, com
puted using Simpson’s Rule. Use your procedure to inte
grate `cube` between 0 and 1 (with $n = 100$ and $n = 1000$),
and compare the results to those of the `integral` procedure.

# Things to do before starting

First of all, I cannot possibly dream of explaining what integrals
are here. So, if you don't know what they are, search for "integral
calculus". Here is a quick refresher of terminology:

- $a$ is starting point.
- $b$ is ending point.
- $dx$ or delta x, is a really (infinitesimally) small change in x
- $f$ is "function of" and is a function in maths

$$\int_{a}^{b} f = \bigg[f\bigg(a + \frac{dx}{2}\bigg) + f\bigg( a + dx + \frac{dx}{2} + ... \bigg) \bigg]dx$$

# How it would work in our program

What happens is simple:

$\frac{h}{3}$ is multiplied by the stuff in the brackets, where $h$ is
$(b - a) \div \text{even} n$. The stuff in brackets is $y$ if $k$ is 0
or equal to $n$, $4y$ if odd, and $2y$ if $k$ is even. In each of
those cases, $y$ is $f(a + kh)$

One thing we could do is, we could find the sum of the stuff in the
parantheses using `sum`. After we have found the answer, we would
multiply it by $\frac{h}{3}$. In sum, we would `term` each element.

So to conclude:

1. $h = (b - a) \div n$
2. $y = f(a + k \times h)$
3. Each element is:
   - $y$ if k is 0 or equal to $n$
   - $2y$ if even
   - $4y$ if odd
4. We multiply the sum of elements by $\frac{h}{3}$

# Our Solution

I have split this to 2 parts - `term` and `simpons`
 
## `term`

We first need to know how to compute $h$. However, since it will never
change, we will store it as a variable :

```scheme
(define h (/ (- b a)n))
```

Then we need to know how to compute $y$:

```scheme
(define (find-y k) 
    (f (+ a (* k h))))
```

We now need to find each element:

```scheme
(define (find-element k)
(define (find-y) 
  (f (+ a (* k h))))
(* (cond ((or (= k 0) (= k n)) 1)
	 ((even? k) 2)
	 ((else 4))) (find-y)))
```


## `simpsons`

Now that we have found what we would have in `term`, we have to write
the `simpsons` procedure.

### Defining `sum`

This is rather simple. We just copy/paste the code the authors gave
us.

```scheme

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
	 (sum term (next a) next b))))
```

### `next`

For `next` we will increment. So:

```scheme
(define (inc n)
  (+ n 1))
```

### The Whole thing:

Now that we have `term`, `next` and `sum` defined, we have to define
`simpsons`:

```scheme
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))
		 
(define (simpsons f a b n)
  (define h (/ (- b a) n))
  (define (find-element k)
    (define (find-y)
    (f (+ a (* k h))))
    (* (cond ((or (= k 0) (= k n)) 1)
	     ((odd? k) 4)
	     (else 2))
       (find-y)))
  (define (inc n)
    (+ n 1))
  (/ (* h (sum find-element 0 inc n)) 3))
```


Let's run it :

```scheme
(simpsons cube 0 1 100.00)

;Value: .24999999999999992

1 (user) => (simpsons cube 0 1 1000.00)

;Value: .2500000000000003
```

Quite clearly, Simpson's Rule is more accurate than the integral
formula the authors use previously.

