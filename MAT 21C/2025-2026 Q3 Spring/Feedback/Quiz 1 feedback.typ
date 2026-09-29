#import "../Template/canvas-html.typ": *
#import "@preview/oxifmt:1.0.0": strfmt

#show: my-table-style

Hi class,

Quiz 1 grades has been posted and open for regrade requests for two weeks.
If you have any questions or want advice, I encourage you to come to my calc room.

For question 1, the common mistakes are
- _Invalid argument using infinity:_
  Writing
  #mitex(```
  \lim_{n\to\infty} \frac{n}{2n + 1} = \frac{\infty}{2\infty + 1} = \frac{1}{2} \tag{❌}
  ```)
  is not valid because infinity is not a number and the usual arithmetic rules do not apply.
  This calculation does have the right idea to "cancel out infinities," and the valid way to do this is to "factor out #mi(`\infty/\infty`)" like this:
  #mitex(```
  \lim_{n\to\infty} \frac{n}{2n + 1} =\lim_{n\to\infty} \frac{n}{n} \cdot \frac{1}{2 + \frac{1}{n}} = \lim_{n\to\infty} \frac{1}{2 + \frac{1}{n}} = \frac{1}{2}.
  ```)
  This is clean and brilliant because #mi(`n`) is a real number and we can apply the usual arithmetic rules to it.
- _Forget to fulfill the assumption of algebraic limit theorem:_
  Algebraic limit theorem says that #mi(`\lim_{n\to\infty} (a_n - b_n) = \lim_{n\to\infty} a_n - \lim_{n\to\infty} b_n`) if both #mi(`\lim_{n\to\infty} a_n`) and #mi(`\lim_{n\to\infty} b_n`) exist and their difference is *not an indeterminate form*.
  When applying a theorem, we always need check the assumptions either retroactively or preemptively.

  A clever observation is that #mi(`\ln \frac{n}{2n + 1} = \ln n - \ln (2n + 1)`), but for this problem, this actually leads to a wrong path.
  Writing
  #mitex(```
  \lim_{n\to\infty} \ln \frac{n}{2n + 1} \stackrel{?}{=} \lim_{n\to\infty} \ln n - \lim_{n\to\infty} \ln (2n + 1) = \infty - \infty \tag{❌}
  ```)
  is not correct because the difference #mi(`\infty - \infty`) is an indeterminate form (and not #mi(`0`) or anything because the usual arithmetic rules do not apply to infinity), so the equality in question mark should be retroactively rejected.
- _Fake telescoping series:_
  The series
  #mitex(```
  \begin{aligned}
  \sum_{n = 1}^\infty (\ln n - \ln (2n + 1)) &= (\ln 1 - \ln 3) + (\ln 2 - \ln 5) + (\ln 3 - \ln 7) +\\
  &\phantom{=} (\ln 4 - \ln 9) + (\ln 5 - \ln 11) + (\ln 6 - \ln 13) + \\
  &\phantom{=} (\ln 7 - \ln 15) + (\ln 8 - \ln 17) + (\ln 9 - \ln 19) + \cdots
  \end{aligned}
  ```)
  is not a telescoping series even though it looks like #mi(`-\ln 3`) is going to cancel with #mi(`\ln 3`) same for #mi(`-\ln 5`) and #mi(`\ln 5`), then #mi(`-\ln 7`) and #mi(`\ln 7`), and so on.
  The problem is that the "cancellation" is happening at a distance and the distance is also growing as the series goes on.
  The telescoping technique only works when the cancellation happens at *a fixed distance*.
  (Plus, telescoping only applies when the remainder terms after cancellation are going to zero, and #mi(`\ln (2n + 1)`) is not going to zero.)
- _Confusion between sequential and series convergence:_
  Some of us wrote that "the series #mi(`\sum_{n=1}^\infty \ln \frac{n}{2n + 1}`) converges because the sequence #mi(`\ln \frac{n}{2n + 1}`) converges."
  You could say this is just forgetting the #mi(`n`)th term test, but I think there is a great opportunity to learn what a series is.
  The series #mi(`\sum_{n=1}^\infty \ln \frac{n}{2n + 1}`) is the limit of the partial sums in the leftmost column of this table.
  #let a(n) = calc.ln(n / (2 * n + 1))
  #let s(n) = range(1, n + 1).map(a).sum()
  #my-table(
    caption: [Partial sums and approximations of the series #mi(`\sum_{n=1}^\infty \ln \frac{n}{2n + 1}`)],
    columns: (1fr, 1fr, 1fr, 1fr),
    table.header(
      [Partial sums],
      [Approximation],
      [#mi(`a_n`)],
      [Approximation of #mi(`a_n`)],
    ),
    [#mi(`\ln \frac{1}{3}`)],
    strfmt("{:.3}", s(1)),
    [#mi(`\ln \frac{1}{3}`)],
    strfmt("{:.3}", a(1)),
    [#mi(`\ln \frac{1}{3} + \ln \frac{2}{5}`)],
    strfmt("{:.3}", s(2)),
    [#mi(`\ln \frac{2}{5}`)],
    strfmt("{:.3}", a(2)),
    [#mi(`\ln \frac{1}{3} + \ln \frac{2}{5} + \ln \frac{3}{7}`)],
    strfmt("{:.3}", s(3)),
    [#mi(`\ln \frac{3}{7}`)],
    strfmt("{:.3}", a(3)),
    [⋮],
    [⋮],
    [⋮],
    [⋮],
    [#mi(`\ln \frac{1}{3} + \cdots + \ln \frac{100}{201}`)],
    strfmt("{:.3}", s(100)),
    [#mi(`\ln \frac{100}{201}`)],
    strfmt("{:.3}", a(100)),
    [#mi(`\ln \frac{1}{3} + \cdots + \ln \frac{101}{203}`)],
    strfmt("{:.3}", s(101)),
    [#mi(`\ln \frac{101}{203}`)],
    strfmt("{:.3}", a(101)),
    [#mi(`\ln \frac{1}{3} + \cdots + \ln \frac{102}{205}`)],
    strfmt("{:.3}", s(102)),
    [#mi(`\ln \frac{102}{205}`)],
    strfmt("{:.3}", a(102)),
    [⋮],
    [⋮],
    [⋮],
    [⋮],
  )
  The rule is that we can obtain say #mi(`\ln \frac{1}{3} + \cdots + \ln \frac{101}{203}`) by adding #mi(`\ln \frac{101}{203} \approx -0.698`) (in the same row) to #mi(`\ln \frac{1}{3} + \cdots + \ln \frac{100}{201} \approx -71.742`) (in the previous row).
  We see for since #mi(`a_n`) is close to #mi(`\ln \frac{1}{2} \approx -0.698`) for large #mi(`n`), the partial sums are going to decrease by about #mi(`0.698`) for each additional term, so the partial sums are going to negative infinity and the series diverges.

  As a general tip for series convergence tests.
  The closer we can relate the tests to base principles, the better we can understand the tests and have a better intuition for when to apply which test.

Question 2 is a standard geometric series problem. It tests whether we
- can recognize a geometric series and identify the ratio (even when the ratio is negative),
- know the criterion for convergence #mi(`\lvert r \rvert < 1`), and
- know the formula #mi(`\frac{\text{first term}}{1 - r}`) when the series converges.

Best,\
Chen
