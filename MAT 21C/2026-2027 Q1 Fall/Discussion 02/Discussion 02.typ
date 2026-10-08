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

#exercise(label: [Warm-Up])[
  Order the following numbers from least to greatest:
  $
    sqrt(2027), quad
    2027^2, quad
    2^2027, quad
    2027^2027, quad
    2027!, quad
    ln 2027, quad
    3^2027.
  $
]
#solution[
  The correct order is
  $
    ln 2027 < sqrt(2027) < 2027^2 < 2^2027 < 3^2027 < 2027! < 2027^2027.
  $
  Some of my intuition:
  - $ln 2027 < sqrt(2027)$ because $ln 2027$ is certainly less than $40$ ($2027$ is less than $e^40$) and $40$ is less than $sqrt(2027)$. Or make the plot of $ln x$ and $sqrt(x)$ and we will see that $ln x$ is always below $sqrt(x)$.
  - $sqrt(2027) < 2027^2$ because $sqrt(2027)$ is less than $2027$ and $2027$ is less than $2027^2$.
  - $2027^2 < 2^2027$ because exponential grows very fast, $2^(10) = 1024$.
  - $2^2027 < 3^2027$ because $2 < 3$.
  - $3^2027 < 2027!$ because they are both products of $2027$ numbers, but $3^2027$ is the product of $2027$ threes, while $2027!$ is the product of $1, 2, 3, ..., 2027$, which is much larger.
  - $2027! < 2027^2027$ because $2027^2027$ is the product of $2027$ copies of $2027$, which is even larger.
]

= Limit Comparison Test

Consider the series
$
  sum_(n=1)^oo (n - ln n) / (n^2 + sqrt(n) + 1).
$
Intuitively, for very large $n$, we want to say that $n$ is so large compared to $ln n$ that the numerator is effectively $n$, and similarly, $n^2$ is so large compared to $sqrt(n)$ and $1$ that the denominator is effectively $n^2$.
Therefore, we are just looking at the series
$
  sum_(n=1)^oo n / n^2 = sum_(n=1)^oo 1/n
$
which is a divergent $p$-series with $p = 1$.

The *limit comparison test* is what makes this intuition rigorous.
Let us introduce the notation that
$
  a_n << b_n quad "if" quad
  lim_(n -> oo) (a_n)/(b_n) = 0 quad "or equivalently" quad
  lim_(n -> oo) (b_n)/(a_n) = oo.
$
The limit comparison test states that
#theorem[
  #set enum(spacing: 1.5em)
  If $a_n >= 0$ and $b_n >= 0$ are nonnegative terms, then
  + If $display(lim_(n -> oo) (a_n)/(b_n) = c)$ and $0 < c < oo$, then $display(sum a_n)$ and $display(sum b_n)$ either both converge or both diverge.
  + If $a_n << b_n$, then the convergence of $display(sum b_n)$ implies the convergence of $display(sum a_n)$ and the divergence of $display(sum a_n)$ implies the divergence of $display(sum b_n)$.
    It is as if
    $
      sum a_n <= sum b_n
    $
    except that technically, this inequality is only true if the we restrict the lower bounds of the series to be sufficiently large.
]
If we return to our example, we have concluded that we should compare the series to $sum_(n = 1)^(oo) 1/n$ and this is exactly what we will do.
Rather than using nested fractions, it is the most elegant to multiply $(n - ln n) / (n^2 + sqrt(n) + 1)$ by the inverse of $1/n$, so we have
$
  lim_(n -> oo) (n - ln n) / (n^2 + sqrt(n) + 1) dot.c n/1
  &= lim_(n -> oo) (n^2 - n ln n) / (n^2 + sqrt(n) + 1) \
  &= lim_(n -> oo) (1 - (ln n)/n) / (1 + 1/sqrt(n) + 1/n^2) \
  &= 1
$
where we used the fact that
$
  lim_(n -> oo) (ln n)/n =^("LH") lim_(n -> oo) (1/n)/1 = 0.
$

#tip[
  Before we move on to exercises, let us note that
  $
    "constant" << ln n << dots.c << n^(1/3) << n^(1/2) << n << n^2 << n^3 << dots.c << e^n << n! << n^n.
  $
  Remembering this will help us identify the fastest growing terms in the numerator and denominator of a series.
]

