---
title: Sicp Ex 1.24
date: 1/12/2020
---

This is the 24th question from Sicp. And yet again, I feel this is a
really easy question.

# The Question

**Exercise 1.24:** Modify the `timed-prime-test` procedure of Exercise
1.22 to use `fast-prime?`(the Fermat method), and the test each of the
12 primes you found in that exercise. Since the Fermat test has
$\theta(\log n)$ growth, how would you expect the time to test primes
near 1,000,000 to compare with the time needed to test primes near
1000? Do your data bear this out? Can you explain any discrepancy you
find?

# My thoughts

This is yet another easy question. I think the current objective is to
teach us how to write scheme code, not how to think like a
programmer. Oh, well. I suppose we'll get to that soon.

# The Answer

I have split the answer into 2 parts:

## The Procedure

We need to make the `timed-prime-test` use the Fermat test instead of
our homebrewed test. This is quite simple. What we have to do is
define `fast-prime?` and modify `timed-prime-test` . Let's do that :

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

(define (fast-prime? n times)
  (cond ((= times 0) true-)
	((fermat-test n) (fast-prime? n (- times 1)))
	(else false)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 3)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

```

## Testing

Let us try using it now. Since, it is log n, the time taken should be
approximately equal for every prime. I also modified
`search-for-primes` from the previous exercise.

Here are the results:

```scheme
(search-for-primes 100 3)

101 *** 0.
103 *** 0.
107 *** 0.
;Unspecified return value

1 (user) => (search-for-primes 1000000000000 3)

1000000000039 *** 0.
1000000000061 *** 0.
1000000000063 *** 0.
;Unspecified return value

1 (user) => (search-for-primes 1000000000000000000000000 3)

1000000000000000000000007 *** 0.
1000000000000000000000049 *** 0.
1000000000000000000000121 *** 0.
;Unspecified return value
```

Quite clearly the fermat test works.
