#import "../Packages/canvas-html.typ": *
#import "@preview/physica:0.9.8"

#let dd = physica.dd.with(d: $d$)

#set document(
  title: "Discussion 2 Notes",
  author: "Chen Liang",
  date: datetime(year: 2026, month: 10, day: 6),
)

#show: canvas-html.with(
  course-id: "1103419",
  image-ids: (:),
)

= Warm-Up

#exercise(label: [Warm-up])[
  #set enum(numbering: "(a)")
  Consider the series
  $
    1 - 1 + 1 - 1 + 1 - 1 + 1 - dots.c.
  $
  We know that the series diverges, but see if you can "deceive" someone into thinking that the value of the series is...
  + $0$
  + $1$
  + $2$
  + $-1$
]
#solution[
  #set enum(numbering: "(a)")
  + We can group the terms as
    $
      (1 - 1) + (1 - 1) + (1 - 1) + dots.c = 0 + 0 + 0 + dots.c = 0.
    $
    #h(1fr)
  + We can group the terms as
    $
      1 + (-1 + 1) + (-1 + 1) + dots.c = 1 + 0 + 0 + dots.c = 1.
    $
  + We can split the series into two to get
    $
      1 & & +1 & & +1 & & +1 & & +1 & & + dots.c \
      & -1 & & -1 & & -1 & & -1 & & -1 & dots.c
    $
    and then shift the second series to the right by one to get
    $
      1 & & +1 & & +1 & & +1 & & +1 & & + dots.c \
      & std.hide(-1) & & -1 & & -1 & & -1 & & -1 & dots.c
    $
    Putting them back and cancel each $-1$ with the next $+1$, we get
    $
      1 + 1 + (-1 + 1) + (-1 + 1) + dots.c = 2.
    $
  + We again split the series into two to get
    $
      1 & & +1 & & +1 & & +1 & & +1 & & + dots.c \
      & -1 & & -1 & & -1 & & -1 & & -1 & dots.c
    $
    and then shift the first series to the right by one to get
    $
      & & +1 & & +1 & & +1 & & +1 & & + dots.c
      \
      & -1 & & -1 & & -1 & & -1 & & -1 & dots.c
    $
    Putting them back and cancel each $+1$ with the next $-1$, we get
    $
      -1 + (1 - 1) + (1 - 1) + (1 - 1) + dots.c = -1.
    $
  Of course, none of the above manipulations are valid because the series diverges, and we can only do these moves if all the terms of the series are nonnegative so the series represents an _area_.

  Series with mixed signs may or may not behave nicely, depending on whether it converges absolutely or conditionally, and this is what we will explore today.
]

= Series with Negative Terms

Consider the alternating harmonic series
$
  1 - 1/2 + 1/3 - 1/4 + 1/5 - 1/6 + 1/7 - 1/8 + dots.c.
$
The alternating series test tells us that this series converges, and in fact, it converges to $ln(2)$ (the past discussion worksheet guides you through the proof, but I prefer to use my own discussion notes).
#theorem(label: [Alternating Series Test])[
  If $(a_(1), a_(2), a_(3), ...)$ is a sequence that
  - is positive (_i.e._ $a_(n) > 0$),
  - is decreasing, and
  - converges to $0$,
  then the alternating series
  $
    sum_(n = 1)^oo (-1)^(n + 1) a_(n) = a_(1) - a_(2) + a_(3) - a_(4) + dots.c
  $
  converges.
  Additionally, if $(a_(1), a_(2), a_(3), ...)$ does not tend to $0$, then the series diverges.

  The alternating series test also applies to $sum_(n = 1)^oo (-1)^(n) a_(n) = -a_(1) + a_(2) - a_(3) + a_(4) - dots.c$.
]
You can think about how to prove that if $(a_(1), a_(2), a_(3), ...)$ does not tend to $0$, the alternating series diverges.
It is not as simple as the $n$th term test, the missing gap is to prove that if $(a_(1), a_(2), a_(3), a_(4), ...)$ does not tend to $0$, then $(a_(1), -a_(2), a_(3), -a_(4), ...)$ also does not tend to $0$.

Let us do further analysis of the alternating harmonic series.
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
We can in fact rearrange the terms to get any value we want!
This is similar to the warm-up question where we can rearrange the terms to get $0$, $1$, $2$, or $-1$.
The moral of the story is that series with negative terms can be very ill-behaved.

However, some series with negative terms are nice and are protected from rearrangement: if both the positive bin and the negative bin converge to finite values, or equivalently, if the series converge absolutely.

- We say that a series $sum a_(n)$ *converges absolutely* if the series of absolute values $sum abs(a_(n))$ converges.
- We say that a series $sum a_(n)$ *converges conditionally* if the series converges but does not converge absolutely.

