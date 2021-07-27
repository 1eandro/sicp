---
title: Sicp Exercise 1.36
date: 2/2/2021
---

This is the $36^{th}$ Exercise from Sicp. Here we modify `fixed-point` so that
it prints each guess. We then find a solution to $x^{x} = 1000$.

# The Question

**Exercise 1.36:** Modify `fixed-point` so that it print the sequence of
approximations it generates, using the `newline` and `display` primitives shown
in Exercise 1.22. Then find a solution to $x^{x} = 1000$ by finding a fixed
point of $x \mapsto \log(1000)/\log(x)$. (Use scheme's primitive `log`procedure,
which computes natural logarithms.) Compare the number of steps this takes with
and without average damping. (Note that you cannot start `fixed-point` with a
guess of 1, as this would cause division by log(1) = 0)

# Notes

I am dividing this answer to 2 parts:

1. Modifying `fixed-point` so that it prints the guesses
2. Finding $x^{x} = 1000$ and comparing the number of steps with and without average damping.

# Part 1

Here we are writing a version of `fixed-point` that prints each guess.

## Printing 

First, let us define a procedure `print` that displays its input and then prints
a newline.

```scheme
(define (print x)
  ((display x)
   (newline)))
```

testing:

```scheme
(print 23)

23
;The object #!unspecific is not applicable.
;To continue, call RESTART with an option number:
; (RESTART 2) => Specify a procedure to use in its place.
; (RESTART 1) => Return to read-eval-print level 1.

```

It's not good practice to have functions that do not return values. That's
possibly why the interpreter is complaining. Let us return `x` after printing.

```scheme
(define (print x)
  (display x)
  (newline)
  x)
```

Testing again :

```scheme
(print 23)
23
;Value: 23
```


## Finding the guess number

Printing the guess number would be meaningless if we couldn't find which guess
it was - whether the first, the second or tenth. 

Hence, we will define a variable called `depth`. We access this variable using
lexical scoping. Every recursion, we increment `depth` by 1.

Let us define a function `report-guess` to print all the information.

```scheme
(define (report-guess guess)
  (display depth)
  (display " *** ")
  (print guess))
```

## Implementing `fixed-point` to use `report-guess` 

This this `fixed-point`:

```scheme
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))
```

We need `try` to have a parameter called `depth`. We then could have a `let`
statement like the following:

```scheme
(let ((next (f (report-guess guess))))
```

Thus, we report the guess whenever the `let` statement is evaluated.

This is the redefined `fixed-point`:

```scheme
(define (print x)
  (display x)
  (newline)
  x)

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess depth)
    (define (report-guess guess)
      (display depth)
      (display " *** ")
      (print guess))
    (let ((next (f (report-guess guess))))
      (if (close-enough? guess next)
          next
          (try next (inc depth)))))
  (try first-guess 1))
```

## Testing `fixed-point`

Now that we have got an implementation of `fixed-point`, let us test it.

```scheme
(fixed-point cos 1.0)
1 *** 1.
2 *** .5403023058681398
3 *** .8575532158463934
4 *** .6542897904977791
5 *** .7934803587425656
6 *** .7013687736227565
7 *** .7639596829006542
8 *** .7221024250267077
9 *** .7504177617637605
10 *** .7314040424225098
11 *** .7442373549005569
12 *** .7356047404363474
13 *** .7414250866101092
14 *** .7375068905132428
15 *** .7401473355678757
16 *** .7383692041223232
17 *** .7395672022122561
18 *** .7387603198742113
19 *** .7393038923969059
20 *** .7389377567153445
21 *** .7391843997714936
22 *** .7390182624274122
23 *** .7391301765296711
24 *** .7390547907469174
25 *** .7391055719265363
26 *** .7390713652989449
27 *** .7390944073790913
28 *** .739078885994992
29 *** .7390893414033927
;Value: .7390822985224024
```

Unfortunately, the last guess is omitted, though I don't understand why.
Probably due to some internal mechanics by which `let` works. 

# Part 2

Here we find `x`, where $x^{x} = 1000$.

The authors have themselves derived that we could find x by find the fixed point
of the function $x \mapsto \log(1000)/\log(x)$

This would be the following `lambda`:

```scheme
(lambda (x)(/ (log 1000)(log x)))
```

## Without average damping

Let us use our `fixed-point` function to compute this.

```scheme
(fixed-point (lambda (x)(/ (log 1000)(log x))) 2)
1 *** 2
2 *** 9.965784284662087
3 *** 3.004472209841214
4 *** 6.279195757507157
5 *** 3.759850702401539
6 *** 5.215843784925895
7 *** 4.182207192401397
8 *** 4.8277650983445906
9 *** 4.387593384662677
10 *** 4.671250085763899
11 *** 4.481403616895052
12 *** 4.6053657460929
13 *** 4.5230849678718865
14 *** 4.577114682047341
15 *** 4.541382480151454
16 *** 4.564903245230833
17 *** 4.549372679303342
18 *** 4.559606491913287
19 *** 4.552853875788271
20 *** 4.557305529748263
21 *** 4.554369064436181
22 *** 4.556305311532999
23 *** 4.555028263573554
24 *** 4.555870396702851
25 *** 4.555315001192079
26 *** 4.5556812635433275
27 *** 4.555439715736846
28 *** 4.555599009998291
29 *** 4.555493957531389
30 *** 4.555563237292884
31 *** 4.555517548417651
32 *** 4.555547679306398
33 *** 4.555527808516254
34 *** 4.555540912917957
;Value: 4.555532270803653
```

Here it took us 35 steps to reach.
Now let us try with average damping

## With average damping

We now need to develop a version with average damping.
With average damping, we average our guess by the value returned by the
function. 

This would be the following lambda:

```scheme
(lambda (x)(average x (/ (log 1000)(log x))))
```

Now let's try it :

```scheme
(define (average x y)(/ (+ x y) 2))

;Value: average

1 (user) => (fixed-point (lambda (x)(average x (/ (log 1000)(log x)))) 2.0)
1 *** 2.
2 *** 5.9828921423310435
3 *** 4.922168721308343
4 *** 4.628224318195455
5 *** 4.568346513136242
6 *** 4.5577305909237005
7 *** 4.555909809045131
8 *** 4.555599411610624
9 *** 4.5555465521473675
;Value: 4.555537551999825
```

We computed something similar in just 10 steps ! That is 2/7 of the steps taken
with out average damping !

