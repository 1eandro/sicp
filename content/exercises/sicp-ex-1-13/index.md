---
title: Sicp Ex 1.13
date: 2020/10/27
---

This is the 13 exercise in Sicp. Here we prove
that Fib(n) is equal to varphi divided by root 5.

# The Question

**Exercise 13:** Prove that Fib(*n*) is the closest integer to $ \varphi^{n}/\sqrt[]{5} $ ,
where $ \varphi = (1 + \sqrt[]{5})/2 $  Hint : Let $\psi = (1 − \sqrt[]{5})/2$. Use induction
and the definition of the Fibonacci numbers (see Section 1.2.2) to
prove that Fib(*n*) = $(\varphi^{n} − \psi^{n})/\sqrt[]{5}$.

# My Thoughts

We'll use some basic algebra to prove this. Also have a look at the
definition of the Fibonacci sequence.

# The Answer

Ok here is some things we know:

 - $$ \varphi = 1 + \sqrt[]{5}/2 $$
 - $$ \psi = 1 - \sqrt[]{5}/2 $$
 - $$ Fib(n) = Fib(n - 1) + Fib(n - 2) $$

We need to prove the following: 

 - $$ Fib(n) = (\varphi^{n} − \psi^{n})/\sqrt[]{5} $$
 - $$ Fib(n) \approx \frac{\varphi^{n}}{\sqrt[]{5}}$$

## $ Fib(n) = (\varphi^{n} − \psi^{n})/\sqrt[]{5} $ 

So let us first substitute the values with their definitions

$$ 
\begin{align}
\frac{\varphi^{n} - \psi^{n}}{\sqrt[]{5}} &= \frac{\varphi^{n - 1} - \psi^{n - 1}}{\sqrt[]{5}} + \frac{\varphi^{n - 2} - \psi^{n - 2}}{\sqrt[]{5}} \\
\varphi^{n} - \psi^{n} &= \varphi^{n - 1} - \psi^{n - 1} + \varphi^{n - 2} - \psi^{n - 2} \\
    &=\frac{\varphi^{n}}{\varphi} - \frac{\psi^{n}}{\psi} + \frac{\varphi^{n}}{\varphi^{2}} - \frac{\psi^{n}}{\psi^{2}} \\
    &=\frac{\varphi^{n}}{\varphi} + \frac{\varphi^{n}}{\varphi^{2}} - \frac{\psi^{n}}{\psi} - \frac{\psi^{n}}{\psi^{2}} \\
    &=\varphi^{n}\bigg(\frac{1}{\varphi} + \frac{1}{\varphi^{2}}\bigg) - \psi^{n}\bigg(\frac{1}{\psi} + \frac{1}{\psi^{2}} \bigg)
\end{align}
$$

Looking at this, it will probably occur to you that $\bigg(\frac{1}{\varphi} + \frac{1}{\varphi^{2}}\bigg)$ and $\bigg(\frac{1}{\psi} + \frac{1}{\psi^{2}} \bigg)$
are equal to one. Let's prove that using the values of $\varphi$ and $\psi$:

$$
\begin{align}
\varphi^{n} - \psi^{n} &= \varphi^{n}\bigg(\frac{1}{(1 + \sqrt[]{5})/2} + \frac{1}{((1 + \sqrt[]{5})/2)^{2}}\bigg) - \psi^{n}\bigg(\frac{1}{(1 - \sqrt[]{5})/2} + \frac{1}{((1 - \sqrt[]{5})/2)^{2}} \bigg) \\
&= \varphi^{n}\bigg(\frac{2}{1 + \sqrt[]{5}} + \frac{4}{(1 + \sqrt[]{5})^{2}}\bigg) - \psi^{n}\bigg(\frac{2}{1 - \sqrt[]{5}} + \frac{4}{(1 - \sqrt[]{5})^{2}} \bigg) \\
&= \varphi^{n}\bigg(\frac{2(1 + \sqrt[]{5})}{(1 + \sqrt[]{5})^{2}} + \frac{4}{(1 + \sqrt[]{5})^{2}}\bigg) - \psi^{n}\bigg(\frac{2(1 - \sqrt[]{5})}{(1 - \sqrt[]{5})^{2}} + \frac{4}{(1 - \sqrt[]{5})^{2}} \bigg) \\
&= \varphi^{n}\bigg(\frac{2(1 + \sqrt[]{5})+ 4}{(1 + \sqrt[]{5})^{2}}\bigg) - \psi^{n}\bigg(\frac{2(1 - \sqrt[]{5}) + 4}{(1 - \sqrt[]{5})^{2}} \bigg) \\
&= \varphi^{n}\bigg(\frac{2 + 2\sqrt[]{5} + 4}{1 + 5 + 2\sqrt[]{5}}\bigg) - \psi^{n}\bigg(\frac{2 + 4 - 2\sqrt[]{5}}{1 + 5 - 2\sqrt[]{5}^{2}} \bigg) \\
&= \varphi^{n}\bigg(\frac{6 + 2\sqrt[]{5}}{6 + 2\sqrt[]{5}}\bigg) - \psi^{n}\bigg(\frac{6 - 2\sqrt[]{5}}{6 - 2\sqrt[]{5}^{2}} \bigg) \\
\varphi^{n} - \psi^{n}&=\varphi^{n} - \psi^{n} \\ 
\end{align}
$$

That is the proof that $ Fib(n) = (\varphi^{n} − \psi^{n})/\sqrt[]{5} $ .

As you can see, inserting the values, of $\varphi$ and $\psi$ is quite a pain, when it obvious that $\bigg(\frac{1}{\varphi} + \frac{1}{\varphi^{2}}\bigg)$ and $ \bigg(\frac{1}{\psi} + \frac{1}{\psi^{2}} \bigg)$ are equal to one.
The thing is that this is a formal proof. The thing with formal proofs is that you need to write
all the steps, and it is often just easier to "spend 5 mins in the queue" than to "spend 20 mins getting around the queue"

## $ Fib(n) \approx \frac{\varphi^{n}}{\sqrt[]{5}}$

We now need to prove that Fib(n) is the closest integer to $\varphi^{n}$.
Notice that if $\varphi^{n}$ is the closest number to Fib(n), then,
the difference between the two must always less than or equal to $\frac{1}{2}$.
So let's re-arrange the equation:

$$ Fib(n) - \frac{\varphi^{n}}{\sqrt[]{5}} \leq \frac{1}{2} $$

Look at the previous equation that we proved:

$$
\begin{align}
Fib(n) &= (\varphi^{n} − \psi^{n})/\sqrt[]{5} \\
&= \frac{\varphi^{n}}{\sqrt[]{5}} - \frac{\psi^{n}}{\sqrt[]{5}} \\
Fib(n) - \frac{\varphi^{n}}{\sqrt[]{5}} &= - \frac{\psi^{n}}{\sqrt[]{5}} \\
\end{align}
$$

From that we derive that all we need to do is to prove that 
$$ - \frac{\psi^{n}}{\sqrt[]{5}} \leq \frac{1}{2} $$

Which equals to
$$ \psi^{n} \leq \frac{\sqrt[]{5}}{2} $$

A quick evaluation of $\frac{\sqrt[]{5}}{2}$  on the calculator gives us

$$ 1.1180339 ..$$

We know that $\psi = -0.618304...$ and hence we can say
$$ \psi^{n} < 1 $$

It soon becomes pretty obvious that
$$ \psi^{n} \leq \frac{\sqrt[]{5}}{2} $$

and therefore:

##### Fib(n) is the closest integer to $\frac{\varphi^{n}}{\sqrt[]{5}}$

**QED**

