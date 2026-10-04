#import "../Packages/canvas-html.typ": *

#let dd(x) = $space.thin d #x$

#set document(
  title: "Discussion 1 Notes",
  author: "Chen Liang",
  date: datetime(year: 2026, month: 9, day: 29),
)

#show: canvas-html.with(
  course-id: "1103419",
  image-ids: (
    "Geometric series.svg" : "32002762",
    "Integral test right.svg" : "32002765",
    "Integral test left.svg" : "32002764",
    "Tricky integral test.svg" : "32002766",
  ),
)

= Warm-Up

#exercise(label: [Warm-Up])[
  How to count to infinity in $10$ minutes?
]
#solution[
  There are many ways to do this, one of them is to use geometric series.
  When we start our timer,
  - we can spend the first $5$ minutes just to count $1$, we have $5$ minutes remaining;
  - spend the next $5\/2$ minutes to count $2$, we have $5\/2$ minutes remaining;
  - spend the next $5\/4$ minutes to count $3$, we have $5\/4$ minutes remaining;
  - spend the next $5\/8$ minutes to count $4$, we have $5\/8$ minutes remaining;
  - and so on.
  You can see that no matter how high we count, we will always have some time remaining, and we can just spend half of the remaining time to count the next integer.
  By the time our timer runs out, we will have counted infinitely many integers.

  This example illustrates that
  $
    5 + 5/2 + 5/4 + 5/8 + dots.c = 10.
  $
]

= Geometric Series

A *geometric series* is a series
$
  s = a_1 + a_2 + a_3 + dots.c
$
whose terms are related by a common ratio $r$:
$
  a_1 mapsto^(times r) a_2 mapsto^(times r) a_3 mapsto^(times r) a_4 mapsto^(times r) dots.c.
$
We can compare this series with the scaled version
$
  r s = a_2 + a_3 + a_4 + dots.c
$
to find that their difference is
$
  s - r s = a_1.
$
#figure(
  image(
    "Geometric series.svg",
    width: 90%,
    alt: "The equation as above with squares drawn around the terms depicting that a_1 is the biggest with a_2, a_3 and so on getting smaller and smaller.",
  ),
  caption: [Pictorial representation of the equation $s - r s = a_1$.],
) <fig:geometric-series>
Therefore, we can solve for $s$ to get
$
  s = (a_1)/(1 - r),
$
or can we?

One thing I want to bring your attention to is that the the above derivation only works when $abs(r) < 1$ (so the boxes in @fig:geometric-series do not grow unboundedly).
The full geometric series formula states that
$
  a_1 + a_2 + a_3 + dots.c = cases(
    (a_1)/(1 - r) & "if" abs(r) < 1\,,
    "diverges" & "if" abs(r) >= 1.
  )
$
Applying this formula to the warm-up question, we have that because $r = 1/2$ and $abs(r) = 1/2 < 1$,
$
  5 + 5/2 + 5/4 + 5/8 + dots.c = (5)/(1 - 1/2) = 10.
$
#tip[
  It is very important for you to write out that $abs(r) < 1$ before applying the geometric series formula.

  Also, it is not important that you index the terms exactly in the way I did.
  You can see from the concrete example that we are just taking the first term and dividing it by $1 - r$.
]

#exercise[
  #set enum(spacing: 1.5em)
  Determine whether the following series converge, if they do, find their sums.
  + $display(1/2 + 1/4 + 1/8 + 1/16 + 1/32 + dots.c)$
  + $display(sum_(n=2)^(oo) (-2)^n/3^(n+1))$
  + $display(sum_(n=1)^(oo) 3^((-2n)))$
]
#solution[
  + This is a geometric series with ratio $1\/2$.
    Because $abs(1\/2) < 1$, it converges and its sum is the first term divided by $1 - 1/2$, which is
    $
      (1/2) / (1 - 1/2) = 1.
    $
  + We can rewrite the series as
    $
      (-2)^2 / 3^3 + (-2)^3 / 3^4 + (-2)^4 / 3^5 + dots.c
    $
    This makes it clear that this is a geometric series with first term $(-2)^2 / 3^3$ and common ratio $-2/3$.
    Because $abs(-2/3) < 1$, the series converges and its sum is the first term divided by $1 - (-2/3)$, which is
    $
      ((-2)^2 / 3^3) / (1 - (-2/3)) = (4/27) / (5/3) = 4/45.
    $
  + Recall that
    $
      3^((-2n)) = (1/3)^(2n) = (1 / 3^2)^n,
    $
    so the series can be written as
    $
      (1 / 3^2) + (1 / 3^2)^2 + (1 / 3^2)^3 + dots.c.
    $
    This is a geometric series with first term $1/3^2$ and common ratio $1/3^2 < 1$, so it converges and its sum
    $
      (1/3^2) / (1 - 1/3^2) = (1/9) / (1 - 1/9) = (1/9) / (8/9) = 1/8.
    $
]

