---
title: Sicp Ex 1.6
date: 22/10/2020
---

This the 6th Sicp exercise. This in my opinion is a 
tricky question which takes a bit of work to figure out.
So getting to the matter:

# The Question 

**Exercise 1.6:** Alyssa P. Hacker doesn’t see why `if` needs to be
provided as a special form. “Why can’t I just define it as an ordinary
procedure in terms of cond?” she asks. Alyssa’s friend Eva Lu Ator
claims this can indeed be done, and she defines a new version of `if`:

```scheme
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
      (else else-clause)))
```

Eva demonstrates the program for Alyssa:

```scheme
(new-if (= 2 3) 0 5)
5
(new-if (= 1 1) 0 5)
0
```

Delighted, Alyssa uses new-if to rewrite the square-root program:
```
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
	  guess
	  (sqrt-iter (improve guess x)
	 	     x)))
```

What happens when Alyssa attempts to use this to compute square
roots? Explain.


# My Thoughts

Just out of curiosity, I think we should see what
does happen. Let us copy our original square roots
program to a new file and re-write it with `new-if`:

```scheme
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
      (else else-clause)));; Alyssa's new if function


(define (average x y)
  (/ (+ x y) 2)) ;; divide the sum of x and y by 2


(define (improve-guess guess x)
  (average guess (/ x guess)));; return the average of guess and guess divided by x

(define (square x)
  (* x x));; returns the square of a numeral

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.0001));; compare the guess's square and x


(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
      guess
      (sqrt-iter (improve-guess guess x)
                 x)))
  ;; if our guess is good enough, return it,
  ;;else call (sqrt-iter) with an improved guess


(define (square-root x)
  (sqrt-iter 1.0 x)) ;; Call sqrt-iter with the guess of 1

```

{: .note-box}
**Note:** If you would like the copy the Original Code,
you can obtain the snippet from my [Newton's Square roots post](https://benjamin-philip.github.io/sicp/example-square-root-by-newtons-method)

Now that we have made the file, let's load the file (scheme --load path/to/file) and let's
test it:

```
1 ]=> (square-root 4)

```

Nothing. It never ends. From this we can conclude that replacing `if` with `new-if`
results in a Never ending loop. But *why?* For that we need to compare `if` and
`new-if` in detail.

## What happens in sqrt-iter? 

In our original sqrt-iter, we checked
if the `guess` is `good-enough?` and returned
`guess` if true. **Only** if false did we evaluate
sqrt-iter once again. Thus, we can say the special form
`if` follows Normal-order evaluation. 

## What happens in new-if

If you recollect from [Ex 1.5](https://benjamin-philip.github.io/sicp/sicp-ex-1-6),
we had to compare the process involved in Ben's test when the interpreter use applicative order
evaluation. And if you recollect, User defined functions are executed with Applicative order
evaluation. The thing with applicative order evaluation is, **all** the expression in function
is evaluated. No matter if the were needed or not.

## What happens in the new sqrt-iter?

So when we are using `new-if` in `sqrt-iter`, you are left with `sqrt-iter`
calling itself forever for no good reason. So we can conclude that sqrt-iter
never ends because it's `new-if` check is being executed in Applicative order.

# The Answer

When `new-if` is called, all the expressions in it are evaluated as in it are executed in Applicative order.
Thus when implemented in sqrt-iter which is a recursive procedure, where the test (here `new-if`)
decides whether it should recur again, it recurs again. This constant recursion lead to a never-ending
loop.
