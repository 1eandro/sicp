---
title: Sicp Ex 1.22
date: 27/11/2020
---

This the 22nd quesion in Sicp. I feel that this question is much more
interesting than lot of the others, because we finally get play with
the `runtime` ! (I wonder how you interfer with memory management.)

# The Quesion

**Exercise 1.22:**  Most Lisp implementations include a primitive
called `runtime` that returns an integer that specifies the amount
of time the system has been running (measured, for example,
in microseconds). The following timed-prime-test procedure,
when called with an integer `n` , prints `n` and checks to see if `n` is
prime. If `n` is prime, the procedure prints three asterisks followed
by the amount of time used in performing the test.

```scheme
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
```

Using this procedure, write a procedure `search-for-primes` that
checks the primality of consecutive odd integers in a specified
range. Use your procedure to find the three smallest primes larger
than 1000; larger than 10,000; larger than 100,000; larger than
1,000,000. Note the time needed to test each prime. Since the
p testing algorithm has order of growth of $\theta(\sqrt[]{n})$, you
should expect that testing for primes around 10,000 should take about
$\sqrt[]{10}$ times as long as testing for primes around 1000. Do your
timing data bear this out? How well do the data for 100,000 and
1,000,000 support the $\theta(\sqrt[]{n})$ prediction? Is your result
compatible with the notion that programs on your machine run in time
proportional to the number of steps required for the computation?

# My Thoughts

(-- awe struck --) They wrote the runtime code for us ? Oh, well.

Now, getting to the matter, we need to do the following things:

- Write a procedure `search-for-primes` that checks the primality of
  consecutive odd integers in a specified range.
  
- We need to use `search-for-primes` to find the three smallest primes
  larger than 1000; larger than 10,000; larger than 100,000; larger
  than 1,000,000
  
- We need to use the data we got for 100,000 and 1,000,000 and support
  our claim the the order of growth is root n.
  
- We need to decide if our result is compatible with the notion that
  that programs run in time proportional to the number of steps
  required for the computation on my machine (Which is WSL)

# The Answer

I have decided to spilt the answer to 4 parts, addressing the 4 points:

## Writing the procedure

So we need to iterate between the order numbers of a given *range* .
But what exactly is a *range* ?

### What exactly is a range ?

A range is computed knowing the following:

1. The first number
2. The Last number
3. The increment value

Typically (atleast in python) there's a function to compute an iterable of
numbers. (I am not sure if `range` class can be treated like a list.)
What happens is that the `range` does the following (something like this):

1. Take the last number (in the beggining this is the first number)
2. Increment it by the increment value and append it to the list (Or
   something like that)
3. If this new number incremented in less than the last number loop

The problem in our case is that we need to compute all the consecutive
odd integers. So we can't specify an increment value. Also, we always
start from the number 1. So the only number we need to supply is the
last value.

The defaults are :

1. first number - 1
2. increment value - 2

### Implementing a range

So we now have a vague Idea of what we should do. In lisp, we do
something like this (the `timed-prime-test` function is imperative
like so I took the liberty of something imperative):

`cond` the current value is less than the last value, do x.
`cond` the current value incremented is less than the last value, call
this function again.

```scheme

(define (range cur-val last-val)
  (cond ((< cur-val last-val)
	 (display cur-val))) ;; displaying cur-val instead of do x
  (cond ((< (+ cur-val 2) last-val)
	(range (+ cur-val 2) last-val))))
```


Checking this in Geiser gives the following :

```
(range 1 10)
13579
;Unspecified return value
```

Showing that it works.

### Searching for primes in a range

We now need to take use this range function and implement it to use
`timed-prime-test`. Let's just quickly check if `test-prime` works:

```
(timed-prime-test 73)

73
;Unbound variable: prime?
;To continue, call RESTART with an option number:
; (RESTART 3) => Specify a value to use instead of prime?.
; (RESTART 2) => Define prime? to a given value.
; (RESTART 1) => Return to read-eval-print level 1.

```

Let's quickly define `prime?` and try again.

```scheme
(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n (+ test-divisor 1)))))

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

```

This what I get:

```
(timed-prime-test 100271)

100271 *** 0.
;Unspecified return value
```

So I assume is works. We might need a larger prime number in-order to
check time though.

Now let's change `range` to `prime-range`:

```scheme
(define (prime-range cur-val last-val)
  (cond ((< cur-val last-val)
	 (timed-prime-test cur-val)))
  (cond ((< (+ cur-val 2) last-val)
	(prime-range (+ cur-val 2) last-val))))
```

Now, we can define `search-for-primes`:

```scheme
(define (search-for-primes range)
  (prime-range 1 range))
```

Now, let's test it.


```
(search-for-primes 100)
1 *** 0.
3 *** 0.
5 *** 0.
7 *** 0.
9
11 *** 0.
13 *** 0.
15
17 *** 0.
19 *** 0.
21
23 *** 0.
25
27
29 *** 0.
31 *** 0.
33
35
37 *** 0.
39
41 *** 0.
43 *** 0.
45
47 *** 0.
49
51
53 *** 0.
55
57
59 *** 0.
61 *** 0.
63
65
67 *** 0.
69
71 *** 0.
73 *** 0.
75
77
79 *** 0.
81
83 *** 0.
85
87
89 *** 0.
91
93
95
97 *** 0.
99
;Unspecified return value
```

