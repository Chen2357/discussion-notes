#import "../Template/canvas-html.typ": *

#show: canvas-html.with(
  course-id: "1067114",
  image-ids: (
    "Rearranged series.svg": "30860789"
  ),
  title: "MAT 21C Discussion 3",
  author: "Chen Liang",
  date: datetime(year: 2026, month: 4, day: 14),
)

// MARK: - Warm-Up
= Warm-Up

#exercise(label: [Warm-up])[
  #set enum(numbering: "(a)")
  Consider the series
  #mitex(```
  1 - 1 + 1 - 1 + 1 - 1 + 1 - \cdots.
  ```)
  We know that the series diverges, but see if you can "deceive" someone into thinking that the value of the series is...
  + #mi(`0`)
  + #mi(`1`)
  + #mi(`2`)
  + #mi(`-1`)
]
#solution[
  #set enum(numbering: "(a)")
  + We can group the terms as
    #mitex(```
    (1 - 1) + (1 - 1) + (1 - 1) + \cdots = 0 + 0 + 0 + \cdots = 0.
     ```)
    #h(1fr)
  + We can group the terms as
    #mitex(```
    1 + (-1 + 1) + (-1 + 1) + \cdots = 1 + 0 + 0 + \cdots = 1.
     ```)
  + We can split the series into two to get
    #mitex(```
    \begin{aligned}
    1 & \, & +1 & \, & +1 & \, & +1 & \, & +1 & \, & + \cdots \\
    \, & -1 & \, & -1 & \, & -1 & \, & -1 & \, & -1 & \cdots
    \end{aligned}
    ```)
    and then shift the second series to the right by one to get
    #mitex(```
    \begin{aligned}
    1 & \, & +1 & \, & +1 & \, & +1 & \, & +1 & \, & +\cdots \\
    \, & \phantom{-1} & \, & -1 & \, & -1 & \, & -1 & \, & -1 & \cdots
    \end{aligned}
    ```)
    Putting them back and cancel each #mi(`-1`) with the next #mi(`+1`), we get
    #mitex(```
    1 + 1 + (-1 + 1) + (-1 + 1) + \cdots = 2.
    ```)
  + We again split the series into two to get
    #mitex(```
    \begin{aligned}
    1 & \, & +1 & \, & +1 & \, & +1 & \, & +1 & \, & +\cdots \\
    \, & -1 & \, & -1 & \, & -1 & \, & -1 & \, & -1 & \cdots
    \end{aligned}
    ```)
    and then shift the first series to the right by one to get
    #mitex(```
    \begin{aligned}
    \phantom{1} & \, & +1 & \, & +1 & \, & +1 & \, & +1 & \, & +\cdots \\
    \, & -1 & \, & -1 & \, & -1 & \, & -1 & \, & -1 & \cdots
    \end{aligned}
    ```)
    Putting them back and cancel each #mi(`+1`) with the next #mi(`-1`), we get
    #mitex(```
    -1 + (1 - 1) + (1 - 1) + (1 - 1) + \cdots = -1.
    ```)
  Of course, none of the above manipulations are valid because the series diverges, and we can only do these moves if all the terms of the series are nonnegative so the series represents an _area_ rather than a _procedure_.
]

// MARK: - Negative Terms
= Series with Negative Terms

Consider the alternating harmonic series
#mitex(```
1 - \frac{1}{2} + \frac{1}{3} - \frac{1}{4} + \frac{1}{5} - \frac{1}{6} + \frac{1}{7} - \frac{1}{8} + \cdots.
```)
The alternating series test tells us that this series converges, and in fact, it converges to #mi(`\ln(2)`) (the past discussion worksheet guides you through the proof, but I prefer to use my own discussion notes).
#theorem(label: [Alternating Series Test])[
  If #mi(`(a_1, a_2, a_3, \ldots)`) is a sequence that
  - is positive (_i.e._ #mi(`a_n > 0`)),
  - is decreasing, and
  - converges to #mi(`0`),
  then the alternating series
  #mitex(```
  \sum_{n = 1}^{\infty} (-1)^{n+1} a_n = a_1 - a_2 + a_3 - a_4 + \cdots
   ```)
  converges.
  Additionally, if #mi(`(a_1, a_2, a_3, \ldots)`) does not tend to #mi(`0`), then the series diverges.

  The alternating series test also applies to #mi(`\sum_{n = 1}^{\infty} (-1)^n a_n = -a_1 + a_2 - a_3 + a_4 - \cdots`).
]
You can think about how to prove that if #mi(`(a_1, a_2, a_3, \ldots)`) does not tend to #mi(`0`), the alternating series diverges.
It is not as simple as the #mi(`n`)th term test, the missing gap is to prove that if #mi(`(a_1, a_2, a_3, a_4, \ldots)`) does not tend to #mi(`0`), then #mi(`(a_1, -a_2, a_3, -a_4, \ldots)`) also does not tend to #mi(`0`).

Let us do further analysis of the alternating harmonic series.
We can collect the positive terms and the negative terms separately to get two bins:
#mitex(```
\begin{aligned}
\text{Positive bin: } & 1, \frac{1}{3}, \frac{1}{5}, \frac{1}{7}, \frac{1}{9}, \ldots, \\
\text{Negative bin: } & -\frac{1}{2}, -\frac{1}{4}, -\frac{1}{6}, -\frac{1}{8}, \ldots.
\end{aligned}
```)
The positive bin consists of the terms with odd denominators #mi(`\frac{1}{2n+1}`) and the negative bin consists of the terms with even denominators #mi(`-\frac{1}{2n}`).
If we try to sum up the positive bin, we would get #mi(`\infty`) by comparison with #mi(`\sum \frac{1}{2n}`) (which diverges by integral test or further comparison with #mi(`p`)-series #mi(`\sum \frac{1}{n}`)).
Similarly, the negative bin also diverges.
We can leverage this observation to rearrange the terms to get any value we want!

Let us say, we want to rearrange the terms to get #mi(`0`), then we can do the following:
+ Take the first term from either bin and start summing up.
  We will start with #mi(`1`).
+ If our current sum is greater than #mi(`0`), we take as much as we need from the negative bin to make the sum less than (or equal to) #mi(`0`).
  In this case, we need to take #mi(`-\frac{1}{2}`) through #mi(`-\frac{1}{8}`) to get
  #mitex(```
  1 - \frac{1}{2} - \frac{1}{4} - \frac{1}{6} - \frac{1}{8} = -0.041666\dots.
  ```)
+ If our current sum is less than (or equal to) #mi(`0`), we take as much as we need from the positive bin to make the sum greater than #mi(`0`).
  In this case, we just need to take #mi(`\frac{1}{3}`) to get
  #mitex(```
  1 - \frac{1}{2} - \frac{1}{4} - \frac{1}{6} - \frac{1}{8} + \frac{1}{3} = 0.291667333\dots.
   ```)
+ We repeat the above two steps indefinitely, and we will get
  #mitex(```
  1 - \frac{1}{2} - \frac{1}{4} - \frac{1}{6} - \frac{1}{8} + \frac{1}{3} - \frac{1}{10} - \frac{1}{12} - \frac{1}{14} - \frac{1}{16} \approx -0.025595\dots
   ```)
   and then
    #mitex(```
    1 - \frac{1}{2} - \frac{1}{4} - \frac{1}{6} - \frac{1}{8} + \frac{1}{3} - \frac{1}{10} - \frac{1}{12} - \frac{1}{14} - \frac{1}{16} + \frac{1}{5} \approx 0.174404\dots
    ```)
    and so on.
This process will produce a series that converges to #mi(`0`).
The key is that because both bins diverge, when we are in step 2 or step 3, we always can take finitely many terms to get the sum to the other side of #mi(`0`).
#figure(
  image(
    "Rearranged series.svg",
    width: 80%,
    alt: "Points in the xy-plane. From left to right, the points decrease in y but it shoots up whenever it goes below the x-axis.",
  ),
  caption: [
    The modified series #mi(`1 - \frac{1}{2} - \frac{1}{4} - \frac{1}{6} - \frac{1}{8} + \frac{1}{3} - \frac{1}{10} - \cdots`).
    The #mi(`y`)-values of the points correspond to the partial sums, and we see that they tend towards #mi(`0`).
  ]
)
We can in fact rearrange the terms to get any value we want!
This is similar to the warm-up question where we can rearrange the terms to get #mi(`0`), #mi(`1`), #mi(`2`), or #mi(`-1`).
The moral of the story is that series with negative terms can be very ill-behaved.

However, some series with negative terms are nice and are protected from rearrangement: if both the positive bin and the negative bin converge to finite values, or equivalently, if the series converge absolutely.

- We say that a series #mi(`\sum a_n`) *converges absolutely* if the series of absolute values #mi(`\sum \lvert a_n \rvert`) converges.
- We say that a series #mi(`\sum a_n`) *converges conditionally* if the series converges but does not converge absolutely.

When a series converges absolutely, both the positive bin and the negative bin converge, and the series would converge and is just the difference of the two bins.
This is called the *absolute convergence test*, but I hope that I made it an intuitive enough result that you do not need to hardcode the theorem in your head.

#exercise[
  #set enum(spacing: 2em)
  Determine whether the series converges absolutely, converges conditionally, or diverges.
  + #mi(`\displaystyle \frac{1}{\sqrt{2}} - \frac{1}{\sqrt{3}} + \frac{1}{\sqrt{4}} - \frac{1}{\sqrt{5}} + \cdots`)
  + #mi(`\displaystyle \sum_{n = 1}^{\infty} (-1)^n \frac{n + 1}{2 n}`)
  + #mi(`\displaystyle \sum_{n = 1}^{\infty} (-1)^n \frac{\cos(\pi n)}{n!}`)
  + (Bonus) #mi(`\displaystyle \frac{1}{1} - \frac{3}{2} + \frac{1}{3} - \frac{3}{4} + \frac{1}{5} - \frac{3}{6} + \frac{1}{7} - \frac{3}{8} + \cdots`)
]
#solution[
  + It is alternating and the magnitude of the terms #mi(`\frac{1}{\sqrt{2}}, \frac{1}{\sqrt{3}}, \frac{1}{\sqrt{4}}, \ldots`) is
    - decreasing because the denominator #mi(`\sqrt{n}`) is increasing, and
    - converging to #mi(`0`) because the denominator #mi(`\sqrt{n}`) goes to infinity.
    So the series converges by the alternating series test.
    We still need to determine whether it converges absolutely or conditionally.
    The series of absolute values is
    #mitex(```
    \sum_{n=2}^{\infty} \frac{1}{\sqrt{n}} = \frac{1}{\sqrt{2}} + \frac{1}{\sqrt{3}} + \frac{1}{\sqrt{4}} + \cdots,
    ```)
    which diverges by the #mi(`p`)-series test with #mi(`p = \frac{1}{2} < 1`).
    So the original series only converges conditionally.
  + The series
    #mitex(```
    \sum_{n = 1}^{\infty} (-1)^n \frac{n + 1}{2 n} = -\frac{2}{2} + \frac{3}{4} - \frac{4}{6} + \frac{5}{8} - \frac{6}{10} + \cdots
    ```)
    is alternating (we can know without writing it out because #mi(`\frac{n + 1}{2n}`) is positive), but since
    #mitex(```
    \lim_{n \to \infty} \frac{n + 1}{2 n} = \lim_{n \to \infty} \frac{n}{n} \frac{1 + \frac{1}{n}}{2} = \frac{1}{2} \neq 0,
    ```)
    the series diverges.
  + The series
    #mitex(```
    \begin{aligned}
    \sum_{n = 1}^{\infty} (-1)^n \frac{\cos(\pi n)}{n!} &= -\frac{-1}{1!} + \frac{1}{2!} - \frac{-1}{3!} + \frac{1}{4!} - \frac{-1}{5!} + \cdots \\
    &= \frac{1}{1!} + \frac{1}{2!} + \frac{1}{3!} + \frac{1}{4!} + \frac{1}{5!} + \cdots
    \end{aligned}
    ```)
    is actually not alternating.
    If we were trying to apply the alternating series test, the failure point is that #mi(`\frac{\cos(\pi n)}{n!}`) is not positive.
    Now, the series
    #mitex(```
    \frac{1}{1!} + \frac{1}{2!} + \frac{1}{3!} + \frac{1}{4!} + \frac{1}{5!} + \cdots = \sum_{n = 1}^{\infty} \frac{1}{n!}
    ```)
    converges absolutely by the ratio test because
    #mitex(```
    \lim_{n \to \infty}\left\lvert \frac{1}{(n+1)!} \cdot \frac{n!}{1} \right\rvert = \lim_{n \to \infty} \frac{1}{n+1} = 0 < 1.
    ```)
  + The series
    #mitex(```
    \frac{1}{1} - \frac{3}{2} + \frac{1}{3} - \frac{3}{4} + \frac{1}{5} - \frac{3}{6} + \frac{1}{7} - \frac{3}{8} + \cdots
    ```)
    is alternating but the magnitude of the terms
    #mitex(```
    \frac{1}{1}, \frac{3}{2}, \frac{1}{3}, \frac{3}{4}, \frac{1}{5}, \frac{3}{6}, \ldots
    ```)
    is not decreasing, so we cannot apply the alternating series test.
    The terms do converge to #mi(`0`) because the denominator goes to infinite while the numerator is at most #mi(`3`), so the #mi(`n`)th term test is also inconclusive.
    Ratio and root tests are also inconclusive, and the integral test is not applicable because the terms are not decreasing.
    It does not look like a telescoping series, and we are left with taking the absolute value and do comparison test.

    We see that
    #mitex(```
    \frac{1}{1} + \frac{3}{2} + \frac{1}{3} + \frac{3}{4} + \frac{1}{5} + \frac{3}{6} + \cdots \geq \frac{1}{1} + \frac{1}{2} + \frac{1}{3} + \frac{1}{4} + \frac{1}{5} + \frac{1}{6} + \cdots = \infty
    ```)
    diverges by comparison with the #mi(`p`)-series with #mi(`p = 1`), so the original series does not converge absolutely.

    It is a genuinely difficult question to determine whether the original series converges conditionally or diverges.
    The key is to write it in a closed form by noticing that #mi(`2 - (-1)^{n+1}`) alternates between #mi(`1`) and #mi(`3`), so we can write the original series as
    #mitex(```
    \frac{1}{1} - \frac{3}{2} + \frac{1}{3} - \frac{3}{4} + \frac{1}{5} - \frac{3}{6} + \frac{1}{7} - \frac{3}{8} + \cdots = \sum_{n = 1}^{\infty} (-1)^{n+1} \frac{2 - (-1)^{n+1}}{n}.
    ```)
    Then, we can try to apply the algebraic limit theorem to rewrite the series as
    #mitex(```
    \sum_{n = 1}^{\infty} (-1)^{n+1} \frac{2 - (-1)^{n+1}}{n} = \sum_{n = 1}^{\infty} (-1)^{n+1} \frac{2}{n} - \sum_{n = 1}^{\infty} \frac{1}{n}.
    ```)
    The first series #mi(`\sum_{n = 1}^{\infty} (-1)^{n+1} \frac{2}{n}`) converges to some finite number #mi(`L`) by the alternating series test, and the second series #mi(`\sum_{n = 1}^{\infty} \frac{1}{n} = \infty`) diverges by the #mi(`p`)-series test with #mi(`p = 1`).
    Since #mi(`L - \infty = -\infty`) is not an indeterminate form, the algebraic limit theorem succeeds and tells us that the original series diverges to #mi(`-\infty`).
]

// MARK: - Choose Test
= Choosing the Right Test

Don't worry about choosing the right test because there is no the right test.
It is more important that we know when a test would not work so that we can just try another test.

Take the series
#mitex(```
\sum_{n=1}^{\infty} \frac{n!}{n^n}
```)
for example (and it is a relatively difficult example).
Here are the steps I would go through in my head.
- We always start with the #mi(`n`)th term test.
  It is not obvious whether #mi(`\frac{n!}{n^n}`) converges to #mi(`0`) because both the numerator and the denominator go to infinity, so I have to leave it. (In fact, it does go to #mi(`0`) because we will show that it converges.)
// - The terms are already positive, so we do not have to worry about alternating series or taking the absolute value.
- We see the factorial and we know that it is not the integral test because we cannot integrate factorial, and it is not the root test because we did not learn anything about #mi(`(n!)^{1/n}`).
  This leaves us with the comparison test and the ratio test.
- The ratio test will be the most straightforward one, we just compute
  #mitex(```
  \lim_{n \to \infty} \left\lvert \frac{(n+1)!}{(n+1)^{n+1}} \cdot \frac{n^n}{n!} \right\rvert = \lim_{n \to \infty} \frac{(n+1) n^n}{(n+1)^{n+1}} = \lim_{n \to \infty} \left( \frac{n}{n+1} \right)^{n}.
  ```)
  If at this point, we do not recognize that we can aim for rewriting it into
  #mitex(```
  \lim_{n \to \infty} \left( 1 + \frac{x}{n} \right)^{n} = e^x
  ```)
  then we would be stuck and we would have to try the comparison test.
  If we do recognize that, we can rewrite
  #mitex(```
  \lim_{n \to \infty} \left( \frac{n}{n+1} \right)^{n} = \lim_{n \to \infty} \frac{1}{\left( \frac{n+1}{n} \right)^{n}} = \lim_{n \to \infty} \frac{1}{\left( 1 + \frac{1}{n} \right)^{n} } = \frac{1}{e} < 1.
  ```)
  Since the limit is less than #mi(`1`), the series converges.
- If we were stuck at the ratio test and have to try the comparison test, we can do this as well.
  We just note that
  #mitex(```
  \frac{n!}{n^n} = \left( \frac{1}{n} \cdot \frac{2}{n} \right) \cdot \left( \frac{3}{n} \cdot \frac{4}{n} \cdot \cdots \cdot \frac{n-1}{n} \cdot \frac{n}{n} \right) \leq \frac{2}{n^2}
  ```)
  for sufficiently large #mi(`n`) (all the #mi(`n`) greater than #mi(`2`)).
  Since #mi(`\sum_{n = 1}^{\infty} \frac{2}{n^2}`) converges by the #mi(`p`)-series test (with #mi(`p = 2`)), the original series also converges by the direct comparison test.

In general, I prioritize the tests that can fail faster such as
- the #mi(`n`)th term test,
- the alternating series test (but if the questions ask whether the series converges absolutely or conditionally, then we would need to take the absolute value and apply other tests anyway),
- the ratio test, and
- the root test,
- the integral test (if it is easy).
I would not literally do them on paper.
I would just think whether the ratio, or the root, or the integral is simple to calculate, and if they are not simple, then I will try to be creative and try
- direct/limit comparison test with geometric or #mi(`p`)-series or something easy to integrate,
- checking whether it is a telescoping series.

#exercise[
  #set enum(spacing: 2em)
  Determine whether the following series converge or diverge.
  Try to come up with as many different methods as you can think of.
  + #mi(`\displaystyle \sum_{n=1}^{\infty} \frac{n}{e^n}`)
  + #mi(`\displaystyle \sum_{n=1}^{\infty} \frac{\ln n}{n^2}`)
]
#solution[
  + _(Method 1: ratio test)_ We compute
    #mitex(```
    \lim_{n \to \infty} \left\lvert \frac{n+1}{e^{n+1}} \cdot \frac{e^n}{n} \right\rvert = \lim_{n \to \infty} \frac{n+1}{n} \cdot \frac{1}{e} = \frac{1}{e} < 1,
    ```)
    so the series converges absolutely by the ratio test.

    _(Method 2: root test)_ We compute
    #mitex(```
    \lim_{n \to \infty} \left\lvert \frac{n}{e^n} \right\rvert^{1/n} = \lim_{n \to \infty} \frac{n^{1/n}}{e}.
    ```)
    We handle the indeterminate form #mi(`\infty^0`) by exponentiating its logarithm:
    #mitex(```
    \lim_{n \to \infty} n^{1/n} = \lim_{n \to \infty} e^{\ln(n^{1/n})} = \lim_{n \to \infty} e^{\frac{1}{n} \ln n}
    ```)
    and then handle the indeterminate form #mi(`\frac{\infty}{\infty}`) by L'Hôpital's rule:
    #mitex(```
    \lim_{n \to \infty} \frac{\ln n}{n} \stackrel{\text{LH}}{=} \lim_{n \to \infty} \frac{1/n}{1} = 0 \implies \lim_{n \to \infty} n^{1/n} = e^0 = 1.
    ```)
    Therefore, the original limit is
    #mitex(```
    \lim_{n \to \infty} \left\lvert \frac{n}{e^n} \right\rvert^{1/n} = \frac{1}{e} < 1,
    ```)
    so the series converges absolutely by the root test.

    _(Method 3: comparison test)_ Intuition tells us that exponential functions grow faster than polynomials and we can break #mi(`e^n`) into #mi(`e^{n/2} e^{n/2}`) and the idea is that
    #mitex(```
    \frac{n}{e^x} = \frac{n}{e^{n/2}} \cdot \frac{1}{e^{n/2}} \ll \frac{1}{e^{n/2}}.
    ```)
    #tip[
      The intuition we should have about sequence growth is that
      #mitex(```
      \text{constant} \ll \ln n \ll \cdots \ll n^{1/3} \ll n^{1/2} \ll n \ll n^2 \ll n^3 \ll \cdots \ll e^n \ll n!
      ```)
      where #mi(`a_n \ll b_n`) means that
      #mitex(```
      \lim_{n \to \infty} \frac{a_n}{b_n} = 0.
      ```)
      Knowing this is extremely powerful to find the right comparison series.
    ]
    To formally justify this, we use limit comparison test with #mi(`\sum \frac{1}{e^{n/2}}`).
    Using #mi(`a_n = \frac{n}{e^n}`) and #mi(`b_n = \frac{1}{e^{n/2}}`), we compute
    #mitex(```
    \lim_{n \to \infty} \frac{a_n}{b_n} = \lim_{n \to \infty} \frac{n}{e^{n}} \cdot e^{n/2} = \lim_{n \to \infty} \frac{n}{e^{n/2}} \stackrel{\text{LH}}{=} \lim_{n \to \infty} \frac{1}{\frac{1}{2} e^{n/2}} = 0.
    ```)
    Therefore, indeed #mi(`a_n \ll b_n`), so if #mi(`\sum b_n`) converges, then #mi(`\sum a_n`) also converges.
    Since
    #mitex(```
    \sum_{n=1}^{\infty} \frac{1}{e^{n/2}} = \sum_{n=1}^{\infty} \left( \frac{1}{\sqrt{e}} \right)^n
    ```)
    is a geometric series with ratio #mi(`\frac{1}{\sqrt{e}} < 1`), it converges.
    Hence, the original series converges by the limit comparison test.

    _(Method 4: integral test)_ We expect #mi(`\frac{n}{e^n}`) to be decreasing at some point.
    We can compute the derivative of the function #mi(`f(x) = \frac{x}{e^x} = x e^{-x}`) to find that
    #mitex(```
    f'(x) = e^{-x} - x e^{-x} = e^{-x} (1 - x) < 0 \text{ for } x > 1,
    ```)
    so it is decreasing for #mi(`x > 1`).
    Therefore, the integral test tells us that (you do not need to write this inequality if you are just interested in convergence, see part 2 for a usage of the integral test without writing the inequality)
    #mitex(```
    \int_{1}^{\infty} x e^{-x} \, dx \leq \sum_{n=1}^{\infty} \frac{n}{e^n} \leq \frac{1}{e} + \int_{1}^{\infty} x e^{-x} \, dx.
    ```)
    Evaluating the integral by integration by parts, we get
    #mitex(```
    \begin{aligned}
    \int_{1}^{\infty} x e^{-x} \, dx &= \lim_{b \to \infty} [-x e^{-x} ]_{1}^{b} + \int_{1}^{\infty} e^{-x} \, dx \\
    &= \lim_{b \to \infty} \left( [-x e^{-x} ]_{1}^{b} + [-e^{-x}]_{1}^{b} \right) \\
    &= \lim_{b \to \infty} \left( -\frac{b}{e^b} + \frac{1}{e} - \frac{1}{e^b} + \frac{1}{e} \right) = \frac{2}{e}.
    \end{aligned}
    ```)
    Therefore, the original series converges and its value is between #mi(`\frac{2}{e}`) and #mi(`\frac{3}{e}`).

  + _(Method 1: comparison test)_ Intuition tells us that #mi(`\ln n`) grows slower than any #mi(`x^p`) for #mi(`p > 0`), so we can try to break #mi(`n^2`) into #mi(`n^{1/2} n^{3/2}`) and argue that
    #mitex(```
    \frac{\ln n}{n^2} = \frac{\ln n}{n^{1/2}} \cdot \frac{1}{n^{3/2}} \ll \frac{1}{n^{3/2}}.
    ```)
    For the formal argument, we use limit comparison test with #mi(`\sum \frac{1}{n^{3/2}}`).
    Using #mi(`a_n = \frac{\ln n}{n^2}`) and #mi(`b_n = \frac{1}{n^{3/2}}`), we compute
    #mitex(```
    \lim_{n \to \infty} \frac{a_n}{b_n} = \lim_{n \to \infty} \frac{\ln n}{n^2} \cdot n^{3/2} = \lim_{n \to \infty} \frac{\ln n}{n^{1/2}} \stackrel{\text{LH}}{=} \lim_{n \to \infty} \frac{1/n}{\frac{1}{2} n^{-1/2}} = \lim_{n \to \infty} \frac{2}{n^{1/2}} = 0.
    ```)
    Therefore, indeed #mi(`a_n \ll b_n`), so if #mi(`\sum b_n`) converges, then #mi(`\sum a_n`) also converges.
    Since #mi(`\sum_{n=1}^{\infty} \frac{1}{n^{3/2}}`) converges by the #mi(`p`)-series test with #mi(`p = \frac{3}{2} > 1`), the original series also converges by the limit comparison test.

    _(Method 2: integral test)_ We compute the derivative of the function #mi(`f(x) = \frac{\ln x}{x^2}`) to find that
    #mitex(```
    f'(x) = \frac{1}{x^3} - \frac{2 \ln x}{x^3} = \frac{1 - 2 \ln x}{x^3} < 0 \text{ for } x > e^{1/2}.
    ```)
    Now, #mi(`e^{1/2}`) is somewhere between #mi(`1`) and #mi(`2`), but we can say for sure that #mi(`f(x)`) is decreasing starting from #mi(`2`).
    Therefore, the integral test tells us that
    #mitex(```
    \int_{2}^{\infty} \frac{\ln x}{x^2} \, dx \text{ converges} \iff \sum_{n=2}^{\infty} \frac{\ln n}{n^2} \text{ converges} \iff \sum_{n=1}^{\infty} \frac{\ln n}{n^2} \text{ converges}.
    ```)
    We calculate using the substitution #mi(`u = \ln x`) and #mi(`du = \frac{1}{x} dx`) to get
    #mitex(```
    \int_{2}^{\infty} \frac{\ln x}{x^2} \, dx = \int_{\ln 2}^{\infty} \frac{u}{e^u} \, du.
    ```)
    This is the same integrand as the one we evaluated in part 1.
    We can show that it converges by direct calculation again or we can be extremely clever and turn the question of whether an integral converges into a question of whether a series converges and then apply ratio or root test.

    If we want to do direct calculation, we get
    #mitex(```
    \int_{\ln 2}^{\infty} \frac{u}{e^u} \, du = \lim_{b \to \infty} [-u e^{-u} - e^{-u}]_{\ln 2}^{b} = \frac{\ln 2 + 1}{2}.
    ```)
    Therefore, the original series converges.

    If we want to be extremely clever, we can write
    #mitex(```
    \int_{\ln 2}^{\infty} \frac{u}{e^u} \, du \leq \int_{\ln 2}^{1} \frac{u}{e^u} \, du + \int_{1}^{\infty} \frac{u}{e^u} \, du
    \leq \int_{\ln 2}^{1} \frac{u}{e^u} \, du + \sum_{n=1}^{\infty} \frac{n}{e^n}.
    ```)
    The first integral is finite because #mi(`\frac{u}{e^u}`) is a continuous function with no singularity on the interval #mi(`[\ln 2, 1]`), and the second series converges by ratio test or root test.
]
