---
title: Exercise 1.37
date: 2021-08-20
---

This is the $37^{th}$ question in SICP. Here we find the value of a continous fraction.

# The Question
## Part A

An infinite continued fraction is an expression of the form

$$
f = \frac{N_{1}}{D_{1} + \frac{N_{2}}{D_{2} \frac{N_{3}}{D_{3} + ...}}}
$$

As an example, one can show that the infinite continued fraction expansion with the $N_{i}$
and the $D_{i}$ all equal to 1 produces $1/\varphi$ where $\varphi$ is the golden ratio
(described in Section 1.2.2). One way to approximate an infinite continued fraction is to
truncate the expansion after a given number of terms. Such a truncation - a so-called
*k-term finite continued fraction* — has the form

$$
\frac{N_{1}}{D_{1} + \frac{N_{2}}{._{._{.}} + \frac{N_{k}}{D_{k}}}}
$$

Suppose that `n` and `d` are procedures of one argument (the term index $i$) that return 
$N_{i}$ and $D_{i}$ of the terms of the continued fraction. Define a procedure `cont-frac` 
such that evaluating `(cont-frac n d k)` computes the value of *k*-term finite continued
fraction. Check your procedure by approximating $1/\varphi$ using:

```scheme
(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           k)
```

for succesive values of `k`. How large must you make `k` in order to get an approximation 
that is accurate to 4 decimal places?

## Part B

If your `cont-frac` procedure generates a recursive process, write one that generates an 
iterative process. If it generates an iterative process, write one that generates a
recursive process.

# My Thoughts

I am going to attempt this question part by part. In part A, I will write a recursive procedure.
In part B, I will write its' iterative equivalent.

## Truncating

We need to find the value of this infinite continued fraction. However, it is not simple to get the
exact value of the fraction because it is - um, infinite. So, the authors have suggested we truncate
the fraction.

What does truncating mean? Assuming we number each instance of the numerator and denominator such
that they are of the form $N_{i}$ and $D_{i}$, if we stop recursing at instance $k$, it is called
truncating. In other words, we are stopping at some approximate value, and cutting the fraction
short.

# The Answer

## Part A

Let us start with a `cont-frac-reccur` this will be called from `cont-frac`. It will have the the
params `n`, `d`, `k`, `i`.

We know that if `i` == `k`, we return the truncated $\frac{N_{k}}{D_{k}}$. However even before we do
any of that, we need to find the value of `n` and `d`. This is simple because the params `n` and `d`
are functions for computing the value of $N_{i}$ and $D_{i}$, with the input of `i`.

```scheme
(let ((n-value (n i))
      (d-value (d i)))
      ;; body)
```

Now that we have got the `n-value` and `d-value`, we need to decide whether we are truncating or recursing.
We truncate if `i` == `k` and we recurse if not.

Truncating is the following:

```scheme
(/ n-value d-value)
```

Recursing is the following:

```scheme
(/ n-value (+ d-value
              (cont-frac-reccur n d k (+ i 1))))
```

Putting this all together, we get the following:

```scheme
(define (cont-frac-reccur n d k i)
  (let ((n-value (n i))
         (d-value (d i)))
     (if (= i k)
       (/ n-value d-value)
       (/ n-value (+ d-value
                     (cont-frac-reccur n d k (+ i 1)))))))
```

Now all we have to do is get `cont-frac` to call `cont-frac-reccur`:

```scheme
(define (cont-frac n d k)
  (cont-frac-reccur n d k 1))
```

### Testing

The author's have said that a continous fraction where $N_{i}$ and $D_{i}$ are equal to
the 1, will be equal to $1/\varphi$. We know that $\varphi$ is equal to 
$\frac{1 + \sqrt{5}}{2}$. Thus $1/\varphi$ is the inverse of that: $\frac{2}{1 + \sqrt{5}}$

A quick division gives 0.618033.

So, if we try:

```scheme
(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           k)
```

for with a random valu of `k`, we should get an approximate of 0.618033.

Trying with `k` as 5:

```scheme
(cont-frac (lambda (i) 1.0)
  (lambda (i) 1.0)
  5)
0.625
```

That is pretty close. Now we know that the procedure is working. We now need
find the lowest value of `k` required to get an accurate value of upto 4 decimals,
i.e 0.6180.

Trying with 10:

```scheme
(cont-frac (lambda (i) 1.0)
  (lambda (i) 1.0)
  10)
0.6179775280898876
```

That is very close. Let me try with 11:

```scheme
(cont-frac (lambda (i) 1.0)
  (lambda (i) 1.0)
  11)
0.6180555555555556
```

There's our answer. 11 is the smallest value of `k` required.

## Part B

Now that we have written a recursive procedure, we must write an iterative
version.

The first thing we need to understand before we start writing an iterative version
is that this procedure depends on the `k` values of `n` and `d` in order to evaluate
any of the "higher" less than `k` forms.

Similarly, in order to computer the `i` forms, we need to know the values of the `i + 1`
forms.

Bearing this mind, our procedure will have the parameters `n`, `d`, `i` and `cur-val`.
We start with $i = k - 1$ and `cur-val` equal to $\frac{N_{k}}{D_{k}}$. We 
compute n and d-value, if `i` is equal to 0, we return, else, we compute the `i`
form and add call the next iteration adding the computed value.

This gives us a `cont-frac-iter` like the following:

```scheme
(define (cont-frac-iter n d i cur-val)
  (let ((n-value (n i))
        (d-value (d i)))
    (if (= i 0)
        cur-val
        (cont-frac-iter n d (- i 1)(/ n-value (+ d-value cur-val))))))
```

We need to truncate the fraction to compute the starting value of `cur-val`
`i`, will also have the value of $k - 1$. This gives us the following `cont-frac`:

```scheme
(define (cont-frac n d k)
  (cont-frac-iter n d (- k 1)(/ (n k) (d k))))
```

### Testing

Testing this in a repl gives the following:

```scheme
(cont-frac (lambda (i) 1.0)
  (lambda (i) 1.0)
  10)
0.6179775280898876
```

Which is the same value received from the recursive version.
