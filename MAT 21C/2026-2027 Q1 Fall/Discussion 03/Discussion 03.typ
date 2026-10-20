#import "../Packages/canvas-html.typ": *
#import "@preview/physica:0.9.8"

#let dd = physica.dd.with(d: $d$)

#set document(
  title: "Discussion 3 Notes",
  author: "Chen Liang",
  date: datetime(year: 2026, month: 10, day: 13),
)

#show: canvas-html.with(
  course-id: "1103419",
  image-ids: (
    "QR code for Conditional Convergence Playground.png": "32123988",
    "Rearranged series.svg": "32123989",
  ),
)

#context if target() == "html" {
  outline()
}

= Warm-Up

#exercise(label: [Warm-up])[
  #set enum(numbering: "(a)")
  The alternating harmonic series
  $
    1 - 1/2 + 1/3 - 1/4 + 1/5 - 1/6 + 1/7 - 1/8 + dots.c
  $
  converges to $ln(2)$.
  Do you think it is possible to rearrange the terms to make it converge to a different value?
  #figure(
    image(
      "QR code for Conditional Convergence Playground.png",
      width: 100pt,
      alt: "QR code for Conditional Convergence Playground",
    ),
    caption: [
      You can play around with rearrangements at
      #link("https://chen2357.github.io/teach/conditional-convergence-playground/")
    ]
  )
]
#solution[
  Yes, it is possible to rearrange the terms to make it converge to any value we want, or even diverge.
  We can collect the positive terms and the negative terms separately to get two bins:
  $
    "Positive bin: " & 1, 1/3, 1/5, 1/7, 1/9, ...,
    \
    "Negative bin: " & -1/2, -1/4, -1/6, -1/8, ... .
  $
  The positive bin consists of the terms with odd denominators $1/(2n + 1)$ and the negative bin consists of the terms with even denominators $-1/(2n)$.
  If we try to sum up the positive bin, we would get $oo$ by comparison with $sum 1/(2n)$ (which diverges by integral test or further comparison with $p$-series $sum 1/n$).
  Similarly, the negative bin also diverges.
  We can leverage this observation to rearrange the terms to get any value we want!

  Let us say, we want to rearrange the terms to get $0$, then we can do the following:
  + Take the first term from either bin and start summing up.
    We will start with $1$.
  + If our current sum is greater than $0$, we take as much as we need from the negative bin to make the sum less than (or equal to) $0$.
    In this case, we need to take $-1/2$ through $-1/8$ to get
    $
      1 - 1/2 - 1/4 - 1/6 - 1/8 = -0.041666... .
    $
  + If our current sum is less than (or equal to) $0$, we take as much as we need from the positive bin to make the sum greater than $0$.
    In this case, we just need to take $1/3$ to get
    $
      1 - 1/2 - 1/4 - 1/6 - 1/8 + 1/3 = 0.291667333... .
    $
  + We repeat the above two steps indefinitely, and we will get
    $
      1 - 1/2 - 1/4 - 1/6 - 1/8 + 1/3 - 1/10 - 1/12 - 1/14 - 1/16 approx -0.025595...
    $
    and then
    $
      1 - 1/2 - 1/4 - 1/6 - 1/8 + 1/3 - 1/10 - 1/12 - 1/14 - 1/16 + 1/5 approx 0.174404...
    $
    and so on.
  This process will produce a series that converges to $0$.
  The key is that because both bins diverge, when we are in step 2 or step 3, we always can take finitely many terms to get the sum to the other side of $0$.
  #figure(
    image(
      "Rearranged series.svg",
      width: 80%,
      alt: "Points in the xy-plane. From left to right, the points decrease in y but it shoots up whenever it goes below the x-axis.",
    ),
    caption: [
      The modified series $1 - 1/2 - 1/4 - 1/6 - 1/8 + 1/3 - 1/10 - dots.c$.
      The $y$-values of the points correspond to the partial sums, and we see that they tend towards $0$.
    ]
  )

  Not all series with negative terms are this wild.
  If both the positive bin and the negative bin converge to finite values, then the series would converge and is just the difference of the two bins, and it will be protected from rearrangement.
  We call this *absolute convergence*.
]

= Alternating Series Test

Exactly because of the discussion above, as mathematicians, we like to further classify convergent series into two categories:
- We say that a series $sum a_(n)$ *converges absolutely* if the series of absolute values $sum abs(a_(n))$ converges.
- We say that a series $sum a_(n)$ *converges conditionally* if the series converges but does not converge absolutely.

