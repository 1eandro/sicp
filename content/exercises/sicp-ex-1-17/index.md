---
title: Sicp Ex 1.17
date: 23/11/2020
---

This is the 17 exercise of Sicp and I am posting after a long time. I
hope that this question will be interesting.

# The Question

**Exercise 1.17:** The exponentiation algorithms in this section are based on performing
exponentiation by means of repeated multiplication. In a similar way, one can perform
integer multiplication by means of repeated addition. The following multiplication
procedure (in which it is assumed that our language can only add, not multiply) is analogous
to the expt procedure:

```scheme
(define (* a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))
```

This algorithm takes a number of steps that is linear to`b`. Now suppse
we include with addition, operations `double`, which doubles and integer
and `halve` which divides an (even) integer by 2.  Using these, design a
multiplication procedure analogous to `fast-expt` that usess a logarithmic
number of steps.

# My Thoughts

This question is quite like the [previous exercise's](https://benjamin-philip.github.io/sicp/sicp-ex-1-17) recursive example.
Here all we are doing is replacing exponentiation with multiplication,
multiplication with addition, and division with subtraction. 

## The program structure

We need to make an recursive procedure to to multiply logarithmicly. Like the 
`fast-expt` in the example.

Let's take the number to multiplicant as `x` and the multiplier and `n`.
We now know few things:

- If `n` is even, double `x` and halve `n`
- If `n` is odd, add `x` and subtract 1 from `n`
- If `n` is zero, return **0** and not 1.

Let's make a recursive procedure from that.

# The Answer

This is how we check if even:

```scheme
(define (even? n)
  (= (remainder n 2) 0))
```

This is how we double:

```scheme
(define (double n)
  (+ n n))
```

This is how we halve:

```scheme
(define (halve n)
  (/ n 2))
```

This is the recursive `fast-mult`:

```scheme
(define fast-mult (b n)
  (cond ((= n 0) 0)
	((even? n) (double (fast-mult b (halve n))))
	(else (+ b (fast-mult b (- n 1))))))
```

And here's the entire thing:

```scheme
(define (even? n)
  (= (remainder n 2) 0))

(define (double n)
  (+ n n))

(define (halve n)
  (/ n 2))

(define (fast-mult b n)
  (cond ((= n 0) 0)
	((even? n) (double (fast-mult b (halve n))))
	(else (+ b (fast-mult b (- n 1))))))
```


And upon testing $ 2 \times 8 $:

```
1 ]=> (fast-mult 2 8)

;Value: 16
```

That's it. A really simple procedure right? Tell us your opinion in the commnets below.
