---
title: Sicp Ex 1.8
date: 2020/10/22
---

In this Exercise, we write a procedure for cube roots.
But, it is not very different from the square-root procedure.

# The Question

**Exercise 1.8:** Newton’s method for cube roots is based on the fact
that if y is an approximation to the cube root of x, then a better
approximation is given by the value:
$$ \frac{x/y^{2} + 2y}{3} $$  
Use this formula to implement a cube-root procedure analogous
to the square-root procedure.

# My thoughts and The Answer

This Exercise is very simple: All we have to do 
is change the `improve-guess` from [Ex 1.7](https://benjamin-philip/sicp/sicp-ex-1-7)
So let's re-write `improve-guess` for our needs:

```scheme
(define (improve-guess guess x )
 (/ (+ (* 2 guess ) (/ x (square guess))) 3))
```

All we are doing is we are converting the above
formula into scheme. Here is the full code: I took
the liberty of renaming some of the procedures.

```scheme
(define (improve-guess guess x )
  (/ (+ (* 2 guess ) (/ x (square guess))) 3));; New improve-guess


(define (square x)
  (* x x));; returns the square of a numeral


(define (good-enough? guess x)
  (< (abs(/ (- (improve-guess guess x) guess) guess)) 0.0001))


(define (curt-iter guess x)
  (if (good-enough? guess x)
      guess
      (curt-iter (improve-guess guess x)
                 x)))
;; if our guess is good enough, return it,
;;else call (curt-iter) with an improved guess


(define (cb-root x)
  (curt-iter 1.0 x)) ;; Call curt-iter with the guess of 1
```

Let us test it:

```
1 ]=> (cb-root 8)

;Value: 2.000004911675504
```

If I know, any Maths, the cube root of 8 is 2 right?

