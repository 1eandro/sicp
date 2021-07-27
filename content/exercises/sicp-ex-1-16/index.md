---
title: Sicp Ex 1.16
date: 12/11/2020
---

This is the 16th Question. Here we design and iterative
procedure for exponentiation which uses a logarithmic number
of steps.

# The Question

**Exercise 1.16:** Design a procedure that evolves an iterative
exponentiation process that uses successive squaring and uses a
logarithmic number of steps, as does `fast-expt`. (Hint: Using the
observation that $(b^{n/2})^{2} = (b^{2})^{n/2}$, keep along with
the exponent *n* and the base *b*, an additional state variable *a*,
define the state transformation in such a way that the product $ab^{n}$
is unchanged from state to state. At the beginning of process $a$ at the
end of the process. In general, the technique of defining an *invariant
quantity* that remains unchanged from state to state is a powerful way
to think about the design of iterative algorithms.)

# My Thoughts

Let's quickly take a recap of what happens inside `fast-expt`.

## Regular expt

Let's say you have to multiply a number to certain power.. Say, 16.
One way to do this to multiply the number by itself 16 times.
This becomes the following procedure:

```scheme
(define (expt n power)
  (expt-iter n 1 power))

(define (expt-iter n mul count)
  (if (= count 0)
      mul
      (expt-iter n (* mul n) (- count 1))))
```

Now this *okay* for smaller powers. It has the order of growth of
$\theta(n)$ So the moment your program starts going to larger numbers
like 10,000 or 100,000 , you will have to execute 10,000 or 100,000
steps to achieve a value.  The thing is that, this is very inefficient
for the larger powers.

## A faster alternative

Now, let's say you wanted a more efficient way
to multiply your the same number to power of 16.
This is what we can do:

$$ b \times b $$  
$$ b^{2} \times b^{2} $$  
$$ b^{4} \times b^{4} $$  
$$ b^{8} \times b^{8} = b^{16} $$

We now only take 4 multiplications. 4x faster!

This works as long as the power is a power of 2.
So what do you when you need to multiply to the power of 5?

$$ b \times b $$  
$$ b^{2} \times b^{2} $$  
$$ b^{4} \times b^{1} = b^{1} $$  

Take gives you a very vague idea of what we are going to do.
Let's make the general rule that if a number is odd, we will
express it as the following :

$$ b^{n} = b \times b^{n - 1} $$

We can now describe `fast-exp` as the following recursive procedure:

```scheme
(define (fast-exp b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))
```

where `even?` is the following:

```scheme
(define (even? n)
  (= (remainder n 2) 0))
```

This procedure now has $\theta(\log n)$
We need to convert this to an Iterative Procedure

## What does the Hint mean?

The Hint says that we must have 3 variables: `b` the base, 
`n` the exponent and `a` the "state" and define the state
transformation in such a way that, the product of $ab^{n}$ 
will be kept unchanged from state to state.

It also says that at the beginning of the process $a$ is taken
to be 1, and the answer is given by the value of $a$ at the end
of the process.

In general, the technique of defining an ***invariant quantity***
that remains unchanged from state to state is a powerful way
to think about the design of iterative algorithms.

# The Answer

Let's assume that we have to find $3^{3}$. We have the variables, `b`,
`n`, `a`. `b` is our *current*  base, `n` the *current* exponent, we will
also have `base` to remember the original base... And something like this:

```scheme
(expt-iter b n a base) ;;This the order of the variables
(expt-iter 3 3 1 3)
(expt-iter 3 2 3 3)
(expt-iter 9 1 3 3)
27
```

This should give you a vague idea of what we do.
Here is the detailed explanation:

We square `b` every iteration and divide `n` by two.
This iteration goes on until `n` is 1, which is when
we return b.

With that description we derive the following procedure:

```scheme
(define (fast-expt b n)
  (expt-iter b n))

(define (expt-iter b n)
  (cond ((= n 1) b)
        (else (expt-iter (square b) (/ n 2)))))
```
This works
```
1 ]=> (fast-expt 2 8)

;Value: 256
```
perfectly
```
1 ]=> (fast-expt 2 16)

;Value: 65536
```
fine
```
1 ]=> (fast-expt 2 32)

;Value: 4294967296
```
until
```
1 ]=> (fast-expt 2 3)

... nothing
```

This is because 3 becomes 1.5 which becomes 0.75 and never becomes 1.
So we now need to implement the $b \times b^{n - 1}$ thing we were
talking about before. This is where `a` and `base` come in.

`a` is where we store the product of all the "single 'b' s". We multiply
`b` with `a` at the end of the iteration. But how do we know what is the
value of the original `b`? This is why store the value of b in `base`.

We lastly need a way to a way to check if a number is even or not. That
will be following:

```scheme
(define (even? n)
  (= (remainder n 2) 0))
```

This is will be our new `fast-expt`:

```scheme
(define (fast-expt b n)
  (expt-iter b n 1 b))


(define (expt-iter b n a base)
  (cond ((= n 1) (* a b))
        ((not (even? n)) (expt-iter b (- n 1) (* a base) base))
        (else (expt-iter (square b) (/ n 2) a base))))
```

And **now** it works fine:

```scheme
(fast-expt 2 3)

;Value: 8
```
