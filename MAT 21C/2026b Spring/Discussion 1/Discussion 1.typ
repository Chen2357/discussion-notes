#import "../Template/canvas-html.typ": *

#show: canvas-html.with(
  course-id: "1067114",
  image-ids: (
    "Linear plot.svg": "30748396",
    "Ex1.svg": "30748403",
    "Ex2.svg": "30748405",
    "Ex3.svg": "30748406",
    "Ex4.svg": "30748407",
    "Cosine.svg": "30748402",
  ),
  title: "MAT 21C Discussion 1",
  author: "Chen Liang",
  date: datetime(year: 2026, month: 3, day: 31),
)

#set heading(numbering: "§I")

= Introduction

This course will cover two very distinct topics.
1. Sequences and series.
2. Multivariable calculus.
I will say more about multivariable calculus when we get there.
Historically, sequences and series opened the door to modern mathematical reasoning.
Mathematicians have always grappled with infinity since the development of calculus.
In the beginning, we applied informal reasoning and often got reasonable results, but inconsistencies started to show as we developed concepts like Taylor series, which we will learn in this course.
To resolve these inconsistencies, a more formal and rigorous framework is needed. That is how we get the theorem-and-proof framework, which even I find cumbersome sometimes. Still, it leads to satisfying and beautiful results, and I think that makes it worth the effort.

As a second-year graduate student in pure math, this is my chance to give you a glimpse of what mathematicians do beyond calculation.
And I hope you enjoy!

