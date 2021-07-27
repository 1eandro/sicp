---
title: Example - Testing for Primality
date: 27/11/2020
---

This is section describes of methods for checking whether
a number `n` is prime or not. One with order of growth $\theta(\sqrt[]{n})$
and another of growth $\theta(\log n)$.

# The First method

A common way to check if a number is prime or not is by finding all
the factors of that number. Take the number 2. Its' factors are 1
and 2. Thus it is prime. Or take 6. It can be expressed as
$\times[2][3]3$ or $\times[6][1]$. So all we need to do is find if it
has factors other than 1 and itself by incrementing from 2.

But what do we do when `n` is indeed prime or if it is a decimal ?
We cannot keep incrementing till we reach till we reach `n` or
forever if `n` is infact a decimal ? One thing we can do is compare
the square of our guess (guess will be reffered to as `test-divisor`
from now) with `n`.

So here is the structure of our program:

1. if `(square test-divisor)` is greater than `n`, return true.
2. else if `test-divisor` divides `n` perfectly (remainder is 0),
   return false.
3. Otherwise increment `test-divisor` and try again.

**If** the square of `test-divisor` is infact greater than `n`, it
means that `n` is either a decimal or a it is a prime number. This is
based on the fact that if `test-divisor` is a factor of `n` then so
$\frac{n}{test-divisor}$. However `test-divisor` and
$\frac{n}{test-divisor}$ cannot both be greater than $\sqrt[]{n}$.


## The Code

This gives us the following procedure (copied from Sicp, which wasn't
returning booleans.):

```scheme

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n (+ test-divisor 1)))))
```

We can now test whether a number is prime as follows: `n` is prime if
and only `n` is its smallest divisor:

```scheme
(define (prime? n)
  (= n (smallest-divisor n)))
```


## Why this algorithm has an order of growth $\theta(\sqrt[]{n})$

The fact that either one of the factors is lesser than $\sqrt[]{n}$
means that it only needs to test for factors between 1 and $
\sqrt[]{n}$. Hence, the number of iterations is $\sqrt[]{n}$ and
the order of growth is $\theta(\sqrt[]{n})$.

# The Fermat test

The $\theta(\log n)$ primality test is based on the result from number
theory known as Fermat's little Theorem.

> **Fermat's Little Theorem:** If $n$ is a prime number and $a$ is any
> positive integer less than $n$, then $a$ raised to the
> $n^{\text{th}}$ is congruent to $a$ modulo $n$.

Just FYI:

Two numbers are said to be *congruent modulo n* if they both have the
same remainder when divided by $n$. The remainder of a number $a$ when
divided by $n$ is also reffered to as the *remainder of a modulo n* or
simply as *a modulo n*.

{: .note-box}
**Note:** I do not plan to prove this test to you. Just accept it
and carry on.

If `n` is not prime in general, most of the numbers $a < n $ will not
satisfy the above relation (with the exception of [Carmichael
numbers](https://en.wikipedia.org/wiki/Carmichael_number)). 
This gives us the following algorithm:

1. Given a number $n$, pick a random number $a < n$
2. Compute the remainder of $a^{n} \text{modulo} n$
   - If result is not equal to $a$, then $n$ is not prime.
   - Else is it most likely prime.
   
3. Pick another random number and try again (untill we are content)
   

To implement the Fermat test, we need a procedure that computes the
exponential of a number modulo another number:

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

The Fermat test is performed by choosing at random a number `a`
between 1 and $ n - 1 $ inclusive and checking whether the remainder
modulo $n$ of the $n^{\text{th}}$ power is equal to $a$. The random
number $a$ is chosen using the procedure `random`, which is assumed
to come with you Scheme installation. `random` returns a nonnegative
integer less than its integer input. 

Continuing with the Fermat test, we will use `random` to compute `a`.
We will also add 1 to the value we get:

```scheme
(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))
```

We also want to run the fermat test a certain number of times.
If the test succeeds every time, return true, else false:

```scheme
(define (fast-prime? n times)
  (cond ((= times 0) true)
	((fermat-test n) (fast-prime? n (- times 1)))
	(else false)))
```

# Probalistic methods

The Fermat test differs in character from most familiar algorithms, in
which one computes an answer that is guaranteed to be correct. Here,
the answer obtained is only possibly correct.

To be precise, we can only say that `n` is not a prime if it fails the
test.(With certain exceptions) But the fact that `n` passes the test,
while an extremely strong indication, is still not a guarantee that
`n` is infact prime.

What one should say rather is that for any number `n`, if we perform
the test enough times and find that `n` always passes the test, then
the probability than `n` is not a prime can be made as small as we
like.

Unfortunately, this assertion is not quite correct. Like I hinted
before, there exist numbers that can fool the fermat test: numbers `n`
that are not prime and yet have the property that $a^{n}$ is congruent
to `a` modulo `n` for all integers a < n. Such numbers are extremely
rare, so the Fermat test is quite reliable in practice.

There are variations of the Fermat test that cannot be fooled. one
such test tests the primality of an integer $n$ by choosing that
depends upon $n \text{and} a$. On the other hand, in contrast to the
Fermat test, one can prove that, for any $n$, the condition does not
hold for must integers unless $n$ is prime. Thus, if $n$ passes the
test for some random choice of $a$, the chances are better that even
that $n$ is prime. If $n$ passes the test for two random choices of
$a$, the chances are better than 3 out of 4 that $n$ is prime. By
running the test with more and more randomly chosen values of $a$ we
can make the probability of error as small as we like.

The existince of test for which one can prove that the chance of error
becomes arbitrarily small has sparked interest in algorithms of this
type, which have come to be known as *probalistic algorithms*. There
is a great deal of reasearch activity in this area, and probalistic
have been fruitfully applied to many fields (A good example is RSA. It
also turns out that my favourite implementation is the RSA dolphin.)
