---
title: "Example: Counting Change"
date: 2020/10/24
---

In this Example, we write a recursive procedure to calculate
the number of possible ways to tend change to a given value.


# The Problem

Suppose you have a sum of 1 dollar. Let's say you bought a 
coffee for 90 cents, and the cafeteria needs to pay you 
back 10 cents. How do find number of ways to the cafeteria 
can pay you back your change? One such way is to manually
count the possible ways.


$$ 10 = 10 $$  
$$ 5 + 5 = 10 $$  
$$ 5 + 1 + 1 + 1 + 1 + 1 = 10 $$  
$$ 1 \times 10 = 10 $$  


If this was a larger number, it would just go on and on. Ugh. So how do you count the change
for a number like $0.25 let alone any given number?


# My thoughts

When you ask for change, say from a shop, you always ask for the
biggest *denomination*. In the case of the cafeteria, you would
probably expect a dime as change. If a dime is missing,
you ask for the next largest denomination i.e a nickel. Now the Cafe owes
you 10 - 5 dollars i.e 5 dollars. If there's still another nickel, you would take
it. But if they don't have a nickel, you would have to take 5 pennies. But what if they
have only pennies? you would have to take 10 pennies then!

So in short the number of ways to tend 0.10 dollars is the sum of the ways we can tend change
to 0.05 dollars and the ways we only used pennies

## Making a better description

The real-life description above gives a very vague description about *how* we 
calculate the ways to tend change. Let us build on it to make
a function for counting change.

Essentially what we are doing is taking an amount ($0.10) and breaking it down
by subtracting from the amount the value of a denomination. We then find the number
of ways we can tend change to that new amount, and then add that to number of ways we 
can tend change to `amount - another denomination`.

## Managing Denominations

But how do count ways that sucessful and not count the way that aren't?
For that we must figure out how to manage the usable denominations.
We make a function that will return the *n*th denomination. So this
would can be easily defined as:

```scheme
(define (first-denomination k)
  (cond ((= k 1) 1)
        ((= k 2) 5)
        ((= k 3) 10)
        ((= k 4) 25)
        ((= k 5) 50)))
```

Now to make our program compatible with another currency,
all you will have to do is adjust this function accordingly.


## Counting change

We now have description that is still quite vague but gives us an
idea of what is happening. Let us improve it even more.

We said that essentially we are adding the sum of `ways(amount - first-denomination(n))` where
we add the value of all ways (with n having different values). Let us change this bit. We will add
the concept of being allowed use a certain type of coin and all coins below that. We will also change
our logic a bit:

```lisp
ways{ 100, 5 } = ways{ 100, 5 - 1 }      ;   never use any 50-cent coins
                 +                       ; OR
                 ways{ 100 - 50,  5 }    ;   may use 50-cent coins, so use one
```

We will sum the ways we can use 50 cents and subtract from amount 50,
or not never use 50 cent coins so that we can find another not involving
50 cents. (In this case, this can be 25 + 25 + 25 + 25)

In general we sum `ways(amount - first-denomination(k), k)` and `ways(amount, k - 1)`.

Now we can define what happens when we have reached, the end of the algorithm: when on the params are
0 or less than 0:

- If `amount` is exactly 0, we should count that as 1 way to make change.
- If `amount` is less than 0, we should count that as 0 ways to make change.
- If kind of coins allowed is less than 0, count that as 0 ways to make change.

# Writing the code

We shall now define our recursive procedure:

```scheme
(define (cc amount kind-of-coins)
  (cond ((= amount 0)1)
        ((or (< amount 0)  (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                    kinds-of-coins)))))
```

This entire script is:

```scheme
(define (count-change amount)
  (cc 5 amount))

(define (cc n-value amount)
  (cond ((= amount 0 ) 1)
	(( or (= n-value 0) (< amount n-value)) 0)
	(else (+ (cc (- n-value 1 ) amount) 
		 (cc n-value (- amount (first-denomination n-value)))))))

(define (first-denomination n)
  (cond ((= n 1) 1)
  ((= n 2) 5)
  ((= n 3) 10)
  ((= n 4) 25)
  ((= n 5) 50)))
```

This when used with 1 dollar, will give 292.

