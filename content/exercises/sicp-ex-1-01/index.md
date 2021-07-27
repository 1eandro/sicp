---
title: Sicp Ex 1.1
layout: post
date: 2020/10/13
tags: [SICP, Lisp, Scheme]
---

So I had just started reading SICP. It’s this amazing book that was used
to teach Comp Sc. to students who had never programmed before at MIT.
When I thought that I should write a blog post with a solution for every
exercise I attempt. So I am gonna write solutions for all the exercise
in SICP. My plan is to finish this book in one year.

You can obtain a copy of SICP for free because of [MIT-Open course ware!](https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/)

# My setup

My plan is to use emacs(sorry for the adultery vim\!) with slime, and
guile. I haven’t setup it up yet, though I will attach a link to the
post when I do. I strongly encourage you to setup emacs though because
soon the exercises will get really complicated, and the support emacs
has for Lisp (Being written in lisp itself) will be really helpful while
editing.

So without further delay, Let’s get to the exercise

# The Question

**Exercise 1.1:** Below is a sequence of expressions. What is the result
printed by the interpreter in response to each expression? Assume that
the sequence is to be evaluated in the order in which presented.

``` scheme
10
(+ 5 3 4)
(- 9 1)
(/ 6 2)
(+ (* 2 4) (- 4 6))
(define a 3)
(define b (+ a 1))
(+ a b (* a b))
(= a b)
(if (and (> b a) (< b (* a b)))
    b
    a)
(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
(+ 2 (if (> b a) b a))
(* (cond) ((> a b) a)
          ((< a b) b)
          (else -1))
   (+ a 1)
```

# My Thoughts

So far, the authors have been explaining about the basic syntax of
scheme. If you are reading this, you most likely also read SICP till
this exercise. So I am not gonna speak much about it, but make a table
of the syntax:

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: right;">Scheme syntax</th>
<th style="text-align: center;">English equivalent</th>
<th style="text-align: left;">Python Equivalent</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;"><div class="sourceCode" id="cb1"><pre class="sourceCode scheme"><code class="sourceCode scheme"><a class="sourceLine" id="cb1-1" title="1">(<span class="ex">define</span><span class="fu"> variable </span>value)</a></code></pre></div></td>
<td style="text-align: center;">variable is value</td>
<td style="text-align: left;"><div class="sourceCode" id="cb2"><pre class="sourceCode python"><code class="sourceCode python"><a class="sourceLine" id="cb2-1" title="1">variable <span class="op">=</span> value</a></code></pre></div></td>
</tr>
<tr class="even">
<td style="text-align: right;"><div class="sourceCode" id="cb3"><pre class="sourceCode scheme"><code class="sourceCode scheme"><a class="sourceLine" id="cb3-1" title="1">(<span class="ex">define</span><span class="fu"> func </span>(params)</a>
<a class="sourceLine" id="cb3-2" title="2">   body)</a></code></pre></div></td>
<td style="text-align: center;">func is a set of instr uctions done with the help of params</td>
<td style="text-align: left;"><div class="sourceCode" id="cb4"><pre class="sourceCode python"><code class="sourceCode python"><a class="sourceLine" id="cb4-1" title="1"><span class="kw">def</span> func(params):</a>
<a class="sourceLine" id="cb4-2" title="2">    body</a></code></pre></div></td>
</tr>
<tr class="odd">
<td style="text-align: right;"><div class="sourceCode" id="cb5"><pre class="sourceCode scheme"><code class="sourceCode scheme"><a class="sourceLine" id="cb5-1" title="1">(func params)</a></code></pre></div></td>
<td style="text-align: center;">Using a set of instruc tions called func with the help of params</td>
<td style="text-align: left;"><div class="sourceCode" id="cb6"><pre class="sourceCode python"><code class="sourceCode python"><a class="sourceLine" id="cb6-1" title="1"> func(params)</a></code></pre></div></td>
</tr>
<tr class="even">
<td style="text-align: right;"><div class="sourceCode" id="cb7"><pre class="sourceCode scheme"><code class="sourceCode scheme"><a class="sourceLine" id="cb7-1" title="1">(<span class="kw">cond</span> (p1 e1)</a>
<a class="sourceLine" id="cb7-2" title="2">      <span class="co">;;...</span></a>
<a class="sourceLine" id="cb7-3" title="3">      (pn en))</a></code></pre></div></td>
<td style="text-align: center;">If p1 is true, do e1. (can be used as many ti- mes as required) p1 is a test, and e1 is an e- xpression</td>
<td style="text-align: left;"><div class="sourceCode" id="cb8"><pre class="sourceCode python"><code class="sourceCode python"><a class="sourceLine" id="cb8-1" title="1"><span class="cf">if</span> p1: e1</a>
<a class="sourceLine" id="cb8-2" title="2"><span class="co"># ...</span></a>
<a class="sourceLine" id="cb8-3" title="3"><span class="cf">elif</span> pn: en</a></code></pre></div></td>
</tr>
<tr class="odd">
<td style="text-align: right;"><div class="sourceCode" id="cb9"><pre class="sourceCode scheme"><code class="sourceCode scheme"><a class="sourceLine" id="cb9-1" title="1">(<span class="kw">if</span> predicate consequent</a>
<a class="sourceLine" id="cb9-2" title="2">    alternative</a></code></pre></div></td>
<td style="text-align: center;">If predicate is true, do consequent, else, do al- ternative.</td>
<td style="text-align: left;"><div class="sourceCode" id="cb10"><pre class="sourceCode python"><code class="sourceCode python"><a class="sourceLine" id="cb10-1" title="1"><span class="cf">if</span> predicate: consequent</a>
<a class="sourceLine" id="cb10-2" title="2"><span class="cf">else</span>: alternative</a></code></pre></div></td>
</tr>
</tbody>
</table>


# Answers

So now that we have got out table, let us get started. To check our answers we can use the [Scheme shell](https://www.gnu.org/software/mit-scheme/documentation/testing/mit-scheme-user.html)

> 10

That will return 10

> (+ 5 3 4)

`(+ 5 3 4)` is basically "sum of 5,3,4" but in [prefix notation](https://en.wikipedia.org/wiki/Polish_notation). That will be 12.

> (- 9 1)

9 - 1 is 8. So it will return 8

>( / 6 2)

$6 \div 2$ is 3. So 3.

> (+ (* 2 4) (- 4 6))

First, $2 \times 4$ is 8 and 4 - 6 is -2.
Then 8 + -2 is 6.

> (define a 3)

`a` is now three. 

> (define b (+ a 1)))

So b will be a + 1 , which is 3 + 1, which equals to 4.

> (+ a b (* a b))

First $a \times b = 3 \times 4 = 12$.
Then 3 + 4 + 12 = 19.

> (= a b)

Now, this test that will output a Boolean.
Since 3 is ***not*** = 4, it will be False.

> (if (and (> b a) (< b (* a b)))
    b
    a)
    
`and` adds to the test, and now checks if ***both***(`(> b a)` and `(< b (* a b) ))` 
return true. Since 4 is greater than 3 and 4 is lesser than 12, this returns True,
and 4 is returned.

> (cond ((= a 4) 6)
        ((= b 4) (+ 6 7 a))
        (else 25))
        
`b = 4` is the first thing that came true so,
what will be returned will be 6 + 7 + 3 = 10.

> (* (cond ((> b a) b a))
           ((< a b) b)
           (else -1))
       (+ a 1))
       

This just multiplies whatever `cond` returns by 4.
`cond` returns 4, so $4^{2} = 16$

That's it! Tell us about in the comments below about your experience
with SICP so far!
