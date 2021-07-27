---
title: Sicp Ex 1.7
date: 2020/10/22
---

In Ex 1.7, we redefine the `good-enough?` test from
the [Newton's Square roots] (https://benjamin-philip.github.io/sicp/example-newtons-square-root)
example inorder to make
it compatible will small numbers and very large numbers.

# The Question

**Exercise 1.7:** `The good-enough?` test used in computing square
roots will not be very effective for finding the square roots of very
small numbers. Also, in real computers, arithmetic operations are
almost always performed with limited precision. This makes our
test inadequate for very large numbers. Explain these statements,
with examples showing how the test fails for small and large numbers. 
An alternative strategy for implementing `good-enough?` is to watch
how `guess` changes from one iteration to the next and to
stop when the change is a very small fraction of the guess. Design
a square-root procedure that uses this kind of end test. Does this
work better for small and large numbers?

# My thoughts 

This exercise is an attempt to fix the problems we faced in [Newton's square roots example](https://benjamin-philip.github.io/sicp/example-newtons-square-root)
We found that the `good-enough?` test was pathetic at returning 
accurate results (i.e in the level of accuracy given) for small
numbers and in the case of larger numbers, just took too long.

## An alternative strategy

If you read the latter parts of the question, you notice that
another way of testing if our guess is good enough? is to
stop when the changes are very minute i.e, The changes are 
only a certain fraction of the guess. This helps as the number
of iterations for smaller numbers increases (which increases accuracy)
and the iterations for larger numbers decreases (which decreases accuracy
as we don't need such precision for larger numbers.)

If we re-write this in simple language this would be:

Divide `guess` by the difference of it and it's improvement 
and check if it  it is lesser than a given amount. 

## Rewrite good-enough?

We can now copy our square-roots file (`cp path/to/file /path/to/new-file`)
and change `good-enough?`. We shall take the "given number" as 0.0001.

```scheme
(define (good-enough? guess x)
  (< (/ (- (improve-guess guess x) guess) guess) 0.0001))
```

This gives us the script:

```scheme
(define (average x y)
  (/ (+ x y) 2)) ;; divide the sum of x and y by 2


(define (improve-guess guess x)
  (average guess (/ x guess)));; return the average of guess and guess divided by x

(define (square x)
  (* x x));; returns the square of a numeral


(define (good-enough? guess x)
  (< (/ (- (improve-guess guess x) guess) guess) 0.0001))


(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve-guess guess x)
                 x)))
  ;; if our guess is good enough, return it,
  ;;else call (sqrt-iter) with an improved guess


(define (square-root x)
  (sqrt-iter 1.0 x)) ;; Call sqrt-iter with the guess of 1

```

Now let us run it and see how it works:

```
1 ]=> (square-root 4)

;Value: 2.5
```

Now 2.5 is obviously wrong. The problem is the moment the guess, is greater than
or equal to the real square root, `(/ (- (improve-guess guess x) guess) guess)`
returns a negative number, In the case where `guess = 2.5 , x = 4`, 
I got `-.1800000000000000000008 as the answer. 

Trying `(/ (- guess (improve-guess guess x)) guess)` was quite the opposite:
I was getting negative numbers for numbers lesser than the square root. However,

## Fixing good-enough?

So how do you fix `good-enough?` one option is to compare the **absolute value**
of the division. So let's try that:

```scheme
(define (good-enough? guess x)
 (< (abs (/ (- (improve-guess guess x) guess) guess) 0.0001))
```

```
1 ]=> (square-root 256)

;Value: 16.00000352670594
```

Now that's what we want! 


# The Answer

Yes. Yes it does..
