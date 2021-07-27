---
title: Sicp Ex 1.11
date: 2020/10/25
---

This is the $11^{th}$ exercise in Sicp.
Here we write an iterative process and a 
recursive process for the same function.

# The Question

**Exercise 1.11:** A function `f` is defined by the rule that $f (n) = n$ if
n < 3$ and $f (n) = f (n − 1) + 2f (n − 2) + 3f (n − 3)$ if $n ≥ 3$. Write a
procedure that computes `f` by means of a recursive process. Write
a procedure that computes `f` by means of an iterative process.

# My thoughts and the Answer

Let's define the recursive process first.
Since the definition itself is recursive, this
should be simple:

```scheme
(define (f n)
 (cond ((< n 3) n)
       ((>= n 3) 
           (+ (f (- n 1)) 
           (* 2 (f (- n 2))) 
           (* 3 (f (- n 3)))))))
```

## Writing the iterative process

Now that we defined that, we will now have make this process an
iterative process. This is the difficult bit. We will have to make
a recursive logic iterative in nature.

Now what is the definition of this function? (when n is <= 3)

> f(n) = f(n-1) + 2f(n-2) + 3f(n -2)

Let's use the substitution model and work this for a few numbers:

```
f(0) = 0
f(1) = 1
f(2) = 2

f(3) = (f 2) + 2(f 1) + 3(f 0) = 2 + 2 + 0 = 4
f(4) = (f 3) + 2(f 2) + 3(f 1) = 4 + (2 * 2) + (3 * 1) = 4 + 4 + 3 = 11
f(5) = (f 4) + 2(f 3) + 3(f 2) = 11 + (2 * 4) + (3 * 2) = 11 + 8 + 6 = 25
f(6) = (f 5) + 2(f 4) + 3(f 3) = 25 + (2 * 11) + (3 * 4) = 25 + 22 + 12

```

If you look at `f(3)` all we are doing is multiplying `f(1)` by 2, `f(0)` by 3 `f(2)` by 1
summing them. When you look at `f(4)` all we are doing is multiplying `f(3)` by 1, `f(2)` by 2
and `f(1)` by 3. 

So what we can do is, use 3 variables : a, b, and c to track the value of `f(n -1)`, `f(n - 2)`, and
`f(n - 3)` respectively. We will use variable `n` to count. When n is 0, we will return the sum.
We will also update the values of `a`, `b`, `c` every recursion. Using this description we can make
a procedure.

```scheme
(define (f n)
  (if (< n 3)
      n
  (f-iter 2 1 0 (- n 3))))
  
(define (f-iter a b c n)
  (if (= count 0)
         (+ a
         (* 2 b)
         (* 3 c))
    (f-iter (+ a (* b 2) (* c 3))
        a b (- n 1))))
```

Now how simple was that?
