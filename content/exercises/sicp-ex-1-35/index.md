---
title: Sicp Ex 1.35
date: 2/2/2021
---

This is the $35^{th}$ exercise from Sicp. Here, we calculate the golden ratio
($\varphi$) by finding the fixed point of a function.

# The Question

**Exercsie 1.35:** Show that the golden ratio $\varphi$ (Section 1.2.2)
is a fixed point of the transformation $x \mapsto 1 + 1/x$ , and
use this fact to compute $\varphi$ by means of the fixed-point
procedure.

# The Answer

This is simple. We already know that $\varphi$ is equal to $\frac{1 +
\sqrt{5}}{2}$. (Refer Exercise 1.13) A quick division gives us 1.6180 as the
representation in float.

All we now need to do is use the `fixed-point` function and pass it a `lambda`
of the function $1 + 1/x$

```scheme
;; fixed-point function
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next 
          (try next))))
  (try first-guess))
```

We shall use 1 as the initial guess. The following is the lambda

```scheme
(lambda (x)(+ 1 (/ 1 x)))
```

And testing:

```scheme
(fixed-point (lambda (x)(+ 1 (/ 1 x))) 1.0)

;Value: 1.6180327868852458
```

There you go! That wasn't too complicated was it ?