The only test we are learning in this class that can lead to the conclusion of conditional convergence is the *alternating series test*.
So if our conclusion is conditional convergence, we better have applied the alternating series test.

#theorem(label: [Alternating Series Test])[
  We can apply the alternating series test to alternating series, which are of the form
  $
    sum_(n = 1)^oo (-1)^(n + 1) a_n = a_1 - a_2 + a_3 - a_4 + dots.c
  $
  where $a_n$ are positive numbers.
  If $a_1, a_2, a_3, ...$ is a sequence that
  - is decreasing (eventually), and
  - converges to $0$,
  then the alternating series above converges either absolutely or conditionally.

  - If $sum a_n$ converges, then the alternating series converges absolutely.
  - If $sum a_n$ diverges, then the alternating series converges conditionally.

  The alternating series test also applies to
  $
    sum_(n = 1)^oo (-1)^(n) a_n = -a_1 + a_2 - a_3 + a_4 - dots.c.
  $
]
#tip[
  If the sequence $a_n$ does not converge to $0$, then the series diverges by the $n$-th term test.
]

#exercise[
  #set enum(spacing: 2em)
  Determine whether the series converges absolutely, converges conditionally, or diverges.
  + $display(1/sqrt(2) - 1/sqrt(3) + 1/sqrt(4) - 1/sqrt(5) + dots.c)$
  + $display(sum_(n = 1)^oo (-1)^(n + 1) (n + 1)/(n^2))$
  + $display(sum_(n = 1)^oo (-1)^(n) cos(pi n)/(n))$
]
#solution[
  + It is obviously alternating and the magnitude of the terms $1/sqrt(2), 1/sqrt(3), 1/sqrt(4), ...$ is
    - decreasing because the denominator $sqrt(n)$ is increasing, and
    - converging to $0$ because the denominator $sqrt(n)$ goes to infinity.
    So the series converges by the alternating series test.
    We still need to determine whether it converges absolutely or conditionally.
    The series of absolute values is
    $
      sum_(n = 2)^oo 1/sqrt(n) = 1/sqrt(2) + 1/sqrt(3) + 1/sqrt(4) + dots.c,
    $
    which diverges by the $p$-series test with $p = 1/2 < 1$.
    So the original series only converges conditionally.
  + The series
    $
      sum_(n = 1)^oo (-1)^(n + 1) (n + 1)/(n^2) = 2/1 - 3/4 + 4/9 - 5/16 + 6/25 - 7/36 + dots.c
    $
    is alternating (algebraically, we can say that $(-1)^(n + 1)$ is alternating and $(n+1)/(n^2)$ is positive, so them multiplied is alternating).
    Now we check that $(n+1)/(n^2)$ is decreasing and converging to $0$.
    - Because the numerator and the denominator are both increasing, it is not obvious that the fraction is decreasing.
      We need to find the derivative of the function $f(x) = (x + 1)/(x^2)$.
      We have
      $
        f'(x) = (x^2 - 2x (x + 1))/(x^4) = (-x^2 - 2x)/(x^4) < 0
      $
      for $x > 0$ (the $0$ is not important here), so $f(x)$ is decreasing for $x > 0$ and thus $(n + 1)/(n^2)$ is decreasing.
      #tip[
        Taking derivatives is the most universal way for checking whether a sequence is decreasing, but there can be clever ways to check as well.
        For this sequence, we can also say
        $
          (n + 1)/(n^2) = 1/n + 1/(n^2),
        $
        and since $1/n$ and $1/(n^2)$ are both decreasing, their sum is also decreasing.
      ]
    - The sequence $(n + 1)/(n^2)$ converges to $0$ because
      $
        lim_(n -> oo) (n + 1)/(n^2) = lim_(n -> oo) (1/n + 1/n^2) = 0.
      $
      the series diverges.
    The series of absolute values diverges by the limit comparison test with $sum 1/n$ because
    $
      lim_(n -> oo) ((n + 1)/(n^2)) dot.c n/1 = lim_(n -> oo) (1 + 1/n) = 1
    $
    and $sum 1/n$ diverges by the $p$-series test with $p = 1$.
    Therefore, the original series converges conditionally.
  + The series
    $
      sum_(n = 1)^oo (-1)^(n) cos(pi n)/(n) & = -(-1)/(1) + 1/(2) - (-1)/(3) + 1/(4) - (-1)/(5) + dots.c
      \
      & = 1/(1) + 1/(2) + 1/(3) + 1/(4) + 1/(5) + dots.c
    $
    is actually not alternating and is divergent.
   Both $(-1)^n$ and $cos(pi n)/n$ are alternating, and the product of two alternating sequences will always be not alternating.
]

