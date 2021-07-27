---
title: "Example: Square roots by Newton's Method"
date: 2020/10/20
---

All the Procedures explained previously were much like
ordinary Mathematical functions. However in Mathematics, 
we are usually concerned with declarative (what is) descriptions.
We soon reach issues when deriving procedure from their 
Mathematical definition. Consider the definition of the 
Square root:

$ \sqrt{x} = $ the *y* such that $ y \geq 0 $ and $ ^{2} = x $

The above is a perfectly legitimate mathematical function **BUT** doesn't
tell use *how* to compute the sqrt.

# Computing Square Roots

So how does one compute square roots ? Of the many methods,
the most prominent of these is Newton's Method. The main idea
is that we can get a better a guess of the square root of number `x`
with the guess `x` by:

1. Taking the Quotient of x/y
2. and assigning `x` to the average of the `Quotient` and `x`

So For example the sqrt of `2` with the guess `1`:

Guess|Quotient|Average|
:----|:-------|:------|
1| (2/1) = 2| ((2 + 1)/2) = 1.5|
1.5| (2/1.5) = 1.3333| ((1.3333 + 1.5)/2) = 1.4167|
1.4167| (2/1.4167) = 1.4118| ((1.4167 + 1.4118)/2) = 1.4142|
1.4167| ,,,| ...|

# Writing a scheme procedure

Continuing with this process, we obtain better and better approximations of the square root.
However we must have a test to check to accuracy of the root so as to stop the process at a 
certain accuracy and prevent a hit on the recursion limit.

## The Iterative process

Let's us define the square root procedure which will call itself (recur) until our test returns true:

```scheme
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
  guess
  (sqrt-iter (improve guess x)
    x)))

```

The procedure `sqrt-iter` has two parameters: `guess` and `x`. `guess`
stands for the current guess and `x` for the number whose root we want
to find. 

We fist check if the guess is accurate enough with the help of the 
function `good-enough?` (defined later). If it is, we return guess.
Else, we call `sqrt-iter` again. However we pass the param `guess`
with the value of `(improve-guess guess x)` (function defined later)
and `x` as `x` itself..

This process of a function calling itself is called recursion.

## Improving a guess

We next will define the procedure for improving a guess:

```scheme
(define (improve-guess guess x)
  (average guess (/ x guess))
```

Where average is:

```scheme
(define (average x y)
  (/ (+ x y) 2))
```

In `improve-guess`, the guess (`guess`) is averaged by guess divided by the
number whose root we want to find (`x`).

## Checking the Accuracy of a guess

We now have to define a test `good-enough` that will
check if the guess is accurate enough. One such way
is to check the difference between the square of the 
current guess and `x` . Let's make that into scheme 
code:

```scheme
(define (good-enough? guess x)
 (< (abs (- (square guess) x)) 0.0001))
```

Here we take the absolute value of the difference of the square guess and x and
compare it with 0.0001. If it the difference is smaller, `#t` is returned.
`#t` is Scheme for the Boolean `True`. Else `#f` which is `False`.


## Writing the wrapper procedure

When we want to find to square root, we don't want to supply
`sqr-iter` with a guess. Instead, we will write a function that
will call `sqrt-iter` with a default guess. Usually, this standard
guess is one:

```scheme
(define (square-root  x)
  (sqrt-iter 1.0 x))
```

{: .note-box}
**Note:** Notice how we pass 1.0 instead of 1
to sqrt-iter. This so that 1, when divided doesn't 
become a rational no. (fraction)

# The Entire Script

We can now combine these functions to form a `.scm` file:

```scheme
(define (average x y)
  (/ (+ x y) 2)) ;; divide the sum of x and y by 2


(define (improve-guess guess x)
  (average guess (/ x guess)));; return the average of guess and guess divided by x

(define (square x)
  (* x x));; returns the square of a numeral

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.0001));; compare the guess's square and x


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
# Running our program

Now notice that our `good-enough?` procedure will check if the 
difference between the square of guess and x is 0.0001.
This is okay for normal size number but isn't accurate enough for
Larger numbers and small numbers. Hence, some leniency is required.

Running this on MIT/GNU Scheme:

```
1 ]=> (square-root 4)

;Value: 2.0000000929222947

```

Of course this isn't correct but an approximate answer.
If we square our square root we get:

```
1 ]=> (square (square-root 4))

;Value: 4.000000371689188
```

Which shouldn't be the Answer. However, this is only off by 
from the 6th decimal point.

If you try to find the square root of
0.0005, you will get:

```
1 ]=> (square-root 0.005)

;Value: 2.25070568342295233-2
```

And when we square the root:

```
1 ]=> (square (square-root 0.0005))
;Value: 5.065676073392379e-4
```

Which is utter bull considering the level of accuracy we gave.
(We had given `0.0005` and not `0.0005065676073392379`)

Similarly for `1234567890987654321234567890`:

```
1 ]=> (square-root 1234567890987654321234567890)
...
```

Nothing. Which goes to say that our test is hopeless when computing small numbers
and larger numbers. This issue will be taken care of in [Ex 1.7.](https://benjamin-philip.github.io/sicp/sicp-ex-1-7) 

