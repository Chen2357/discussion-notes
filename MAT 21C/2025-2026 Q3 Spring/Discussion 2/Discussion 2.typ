#import "../Template/canvas-html.typ": *

#show: canvas-html.with(
  course-id: "1067114",
  image-ids: (
    "Finite geometric series.svg": "30778524",
    "Integral test left.svg": "30778526",
    "Integral test right.svg": "30778527",
    "Warm up limit.svg": "30778528",
    "Warm up steps.svg": "30778529",
  ),
  title: "MAT 21C Discussion 2",
  author: "Chen Liang",
  date: datetime(year: 2026, month: 4, day: 7),
)

#set heading(numbering: "§I")

= Warm-Up

#exercise[
  We will construct squares on top of the unit interval #mi(`[0, 1]`).
  First, we construct a square using the middle third #mi(`[1/3, 2/3]`) as the base; this creates two gaps on the left and right.
  On each gap, we repeat the same process: construct a square using the middle third of the gap as the base.
  We keep repeating this process indefinitely.
  #figure(
    image(
      "Warm up steps.svg",
      width: 90%,
      alt: "Four figures labeled Step 1 through 4. In each step, smaller and smaller blue squares appear in the middle of each gap."
    ),
    caption: [The first four steps of the construction.]
  )
  #figure(
    image(
      "Warm up limit.svg",
      width: 80%,
      alt: "Seemingly infinitely many blue squares of various sizes appear on the interval [0, 1] accumulating every point."
    ),
    caption: [The limit of the construction.]
  )
  Discuss with your group how you would approach the question of how much area is covered by the squares in the limit.
  Can you do it with simple algebra without using a series?
]
#solution[
  Let the total area covered by the squares in the limit be #mi(`A`).
  The entire construction can be seen as two scaled copies of itself (the left and right halves) plus the first square (the middle one).
  Suppose that each copy is scaled by a factor of #mi(`r`), then we have the equation
  #mitex(```
  A - 2 r A = \left( \frac{1}{3} \right)^2.
  ```)
  Solving for #mi(`A`), we get
  #mitex(```
  A = \frac{(1/3)^2}{1 - 2 r}.
  ```)

  The factor #mi(`r`) can be determined by taking the area of a square added in Step 2 (which has width #mi(`1/9`)) and dividing it by the area of the square added in Step 1 (which has width #mi(`1/3`)), which gives us
  #mitex(```
  r = \frac{(1/9)^2}{(1/3)^2} = \frac{1}{9}.
  ```)
  Therefore, the total area covered by the squares in the limit is
  #mitex(```
  A = \frac{1/9}{1 - 2 \cdot (1/9)} = \frac{1}{9 - 2} = \frac{1}{7}.
  ```)
]

= Geometric Series

The formula for geometric series is a special case of the trick we saw in the warm-up: we can get a closed form for a sum by subtracting a scaled version of itself.

If we are looking at the sum of six terms
#mitex(```
s_6 = a_1 + a_2 + a_3 + a_4 + a_5 + a_6,
```)
with common ratio #mi(`r`), we can compare it with the scaled version
#mitex(```
r s_6 = a_2 + a_3 + a_4 + a_5 + a_6 + r a_6
```)
and get the equation
#mitex(```
s_6 - r s_6 = a_1 - r a_6.
```)
#figure(
  image(
    "Finite geometric series.svg",
    width: 90%,
    alt: "The equations as above with squares drawn around the terms depicting that a_1 is the biggest and r a_6 is the smallest."
  ),
  caption: [The scaling trick applied to a partial geometric series.]
)
Therefore, we can solve for #mi(`s_6`) and get
#mitex(```
s_6 = a_1 + a_2 + a_3 + a_4 + a_5 + a_6 = \frac{a_1 - r a_6}{1 - r}.
```)
This works very generally: the sum of #mi(`N`) terms differing by a common ratio #mi(`r`) is given by
#mitex(```
a_1 + a_2 + \cdots + a_N = \frac{a_1 - r a_N}{1 - r},
```)
or in words
#mitex(```
\text{the sum of terms with common ratio } r = \frac{(\text{the first term} )- r \cdot (\text{the last term})}{1 - r}.
```)

A *geometric series* is a series
#mitex(```
a_1 + a_2 + a_3 + \cdots
```)
whose terms are related by a common ratio #mi(`r`):
#mitex(```
a_1 \overset{\times r}{\longmapsto} a_2 \overset{\times r}{\longmapsto} a_3 \overset{\times r}{\longmapsto} a_4 \overset{\times r}{\longmapsto} a_5 \overset{\times r}{\longmapsto} \cdots.
```)
Taking the limit of #mi(`a_1 + a_2 + \cdots + a_N`) as #mi(`N`) goes to infinity (and applying the #mi(`n`)-th term test when #mi(`\lim_{N \to \infty} a_N \neq 0`)), we get the formula for the geometric series
#mitex(```latex
a_1 + a_2 + a_3 + \cdots = \begin{cases}
\frac{a_1}{1 - r} & \text{if } \lim_{N \to \infty} a_N = 0, \\
\text{diverges} & \text{otherwise}.
\end{cases}
```)
In the case of #mi(`a_1 \neq 0`), we have #mi(`\lim_{N \to \infty} a_N = 0`) if and only if #mi(`\lvert r \rvert < 1`), so we can also write the formula as
#mitex(```
a_1 + a_2 + a_3 + \cdots = \begin{cases}
\frac{a_1}{1 - r} & \text{if } \lvert r \rvert < 1, \\
\text{diverges} & \text{if } \lvert r \rvert \geq 1.
\end{cases}
```)

#exercise[
  #set enum(spacing: 1.5em)
  Determine whether the following series converge, if they do, find their sums.
  + #mi(`\displaystyle \frac{1}{2} + \frac{1}{4} + \frac{1}{8} + \frac{1}{16} + \frac{1}{32} + \cdots`)
  + #mi(`\displaystyle \sum_{n = 2}^\infty \frac{(-2)^n}{3^{n+1}}`)
  + #mi(`\displaystyle \sum_{n = 1}^\infty 3^{(-2n)}`)
  + (Bonus) Come up with a method using geometric series to count all the natural numbers in under #mi(`1`) second!
]
#solution[
  + This is a geometric series with ratio #mi(`1/2`), so it converges and its sum is the first term divided by #mi(`1 - 1/2`), which is
    #mitex(```
    \frac{1/2}{1 - 1/2} = 1.
    ```)
  + Noting that #mi(`x^n = x \cdots x`) is literally writing out #mi(`x`) multiplied by itself #mi(`n`) times, we can write the series as
    #mitex(```
    \frac{(-2)(-2)}{3\cdot 3 \cdot 3} + \frac{(-2)(-2)(-2)}{3\cdot 3 \cdot 3 \cdot 3} + \frac{(-2)(-2)(-2)(-2)}{3\cdot 3 \cdot 3 \cdot 3 \cdot 3} + \cdots.
    ```)
    This makes it clear that this is a geometric series with first term #mi(`(-2)^2 / 3^3`) and common ratio #mi(`-2/3`).
    Because #mi(`\lvert -2/3 \rvert < 1`), the series converges and its sum is the first term divided by #mi(`1 - (-2/3)`), which is
    #mitex(```
    \frac{(-2)^2 / 3^3}{1 - (-2/3)} = \frac{4/27}{5/3} = \frac{4}{45}.
    ```)
  + Recall that
    #mitex(```
    3^{-2n} = \left( \frac{1}{3} \right)^{2n} = \left( \frac{1}{3^2} \right)^n,
    ```)
    so the series can be written as
    #mitex(```
    \left( \frac{1}{3^2} \right) + \left( \frac{1}{3^2} \right) \left( \frac{1}{3^2} \right) + \left( \frac{1}{3^2} \right) \left( \frac{1}{3^2} \right) \left( \frac{1}{3^2} \right) + \cdots.
    ```)
    This is a geometric series with first term #mi(`1/3^2`) and common ratio #mi(`1/3^2`), so it converges and its sum
    #mitex(```
    \frac{1/3^2}{1 - 1/3^2} = \frac{1/9}{1 - 1/9} = \frac{1/9}{8/9} = \frac{1}{8}.
    ```)
    #tip[
      In general, if we are able to write the series as
      #mitex(```
      \sum_{n = N}^\infty a r^n
      ```)
      then we can immediately recognize this as a geometric series with first term #mi(`a r^N`) and common ratio #mi(`r`).
      This applies to part 2 as well: we can write
      #mitex(```
      \sum_{n = 2}^\infty \frac{(-2)^n}{3^{n+1}} = \sum_{n = 2}^\infty \frac{(-2)^n}{3 \cdot 3^n} = \sum_{n = 2}^\infty \frac{1}{3} \left( \frac{-2}{3} \right)^n
      ```)
      and recognize this as a geometric series with first term #mi(`\frac{1}{3} \left( \frac{-2}{3} \right)^2`) and common ratio #mi(`-2/3`).
    ]
  + There are many ways to do this, one of them is to use part 1.
    When we start our timer, we count #mi(`1`) after #mi(`1/2`) second, then we count #mi(`2`) after another #mi(`1/4`) second, then we count #mi(`3`) after another #mi(`1/8`) second, and so on.
    Every natural number will be counted sometime before our timer reaches #mi(`1`) second!
]

= Integral Test and Direct Comparison Test

Both the integral test and the direct comparison test are based on the following principle.
#theorem(label: [Principle of nonnegative series])[
  If the series
  #mitex(```
  a_1 + a_2 + a_3 + a_4 + \cdots
  ```)
  consists only of nonnegative terms (that is #mi(`a_n \geq 0`) for all #mi(`n`)), then it either converges to a finite nonnegative number or diverges to infinity.
  The limit is always well-defined!
]
This is due to the monotone convergence theorem and you can think about how they relate to each other.
The principle is not necessarily true for series with negative terms, for example #mi(`1 - 1 + 1 - 1 + \cdots`) does not have a well-defined limit.

We have a simple characterization of series with nonnegative terms: it converges when there is a finite upper bound, and it diverges when it is infinite (we do not have to worry about divergence in the sense of having ill-defined limit like #mi(`1 - 1 + 1 - 1 + \cdots`)).

#theorem(label: [Integral test])[
  Let #mi(`a_N, a_{N+1}, a_{N+2}, \ldots`) be a sequence of nonnegative terms.
  Suppose that #mi(`a_n = f(n)`), where #mi(`f(x)`) is a nonnegative and #highlight[decreasing] function of #mi(`x`) for all #mi(`x \geq N`).
  Then, we have the inequality
  #mitex(```
  \int_N^\infty f(x) \, dx
  \leq \sum_{n = N}^\infty a_n
  \leq a_N + \int_N^\infty f(x) \, dx
  ```)
  due to the following figures.
  #figure(
    image(
      "Integral test right.svg",
      width: 50%,
      alt: "Decreasing curve with rectangles whose left endpoints on the curve and right endpoints above it."
    ),
    caption: [Lower bound for the series. Notice that we are swinging the rectangles to the right to stay above the curve.]
  )
  #figure(
    image(
      "Integral test left.svg",
      width: 50%,
      alt: "Decreasing curve with rectangles whose right endpoints on the curve and left endpoints below it."
    ),
    caption: [Upper bound for the series. Notice that we are swinging the rectangles to the left to stay under the curve.]
  )

  #set list(spacing: 1.5em)
  In particular,
  - if #mi(`\displaystyle \int_N^\infty f(x) \, dx = L`) is finite, then #mi(`\displaystyle \sum_{n = N}^\infty a_n \leq a_N + L`) is also finite by the upper bound;
  - if #mi(`\displaystyle \int_N^\infty f(x) \, dx = \infty`), then #mi(`\displaystyle \sum_{n = N}^\infty a_n = \infty`) by the lower bound.
]
#tip[
  It is important that you show that the function #mi(`f(x)`) is decreasing when it is not obvious.
  For example, it is not obvious that #mi(`f(x) = \frac{\ln x}{x}`) is decreasing for #mi(`x \geq 3`) because both the numerator and denominator are increasing.
  To show that #mi(`f(x)`) is decreasing, we need to compute its derivative and show that it is negative for #mi(`x \geq 3`):
  #mitex(```
  f'(x) = \frac{x \frac{1}{x} - \ln x}{x^2} = \frac{1 - \ln x}{x^2} < 0 \quad \text{for } x \geq 3 \text{ since } \ln x \geq \ln 3 > 1.
  ```)
]

The direct comparison test is an intuitive result.

#theorem(label: [Direct comparison test])[
  Let #mi(`\displaystyle \sum_{n = N}^{\infty} a_n`) and #mi(`\displaystyle \sum_{n = N}^{\infty} b_n`) be two series with #mi(`0 \leq a_n \leq b_n`).
  Then,
  #mitex(```
  0 \leq \sum_{n = N}^\infty a_n \leq \sum_{n = N}^\infty b_n.
  ```)

  #set list(spacing: 1.5em)
  In particular,
  - if #mi(`\displaystyle \sum_{n = N}^\infty b_n`) is finite, then #mi(`\displaystyle \sum_{n = N}^\infty a_n`) is also finite by the upper bound;
  - if #mi(`\displaystyle \sum_{n = N}^\infty a_n = \infty`), then #mi(`\displaystyle \sum_{n = N}^\infty b_n = \infty`) by the lower bound.
]

The comparison test is often used in conjunction with the integral test: we compare a complicated series with a simpler one that is either geometric or yields a simple integral when we apply the integral test.

#exercise[
  #set enum(spacing: 1.5em)
  Determine whether the following series converge or diverge.
  If they converge, provide a lower bound and an upper bound.
  + #mi(`\displaystyle 1 + \frac{1}{4} + \frac{1}{9} + \frac{1}{16} + \frac{1}{25} + \cdots`)

    (_Bonus_: can you find a pair of bounds whose difference is less than #mi(`0.05`)?)
  + #mi(`\displaystyle \sum_{n = 1}^{\infty} \frac{2 + \cos n}{n}`)
  + #mi(`\displaystyle \sum_{n = 1}^{\infty} \frac{2 + \cos n}{n^2}`)
  + #mi(`\displaystyle \sum_{n = 1}^{\infty} \frac{1}{(n - 4)^2 + 1}`) (_hint_: #mi(`\displaystyle \int_0^\infty \frac{1}{x^2 + 1} \, dx = \frac{\pi}{2}`))
]
#solution[
  + This series can be written as
    #mitex(```
    \sum_{n = 1}^\infty \frac{1}{n^2}.
    ```)
    Notice that #mi(`\frac{1}{x^2}`) is nonnegative and decreasing for #mi(`x \geq 1`), so we can apply the integral test and write
    #mitex(```
    \int_1^\infty \frac{1}{x^2} \, dx \leq \sum_{n = 1}^\infty \frac{1}{n^2} \leq 1 + \int_1^\infty \frac{1}{x^2} \, dx.
    ```)
    We calculate that
    #mitex(```
    \int_1^\infty \frac{1}{x^2} \, dx = \left[ -\frac{1}{x} \right]_1^\infty = 1,
    ```)
    so the series converges and its sum is between #mi(`1`) and #mi(`2`).
    #tip[
      We can get better and better bounds by extracting initial terms and applying the integral test to the rest of the series, for example, we can break the series into
      #mitex(```
      1 + \frac{1}{4} + \frac{1}{9} + \frac{1}{16} + \frac{1}{25} + \cdots = 1 + \frac{1}{4} + \frac{1}{9} + \frac{1}{16} + \sum_{n = 5}^\infty \frac{1}{n^2}.
      ```)
      Applying the integral test to the last part, we have
      #mitex(```
      \int_5^\infty \frac{1}{x^2} \, dx \leq \sum_{n = 5}^\infty \frac{1}{n^2} \leq \frac{1}{25} + \int_5^\infty \frac{1}{x^2} \, dx.
      ```)
      Calculating the integral, we have
      #mitex(```
      \int_5^\infty \frac{1}{x^2} \, dx = \left[ -\frac{1}{x} \right]_5^\infty = \frac{1}{5},
      ```)
      thus, the original series is between
      #mitex(```
      1 + \frac{1}{4} + \frac{1}{9} + \frac{1}{16} + \frac{1}{5} \quad \text{and} \quad 1 + \frac{1}{4} + \frac{1}{9} + \frac{1}{16} + \frac{1}{25} + \frac{1}{5}.
      ```)
      In decimals, we find that the sum is between #mi(`1.623`) and #mi(`1.664`).
    ]
  + Notice that this series is nonnegative because #mi(`2 + \cos n \geq 1 \geq 0`), so we can apply the direct comparison test.
    Because #mi(`1 \leq 2 + \cos n \leq 3`), we have
    #mitex(```
    \frac{1}{n} \leq \frac{2 + \cos n}{n} \leq \frac{3}{n}.
    ```)
    Since #mi(`\sum_{n = 1}^\infty \frac{1}{n} = \infty`) by the integral test:
    #mitex(```
    \int_{1}^{\infty} \frac{1}{x} \, dx = [\ln x]_1^\infty = \infty,
    ```)
    we also have that #mi(`\sum_{n = 1}^\infty \frac{2 + \cos n}{n} = \infty`) diverges.
  + Still using #mi(`1 \leq 2 + \cos n \leq 3`), we have
    #mitex(```
    \frac{1}{n^2} \leq \frac{2 + \cos n}{n^2} \leq \frac{3}{n^2}.
    ```)
    Thus, by part 1, we have
    #mitex(```
    1 \leq \sum_{n = 1}^\infty \frac{1}{n^2} \leq \sum_{n = 1}^\infty \frac{2 + \cos n}{n^2} \leq 3 \sum_{n = 1}^\infty \frac{1}{n^2} \leq 6.
    ```)
  + It is very tempting to apply the integral test since the hint literally tells us how to compute the integral, but notice that the terms in
    #mitex(```
    \sum_{n = 1}^{\infty} \frac{1}{(n - 4)^2 + 1} = \frac{1}{9 + 1} + \frac{1}{4 + 1} + \frac{1}{1 + 1} + \frac{1}{0 + 1} + \frac{1}{1 + 1} + \frac{1}{4 + 1} + \frac{1}{9 + 1} + \cdots
     ```)
     are not decreasing, so any interpolating function would also not be decreasing.
     The good news is that we can extract the first three terms
     #mitex(```
     \frac{1}{9 + 1} + \frac{1}{4 + 1} + \frac{1}{1 + 1} = \frac{1}{10} + \frac{1}{5} + \frac{1}{2} = \frac{8}{10},
     ```)
     and apply the integral test to the rest of the series
     #mitex(```
     \frac{1}{0 + 1} + \frac{1}{1 + 1} + \frac{1}{4 + 1} + \frac{1}{9 + 1} + \cdots = \sum_{n = 0}^\infty \frac{1}{n^2 + 1}.
     ```)
    Since #mi(`\frac{1}{x^2 + 1}`) is nonnegative and decreasing for #mi(`x \geq 0`), we have
     #mitex(```
     \int_0^\infty \frac{1}{x^2 + 1} \, dx \leq \sum_{n = 0}^\infty \frac{1}{n^2 + 1} \leq \frac{1}{0 + 1} + \int_0^\infty \frac{1}{x^2 + 1} \, dx.
     ```)
     Using the hint, we have
     #mitex(```
     \frac{\pi}{2} \leq \sum_{n = 0}^\infty \frac{1}{n^2 + 1} \leq 1 + \frac{\pi}{2}.
     ```)
     Therefore, the original series converges and its sum is between
     #mitex(```
    \frac{8}{10} + \frac{\pi}{2} \quad \text{and} \quad \frac{8}{10} + 1 + \frac{\pi}{2}.
     ```)
]