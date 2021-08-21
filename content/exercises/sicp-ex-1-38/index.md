---
title: Exercise 1.38
date: 21-08-2021
---

This is the $38^{th}$ exercise of Sicp. Here we find the value of $e$

# The Question

**Exercise 1.38:** In 1737, the Swiss mathematician Leonhard
Euler published a memoir *De Fractionibus Continuis**, which
included a continued fraction expansion for $e − 2$, where
$e$ is the base of the natural logarithms. In this fraction, the
$N_{i}$ are all 1, and the $D_{i}$ are successively 1, 2, 1, 1, 4, 1, 1,
6, 1, 1, 8, . . .. Write a program that uses your `cont-frac`
procedure from Exercise 1.37 to approximate $e$, based on
Euler’s expansion.

# The Answer

The above question is a direct application of `cont-frac`. In order
to compute $e$ $N_{i} = 1$ and the values of $D_{i}$ are successively
1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, . . ..

If you look carefully, after 2, every third number is an even number.
Infact, if you add their indices by 1 (counting from 1, since `i` starts from 1),
and then divide it by three, and then multiply by 2, you get the value of that
number.

So we get $D_{i}$ with the following function:

$$
d \rightarrow (i + 1) \times \frac{2}{3}
$$


Of course that is assuming all indiced when divided by 3 yield an integer.
If it does not yield and integer, we return 1.

This would translate to the following in scheme:

```scheme
(define (d i)
  (let ((by-3 (/ (+ i 1) 3)))
    (if (integer? by-3)
        (* 2 by-3)
        1)))
```

Testing: 

```scheme
> (d 1)
1
> (d 2)
2
> (d 5)
4
> (d 8)
6
> (d 11)
8
```

Now that we have our function, we now just need to pass it into `cont-frac`.
Let's also keep `k` as 20.

This would give us the following:

```scheme
(define (d i)
  (let ((by-3 (/ (+ i 1) 3)))
    (if (integer? by-3)
        (* 2 by-3)
        1)))

(define (cont-frac n d k)
  (cont-frac-reccur n d k 1))

(define (cont-frac-reccur n d k i)
  (let ((n-value (n i))
         (d-value (d i)))
     (if (= i k)
          (/ n-value d-value)
          (/ n-value (+ d-value
                     (cont-frac-reccur n d k (+ i 1)))))))
(define (e)
  (cont-frac (lambda (i) 1.0) d 20))
```

and testing:

```scheme
(e)
0.7182818284590452
```

That's it!
