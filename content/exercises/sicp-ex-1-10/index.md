---
title: Sicp Ex 1.10
date: 2020/10/23
---

In the 10th exercise, we look at Ackerman's function
and give concise mathematical definitions for 
functions which involve it.

# The Question

**Exercise 1.10:** The following procedure computes a mathematical
function called Ackermann’s function.

```scheme
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
	      (A x (- y 1))))))
```

What are the values of the following expressions?
```scheme
(A 1 10)
(A 2 4)
(A 3 3)
```
Consider the following procedures, where `A` is the procedure defined above:

```scheme
(define (f n) (A 0 n))
(define (g n) (A 1 n))
(define (h n) (A 2 n))
(define (k n) (* 5 n n))
```

Give concise mathematical definitions for the functions computed
by the procedures `f`, `g`, and `h` for positive integer values of *n*. For
example, `(k n)` computes $ 5n^{2} $ .

# My Thoughts

To answer this question, we are going to calculate this manually.
This so that we get a better understanding to what happens in the
Ackerman's function. However you can copy-paste the given code
to Check if our answer is right.

# The Answer

Let us use the Substitution model in the expression `(A 1 10)`:

```scheme
(A 1 10)
(A 0 (A 1 9))
(A 0 (A 0 (A 1 8)))
(A 0 (A 0 (A 0 (A 1 7))))
(A 0 (A 0 (A 0 (A 0 (A 1 6)))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))
....
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))
(A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2))))))))))
....
1024
```

Let us do the same for `(A 2 4)`

```scheme
(A 2 4) 
 (A 1 (A 2 3)) 
 (A 1 (A 1 (A 2 2))) 
 (A 1 (A 1 (A 1 (A 2 1)))) 
 (A 1 (A 1 (A 1 2))) 
 (A 1 (A 1 (A 0 (A 1 1)))) 
 (A 1 (A 1 (A 0 2))) 
 (A 1 (A 1 4)) 
 (A 1 (A 0 (A 1 3))) 
 (A 1 (A 0 (A 0 (A 1 2)))) 
 (A 1 (A 0 (A 0 (A 0 (A 1 1))))) 
 (A 1 (A 0 (A 0 (A 0 2)))) 
 (A 1 (A 0 (A 0 4))) 
 (A 1 (A 0 8)) 
 (A 1 16) 
 (A 0 (A 1 15)) 
 (A 0 (A 0 (A 1 14))) 
 (A 0 (A 0 (A 0 (A 1 13)))) 
 (A 0 (A 0 (A 0 (A 0 (A 1 12))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 11)))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 10))))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 9)))))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 8))))))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 7)))))))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 6))))))))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5)))))))))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4))))))))))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3)))))))))))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2))))))))))))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1)))))))))))))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2))))))))))))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4)))))))))))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8))))))))))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16)))))))))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 32))))))))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 64)))))))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 128))))))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 256)))))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 512))))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 1024)))))) 
 (A 0 (A 0 (A 0 (A 0 (A 0 2048))))) 
 (A 0 (A 0 (A 0 (A 0 4096)))) 
 (A 0 (A 0 (A 0 8192))) 
 (A 0 (A 0 16384)) 
 (A 0 32768) 
 65536 
```

I presume that the `(A 3 3)` would be rather long to express
in the substitution model, let's just find the answers using 
the scheme shell.

```
1 ]=> (A 3 3)

;Value: 65536
```

## The Mathematical Definitions

Now getting to the 2nd part of the question:

### (f n)

```scheme
(define (f n) (A 0 n))
```
If you look at the `cond` test in the Ackerman's Function, you will
see `((= x 0) (* 2 y))`. Here in `(A 0 n)`, `x = 0` so $ 2 \times n $.
We can conclude that `(f n)` will return $ 2n $.

$$ (f n) \rightarrow 2n $$

### (g n)

```scheme
(define (g n) (A 1 n))
```

When we were computing `(A 1 10)`, we saw that `(A 1 10)`
became `(A 0 (A 1 9))`, which became `(A 0 (A 0 (A 1 8)))`.
This nesting continued until `n` became 1, which was when 
2 was returned. If look more carefully, you will notice
that the nesting continued till `n` was reduced to `1`
which was 9 times and two returned to the last level.
We can then say that 2 was multiplied 10 times.

$ 2 \times 2 \times 2 \times 2 \times 2 \times 2 \times 2 \times 2 \times 2 \times 2 = 10 $

Thus we see that `(g n)` is 2 multiplied `n` times.
This can be then be further simplified to say that
`(g n)` returns $ 2^{n} $ . However if n = 0, 0 is returned.

$$ (g 0) \rightarrow 0, (g n) \rightarrow 2^{n}$$

### (h n)

```scheme
(define (h n) (A 2 n))
```

When we were computing `(A 2 4)` we saw that it became
`(A 1 (A 2 3))` which eventually became `(A 1 (A 1 (A (A 2 1))))`
In this case, (A 1) is nested $ n -1 $ times, with two being
returned to the innermost level. This leads to the exponent 
being raised to the power of the exponent above it. 
This is called [Tetration](https://en.wikipedia.org/wiki/Tetration). 

$ 2^{2^{2^{2}}} $

The definition:

$$ 2 \uparrow \uparrow n $$

$$ (h 0) \rightarrow 0, (h n) \rightarrow 2 \uparrow \uparrow n$$