#exercise[
  #set enum(spacing: 1.5em)
  Determine whether the following series converge or diverge.
  + $display(sum_(n=1)^(oo) (2^n + 5)/(3^n))$
  + $display(sum_(n=2)^(oo) 1/(n sqrt(n^2 - 1)))$
  + $display(sum_(n=1)^(oo) (n^2)/(e^n))$ (hint: split $display((n^2)/(e^n) = (n^2)/(e^(n\/2)) dot.c 1/(e^(n\/2)))$)
]
#solution[
  + The fastest growing term in the numerator is $2^n$ and the fastest growing term in the denominator is $3^n$, so we will compare to $sum_(n=1)^(oo) (2^n)/(3^n)$.
    We have
    $
      lim_(n -> oo) (2^n + 5)/(3^n) dot.c (3^n)/(2^n) = lim_(n -> oo) (1 + 5/(2^n)) = 1.
    $
    Since $sum_(n=1)^(oo) (2^n)/(3^n)$ is a convergent geometric series, we conclude that $sum_(n=1)^(oo) (2^n + 5)/(3^n)$ converges.
    #tip[
      This problem can be more easily solved by splitting the series into two parts.
      This is mistake in problem design on my part.
      A better problem is perhaps
      $
        sum_(n=1)^(oo) (2^n + 5)/(3^n - 2^n).
      $
    ]
  + For large $n$, $1$ is negligible compared to $n^2$, so we will compare to $sum_(n=2)^(oo) 1/(n sqrt(n^2)) = sum_(n=2)^(oo) 1/(n^2)$.
    We have
    $
      lim_(n -> oo) 1/(n sqrt(n^2 - 1)) dot.c n^2 = lim_(n -> oo) n/sqrt(n^2 - 1) = lim_(n -> oo) 1/sqrt(1 - 1/n^2) = 1.
    $
    Since $sum_(n=2)^(oo) 1/(n^2)$ is a convergent $p$-series with $p = 2 > 1$, we conclude that $sum_(n=2)^(oo) 1/(n sqrt(n^2 - 1))$ converges.
  + We expect that $n^2 << e^(n\/2)$, so we will expect
    $
      n^2/(e^n) = (n^2)/(e^(n\/2)) dot.c 1/(e^(n\/2)) << 1/(e^(n\/2)) = (1/(e^(1\/2)))^n.
    $
    Explicitly, we need to write
    $
      lim_(n -> oo) (n^2)/(e^n) dot.c (e^(n\/2))/1 = lim_(n -> oo) n^2/(e^(n\/2))
      =^("LH") lim_(n -> oo) 4n/(e^(n\/2))
      =^("LH") lim_(n -> oo) 8/(e^(n\/2)) = 0.
    $
    Since $sum_(n=1)^(oo) 1/(e^(n\/2))$ is a convergent geometric series ($abs(r) = e^(-1\/2) < 1$), we conclude that $sum_(n=1)^(oo) (n^2)/(e^n)$ converges.
]

= Ratio and Root Tests

The ratio and root tests extend our ability to determine convergence and divergence of series that involve products of factorial terms $n!$ and power terms like $n^k$, $a^n$, and $n^n$.

For series with factorials, the ratio test is essentially the exclusive test.
For example, consider
$
  sum_(n=1)^(oo) (2^n)/(n!).
$
We will set $a_n = (2^n)/(n!)$ and decide whether
$
  lim_(n -> oo) abs(a_(n+1)/a_n)
$
is less than $1$ (convergent), greater than $1$ (divergent), or equal to $1$ (inconclusive).
The elegant way to write $a_(n+1)\/a_n$ is not through nested fractions but rather multiplying $a_(n+1)$ by the inverse of $a_n$:
$
  a_(n+1) 1/(a_n) = (2^(n+1))/(n+1)! dot.c n!/2^n = 2/(n+1).
$
Thus, we have
$
  lim_(n -> oo) abs(a_(n+1)/a_n) = lim_(n -> oo) 2/(n+1) = 0 < 1,
$
which implies that the series $sum_(n=1)^(oo) (2^n)/(n!)$ converges.

The root test is effective when the terms are products of power terms.
For example, consider
$
  sum_(n=1)^(oo) (n^7)/(n^n).
$
We can apply the root test by looking at the limit
$
  lim_(n -> oo) abs(a_n)^(1/n) = lim_(n -> oo) (n^(7\/n))/(n) = lim_(n -> oo) ((n^(1\/n))^7)/(n) = 0 < 1.
$
Similar to the ratio test, a limit of less than $1$ implies convergence, a limit greater than $1$ implies divergence, and a limit equal to $1$ is inconclusive.

#tip[
  An identity that is worth remembering for the root test is that
  $
    lim_(n -> oo) n^(1\/n) = 1,
  $
  which we used in the previous example.
]

#exercise[
  #set enum(spacing: 1.5em)
  Determine whether the following series converge or diverge.
  + $display(sum_(n=1)^(oo) ((2n)!)/(n+2))$
  + $display(sum_(n=1)^(oo) (2 n)/(e^(n^2)))$
]
#solution[
  + We will apply the ratio test.
    We calculate
    $
      lim_(n -> oo) abs(a_(n+1)/a_n) &= lim_(n -> oo) (2(n+1))!/(n+3) dot.c (n+2)/(2n)! \
      &= lim_(n -> oo) (2n + 2)!/(n+3) dot.c (n+2)/(2n)! \
      &= lim_(n -> oo) (2n + 2)(2n + 1) (n + 2)/(n + 3) \
      &= lim_(n -> oo) (2n + 2)(2n + 1) (1 + 2\/n)/(1 + 3\/n) \
      &= oo > 1.
    $
    Since the limit is greater than $1$, we conclude that the series $sum_(n=1)^(oo) ((2n)!)/(n+2)$ diverges.
  + Ratio test also works well, but we will apply the root test.
    We calculate
    $
      lim_(n -> oo) abs(a_n)^(1/n) = lim_(n -> oo) ((2 n)/(e^(n^2)))^(1/n) = lim_(n -> oo) (2^(1\/n) n^(1\/n))/(e^n) = 0 < 1.
    $
    Since the limit is less than $1$, we conclude that the series $sum_(n=1)^(oo) (2 n)/(e^(n^2))$ converges.


]