#exercise(label: [Discuss])[
  Gather in groups of 2-4 and introduce yourselves. Then, discuss the following questions:
  + What do you think the calculator does when you punch `cos(0.01)` into it and it shows the number
    #mitex(```
    0.999\,950\,000\,4
    ```)
    on the screen?
  + There is a way to calculate #mi(`\cos 0.01`) by hand which is to use the formula
    #mitex(```
    \cos x = 1 - \frac{x^2}{2} + \frac{x^4}{24} - \frac{x^6}{720} + \frac{x^8}{40320} - \cdots.
    ```)
    If we take the first three terms and perform the precise calculation, we get
    #mitex(```
    1 - \frac{0.01^2}{2} + \frac{0.01^6}{24} = 0.999\,950\,000\,41\overline{6}.
    ```)
    Can we say that this hand calculation is off from the true value of #mi(`\cos 0.01`) by #mi(`0.000\,000\,000\,01\overline{6}`)?
    #h(100%)
]
#solution(label: [Explanation])[
  + The calculator either uses a Taylor series or runs a recursive algorithm (the CORDIC algorithm) that gets more and more accurate with each loop it runs.
    However, the calculator cannot run forever, so the designer has to put a manual stop to the calculation, but how does the designer decide when to stop?

    The answer is that, through an analysis of sequential convergence, the designer can guarantee that after a certain number of iterations, the result is accurate up to a certain number of digits.
    So the designer can decide on the number of iterations based on how many digits of accuracy they want to guarantee (how many digits are shown on the screen).

  + As we discussed, the value shown on the calculator is also an approximation!
    How it obtains this approximation is exactly analogous to this hand calculation.
    Neither of them is the true value of #mi(`\cos 0.01`); we can only know how far off we are from the true value by analyzing series convergence, and the calculator is not the source of truth.

    If we take a look at the next term in the Taylor series #mi(`x^8 / 40320`), we see that it only changes our calculation by less than #mi(`0.01^8`), and that tells us that actually our result is accurate at least to #mi(`16`) decimal places (at least 6 more than the calculator shows).
    We do in general have to worry about more error terms beyond #mi(`x^8 / 40320`), but we will eventually learn something called the _alternating series test_ that will shed light on my confidence that we do not have to worry about the error terms beyond #mi(`x^8 / 40320`).
]

= Informal Understanding of Limits

A sequence is a list of numbers in a given order such as
#mitex(```
0, \frac{1}{2}, \frac{2}{3}, \frac{3}{4}, \frac{4}{5}, \frac{5}{6}, \dots
```)
It can come from a formula, an algorithm (such as a recursive procedure), or a _recognizable_ pattern.
Can you recognize the next term in the above sequence?
Hopefully you say #mi(`6/7`), and if I ask what is the term after that you would say #mi(`7/8`), and so on.

Because you can predict the next term in the sequence forever, my presentation of the sequence is a _recognizable_ one and hence is a fine way to define a sequence.

The sequence can also be presented with a formula such as
#mitex(```
a_n = \frac{n-1}{n},
```)
and this is because if we substitute #mi(`n = 1`), we have #mi(`a_1 = 0`); if we substitute #mi(`n = 2`), we have #mi(`a_2 = 1/2`); and so on, forever!

We can draw the above sequence by plotting the points whose #mi(`x`)-coordinates are the indices and #mi(`y`)-coordinates are the terms of the sequence, so the first point is #mi(`(1, 0)`) and the second point is #mi(`(2, 1/2)`), and so on.
The plot looks like this:
#figure(
  image(
    "Linear plot.svg",
    width: 80%,
    alt: "30 red points evenly spaced horizontally and increasing vertically, approaching a red dashed horizontal line y = 1",
  ),
  caption: [A plot of the sequence #mi(`a_n = \frac{n-1}{n}`) for #mi(`n = 1, 2, \dots, 30`).],
)
We see that the points are getting closer and closer to the horizontal line #mi(`y = 1`) as we move to the right.
To be more precise, the _tails_ of the sequence get arbitrarily close to the line #mi(`y = 1`) (a tail of a sequence is what remains after we remove a finite number of starting terms).
This is what we mean by saying that
#mitex(```
\lim_{n \to \infty} \frac{n-1}{n} = 1.
```)

There are four possible limit scenarios for a sequence #mi(`a_n`):
1. the limit of #mi(`a_n`) is a finite number #mi(`L`): the tails get arbitrarily close to #mi(`L`).
2. the limit of #mi(`a_n`) is #mi(`\infty`): even the smallest terms in the tails  get arbitrarily large.
3. the limit of #mi(`a_n`) is #mi(`-\infty`): even the greatest terms in the tails get arbitrarily large in the negative direction.
4. there are two subsequences of #mi(`a_n`) with different limits.
In the first case, we say that #mi(`a_n`) is convergent and it converges to #mi(`L`), and in the other three cases, we say that #mi(`a_n`) is divergent.

#exercise[
  Draw the following sequences and categorize them into the four limit scenarios above:
  + The sequence #mi(`\displaystyle 1, 4, 9, 16, 25, 36, \dots`).
  + The sequence #mi(`\displaystyle 1, -\frac{1}{2}, \frac{1}{3}, -\frac{1}{4}, \frac{1}{5}, -\frac{1}{6}, \dots`).
  + The sequence #mi(`\displaystyle 1, -1, 1, -1, 1, -1, \dots`).
  + The sequence #mi(`\displaystyle 0, -1, 0, -2, 0, -3, 0, -4, \dots`).
  + Can you come up with a sequence that does not fit into any of the four limit scenarios above?
]
#solution[
  + Based on the following plot, we can see that this sequence is diverging to #mi(`\infty`).
    Note that the points lie on the parabola #mi(`y = x^2`).
    #h(100%)
    #figure(
      image(
        "Ex1.svg",
        width: 300pt,
        alt: "Points evenly spaced horizontally and lie on the parabola labeled y = x^2.",
      ),
      caption: [A plot of the sequence #mi(`a_n = n^2`) for #mi(`n = 1, 2, \dots, 12`).],
    )
  + Based on the following plot, we can see that this sequence is converging to #mi(`0`).
    The sequence is oscillating between positive and negative values but the points are all getting closer and closer to the horizontal line #mi(`y = 0`).
    #h(100%)
    #figure(
      image(
        "Ex2.svg",
        width: 300pt,
        alt: "Points alternating above and below the x-axis. Points are either on the hyperbola y = 1/x or the hyperbola y = -1/x.",
      ),
      caption: [A plot of the sequence #mi(`a_n = (-1)^{n-1} / n`) for #mi(`n = 1, 2, \dots, 14`).],
    )
  + The limit does not exist because it has two subsequences with different limits.
    - If we start with the first term and take every other term, we get the subsequence #mi(`1, 1, 1, \dots`), which converges to #mi(`1`).
    - If we start with the second term and take every other term, we get the subsequence #mi(`-1, -1, -1, \dots`), which converges to #mi(`-1`).
    #figure(
      image(
        "Ex3.svg",
        width: 300pt,
        alt: "Points alternating between on the line y = 1 and the line y = -1.",
      ),
      caption: [A plot of the sequence #mi(`a_n = (-1)^{n-1}`) for #mi(`n = 1, 2, \dots, 14`).],
    )
  + The limit does not exist because it has two subsequences with different limits.
    - If we start with the first term and take every other term, we get the subsequence #mi(`0, 0, 0, \dots`) whose limit is #mi(`0`).
    - If we start with the second term and take every other term, we get the subsequence #mi(`-1, -2, -3, \dots`) whose limit is #mi(`-\infty`).
    #figure(
      image(
        "Ex4.svg",
        width: 300pt,
        alt: "Points alternating between on the x-axis and points on the line y = -x.",
      ),
      caption: [A plot of the first #mi(`14`) terms of the sequence #mi(`0, -1, 0, -2, 0, -3, 0, -4, \dots`).],
    )

  + No!
    The four limit scenarios are exhaustive.
    It comes from a deeper fact in real analysis that every sequence valued in the extended real numbers #mi(`\mathbb{R} \cup \{\infty, -\infty\}`) either converges or has at least two subsequences with different limits.
    This is a result of the fact that the extended real numbers #mi(`\mathbb{R} \cup \{\infty, -\infty\}`) is a _compact topological space_.
    Of course, you do not need to know any of these, you just need to know that the four limit scenarios are exhaustive. 🙂
]

= Formal argument for limits

We are not starting from zero; we can make arguments for the limit of a sequence by leveraging our knowledge of functional limits.
The key theorem is the following.

#theorem[
  Given a sequence #mi(`a_n`) and a function #mi(`f(x)`) that interpolates it (that is #mi(`f(n) = a_n`)), then #highlight[*if*]
  #mitex(```
  \lim_{x \to \infty} f(x) = L,
  ```)
  then we have
  #mitex(```
  \lim_{n \to \infty} a_n = \lim_{x \to \infty} f(x) = L.
  ```)
  The symbol #mi(`L`) can be a finite number, #mi(`\infty`), or #mi(`-\infty`).
]

I want to bring your attention to the "if" clause in the above theorem.
We can only apply the theorem when the "if" clause is satisfied---it is a promise that we are making when we apply the theorem, and we have to fulfill our promise.
To show you an incorrect usage, let us say we are trying to find
#mitex(```
\lim_{n\to \infty} \cos(2 \pi n).
```)
If we start our argument with
#mitex(```
\lim_{n\to \infty} \cos(2 \pi n) = \lim_{x\to \infty} \cos(2 \pi x),
```)
then we are making a promise that #mi(`\lim_{x\to \infty} \cos(2 \pi x)`) exists either as a finite number, #mi(`\infty`), or #mi(`-\infty`).
However, the function #mi(`\cos(2 \pi x)`) is oscillating and its limit does not exist.
The reason why the argument
#mitex(```
\lim_{n\to \infty} \cos(2 \pi n) = \lim_{x\to \infty} \cos(2 \pi x) \quad \text{DNE}
```)
is incorrect ❌ is because we applied the theorem without fulfilling its assumption---the promise we made.
#figure(
  image(
    "Cosine.svg",
    width: 300pt,
    alt: "Oscillating curve y = cos(2 pi x) and the sequence a_n = cos(2 pi n) whose points are on the peaks of the curve.",
  ),
  caption: [#mi(`f(x) = \cos(2\pi x)`) passes through the points of the sequence #mi(`a_n = \cos(2\pi n)`). While #mi(`f(x)`) does not have a limit as #mi(`x \to \infty`), the sequence surely looks like it has a limit.],
)

The correct argument is to notice that #mi(`\cos(2 \pi n) = 1`) for all natural numbers #mi(`n`), and so actually #mi(`f(x) = 1`) interpolates the sequence #mi(`\cos(2 \pi n)`).
Then we can apply the theorem to conclude that
#mitex(```
\lim_{n\to \infty} \cos(2 \pi n) = \lim_{x\to \infty} 1 = 1.
```)
Notice that we fulfilled our promise that #mi(`\lim_{x \to \infty} f(x) = \lim_{x\to \infty} 1 = 1`) exists, so this argument is correct ✅.

// Another tip:

Not all sequences can be analyzed by this theorem.
Two other theorems you need to know are the algebraic limit theorem and the sandwich theorem.
#theorem(label: [Algebraic Limit Theorem])[
  Given two sequences #mi(`a_n`) and #mi(`b_n`), if
  #mitex(```
  \lim_{n \to \infty} a_n = L \quad \text{and} \quad \lim_{n \to \infty} b_n = M,
  ```)
  and that #mi(`L + M`) is not an indeterminate form, then we have
  #mitex(```
  \lim_{n \to \infty} (a_n + b_n) = \lim_{n \to \infty} a_n + \lim_{n \to \infty} b_n = L + M.
  ```)
  The same also applies to subtraction, multiplication, and division.
]
In the algebraic limit theorem, notice that we need to make three promises:
+ #mi(`\lim_{n \to \infty} a_n = L`) exists.
+ #mi(`\lim_{n \to \infty} b_n = M`) exists.
+ #mi(`L + M`) is not an indeterminate form.
If we fail to fulfill any of the three promises when writing the argument, then the argument is incorrect and we have to try a different approach.

#theorem(label: [Sandwich Theorem])[
  Given three sequences #mi(`a_n`), #mi(`b_n`), and #mi(`c_n`) such that #mi(`a_n \leq b_n \leq c_n`) for all #mi(`n`), if
  #mitex(```
  \lim_{n\to \infty} a_n = \lim_{n\to \infty} c_n = L,
  ```)
  then we have
  #mitex(```
  \lim_{n\to \infty} b_n = L.
  ```)
  Here, #mi(`L`) can be a finite number, #mi(`\infty`), or #mi(`-\infty`).
]

#let grid-enum(e, count-display: "1. ") = {
  v(-.65em)
  let sub-item-counter = counter("sub-item")
  let numbered-children = e.children.map(c => {
    (
      {
        sub-item-counter.step()
        context sub-item-counter.display(count-display)
      },
      c.body,
    )
  })
  grid(
    columns: (auto, 1fr) * 2,
    row-gutter: .5em,

    ..numbered-children.flatten()
  )
}

#exercise[
  #set enum(spacing: 2em)
  Find the limits of the following sequences or show that they do not exist.
  + #mi(`\displaystyle a_n = \frac{3n^2 + n}{1 + n^2}`)
  + #mi(`\displaystyle a_n = \frac{\ln n}{n}`)
  + #mi(`\displaystyle a_n = (-1)^{n - 1} \left(\frac{1}{n}\right)`)
  + #mi(`\displaystyle a_n = (-1)^{n - 1} \left(1 + \frac{1}{n}\right)`)
  + #mi(`\displaystyle a_n = \ln (n + 1) - \ln (n)`)
]
#solution[
  + We have
    #mitex(```
    \lim_{n \to \infty} \frac{3n^2 + n}{1 + n^2} = \lim_{n \to \infty} \frac{n^2}{n^2} \cdot \frac{3 + 1/n}{1/n^2 + 1} = \lim_{n \to \infty} \frac{3 + 1/n}{1/n^2 + 1} = \frac{3 + 0}{0 + 1} = 3.
    ```)
    Note that this is an argument because all applications of algebraic limit theorem are fulfilled: there was no indeterminate form and all limits involved in the argument exist.
  + We have
    #mitex(```
    \lim_{n\to \infty} \frac{\ln n}{n} = \lim_{x\to \infty} \frac{\ln x}{x} = \lim_{x\to \infty} \frac{1/x}{1} = \frac{0}{1} = 0.
    ```)
    The first equality is not doing nothing! It is the application of the first theorem we introduced in this section.
    It is only by reframing the problem as the functional limit of #mi(`\frac{\ln x}{x}`) that we can apply L'Hôpital's rule in the second equality.
    L'Hôpital's rule cannot be applied to sequential limits because it does not make sense to "take the derivative of a sequence".
    Recall that derivative makes sense when slope makes sense.
    #tip[
      L'Hôpital's rule says that if
      #mitex(```
      \frac{\lim_{x\to \infty} f(x)}{\lim_{x\to \infty} g(x)}
      ```)
      is an indeterminate form like #mi(`\frac{0}{0}`) or #mi(`\frac{\infty}{\infty}`), then we can evaluate it by taking the derivative of the numerator and denominator separately and then taking the limit of the resulting fraction, that is
      #mitex(```
      \lim_{x\to \infty} \frac{f(x)}{g(x)} = \lim_{x\to \infty} \frac{f'(x)}{g'(x)}.
      ```)
      If you are not confident about this, it is time to review Section 4.5 of the textbook on "Indeterminate Forms and L'Hôpital's Rule" (you can stop at page 257; there is no need to read about the proof).
      Try out the examples in that section as you read along!
    ]
  + This is exactly the sequence
    #mitex(```
    1, -\frac{1}{2}, \frac{1}{3}, -\frac{1}{4}, \frac{1}{5}, -\frac{1}{6}, \dots
    ```)
    that we encountered in the previous exercise.
    It is time to formally justify it.
    The idea is that this sequence is sandwiched between the two sequences #mi(`1/n`) and #mi(`-1/n`) as shown in the picture we drew in the previous section.
    Thus, we apply the sandwich theorem on
    #mitex(```
    -\frac{1}{n} \leq (-1)^{n - 1} \left(\frac{1}{n}\right) \leq \frac{1}{n}.
    ```)
    The left and right sequences both converge to #mi(`0`):
    #mitex(```latex
    \begin{aligned}
    \lim_{n\to \infty} -\frac{1}{n} = 0, \\
    \lim_{n\to \infty} \frac{1}{n} = 0,
    \end{aligned}
    ```)
    and so we conclude the limit of the middle sequence is also #mi(`0`):
    #mitex(```
    \lim_{n\to \infty} (-1)^{n - 1} \left(\frac{1}{n}\right) = 0.
    ```)

  + We can write down the first few terms of the sequence as
    #mitex(```
    1 + \frac{1}{1}, -\left(1 + \frac{1}{2}\right), 1 + \frac{1}{3}, -\left(1 + \frac{1}{4}\right), 1 + \frac{1}{5}, -\left(1 + \frac{1}{6}\right), \dots.
    ```)
    It alternates, so can we use the sandwich theorem?
    If we try to apply sandwich theorem on
    #mitex(```
    -\left(1 + \frac{1}{n}\right) \leq (-1)^{n - 1} \left(1 + \frac{1}{n}\right) \leq 1 + \frac{1}{n},
    ```)
    we will find that
    #mitex(```
    \begin{aligned}
    \lim_{n\to \infty} -\left(1 + \frac{1}{n}\right) = -1, \\
    \lim_{n\to \infty} \left(1 + \frac{1}{n}\right) = 1,
    \end{aligned}
    ```)
    and since the two sides do not converge to the same limit, we actually cannot apply the sandwich theorem because we failed to fulfill the promise that #mi(`\lim_{n\to \infty} a_n = \lim_{n\to \infty} c_n`) in the sandwich theorem.

    Nevertheless, it inspires us to show that the limit does not exist because there might be two subsequences with different limits, namely, #mi(`-1`) and #mi(`1`).
    - If we start with the first term and take every other term, we get the subsequence
      #mitex(```
      1 + \frac{1}{1}, 1 + \frac{1}{3}, 1 + \frac{1}{5}, 1 + \frac{1}{7}, \dots
      ```)
      which converges to #mi(`1`).
    - If we start with the second term and take every other term, we get the subsequence
      #mitex(```
      -\left(1 + \frac{1}{2}\right), -\left(1 + \frac{1}{4}\right), -\left(1 + \frac{1}{6}\right), -\left(1 + \frac{1}{8}\right), \dots
      ```)
      which converges to #mi(`-1`).
      #h(100%)
    Since the two subsequences have different limits, we conclude that the limit of the original sequence does not exist.

    #tip[
      I consider the above solution acceptable.
      Both subsequences are simple enough that we do not have to justify that they converge.
      To justify, say, that the first subsequence converges, we can say the following.

      If we take the first term and every other term, we get the subsequence #mi(`a_1, a_3, a_5, \dots, a_{2n - 1}, \dots`).
      We calculate
      #mitex(```
      a_{2n - 1} = (-1)^{2n - 2} \left(1 + \frac{1}{2n - 1}\right) = 1 + \frac{1}{2n - 1},
      ```)
      and so
      #mitex(```
      \lim_{n \to \infty} a_{2n - 1} = \lim_{n \to \infty} \left(1 + \frac{1}{2n - 1}\right) = 1.
      ```)

      Can you write down a formal argument to justify the convergence of the second subsequence?
    ]
  + If we naively apply the algebraic limit theorem, we will get
    #mitex(```
    \lim_{n\to \infty} (\ln (n + 1) - \ln (n)) = \lim_{n\to \infty} \ln (n + 1) - \lim_{n\to \infty} \ln (n) = \infty - \infty.
    ```)
    This is an indeterminate form, so we actually cannot apply the algebraic limit theorem here.
    The key is to use the fact that
    #mitex(```
    \ln a - \ln b = \ln \frac{a}{b}
    ```)
    to rewrite the limit as
    #mitex(```
    \lim_{n\to \infty} (\ln (n + 1) - \ln (n)) = \lim_{n\to \infty} \ln \left( \frac{n + 1}{n} \right) = \lim_{n\to \infty} \ln \left(1 + \frac{1}{n}\right) = \ln 1 = 0.
    ```)

    We secretly snuck in the functional limit theorem which says that if #mi(`f(x)`) is continuous and #mi(`\lim_{n \to \infty} a_n = L`), then
    #mitex(```
    \lim_{n\to \infty} f(a_n) = f\left(\lim_{n\to \infty} a_n\right) = f(L).
    ```)
    Because #mi(`\ln`) is continuous, we can simply evaluate #mi(`\lim_{n\to \infty} \left( 1 + \frac{1}{n} \right) = 1`) #highlight[(hence fulfilling the promise that #mi(`\lim_{n\to \infty} a_n = L`) exists for the functional limit theorem!)] and feed #mi(`1`) into #mi(`\ln`).
]

