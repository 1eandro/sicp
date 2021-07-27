---
title: Sicp Ex 1.28
date: 2/12/2020
---

This is the 28th Exercise from Sicp. Here we implement an unfoolable
version of the Fermat test called the Miller Rabin Test.

# The Question

**Exercise 1.28:** One variant of the Fermat test that cannot be fooled
is called the *Miller-Rabin* test (Miller 1976; Rabin 1980). This starts
from an alternate form of Fermat’s Little Theorem, which states
that if $n$ is a prime number and $a$ is any positive integer less than $n$
,then a raised to the $( n − 1)$-st power is congruent to 1 modulo *n* . To
test the primality of a number n by the Miller-Rabin test, we pick a
random number $a < n$ and raise $a$ to the $( n − 1)$-st power modulo
$n$ using the expmod procedure. However, whenever we perform the
squaring step in expmod , we check to see if we have discovered a
“nontrivial square root of 1 modulo $n$ ,” that is, a number not equal
to 1 or n − 1 whose square is equal to 1 modulo n . It is possible to
prove that if such a nontrivial square root of 1 exists, then $n$ is not
prime. It is also possible to prove that if $n$ is an odd number that
is not prime, then, for at least half the numbers $a < n$ , computing
$a n− 1$ in this way will reveal a nontrivial square root of 1 modulo $n$ .
(This is why the Miller-Rabin test cannot be fooled.) Modify the
expmod procedure to signal if it discovers a nontrivial square root
of 1, and use this to implement the Miller-Rabin test with a proce-
dure analogous to fermat-test . Check your procedure by testing
various known primes and non-primes. Hint: One convenient way
to make expmod signal is to have it return 0.

# My thoughts

Hmm... This question is more challenging than the previous few. 

The way the Miller Rabin Test works, is that it looks for a nontrivial
square-root of 1 modulo `n` inplace of the squaring step in
`expmod`. If it isn't a non-trivial ..., We square the number and
continue, else, we know that `n` is not a prime number. 

# The Answer

We now, need to write a procedure that checks if a number is a
non-trivial square root of 1 modulo 1. If we do find one, we signal 0
and stop.

## Non-trivial sqrt

> we check to see if we have discovered a
> “nontrivial square root of 1 modulo n ,” that is, a number not equal
> to 1 or n − 1 whose square is equal to 1 modulo n .

This gives us a breig idea of how to check for a not trivial square
root. Here is the scheme code for it :

```scheme
(define (not-trivial? n num)
  (if (and (= (square n)(remainder 1 n)) (not (and (= num 1)(= num (- n 1)))))
      #t
      #f))
```

We can make a function that square if a numbers in trivial and returns
0 if not trivial:

```scheme
(define (check n num)
  (if (not-trivial? n num)
      0
      (square num )))
```

## Redefing `expmod`

This is the current code for `expmod`:

```scheme
(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((even? exp)
	 (remainder (square (expmod base (/ exp 2) m))
		    m))
	(else
	 (remainder (* base (expmod base (- exp 1) m))
		    m))))
```

This is the difficult part. What we can do is, check the value. At the remainder bit,
we check if our value is 0. If it is, we return 0, and if it isn't we
just do the remainder. At the end, `expmod` returns 0 if there is a
non-trivial square root. We shall get to that soon.

We can use this for the remainder bit. This checks if the value is
zero and act accordingly:

```scheme
(define (trivial-mod num mod)
  (if (= num 0)
      0
      (remainder num mod)))
```

And now define expmod:

``` scheme
(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((even? exp)
	 (trivial-mod (check (expmod base (/ exp 2) m) base)
		    m))
	(else
	 (trivial-mod (* base (expmod base (- exp 1) m))
		    m))))
```

## Final Product

This is the Final Product:

```scheme
(define (fast-prime? n times)
  (cond ((= times 0) true)
	((fermat-test n) (fast-prime? n (- times 1)))
	(else false)))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((even? exp)
	 (trivial-mod (check (expmod base (/ exp 2) m) base)
		    m))
	(else
	 (trivial-mod (* base (expmod base (- exp 1) m))
		    m))))

(define (trivial-mod num mod)
  (if (= num 0)
      0
      (remainder num mod)))

(define (check n num)
  (if (not-trivial? n num)
      0
      (square num )))

(define (not-trivial? n num)
  (if (and (= (square n)(remainder 1 n)) (not (and (= num 1)(= num (- n 1)))))
      #t
      #f))
```

And checking it gives:

```scheme
(fast-prime? 561 3)

;Value: #f

1 (user) => (fast-prime? 1105 3)

;Value: #f

1 (user) => (fast-prime? 3 3)

;Value: #t
```