= Integral and Direct Comparison Test

Both the integral test and the direct comparison test are based on the following principle.
#theorem(label: [Principle of nonnegative series])[
  If the series
  $
    a_1 + a_2 + a_3 + a_4 + dots.c
  $
  consists only of nonnegative terms (that is $a_n >= 0$ for all $n$), then it either converges to a finite nonnegative number or diverges to infinity.
  The limit is always well-defined!
]
This is due to the monotone convergence theorem and you can think about how they relate to each other.
The principle is not necessarily true for series with negative terms, for example $1 - 1 + 1 - 1 + dots.c$ does not have a well-defined limit.

We have a simple characterization of series with nonnegative terms: it converges when there is a finite upper bound, and it diverges when it is infinite (we do not have to worry about divergence in the sense of having ill-defined limit like $1 - 1 + 1 - 1 + dots.c$).

#theorem(label: [Integral test])[
  Let $a_N, a_(N+1), a_(N+2), dots$ be a sequence of nonnegative terms.
  Suppose that $a_n = f(n)$, where $f(x)$ is a nonnegative and #highlight[decreasing] function of $x$ for all $x >= N$.
  Then, we have the inequality
  $
    integral_N^oo f(x) dd(x)
    <= sum_(n = N)^oo a_n
    <= a_N + integral_N^oo f(x) dd(x)
  $
  due to the following figures.
  #figure(
    image(
      "Integral test right.svg",
      width: 50%,
      alt: "Decreasing curve with rectangles whose left endpoints on the curve and right endpoints above it.",
    ),
    caption: [Lower bound for the series. Imagine the red dots as flag poles, we are swinging the rectangles to the right to stay above the curve.],
  )
  #figure(
    image(
      "Integral test left.svg",
      width: 50%,
      alt: "Decreasing curve with rectangles whose right endpoints on the curve and left endpoints below it.",
    ),
    caption: [Upper bound for the series. Imagine the red dots as flag poles, we are swinging the rectangles to the left to stay under the curve.],
  )

  #set list(spacing: 1.5em)
  In particular,
  - if $display(integral_N^oo f(x) dd(x) = L)$ is finite, then $display(sum_(n = N)^oo a_n <= a_N + L)$ is also finite by the upper bound;
  - if $display(integral_N^oo f(x) dd(x) = oo)$, then $display(sum_(n = N)^oo a_n = oo)$ by the lower bound.
]
The direct comparison test is an intuitive result.

#theorem(label: [Direct comparison test])[
  Let $display(sum_(n = N)^(oo) a_n)$ and $display(sum_(n = N)^(oo) b_n)$ be two series with $0 <= a_n <= b_n$.
  Then,
  $
    0 <= sum_(n = N)^(oo) a_n <= sum_(n = N)^(oo) b_n.
  $

  #set list(spacing: 1.5em)
  In particular,
  - if $display(sum_(n = N)^(oo) b_n)$ is finite, then $display(sum_(n = N)^(oo) a_n)$ is also finite by the upper bound;
  - if $display(sum_(n = N)^(oo) a_n = oo)$, then $display(sum_(n = N)^(oo) b_n = oo)$ by the lower bound.
]

In the following exercise, we might want to use the comparison test in conjunction with the integral test: we can compare a complicated series with a simpler one that yields a simple integral when we apply the integral test.