= Story Time: Taylor Series

Let me finally start to explain why
$
  1 - 1/2 + 1/3 - 1/4 + 1/5 - 1/6 + 1/7 - 1/8 + dots.c = ln(2).
$
The secret is that
$
  ln (1 + x) = x - x^2/2 + x^3/3 - x^4/4 + x^5/5 - x^6/6 + dots.c
$
...but somehow only for $-1 < x <= 1$.

This is the most important and revolutionary idea that we want you to learn in the first half of this course:
we can hope to represent a function (like $ln(1 + x)$, $sin(x)$, $cos(x)$, $e^x$, etc.) as a *power series*!
Everything we learned was building up to this moment.

We should have two questions in mind:
+ How did we get this power series representation of $ln(1 + x)$?
+ Are we sure that the series converges to $ln(1 + x)$ and why only for $-1 < x <= 1$?

The answer to the first question is *Taylor series*.
A Taylor series is our best guess at a power series representation based on the value of the function and its higher order derivatives at a point.

Let $f(x) = ln(1 + x)$ and $p(x) = x - x^2/2 + x^3/3 - x^4/4 + x^5/5 - x^6/6 + dots.c$.
- We have $f(0) = 0$ and $p(0) = 0$, so they agree at $x = 0$.
- We have
  $
    f'(x) = 1/(1 + x)
  $
  and
  $
    p'(x) = 1 - x + x^2 - x^3 + x^4 - x^5 + dots.c = 1/(1 + x)
  $
  for $-1 < x < 1$ (geometric series).
  So of course, we have $f'(0) = p'(0)$ because $f'(x) = p'(x)$ agrees for all $-1 < x < 1$.
- The argument actually shortens for higher order derivatives because $f'(x) = p'(x)$ implies $f''(x) = p''(x)$, $f'''(x) = p'''(x)$, $f^((4)) (x) = p^((4)) (x)$, and so on.

Because for a general power series of the form
$
  p(x) = c_0 + c_1 x + c_2 x^2/2! + c_3 x^3/3! + c_4 x^4/4! + dots.c,
$
its value and derivatives at $x = 0$ are
$
  p(x) &= c_0 + c_1 x + c_2 x^2/2! + c_3 x^3/3! + c_4 x^4/4! + dots.c && ==> p(0) = c_0 \
  p'(x) &= c_1 + c_2 x + c_3 x^2/2! + c_4 x^3/3! + dots.c && ==> p'(0) = c_1 \
  p''(x) &= c_2 + c_3 x + c_4 x^2/2! + dots.c && ==> p''(0) = c_2 \
  & space.thin dots.v && space dots.v
$
Thus, we obtain our best guess for a power series representation of an arbitrary function $f(x)$ by setting $c_0 = f(0)$, $c_1 = f'(0)$, $c_2 = f''(0)$, $c_3 = f^((3))(0)$, $c_4 = f^((4))(0)$, and so on.
Therefore, we define the Taylor series of $f(x)$ at $x = 0$ to be
$
  p(x) = f(0) + f'(0) x + f''(0) x^2/2! + f^((3))(0) x^3/3! + f^((4))(0) x^4/4! + dots.c.
$

As another example, for $f(x) = e^x$, because $f^((n)) (x) = e^x$ and $f^((n)) (0) = 1$ for all $n$, we have that the Taylor series is
$
  p(x) = 1 + x + x^2/2! + x^3/3! + x^4/4! + dots.c.
$
You can convince yourself that $f(0) = p(0)$ and all higher derivatives agree at $x = 0$ because both $f(x)$ and $p(x)$ has the property that their derivatives are themselves.

#tip[
  Also be aware that this is not the only way to obtain the Taylor series.
  We can obtain Taylor series by operations on known Taylor series.
  For example, we can obtain the Taylor series for $ln (1 + 2x)$ by substituting $2x$ into the Taylor series for $ln(1 + x)$ to get
  $
    (2x) - (2x)^2/2 + (2x)^3/3 - (2x)^4/4 + dots.c.
  $
  Or consider $x^2 e^x$, we can multiply the Taylor series for $e^x$ by $x^2$ to get
  $
    x^2 + x^3 + x^4/2! + x^5/3! + x^6/4! + dots.c.
  $
]

