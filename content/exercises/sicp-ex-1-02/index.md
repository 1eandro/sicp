---
title: Sicp Ex 1.2
layout: post
date: 2020/10/14
tags: [SICP, Lisp, Scheme]
---

So getting to the matter: This the second exercise in SICP.
It's basically change mathematical notation to prefix.

# Question

**Exercise 1.2:** Translate the following expression into prefix form.

$$\frac{5 + 4 + (2 - (3 - (6 + \frac{4}{5})))}{3(6 - 2)(2 - 7)}$$

# My thoughts

Like I mentioned before, basically, change mathematical notation to prefix.

# The Answer

The first thing that happens is the division. So lets start with that:

```scheme
(/ numerator denominator)
```

Let's continue with what happens in the numerator:

That is 5 + 4 + parentheses. So our equation becomes:

```scheme
(/ (+ 5 4 ()) denominator)
```

Now what happens in the brackets? 2 - parentheses  
This becomes:

```scheme 
(/ (+ 5 4 (- 2 ()))denominator)
```

Continuing with this cycle, we soon get:

```scheme
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) denominator)
```

Doing the same for the denominator, we get:

```scheme
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))(* 3 (- 6 2)(- 2 7)))
```

And that's it! Now that's it! Remember though that you will to have follow
[BODMAS](https://en.wikipedia.org/wiki/Order_of_operations) while translating, and BODMAS is a 
mess! Maybe we should all switch to Prefix or [RPN](https://en.wikipedia.org/wiki/Reverse_Polish_notation)?
Tell us what you think in the comments below!