When a series converges absolutely, both the positive bin and the negative bin converge, and the series would converge and is just the difference of the two bins.
This is called the *absolute convergence test*, but I hope that I made it an intuitive enough result that you do not need to hardcode the theorem in your head.

#exercise[
  #set enum(spacing: 2em)
  Determine whether the series converges absolutely, converges conditionally, or diverges.
  + $display(1/sqrt(2) - 1/sqrt(3) + 1/sqrt(4) - 1/sqrt(5) + dots.c)$
  + $display(sum_(n = 1)^oo (-1)^(n) (n + 1)/(2n))$
  + $display(sum_(n = 1)^oo (-1)^(n) cos(pi n)/(n!))$
  + (Bonus) $display(1/1 - 3/2 + 1/3 - 3/4 + 1/5 - 3/6 + 1/7 - 3/8 + dots.c)$
]
#solution[
  + It is alternating and the magnitude of the terms $1/sqrt(2), 1/sqrt(3), 1/sqrt(4), ...$ is
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
      sum_(n = 1)^oo (-1)^(n) (n + 1)/(2n) = -2/2 + 3/4 - 4/6 + 5/8 - 6/10 + dots.c
    $
    is alternating (we can know without writing it out because $(n + 1)/(2n)$ is positive), but since
    $
      lim_(n -> oo) (n + 1)/(2n) = lim_(n -> oo) n/n (1 + 1/n)/2 = 1/2 != 0,
    $
    the series diverges.
  + The series
    $
      sum_(n = 1)^oo (-1)^(n) cos(pi n)/(n!) & = -(-1)/(1!) + 1/(2!) - (-1)/(3!) + 1/(4!) - (-1)/(5!) + dots.c
      \
      & = 1/(1!) + 1/(2!) + 1/(3!) + 1/(4!) + 1/(5!) + dots.c
    $
    is actually not alternating.
    If we were trying to apply the alternating series test, the failure point is that $cos(pi n)/(n!)$ is not positive.
    Now, the series
    $
      1/(1!) + 1/(2!) + 1/(3!) + 1/(4!) + 1/(5!) + dots.c = sum_(n = 1)^oo 1/(n!)
    $
    converges absolutely by the ratio test because
    $
      lim_(n -> oo) abs(1/((n + 1)!) dot.c n!/1) = lim_(n -> oo) 1/(n + 1) = 0 < 1.
    $
  + The series
    $
      1/1 - 3/2 + 1/3 - 3/4 + 1/5 - 3/6 + 1/7 - 3/8 + dots.c
    $
    is alternating but the magnitude of the terms
    $
      1/1, 3/2, 1/3, 3/4, 1/5, 3/6, ...
    $
    is not decreasing, so we cannot apply the alternating series test.
    The terms do converge to $0$ because the denominator goes to infinite while the numerator is at most $3$, so the $n$th term test is also inconclusive.
    Ratio and root tests are also inconclusive, and the integral test is not applicable because the terms are not decreasing.
    It does not look like a telescoping series, and we are left with taking the absolute value and do comparison test.

    We see that
    $
      1/1 + 3/2 + 1/3 + 3/4 + 1/5 + 3/6 + dots.c >= 1/1 + 1/2 + 1/3 + 1/4 + 1/5 + 1/6 + dots.c = oo
    $
    diverges by comparison with the $p$-series with $p = 1$, so the original series does not converge absolutely.

    It is a genuinely difficult question to determine whether the original series converges conditionally or diverges.
    The key is to write it in a closed form by noticing that $2 - (-1)^(n + 1)$ alternates between $1$ and $3$, so we can write the original series as
    $
      1/1 - 3/2 + 1/3 - 3/4 + 1/5 - 3/6 + 1/7 - 3/8 + dots.c = sum_(n = 1)^oo (-1)^(n + 1) (2 - (-1)^(n + 1))/n.
    $
    Then, we can try to apply the algebraic limit theorem to rewrite the series as
    $
      sum_(n = 1)^oo (-1)^(n + 1) (2 - (-1)^(n + 1))/n = sum_(n = 1)^oo (-1)^(n + 1) 2/n - sum_(n = 1)^oo 1/n.
    $
    The first series $sum_(n = 1)^oo (-1)^(n + 1) 2/n$ converges to some finite number $L$ by the alternating series test, and the second series $sum_(n = 1)^oo 1/n = oo$ diverges by the $p$-series test with $p = 1$.
    Since $L - oo = -oo$ is not an indeterminate form, the algebraic limit theorem succeeds and tells us that the original series diverges to $-oo$.
]