So now this is cool and all, but now, how do we compute 3 primes
numbers larger than a given number ?

### Finding primes larger than a given number

We now have to find a prime number *larger* than a given a number.
The problem here is that we don't have a definite number to end
with. One thing, we could do to deal with that is guessing a random
number larger than the given number. But there exists a much more
elegant solution.

Now, we want only three prime numbers. We could make a certain test
asking "If we haven't found three prime-numbers yet, loop". This makes
things much simpler. But how do we know, if a number is prime or
not? - the `timed-primes` procedure doesn't return a value. So we have
two options : 

1. Make `timed-primes` return `#t` or `#f`
2. Do the `primes?` test again

We are going to go with the second option. While, the first option is
more efficient, we don't want to use `timed-primes` as a test as it
has a completly diffrent purpose. Doing so, is like smearing white
paint on a priceless painting for the sake of it being lighter in
shade. A much better thing to do is keeping it under better light.

Now, we need to change how range works. Here's a good description of
what we need:

> `cond` we haven't found three primes, do `(timed-primes cur-val)
> again.
> If we found a prime, increment count by 1 and cur-val by 2
> Else just loop with cur-val incremented by 2

Now, that will give us this:

```scheme
(define (prime-range cur-val count req)
  (cond ((not (= count req))
	  (timed-prime-test cur-val)
	  (if (prime? cur-val)
	      (prime-range (+ cur-val 2)(+ count 1) req)
	      (prime-range (+ cur-val 2) count  req)))))

	  
(define (search-for-primes range no-of-primes)
  (prime-range (if (even? range)(- range 1) range) 0 no-of-primes))

```

Testing it gives use this:

```
1 (user) => (search-for-primes 100 3)

99
101 *** 0.
103 *** 0.
105
107 *** 0.
;Unspecified return value
```

However, there's a way we can only test run `timed-prime-test` only
when the current value is prime. This procedure takes less screen
space and also more efficient:

```scheme
(define (prime-range cur-val count req)
  (cond ((not (= count req))
	  (if (prime? cur-val)
	      (and (timed-prime-test cur-val)
	       (prime-range (+ cur-val 2)(+ count 1) req))
	      (prime-range (+ cur-val 2) count  req)))))
```

And testing is gives this:

```
(search-for-primes 100 3)

101 *** 0.
103 *** 0.
107 *** 0.
;Unspecified return value
```

Much cleaner! We are now ready to do go the next few parts of the
Exercise.

## Use our procedure

We now need to find the first 3 primes greater than:

1. 100
2. 1,000
3. 10,000
4. 100,000
5. 1,000,000

So the results:

100 :

```scheme
(search-for-primes 100 3)

101 *** 0.
103 *** 0.
107 *** 0.
;Unspecified return value
```

1,000:

```scheme
(search-for-primes 1000 3)

1009 *** 0.
1013 *** 0.
1019 *** 0.
;Unspecified return value

```

10,000: 

```scheme
(search-for-primes 10000 3)

10007 *** 0.
10009 *** 0.
10037 *** 0.
;Unspecified return value
```

100,000:

```scheme
(search-for-primes 100000 3)

100003 *** 0.
100019 *** 0.
100043 *** 0.
;Unspecified return value
```

1,000,000:

```scheme
(search-for-primes 1000000 3)

1000003 *** 0.
1000033 *** 0.
1000037 *** 0.
;Unspecified return value
```

Sicp, is an old book, and technology has improved. So, what I think we
should do, is find for larger values.

10,000,000:

```scheme
(search-for-primes 10000000 3)

10000019 *** 1.9999999999999574e-2
10000079 *** 0.
10000103 *** 0.
;Unspecified return value
```

100,000,000:

```scheme
(search-for-primes 100000000 3)

100000007 *** 1.0000000000001563e-2
100000037 *** 0.
100000039 *** 0.
;Unspecified return value
```

1,000,000,000

```scheme
(search-for-primes 1000000000 3)

1000000007 *** 1.9999999999999574e-2
1000000009 *** 2.9999999999997584e-2
1000000021 *** 1.9999999999999574e-2
;Unspecified return value
```

10,000,000,000

```scheme
(search-for-primes 10000000000 3)

10000000019 *** .08000000000000185
10000000033 *** .08000000000000185
10000000061 *** .0799999999999983
;Unspecified return value
```

100,000,000,000 

```scheme
(search-for-primes 100000000000 3)

100000000003 *** .25
100000000019 *** .2699999999999996
100000000057 *** .26000000000000156
;Unspecified return value
```

Now, we have some information we can use.

# Is our claim true ? (Conclusion)

Judging from the values we got from 100,000,000,000 I say yes.

$\sqrt[]{100000000003} =  316,227.7660215813$. $\sqrt[]{100000000019}
= 316,227.7660468796$. Their quotient is 1.

0.25 / 0.2699999999999996 = ~0.92592592596021947874.

So, our claim is true !! At least in my machine.
  
  
  
Please let me know, if I did anything wrong. I really appreciate
feedback .
