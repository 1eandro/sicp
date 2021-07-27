---
title: Sicp Ex 1.19
date: 24/11/2020
---

Now, this question is not as easy as the last.
This is the $19^{th}$ from Sicp.

# The Question

**Exercise 1.19** There is a clever algorithm for computing the Fibonacci
numbers in a logarithmic number of steps. Recall the transformation of the
state variables `a` and `b` in the `fib-iter` process of Section 1.2.2:
$ a \leftarrow a + b $ and $ b \leftarrow a$.  Call this transformation
$T$ , and observe that applying $T$ over and over again $n$ times,
starting with 1 and 0, produces the pair Fib( n + 1) and Fib( n ). In
other words, the Fibonacci numbers are produced by applying $T^{n}$ ,
the $n^{th}$ power of the transformation $T$ , starting with the pair
(1, 0). Now consider $T$ to be the special case of $p = 0$ and $q = 1$
in a family of transformations $T_{pq}$ , where $T_ {pq}$ transforms the
pair $( a, b )$ according to $a \leftarrow bq + aq + ap$ and $b \leftarrow
bp + aq$ . Show that if we apply such a transformation $T_{pq}$ twice,
the effect is the same as using a single transformation $T_ {pq}$ of
the same form, and compute $p'$ and $q'$ in terms of $p$ and $q$ .
This gives us an explicit way to square these transformations, and
thus we can compute $T_{n}$ using successive squaring, as in the fast-expt
procedure. Put this all together to complete the following procedure,
which runs in a logarithmic number of steps:

```scheme
(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
	((even? count)
	 (fib-iter a
		   b
		   〈 ?? 〉; compute p’
		   〈 ?? 〉; compute q’
		   (/ count 2)))
	(else (fib-iter (+ (* b q) (* a q) (* a p))
			(+ (* b p) (* a q))
			p
			q
			(- count 1)))))
```

# The Explanation (not my thoughts)

In the previous attempts at the fibonacci sequence, we mostly
computed it by adding the "inducting" to the number. With a
changes like this:

$a \leftarrow a + b$
$b \leftarrow a$

Consider this "change" to be $T$. $T$ is called a *Transformation*.
$T$ will happen `n` times. In proper notation, it would be $T_{pq}$.
This means a certain transformation happens on p and q.

## A different sytax for the same thing

Now consider $T$ to be the special case in  a "family" of transformations,
where $ p = 0 $ and $ q = 1$. `p` and `q` here are internal variables.
Do not confuse them with $T_{pq}$. 

Consider this transformation where the pair $(a, b)$ according to the following rules:

$$
a \leftarrow bq + aq + ap
$$

and 

$$
b \leftarrow bp + aq
$$

A quick substitution shows us that it's essentially the same algorithm:

$$
a \leftarrow b(1) + a(1) + a(0) \\
a \leftarrow b + a
$$

and

$$
b \leftarrow b(0) + a(1)\\
b \leftarrow a
$$

## What the question means

The question wants use to find a way to apply 2 Transformations at once.
This can be used to "square" the numbers like the previous `fast-expt`.

# My Thoughts

Now, the reason why variables `p` and `q` were introduced is because, using
the way we compute `a` and `b`, we can skip the computation of numbers inbetween
by applying Transformations on *`p` and `q`* . Since, we are free to compute `p`
and `q` however we want (There is no hard and fast rule to compute it yet) we
could possibly use it to change `a` and `b` however we want. and when we reach
count of one, we can take the values of `p` and `q` compute this a and b.

So, what is intended for us to do transform `p` and `q`, rather than`a` and `b`.
You must have already deduced by looking at the missing code.

Now the question is how on Earth do we transform `p` and `q` so that
we can transform to transform `a` and `b`.

# How on Earth do we transform `p` and `q` (the answer)

Well, (that's [ben in french](https://forum.wordreference.com/threads/bah-oui-ben-oui.196005/)), the answer lies with a common enemy - Algebra
(Or google)

One thing we can do is study how every iteration of the new algorithm changes.
So, let's do that. (And remeber we must focus on `p` and `q` )

Let's give the first iteration a value ($a_{1}$, $b_{1}$):

$$
a{1} \leftarrow b_{0}q + a_{0}q + a_{0}p \\
b_{1} \leftarrow b_{0}p + a_{0}q
$$

We'll just use this to refer to `iteration 0`.

Now, we can say that b in `iteration 2` is the following:

$$
\begin{align}
  b_{2} &= b_{1}p + a_{1} \\
  &= (b_{0}p + a_{0}q) \times p + (b_{0}p + a_{0}q + a_{0}p) \times q\\
  &= b_{0}pp + a_{0}qp + b_{0}pq + a_{0}qq + a_{0}pq\\
        &= (b_{0}pp + b_{0}pq) + (2a_{0}pq + a_{0}qq)\\
        &= b_{0}(pp + qq) + a_{0}(2pq + qq)\\
\end{align}
$$

Compare this with our algorithm :

$$
b \leftarrow bp + aq
$$

and




$$
b_{0}(pp + qq) + a_{0}(2pq + qq)
$$

You begin to see the transformation. p is $p^{2} + q^{2}$ and q is $2pq + q^{2}$.

## Write the scheme code

Now to write the scheme

```scheme
(define (fib n)
  (fib-iter 1 0 0 1 n))
  
(define (fib-iter a b p q count)
  (cond ((= count 0) b)
	((even? count)
	 (fib-iter a
		   b
		   (+ (* p p) (* q q))
		   (+ (* 2 p q) (* q q))
		   (/ count 2)))
	(else (fib-iter (+ (* b q) (* a q) (* a p))
			(+ (* b p) (* a q))
			p
			q
			(- count 1)))))
```

A quick check in a REPL gives us the right answers

```slime
 => (fib 2)

;Value: 1

1 (user) => (fib 100)

;Value: 354224848179261915075

1 (user) => (fib 4)

;Value: 3

1 (user) => (fib 2)

;Value: 1

1 (user) => (fib 3)

;Value: 2

1 (user) => (fib 4)

;Value: 3

1 (user) => (fib 5)

;Value: 5

1 (user) => (fib 10)

;Value: 55
```

That's it. Hope that helped