#exercise[
  #set enum(spacing: 1.5em)
  Determine whether the following series converge or diverge. (For the sake of exercise, try to use the integral test instead of $p$-series test.)
  + $display(1 + 1/4 + 1/9 + 1/16 + 1/25 + dots.c)$
  + $display(sum_(n = 1)^(oo) (2 + cos n)/n)$ (_hint_: $-1 <= cos x <= 1$)
  + $display(sum_(n = 1)^(oo) (2 + cos n)/n^2)$
  + $display(sum_(n = 1)^(oo) 1/((n - 4)^2 + 1))$ (_hint_: $display(integral_0^(oo) 1/(x^2 + 1) dd(x) = pi/2)$)
    #figure(
      image(
        "Tricky integral test.svg",
        width: 70%,
        alt: "Decreasing curve with rectangles whose left endpoints on the curve and right endpoints above it.",
      ),
      caption: [Graph of $1/((x-4)^2 + 1)$.],
    ) <fig:tricky-integral-test>
  + _Bonus:_ For the convergent series above, find a lower bound and an upper bound for their sums.
]
#solution[
  + This series can be written as
    $
      sum_(n = 1)^(oo) 1/n^2.
    $
    Notice that $1/x^2$ is nonnegative and decreasing for $x >= 1$, so it converges if and only if the integral
    $
      integral_1^(oo) 1/x^2 dd(x)
    $
    converges.
    We compute that
    $
      integral_1^(oo) 1/x^2 dd(x) = [-1/x]_1^(oo) = 1,
    $
    so the series converges.

    // we can apply the integral test and write
    // $
    //   integral_1^(oo) 1/x^2 dd(x) <= sum_(n = 1)^(oo) 1/n^2 <= 1 + integral_1^(oo) 1/x^2 dd(x).
    // $
    // We calculate that
    // $
    //   integral_1^(oo) 1/x^2 dd(x) = [-1/x]_1^(oo) = 1,
    // $
    // so the series converges and its sum is between $1$ and $2$.
  + Notice that this series is nonnegative because $2 + cos n >= 1 >= 0$, so we can apply the direct comparison test.
    Because $1 <= 2 + cos n <= 3$, we have
    $
      1/n <= (2 + cos n)/n <= 3/n.
    $
    Since $sum_(n = 1)^(oo) 1/n = oo$ by the integral test:
    $
      integral_(1)^(oo) 1/x dd(x) = [ln x]_1^(oo) = oo,
    $
    we also have that $sum_(n = 1)^(oo) (2 + cos n)/n = oo$ diverges.
  + Still using $1 <= 2 + cos n <= 3$, we have
    $
      1/n^2 <= (2 + cos n)/n^2 <= 3/n^2.
    $
    As shown in part 1, $sum_(n = 1)^(oo) 1/n^2$ converges, so $sum_(n = 1)^(oo) 3/n^2$ converges as well.
    By the direct comparison test, we have that
    $
      sum_(n = 1)^(oo) (2 + cos n)/n^2 <= sum_(n = 1)^(oo) 3/n^2 < oo
    $
    converges.
    // Thus, by part 1, we have
    // $
    //   1 <= sum_(n = 1)^(oo) 1/n^2 <= sum_(n = 1)^(oo) (2 + cos n)/n^2 <= 3 sum_(n = 1)^(oo) 1/n^2 <= 6.
    // $
  + It is very tempting to apply the integral test, but notice that the terms in
    $
      sum_(n = 1)^(oo) 1/((n - 4)^2 + 1) = 1/(9 + 1) + 1/(4 + 1) + 1/(1 + 1) + 1/(0 + 1) + 1/(1 + 1) + 1/(4 + 1) + 1/(9 + 1) + dots.c
    $
    are not decreasing (also clear from @fig:tricky-integral-test), so any interpolating function would also not be decreasing.
    The good news is that we can extract the first three terms
    $
      1/(9 + 1) + 1/(4 + 1) + 1/(1 + 1) = 1/10 + 1/5 + 1/2 = 8/10,
    $
    and apply the integral test to the rest of the series
    $
      1/(0 + 1) + 1/(1 + 1) + 1/(4 + 1) + 1/(9 + 1) + dots.c = sum_(n = 0)^(oo) 1/(n^2 + 1).
    $
    Since $1/(x^2 + 1)$ is nonnegative and decreasing for $x >= 0$, we have
    $
      integral_0^(oo) 1/(x^2 + 1) dd(x) <= sum_(n = 0)^(oo) 1/(n^2 + 1) <= 1/(0 + 1) + integral_0^(oo) 1/(x^2 + 1) dd(x).
    $
    Using the hint, this inequality becomes
    $
      pi/2 <= sum_(n = 0)^(oo) 1/(n^2 + 1) <= 1 + pi/2.
    $
    Therefore, the original series converges and its sum is between
    $
      8/10 + pi/2 quad "and" quad 8/10 + 1 + pi/2.
    $
  + For the series in part 1, we have
    $
      1 = integral_1^(oo) 1/x^2 dd(x) <= sum_(n = 1)^(oo) 1/n^2 <= 1 + integral_1^(oo) 1/x^2 dd(x) = 2.
    $
    For the series in part 3, we have
    $
      1 <= sum_(n = 1)^(oo) (2 + cos n)/n^2 <= 3 sum_(n = 1)^(oo) 1/n^2 <= 6.
    $
    #tip[
      The range $1$ to $6$ is quite a loose bound, we can get better bounds by extracting initial terms and applying the integral test to the rest of the series.
      For example, we can break the series into
      $
        1 + 1/4 + 1/9 + 1/16 + sum_(n = 5)^(oo) 1/n^2.
      $
      Applying the integral test to the last part, we have
      $
        integral_5^(oo) 1/x^2 dd(x) <= sum_(n = 5)^(oo) 1/n^2 <= 1/25 + integral_5^(oo) 1/x^2 dd(x).
      $
      Calculating the integral, we have
      $
        integral_5^(oo) 1/x^2 dd(x) = [-1/x]_5^(oo) = 1/5.
      $
      thus, the original series is between
      $
        1 + 1/4 + 1/9 + 1/16 + 1/5 quad "and" quad 1 + 1/4 + 1/9 + 1/16 + 1/25 + 1/5.
      $
      In decimals, we find that the sum is between $1.623$ and $1.664$.
    ]
    We have already found that the sum of the series in part 4 is between $8/10 + pi/2 approx 2.370$ and $8/10 + 1 + pi/2 approx 3.371$.
]
