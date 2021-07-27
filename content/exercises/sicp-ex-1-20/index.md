---
title: Sicp Ex 1.20
date: 26/11/2020
---

This is the $20^{th}$ question in Sicp. In general I feel that
this is a rather easy question to the previous ones.

# The Question 

**Exercise 1.20:** The process that a procedure generates is of course
dependent on the rules used by the interpreter. As an example,
consider the iterative gcd procedure given above. Suppose we
were to interpret this procedure using normal-order evaluation,
as discussed in Section 1.1.5. (The normal-order-evaluation rule
for if is described in [Exercise 1.5.](https://benjamin-philip.github.io/sicp/sicp-ex-1-5)) Using the substitution method
(for normal order), illustrate the process generated in evaluating
`(gcd 206 40)` and indicate the remainder operations that are
actually performed. How many remainder operations are actually
performed in the normal-order evaluation of `(gcd 206 40)` ? In
the applicative-order evaluation?

# The Answer

A quick summary from applicative order vs normal order : 

- Normal order only evaluates when the value is needed.(fully expanded and then eval)
- Applicative order evaluates immediately

Here is the gcd code:

```scheme
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))
```

Since, normal order evaluates only after fully expanding, the functions get really nested.
So, pardon any errors. Here's the normal order evaluation:

```scheme
(gcd 206 40)

(if (= 40 0)
    40
    (gcd 40 (remainder 260 40)))

(if (= (remainder 260 40) 0)
    (remainder 260 40)
    (gcd (remainder 206 40)(remainder 40 (remainder 260 40))))

(if (= 6 0);; 1 remainder is evaluated 
    6
    (gcd (remainder 206 40)(remainder 40 (remainder 260 40))))

(if (= (remainder 206 40)(remainder 40 (remainder 260 40)) 0)
    (remainder 206 40)(remainder 40 (remainder 260 40))
(gcd (remainder 40 (remainder 260 40)) ((remainder 206 40)(remainder 40 (remainder 260 40)))))


(if (= 4 0);; 2 remainders are evaluated
    4
    ((gcd (remainder 40 (remainder 260 40)) ((remainder 206 40)(remainder 40 (remainder 260 40))))))

;; This pattern continues until ..

(if (= 0 0) ;; 7 remainders evaluated
    (remainder (remainder 206 40)
               (remainder 40 (remainder 206 40)))
    (gcd (remainder (remainder 40 (remainder 206 40))
                    (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40))))
         (remainder (remainder (remainder 206 40)
                               (remainder 40 (remainder 206 40)))
                    (remainder (remainder 40 (remainder 206 40))
                               (remainder (remainder 206 40)
                                          (remainder 40
                                                     (remainder 206 40)))))))
;Value: 2

```

The Applicative order is the following:

```scheme

(gcd 260 40)

(if (= 40 0)
    40
    (gcd 40 (remainder 260 40)))

(if (= 40 0)
    40
    (gcd 40 6)) ;; immediately evaluated

(gcd 40 6)

(if (= 6 0)
    40
    (gcd 6 (remainder 40 6)))

(if (= 6 0)
    40
    (gcd 6 4))

(gcd 6 4)

(if (= 4 0)
    6
    (gcd 4 (remainder 6 4)))

(gcd 4 2)

(if (= 2 0)
    4
    (gcd 4 (remainder 4 2)))

(gcd 2 0)

(if (= 0 0)
    2
    (gcd 2 (remainder 2 0)))

;Value: 2
```

That's it. Hope it helps.