Currently, the Taylor series and its original function are totally separate objects.
Why would we expect that $e^x$ and $1 + x + x^2/2! + x^3/3! + x^4/4! + dots.c$ to be equal for all $x$ when we only checked their behavior at $x = 0$?
This will brew the answer to the second question, but I will leave as a cliffhanger for next week!

= Interval of Convergence

For now, let us do something simpler.
We can analyze the convergence of the power series in isolated context and not worry about the original function.
We might wonder for what values of $x$ does the series
$
  x - x^2/2 + x^3/3 - x^4/4 + x^5/5 - x^6/6 + dots.c
$
converge.

This is an instance of the general problem of determining the *interval of convergence* of a power series
$
  c_0 + c_1 (x - a) + c_2 (x - a)^2 + c_3 (x - a)^3 + c_4 (x - a)^4 + dots.c.
$
The solution will consist of two or three parts:
+ Apply the ratio test or root test, so we are looking at the condition for absolute convergence
  $
    lim_(n -> oo) abs(((n+1)"-th term")/(n"-th term")) < 1 quad "or" quad
    lim_(n -> oo) abs(n"-th term")^(1\/n) < 1.
  $
+ If we find that the inequality holds regardless of $x$, then the interval of convergence is $(-oo, oo)$ (with radius of convergence $R = oo$).
  If we find that the inequality is only true for $x = a$, then the interval of convergence is just the point $a$ (with radius of convergence $R = 0$).
  Otherwise, rewrite the inequality as
  $
    abs(x - a) < R,
  $
  then $R$ would be the radius of convergence.
+ If $0 < R < oo$, then we have four possibilities
  $
    (a - R, a + R), quad [a - R, a + R), quad (a - R, a + R], quad [a - R, a + R].
  $
  We have to check for convergence at the endpoints $x = a - R$ and $x = a + R$ separately.

#exercise[
  #set enum(spacing: 2em)
  Find the interval of convergence of the following power series.
  + $display(x - x^2/2 + x^3/3 - x^4/4 + x^5/5 - x^6/6 + dots.c)$
  + $display(1 + x + x^2/2! + x^3/3! + x^4/4! + dots.c)$
]
#solution[
  + The series can be written as
    $
      sum_(n = 1)^oo (-1)^(n + 1) x^n/n.
    $
    The condition for absolute convergence by the ratio test is
    $
      lim_(n -> oo) abs(x^(n + 1)/(n + 1) dot.c n/x^n) < 1
    $
    We can compute
    $
      lim_(n -> oo) abs((x^(n+1))/(n+1) dot.c n/x^n) = lim_(n -> oo) abs(x) dot.c (1\/n)/(1 + 1\/n) = abs(x).
    $
    Therefore, the series converges absolutely if $abs(x) < 1$ and diverges if $abs(x) > 1$ (the radius of convergence is $1$).
    We still need to check the endpoints $x = -1$ and $x = 1$.
    - If $x = 1$, then the series becomes
      $
        1 - 1/2 + 1/3 - 1/4 + 1/5 - 1/6 + dots.c,
      $
      which converges conditionally by the alternating series test (as we discussed in the warm-up).
    - If $x = -1$, then the series becomes
      $
        -1 - 1/2 - 1/3 - 1/4 - 1/5 - 1/6 - dots.c = - (1 + 1/2 + 1/3 + 1/4 + 1/5 + 1/6 + dots.c),
      $
      which diverges by the $p$-series test (it's the negative of the harmonic series).
    Therefore, the interval of convergence is $(-1, 1]$.
  + The series can be written as
    $
      sum_(n = 0)^oo x^n/n!.
    $
    The condition for absolute convergence by the ratio test is
    $
      lim_(n -> oo) abs(x^(n + 1)/(n + 1)! dot.c n!/x^n) < 1
    $
    We can compute
    $
      lim_(n -> oo) abs(x^(n + 1)/(n + 1)! dot.c n!/x^n) = lim_(n -> oo) abs(x)/(n + 1) = 0 < 1,
    $
    which holds for all $x$.
    Therefore, the series converges absolutely for all $x$ and the interval of convergence is $(-oo, oo)$.
]
