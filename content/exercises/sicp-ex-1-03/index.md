---
title: Sicp Ex 1.3
layout: post
date: 2020/10/14
tags: [Sicp, Lisp, Scheme]
---

This is the third Sicp Exercise, and we finally start writing scheme programs!
So without further delay...

# The Question

**Exercise 1.3:** Define a procedure that takes three numbers as arguments
and returns the sum of the squares of the two larger numbers.

# Thoughts

So here we will most likely will have to copy the code sum of  squares (make copying a habit. Half of what programmers do is copy pasting. The other half is understanding 
what you are copy-pasting.) We will also have to make a test that will take two of the
largest no.s)

# Answers

Let's start programming. Like I mentioned [before](https://benjamin-philip.github.io/2020-10-13-sicp-ex-1.1), You should use Emacs for programming in Lisp.
I will attach a link to that page when I get my setup ready.

## Define square

Squaring is essentially multiplying a number by itself.
So let's make that into a function:

```scheme
(define (sqr x)
  ;;x is the numeral to be squared
  (* x x))
```

## Define sum of squares

So now let us make a function that will return the sum of 2 numbers:

```scheme
(define (sum-squares x y)
  ;;x is numeral 1 and y numeral 2
  (+ (sqr x) (sqr y)))
```

## Writing our test

Now, here comes the annoying bit: Writing the if - else test.
The simplest way is to write a `cond` that will deal with all the possibilities
and do something accordingly. So now make a function that will run `sum-squares`
with the right numbers:

```scheme
(define (func x y z)
  ;;x is numeral 1, y is numeral 2 and z numeral 3
   (cond ((and (>= x y) (>= y z)) (sum-squares x y))
        ((and (>= x y) (>= z y)) (sum-squares x z))
        ((and (>= y x) (>= z x)) (sum-squares z y))))
```

This is the script:

```scheme
;;Sicp ex 1.3

(define (sqr x)
  ;;x is the numeral to be squared
  (* x x))


(define (sum-squares x y)
  ;;x is numeral 1 and y numeral 2
  (+ (sqr x) (sqr y)))


(define (func x y z)
  ;;x is numeral 1, y is numeral 2 and z numeral 3
  (cond ((and (>= x y) (>= y z)) (sum-squares x y))
        ((and (>= x y) (>= z y)) (sum-squares x z))
        ((and (>= y x) (>= z x)) (sum-squares z y))))
```

And now we are done! Running this script in the shell with 4 5 6, we get:
```
MIT/GNU Scheme running under GNU/Linux
Type `^C' (control-C) followed by `H' to obtain information about interrupts.

Copyright (C) 2019 Massachusetts Institute of Technology
This is free software; see the source for copying conditions. There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Image saved on Thursday September 5, 2019 at 11:51:46 AM
  Release 10.1.10 || Microcode 15.3 || Runtime 15.7 || SF 4.41 || LIAR/x86-64 4.118
  ;Loading "ex.scm"... done

1 ]=> (func 4 5 6)

;Value: 61
```

Well that's right!

