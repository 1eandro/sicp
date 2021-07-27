---
title: Sicp Ex 1.27
date: 2/12/2020
---

This is the 27th question from Sicp. Here we just Run a procedure.

# The Question

**Exercise 1.27:** Demonstrate that the Carmichael numbers listed in
Footnote 1.47 really do fool the Fermat test. That is, write a proce-
dure that takes an integer n and tests whether a n is congruent to
a modulo n for every a < n , and try your procedure on the given
Carmichael numbers.

# My thoughts

This is also rather simple. We just need to use the Fermat Test and
prove that is is fooled by the Carmichael numbers. Here is Footnote 47
for out reference.

> Numbers that fool the Fermat test are called Carmichael numbers, and little
> is known about them other than that they are extremely rare. There are 255
> Carmichael numbers below 100,000,000. The smallest few are 561, 1105, 1729,
> 2465, 2821, and 6601. In testing primality of very large numbers chosen at random,
> the chance of stumbling upon a value that fools the Fermat test is less than the
> chance that cosmic radiation will cause the computer to make an error in carrying
> out a “correct” algorithm. Considering an algorithm to be inadequate for the first
> reason but not for the second illustrates the difference between mathematics and
> engineering.

# The Answer

This is the Fermat test :

```scheme
(define (expmod base exp m)
(cond ((= exp 0) 1)
      ((even? exp)
 (remainder (square (expmod base (/ exp 2) m))
	   m))
(else
 (remainder (* base (expmod base (- exp 1) m))
	   m))))
	 	   
(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))
```

And here is what I got from the REPL:

```scheme
(fermat-test 561)

;Value: #t

3 error> (fermat-test 1105)

;Value: #t

3 error> (fermat-test 1729)

;Value: #t

3 error> (fermat-test 2465)

;Value: #t

3 error> (fermat-test 2821)

;Value: #t

3 error> (fermat-test 6601)

;Value: #t
```

There you go. The Carmichael numbers fool the Fermat test.

