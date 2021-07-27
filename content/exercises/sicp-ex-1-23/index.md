---
title: Sicp Ex 1.23
date: 30/11/2020
---

This is the 23rd exercise from Sicp.

# The Question

**Exercise 1.23:** The smallest-divisor procedure shown at the
start of this section does lots of needless testing: After it checks to
see if the number is divisible by 2 there is no point in checking to
see if it is divisible by any larger even numbers. This suggests that
the values used for `test-divisor` should not be 2, 3, 4, 5, 6, . . . ,
but rather 2, 3, 5, 7, 9, . . . . To implement this change, define a pro-
cedure next that returns 3 if its input is equal to 2 and otherwise
returns its input plus 2. Modify the smallest-divisor procedure
to use (next test-divisor) instead of (+ test-divisor 1) .
With timed-prime-test incorporating this modified version of
smallest-divisor , run the test for each of the 12 primes found
in Exercise 1.22. Since this modification halves the number of
test steps, you should expect it to run about twice as fast. Is this
expectation confirmed? If not, what is the observed ratio of the
speeds of the two algorithms, and how do you explain the fact that
it is different from 2?

# My thoughts

The question is simple. Write a procedure `next` that returns 
`3`  if `input` is 2 and `input + 2` if odd. We then need to modify
`find-divisor` to use this change.

After all that, we need to check if this makes any diffrence.

# The Answer

This question is very simple. So I am not going to spend all my time
explaining it.

## `next`

This is the definition of `next`:

```scheme
(define (next input)
  (if (= input 2)
      3
      (+ input 2)))
```

## `smallest-divisor`

This is what smallest-divisor looks like:

```scheme

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))
```

What I have done is added a test checking if `test-divisor` is even
and if it is also not equal to 2. If it is, use `next`.

I also changed the increment value in `find-divisor` to 2.

## Checking if this makes any diffrence

Now, we check for a diffrence. Let's use the code from the previous
exercise and modify `smallest-divisor` and `test-divisor`.

```scheme
(define (next input)
  (if (= input 2)
      3
      (+ input 2)))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))
  
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (prime-range cur-val count req)
  (cond ((not (= count req))
	  (if (prime? cur-val)
	      (and (timed-prime-test cur-val)
	       (prime-range (+ cur-val 2)(+ count 1) req))
	      (prime-range (+ cur-val 2) count  req)))))

	  
(define (search-for-primes range no-of-primes)
  (prime-range (if (even? range)(- range 1) range) 0 no-of-primes))
```

Now, let's test it :

```scheme
(search-for-primes 100000000000 3)

100000000003 *** .15999999999999992
100000000019 *** .15999999999999992
100000000057 *** .1599999999999997
;Unspecified return value

```

Huge Diffrence ! What was 0.27 became 0.16 ! 0.27 divided by 0.16 is
1.6875. While, this is not 2, It is 1.7


# Answering Sicp's Questions

No, the expectation is not confirmed. The observed ratio 0.25:0.16. This
can be written as 25:16

## How do I explain this ?

I think this .04 difference can be attributed to `next`. We have a lot
more tests and evaluations happening because of, it. However, in my
opinion being 1.6 times faster is a big thing.







