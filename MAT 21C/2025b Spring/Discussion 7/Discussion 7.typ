#import "../Template/canvas-html.typ": *

#show: canvas-html.with(
  course-id: "1067114",
  image-ids: (
    :
  ),
  title: "MAT 21C Discussion 7",
  author: "Chen Liang",
  date: datetime(year: 2026, month: 5, day: 12),
)

= Warm-Up

#exercise(label: [Warm-up])[
  Explain the mistakes in the following *incorrect* derivation of the first three terms of the Taylor series of the function #mi(`f(x) = e^x \cos x`).
  #incorrect-solution[
    #show grid: it => {
      if it.row-gutter == (0% + 0.5em,) {
        grid(
          ..it.children,
          columns: it.columns,
          column-gutter: 1em,
          row-gutter: 1.5em
        )
      } else {
        it
      }
    }
    #mitex(```
    e^x = 1 + x + \frac{x^2}{2} \qquad \cos x = 1 - \frac{x^2}{2} + \frac{x^4}{24}
    ```)
    #mitex(```
    \begin{array}{c|c|c|c}
    & 1 & x & \frac{x^2}{2} \\
    \hline
    1 & 1 & x & \frac{x^2}{2} \\
    \hline
    -\frac{x^2}{2} & -\frac{x^2}{2} & -\frac{x^3}{2} & -\frac{x^4}{4} \\
    \hline
    \frac{x^4}{24} & \frac{x^4}{24} & \frac{x^5}{24} & \frac{x^6}{48}
    \end{array}
    ```)
    #mitex(```
    \begin{align}
    e^x \cos x &= 1 + x + \frac{x^2}{2} - \frac{x^2}{2} - \frac{x^3}{2} + \frac{x^4}{24} - \frac{x^4}{4} + \frac{x^5}{24} + \frac{x^6}{48} \\
    &= 1 + x - \frac{x^3}{2}
    \end{align}
    ```)
  ]
]
#solution[
  // TODO: add solution
  The source of the mistake is the arbitrary truncation of the Taylor series.
  It is important to not only write
  #mitex(```
  e^x = 1 + x + \frac{x^2}{2} + \cdots \qquad \cos x = 1 - \frac{x^2}{2} + \frac{x^4}{24} + \cdots
  ```)
  but also keep in mind the omitted terms, because in the end, we will get to
  #mitex(```
  e^x \cos x = 1 + x - \frac{x^3}{2} + \cdots
  ```)
  we have to verify that the omitted terms contain strictly higher powers of #mi(`x`).
  This is not the case in the incorrect solution.

  The correct solution is to write
  #mitex(```
  \begin{align}
  e^x &= 1 + x + \frac{x^2}{2} + \frac{x^3}{6} + \cdots \\
  \cos x &= 1 - \frac{x^2}{2} + \frac{x^4}{24} + \cdots
  \end{align}
  ```)
  and in the subsequent calculation, always ensure that the omitted terms contain fourth or or higher powers of #mi(`x`) (so actually we can even absorb #mi(`\frac{x^4}{24}`) into the #mi(`\cdots`)).
  #show grid: it => {
    if it.row-gutter == (0% + 0.5em,) {
      grid(
        ..it.children,
        columns: it.columns,
        column-gutter: 1em,
        row-gutter: 1.5em
      )
    } else {
      it
    }
  }
  We can multiply to get
  #mitex(```
  \begin{array}{c|c|c|c|c|c}
  & 1 & x & \frac{x^2}{2} & \frac{x^3}{6} & \cdots \\
  \hline
  1 & 1 & x & \frac{x^2}{2} & \frac{x^3}{6} & \cdots \\
  \hline
  -\frac{x^2}{2} & -\frac{x^2}{2} & -\frac{x^3}{2} & \cdots & \cdots & \cdots \\
  \hline
  \vdots & \vdots & \vdots & \vdots & \vdots & \ddots
  \end{array}
  ```)
  where the omitted terms are always fourth or higher powers of #mi(`x`), so we can conclude that
  #mitex(```
  e^x \cos x = 1 + x - \frac{x^3}{2} + \frac{x^3}{6} + \cdots.
  ```)
]

= Two-Variable Limits

The formal definition of
#mitex(```
\lim_{(x, y) \to (x_0, y_0)} f(x, y) = L
```)
is not important to us.
We need to know to compute a two-variable limit is that if #mi(`f(x, y)`) is continuous and is well-defined at #mi(`(x_0, y_0)`), then we can simply substitute #mi(`(x_0, y_0)`) into #mi(`f(x, y)`) to get
#mitex(```
\lim_{(x, y) \to (x_0, y_0)} f(x, y) = f(x_0, y_0).
```)
If #mi(`f(x, y)`) is not well-defined at #mi(`(x_0, y_0)`), then the strategy is to rewrite #mi(`f(x, y)`) into a function that agrees with #mi(`f(x, y)`) near #mi(`(x_0, y_0)`) and is well-defined at #mi(`(x_0, y_0)`).

For example, to compute
#mitex(```
\lim_{(x, y) \to (0, 0)} \frac{\sin (x^2 + y^2)}{x^2 + y^2}
```)
we can use Taylor series to rewrite this as
#mitex(```
\begin{align}
\lim_{(x, y) \to (0, 0)} \frac{1}{x^2 + y^2} \left( (x^2 + y^2) - \frac{(x^2 + y^2)^3}{3!} + \cdots \right)
&= \lim_{(x, y) \to (0, 0)} \left( 1 - \frac{(x^2 + y^2)^2}{3!} + \cdots \right) \\
&= 1.
\end{align}
```)
#tip[
  Power series is continuous and smooth on its interval of convergence.
]
Besides Taylor series, you also need to know factoring and the Sandwich Theorem, and knowing these three tricks is enough to evaluate every limit on Homework 18.

#exercise[
  #set enum(spacing: 1em)
  Evaluate the limit:
  + #mi(`\displaystyle \lim_{(x, y) \to (0, 0)} \frac{e^y \sin x}{x}`).
  + #mi(`\displaystyle \lim_{(x, y) \to (4, 3)} \frac{\sqrt{x} - \sqrt{y + 1}}{x - y - 1}`).
]
#solution[
  + We have
    #h(100%)
    #mitex(```
    \begin{align}
    \lim_{(x, y) \to (0, 0)} \frac{e^y \sin x}{x} &= \lim_{(x, y) \to (0, 0)} e^y \cdot \frac{1}{x} \left( x - \frac{x^3}{3!} + \cdots \right) \\
    &= \lim_{(x, y) \to (0, 0)} e^y \cdot \left( 1 - \frac{x^2}{3!} + \cdots \right) \\
    &= 1.
    \end{align}
    ```)
  + We can factor the denominator as
    #mitex(```
    x - y - 1 = (\sqrt{x})^2 - (\sqrt{y + 1})^2 = (\sqrt{x} - \sqrt{y + 1})(\sqrt{x} + \sqrt{y + 1}),
    ```)
    so we can rewrite the limit as
    #mitex(```
    \lim_{(x, y) \to (4, 3)} \frac{\sqrt{x} - \sqrt{y + 1}}{(\sqrt{x} - \sqrt{y + 1})(\sqrt{x} + \sqrt{y + 1})} = \lim_{(x, y) \to (4, 3)} \frac{1}{\sqrt{x} + \sqrt{y + 1}} = \frac{1}{4}.
    ```)
]

To show that a two-variable limit does not exist, we need to find two different paths to #mi(`(x_0, y_0)`) along which #mi(`f(x, y)`) approaches different limits.
For this kind of problem, we often like to describe a path to #mi(`(x_0, y_0)`) as an equation #mi(`y = g(x)`) #highlight[as long as] #mi(`g(x_0) = y_0`) so that it actually goes through the point.
We evaluate the limit along the path by
#mitex(```
\lim_{\stackrel{(x, y) \to (x_0, y_0)}{y = g(x)}} f(x, y) = \lim_{x \to x_0} f(x, y) \bigr|_{y = g(x)}.
```)
If we can find two paths #mi(`y = g_1(x)`) and #mi(`y = g_2(x)`) such that
#mitex(```
\lim_{\stackrel{(x, y) \to (x_0, y_0)}{y = g_1(x)}} f(x, y) \neq \lim_{\stackrel{(x, y) \to (x_0, y_0)}{y = g_2(x)}} f(x, y),
```)
then we can conclude that the two-variable limit
#mitex(```
\lim_{(x, y) \to (x_0, y_0)} f(x, y) \quad \text{does not exist.}
```)
Also note that we can describe a path using #mi(`x = h(y)`) also, we will similarly evaluate the limit along this path by
#mitex(```
\lim_{\stackrel{(x, y) \to (x_0, y_0)}{x = h(y)}} f(x, y) = \lim_{y \to y_0} f(x, y) \bigr|_{x = h(y)}
```)
and if this is different from the limit along some other path (including the #mi(`y = g(x)`) paths), then we can also conclude that the two-variable limit does not exist.

#tip[
  In practice, we like to test the straight-line paths #mi(`y=kx`) including the vertical line #mi(`x=0`).
  You will probably get hints if more complicated paths are needed.
]

As an example, we can show that the limit
#mitex(```
\lim_{(x, y) \to (0, 0)} \frac{y}{x}
```)
does not exist by evaluating the limit along the paths #mi(`y = kx`):
#mitex(```
\lim_{\stackrel{(x, y) \to (0, 0)} {y = kx}} \frac{y}{x} = \lim_{x \to 0} \frac{kx}{x} = k.
```)
Since the limit depends on the value of #mi(`k`), we can conclude that the two-variable limit does not exist.

#exercise[
  #set enum(spacing: 1em)
  Show that the limit does not exist:
  + #mi(`\displaystyle \lim_{(x, y) \to (0, 0)} \frac{xy}{\lvert x y \rvert}`).
  + #mi(`\displaystyle \lim_{(x, y) \to (1, -1)} \frac{x y + 1}{x^2 - y^2}`).
]
#solution[
  + We can evaluate the limit along the paths #mi(`y = kx`):
    #mitex(```
    \lim_{\stackrel{(x, y) \to (0, 0)}{y = kx}} \frac{xy}{\lvert xy \rvert} = \lim_{x \to 0} \frac{k x^2}{\lvert k x^2 \rvert} = \begin{cases}
    1 & \text{if } k > 0, \\
    -1 & \text{if } k < 0.
    \end{cases}
    ```)
    Since the limit depends on the value of #mi(`k`), we can conclude that the two-variable limit does not exist.
  + We can evaluate the limit along the paths #mi(`y = k(x - 1) - 1`), but the limit will actually be quite cumbersome to compute.
    Instead, we can just evaluate the limit along the paths #mi(`y = -1`) and #mi(`x = 1`).

    Along the path #mi(`y = -1`), we have
    #mitex(```
    \lim_{\stackrel{(x, y) \to (1, -1)}{y = -1}} \frac{x y + 1}{x^2 - y}^2 = \lim_{x \to 1} \frac{-x + 1}{x^2 - 1} = \lim_{x \to 1} \frac{-(x - 1)}{(x - 1)(x + 1)} = -\frac{1}{2}.
    ```)
    Along the path #mi(`x = 1`), we have
    #mitex(```
    \lim_{\stackrel{(x, y) \to (1, -1)}{x = 1}} \frac{x y + 1}{x^2 - y^2} = \lim_{y \to -1} \frac{y + 1}{1 - y^2} = \lim_{y \to -1} \frac{y + 1}{(1 - y)(1 + y)} = \lim_{y \to -1} \frac{1}{1 - y} = \frac{1}{2}.
    ```)
    Since the limit along these two paths are different, we can conclude that the two-variable limit does not exist.
]

= Midterm Review

Here are the topics that we should be familiar with for the midterm based on the review problems:
- P1-2: Interval of convergence of a power series.
  - Apply ratio or root test
  - Rewrite inequality to get the radius of convergence
  - Check endpoints if any
- P3: Finding the Taylor series (through derivatives or substitution into known Taylor series)
- P4: Use Taylor series to evaluate limits.
- P5: Estimate error
- P6-8: Dot product, cross product, angle, length, and projection
- P9: Area of parallelogram and volume of parallelepiped
- P10: Parallel or perpendicular
- P11: Parametric equations for a line (segment)
- P12: Equation of a plane
- P13: Intersection of planes
- P14: Intersection of a plane and a line
- P15-16: Velocity and acceleration of a parametric curve

#exercise(label: [Selected Midterm Review Problems])[
  - P3.B: Use any method to find the Taylor series of #mi(`\displaystyle \sin \frac{2x}{3}`).
  - P5: Use a fourth-order Taylor polynomial to approximate the integral #mi(`\displaystyle \int_0^1 \frac{\sin x}{x} \, dx`) and estimate the error in your approximation.
  - P8: If #mi(`\lvert \mathbf{v} \rvert = 2`), #mi(`\lvert \mathbf{u} \rvert = 3`), and the angle between #mi(`\mathbf{v}`) and #mi(`\mathbf{u}`) is #mi(`\frac{\pi}{3}`), find #mi(`\lvert \mathbf{v} - 2 \mathbf{u} \rvert`).
  - P12: Find the plane passing through the points #mi(`(1, -1, 2)`), #mi(`(2, 1, 3)`), and #mi(`(-1, 2, -1)`).
  - P14: Find the point at which the line passing through the origin perpendicular to the plane #mi(`2x - y - z = 4`) meets the plane #mi(`3x - 5y + 2z = 6`).
  - P15: Given #mi(`\mathbf{r}(t) = \langle e^t \cos t, e^t \sin t \rangle`), show that the angle between #mi(`\mathbf{r}(t)`) and #mi(`\mathbf{a}(t)`) is constant.
    What is this angle?
]
#solution[
  - *P3.B*: We know that the Taylor series of #mi(`\sin u`) is
    #h(100%)
    #mitex(```
    \sin u = u - \frac{u^3}{3!} + \frac{u^5}{5!} - \frac{u^7}{7!} + \cdots
    ```)
    so we can substitute #mi(`u = \frac{2x}{3}`) to get
    #mitex(```
    \begin{align}
    \sin \frac{2x}{3} &= \frac{2x}{3} - \frac{(2x/3)^3}{3!} + \frac{(2x/3)^5}{5!} - \frac{(2x/3)^7}{7!} + \cdots \\
    &= \frac{2x}{3} - \frac{2^3 x^3}{3^3 \cdot 3!} + \frac{2^5 x^5}{3^5 \cdot 5!} - \frac{2^7 x^7}{3^7 \cdot 7!} + \cdots.
    \end{align}
    ```)
    #tip[
      I highly recommend you when using substitution to find the Taylor series to express the known Taylor series in terms of a fresh variable like #mi(`u`), and then write an explicit substitution of #mi(`u`) equals some expression of #mi(`x`).
    ]
  - *P5*: We can use the Taylor series of #mi(`\sin x`) to get
    #mitex(```
    \frac{\sin x}{x} = 1 - \frac{x^2}{3!} + \frac{x^4}{5!} - \frac{x^6}{7!} + \cdots.
    ```)
    Approximating the integral by a fourth order Taylor polynomial, we get
    #mitex(```
    \int_0^1 \left( 1 - \frac{x^2}{3!} + \frac{x^4}{5!} \right) \, dx = 1 - \frac{1}{3! \cdot 3} + \frac{1}{5! \cdot 5}.
    ```)
    Note the Taylor series is alternating with terms decreasing for #mi(`0 < x < 1`), so the error approximation is at most the absolute value of the first omitted term:
    #mitex(```
    R_4 (x) \leq \frac{x^6}{7!}.
    ```)
    We can integrate to get the error bound for the integral
    #mitex(```
    \int_0^1 \frac{x^6}{7!} \, dx = \frac{1}{7! \cdot 7}.
    ```)
  - *P8*: We have
    #mitex(```
    \begin{align}
    \lvert \mathbf{v} - 2 \mathbf{u} \rvert^2 = (\mathbf{v} - 2 \mathbf{u}) \cdot (\mathbf{v} - 2 \mathbf{u}) &= \mathbf{v} \cdot \mathbf{v} - 2 \mathbf{u} \cdot \mathbf{v} - 2 \mathbf{v} \cdot \mathbf{u} + 4 \mathbf{u} \cdot \mathbf{u} \\
    &= \lvert \mathbf{v} \rvert^2 - 4 \mathbf{u} \cdot \mathbf{v} + 4 \lvert \mathbf{u} \rvert^2 \\
    &= 2^2 - 4 \left(3 \cdot 2 \cdot \cos \frac{\pi}{3}\right) + 4 \cdot 3^2 \\
    &= 4 - 12 + 36 = 28.
    \end{align}
    ```)
    So we have #mi(`\lvert \mathbf{v} - 2 \mathbf{u} \rvert = \sqrt{28} = 2 \sqrt{7}`).
  - *P12*: We can find the normal vector of the plane by taking the cross product of two vectors parallel to the plane, and we can find two vectors parallel to the plane by finding the difference of two of the points with the third.
    We have
    #mitex(```
    \begin{align}
    \langle 2, 1, 3 \rangle - \langle 1, -1, 2 \rangle &= \langle 1, 2, 1 \rangle, \\
    \langle -1, 2, -1 \rangle - \langle 1, -1, 2 \rangle &= \langle -2, 3, -3 \rangle.
    \end{align}
    ```)
    So we can take the cross product to get the normal vector
    #mitex(```
    \begin{align}
    \begin{vmatrix}
    \mathbf{i} & \mathbf{j} & \mathbf{k} \\
    1 & 2 & 1 \\
    -2 & 3 & -3
    \end{vmatrix}
    &= \mathbf{i} (-6 - 3) - \mathbf{j} (-3 + 2) + \mathbf{k} (3 + 4) \\
    &= -9 \mathbf{i} + \mathbf{j} + 7 \mathbf{k}
    \end{align}
    ```)
    Therefore, the equation of the plane is of the form
    #mitex(```
    -9 x + y + 7 z = d
    ```)
    for some constant #mi(`d`), and we can find #mi(`d`) by plugging in any of the three points (and they should give the same answer, sometime would be wrong if they are not), for example, we can plug in #mi(`(1, -1, 2)`) to get
    #mitex(```
    -9 \cdot 1 + (-1) + 7 \cdot 2 = 5.
    ```)
    So the equation of the plane is
    #mitex(```
    -9 x + y + 7 z = 5.
    ```)
  - *P14*: The line passing through the origin perpendicular to the plane #mi(`2x - y - z = 4`) is given by the parametric equations
    #mitex(```
    x = 2t, \quad y = -t, \quad z = -t.
    ```)
    We can plug these into the equation of the plane #mi(`3x - 5y + 2z = 6`) to get
    #mitex(```
    3(2t) - 5(-t) + 2(-t) = 9 t = 6 \implies t = \frac{2}{3}.
    ```)
    Therefore, the point at which the line meets the plane is (by plugging into the parametric equations)
    #mitex(```
    (x, y, z) = \left( \frac{4}{3}, -\frac{2}{3}, -\frac{2}{3} \right).
    ```)
  - *P15*: We can compute the velocity and acceleration by taking derivatives:
    #mitex(```
    \begin{align}
    \mathbf{v}(t) &= \mathbf{r}'(t) = \langle e^t \cos t - e^t \sin t, e^t \sin t + e^t \cos t \rangle, \\
    \mathbf{a}(t) &= \mathbf{v}'(t) = \langle -2 e^t \sin t, 2 e^t \cos t \rangle.
    \end{align}
    ```)
    So we have
    #mitex(```
    \mathbf{r}(t) \cdot \mathbf{a}(t) = 2 e^{2t} (\cos t (-\sin t) + \sin t \cos t) = 0,
    ```)
    Therefore, #mi(`\mathbf{r}(t)`) and #mi(`\mathbf{a}(t)`) are perpendicular for all #mi(`t`), so the angle between them is constant and is equal to #mi(`\frac{\pi}{2}`).
]
