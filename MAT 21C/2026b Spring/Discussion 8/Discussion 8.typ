#import "../Template/canvas-html.typ": *

#show: canvas-html.with(
  course-id: "1067114",
  image-ids: (
    "contours.svg" : "31214891"
  ),
  title: "MAT 21C Discussion 8",
  author: "Chen Liang",
  date: datetime(year: 2026, month: 5, day: 19),
)

= Warm-Up

#exercise(label: [Warm-up])[
  If #mi(`\langle a, b \rangle`) is a unit vector, then for what values of #mi(`a`) and #mi(`b`) is the dot product
  #mitex(```
  \langle 4, 3 \rangle \cdot \langle a, b \rangle
  = 4a + 3b
  ```)
  maximized? (Hint: think about the cosine formula for the dot product.)
]
#solution[
  The cosine formula says that
  #mitex(```
  \langle 4, 3 \rangle \cdot \langle a, b \rangle = \lvert \langle 4, 3 \rangle \rvert \lvert \langle a, b \rangle \rvert \cos \theta,
  ```)
  where #mi(`\theta`) is the angle between the two vectors.
  Since #mi(`\lvert \langle 4, 3 \rangle \rvert = 5`) and #mi(`\lvert \langle a, b \rangle \rvert = 1`), the dot product is equal to #mi(`5 \cos \theta`).
  This is maximized when #mi(`\theta = 0`), which means that the two vectors are in the same direction.
  The unit vector pointing in the direction of #mi(`\langle 4, 3 \rangle`) is
  #mitex(```
  \frac{\langle 4, 3 \rangle}{\lvert \langle 4, 3 \rangle \rvert} =\left\langle \frac{4}{5}, \frac{3}{5} \right\rangle.
  ```)
]

This is the first constrained optimization problem we solved analytically!
In the warm-up, we
#mitex(```
\text{optimized} \quad 4a + 3b \quad \text{under the constraint} \quad a^2 + b^2 = 1.
```)
We still had to be a little clever to use the cosine formula for dot product.
At the end of the quarter, we will learn a systematic method called *Lagrange multipliers* to solve this kind of problem without having to be clever.

= Partial Derivatives

A two-variable function #mi(`f(x, y)`) has two partial derivatives, #mi(`f_x(x, y)`) and #mi(`f_y(x, y)`).
They represent how fast #mi(`f(x, y)`) changes as we take a small step in the #mi(`x`)-direction and #mi(`y`)-direction, respectively.
Consider the contour plot of #mi(`f(x, y)`) below.
#figure(
  image(
    "contours.svg",
    width: 50%,
    alt: "Contour plot of a hill. Point A is at the bottom left, point B is at the bottom right, and point C is at the top left."
  ),
  caption: [
    The contour plot of a function representing a hill.
    Along a contour line, the function has constant value labeled by the number on the line.
  ]
)
At point #mi(`A`), if we take a small step in the #mi(`x`)-direction (towards the right), we will cross the contour line where the function value is #mi(`80`).
Looking at the surrounding contour lines, it looks like we are going from somewhere below #mi(`80`) to somewhere above #mi(`80`), so the function is increasing as we take the step, and we can conclude that #mi(`f_x > 0`) at the point #mi(`A`).
Similarly, we can also see that #mi(`f_y > 0`) at the point #mi(`A`) because we are also going up the hill in the #mi(`y`)-direction.

Computationally, to find the derivative of #mi(`f(x, y)`) with respect to #mi(`x`), we treat #mi(`y`) as a constant and vice versa.
For example, if #mi(`f(x,y) = x^4 y^3`), then #mi(`f_x = 4x^3 y^3`) and #mi(`f_y = 3x^4 y^2`).
#tip[
  - The #mi(`x`)-derivative of #mi(`x^4 1^3`) is #mi(`4x^3 1^3`).
  - The #mi(`x`)-derivative of #mi(`x^4 2^3`) is #mi(`4x^3 2^3`).
  - The #mi(`x`)-derivative of #mi(`x^4 \pi^3`) is #mi(`4x^3 \pi^3`).
  - The #mi(`x`)-derivative of #mi(`x^4 y^3`) is #mi(`4x^3 y^3`).
  When taking the #mi(`x`)-derivative, we treat #mi(`y`) as a constant just like #mi(`1`), #mi(`2`), and #mi(`\pi`) are constants.
]

Another notation for partial derivative is that
#mitex(```
f_x(x, y) = \frac{\partial f}{\partial x}(x, y) \quad \text{and} \quad
f_y(x, y) = \frac{\partial f}{\partial y}(x, y).
```)

#exercise[
  + Looking at the contour plot above.
    Find the signs of #mi(`f_x`) and #mi(`f_y`) at points #mi(`B`) and #mi(`C`).
  + Let #mi(`f(x, y) = x^2 + y^2`), find #mi(`f_x`) and #mi(`f_y`).
  + Let #mi(`f(x, y) = \ln (2x + 3y)`), find #mi(`f_x`) and #mi(`f_y`).
]
#solution[
  + At point #mi(`B`), we are going down the hill in the #mi(`x`)-direction and going up the hill in the #mi(`y`)-direction.
    So #mi(`f_x < 0`) and #mi(`f_y > 0`) at point #mi(`B`).

    At point #mi(`C`), we are going up the hill in the #mi(`x`)-direction and going down the hill in the #mi(`y`)-direction, so #mi(`f_x > 0`) and #mi(`f_y < 0`) at point #mi(`C`).
  + We have #mi(`f_x = 2x`) and #mi(`f_y = 2y`).
  + We have
    #mitex(```
    f_x = \frac{2}{2x + 3y} \quad \text{and} \quad
    f_y = \frac{3}{2x + 3y}.
    ```)
]

= Chain Rule

Let #mi(`z(x, y)`) be a function of #mi(`x`) and #mi(`y`), we have discussed that
#mitex(```
\frac{\partial z}{\partial x} \quad \text{and} \quad
\frac{\partial z}{\partial y}
```)
represent how fast #mi(`z`) changes as we take a small step in the #mi(`x`)-direction and #mi(`y`)-direction, respectively.
Now, if we take a small step #mi(`dx`) in the #mi(`x`)-direction and a small step #mi(`dy`) in the #mi(`y`)-direction, the change in #mi(`z`) is going to be the sum of
#mitex(```
dz = \frac{\partial z}{\partial x} dx + \frac{\partial z}{\partial y} dy.
```)
The same idea leads to the multivariate chain rule
#mitex(```
\frac{dz}{dt} = \frac{\partial z}{\partial x} \frac{dx}{dt} + \frac{\partial z}{\partial y} \frac{dy}{dt}
```)
when #mi(`x(t)`) and #mi(`y(t)`) are both functions of #mi(`t`).
For example, if we have #mi(`z = x^2 + y^2`), #mi(`x = \cos t`), and #mi(`y = \sin t`), then
#mitex(```
\begin{aligned}
\frac{dz}{dt} &= \frac{\partial z}{\partial x} \frac{dx}{dt} + \frac{\partial z}{\partial y} \frac{dy}{dt} \\
&= 2x \cdot (-\sin t) + 2y \cdot \cos t \\
&= 2\cos t \cdot (-\sin t) + 2\sin t \cdot \cos t \\
&= 0.
\end{aligned}
```)
This agrees with a more direct computation that #mi(`z = x^2 + y^2 = \cos^2 t + \sin^2 t = 1`) and so #mi(`dz/dt = 0`).

A more general version applies to partial derivative as well.
Given #mi(`z(x, y)`), #mi(`x(u, v)`), and #mi(`y(u, v)`), we have
#mitex(```
\frac{\partial z}{\partial u} = \frac{\partial z}{\partial x} \frac{\partial x}{\partial u} + \frac{\partial z}{\partial y} \frac{\partial y}{\partial u}.
```)

#exercise[
  #set enum(spacing: 1em)
  + Let #mi(`z = \ln(2x + 3y)`), #mi(`x = u + 3v`), and #mi(`y = u - 2v`), find #mi(`\displaystyle \frac{\partial z}{\partial u}`) and #mi(`\displaystyle \frac{\partial z}{\partial v}`).
  + Let #mi(`z = x^4 y^3`), #mi(`\displaystyle x = 1 + \frac{t}{\sqrt{5}}`), and #mi(`\displaystyle y = 1 + \frac{2t}{\sqrt{5}}`), find #mi(`\displaystyle \frac{dz}{dt}`) at #mi(`t = 0`).
  + Let #mi(`\langle a, b \rangle`) be a unit vector and
    #mitex(```
    z = x^4 y^3, \quad x = 1 + a t, \quad y = 1 + b t.
    ```)
    Find #mi(`\displaystyle \frac{dz}{dt}`) at #mi(`t = 0`), and find the values of #mi(`a`) and #mi(`b`) that maximize #mi(`\displaystyle \frac{dz}{dt}`) at #mi(`t = 0`).
    Explain why this vector #mi(`\langle a, b \rangle`) is the direction of the "steepest ascent" of the function #mi(`z = x^4 y^3`) at the point #mi(`(1, 1)`).
]
#solution[
  + This problem can be easily done with substitution, we have
    #mitex(```
    z = \ln (2 (u + 3v) + 3 (u - 2v)) = \ln (5u).
    ```)
    So we have
    #mitex(```
    \frac{\partial z}{\partial u} = \frac{5}{5u} = \frac{1}{u} \quad \text{and} \quad
    \frac{\partial z}{\partial v} = 0.
    ```)

    #tip[
      We can definitely still do it with the chain rule as well.
      We have found in the previous exercise that
      #mitex(```
      \frac{\partial z}{\partial x} = \frac{2}{2x + 3y} \quad \text{and} \quad
      \frac{\partial z}{\partial y} = \frac{3}{2x + 3y}.
      ```)
      We also have
      #mitex(```
      \frac{\partial x}{\partial u} = 1 \quad \text{and} \quad \frac{\partial y}{\partial u} = 1
      ```)
      and so
      #mitex(```
      \frac{\partial z}{\partial u} = \frac{2}{2x + 3y} \cdot 1 + \frac{3}{2x + 3y} \cdot 1 = \frac{5}{2x + 3y} = \frac{1}{u}.
      ```)
      Similarly, we have
      #mitex(```
      \frac{\partial x}{\partial v} = 3 \quad \text{and} \quad \frac{\partial y}{\partial v} = -2
      ```)
      and so
      #mitex(```
      \frac{\partial z}{\partial v} = \frac{2}{2x + 3y} \cdot 3 + \frac{3}{2x + 3y} \cdot (-2) = 0.
      ```)
      Sure enough, we get the same answers using both methods.
    ]

  + Substitution would not make progress to solve the problem.
    This is where the chain rule comes in handy.
    We computed in the previous part that
    #mitex(```
    \frac{\partial z}{\partial x} = 4x^3 y^3 \quad \text{and} \quad
    \frac{\partial z}{\partial y} = 3x^4 y^2,
    ```)
    We also have
    #mitex(```
    \frac{\partial x}{\partial t} = \frac{1}{\sqrt{5}} \quad \text{and} \quad
    \frac{\partial y}{\partial t} = \frac{2}{\sqrt{5}}.
    ```)
    So we have
    #mitex(```
    \frac{dz}{dt} = 4x^3 y^3 \cdot \frac{1}{\sqrt{5}} + 3x^4 y^2 \cdot \frac{2}{\sqrt{5}}.
    ```)
    Instead of expanding #mi(`x`) and #mi(`y`) into expressions in terms of #mi(`t`) and plugging in #mi(`t = 0`), it is simpler to the values of #mi(`x`) and #mi(`y`) at #mi(`t = 0`) and then plug them into the expression above.
    At #mi(`t = 0`), we have 
    #mitex(```
    x = 1 \quad \text{and} \quad y = 1,
    ```)
    so
    #mitex(```
    \frac{dz}{dt} = 4 \frac{1}{\sqrt{5}} + 3 \frac{2}{\sqrt{5}} = \frac{10}{\sqrt{5}}.
    ```)
    #tip[
      We can write #mi(`dz/dt`) completely in terms of #mi(`t`) first then plug in #mi(`t=0`).
      Doing this, we have
      #mitex(```
      \begin{aligned}
      \frac{dz}{dt} &= 4 \left(1 + \frac{t}{\sqrt{5}}\right)^3 \left(1 + \frac{2t}{\sqrt{5}}\right)^3 \cdot \frac{1}{\sqrt{5}} + 3 \left(1 + \frac{t}{\sqrt{5}}\right)^4 \left(1 + \frac{2t}{\sqrt{5}}\right)^2 \cdot \frac{2}{\sqrt{5}} \\
      &= 4 \frac{1}{\sqrt{5}} + 3 \frac{2}{\sqrt{5}}
      \end{aligned}
      ```)
      which is of course the same answer but has a lot to write.
      Knowing to compute #mi(`x`) and #mi(`y`) at #mi(`t = 0`) and plugging them in is a very useful trick.
    ]
  + In general, we have
    #mitex(```
    \frac{\partial x}{\partial t} = a \quad \text{and} \quad
    \frac{\partial y}{\partial t} = b,
    ```)
    and so,
    #mitex(```
    \frac{dz}{dt} = 4x^3 y^3 a + 3x^4 y^2 b.
    ```)
    At #mi(`t = 0`), we have #mi(`x = 1`) and #mi(`y = 1`), so
    #mitex(```
    \frac{dz}{dt} = 4a + 3b.
    ```)
    To maximize this for unit vector #mi(`\langle a, b \rangle`), we have seen in the warm-up problem that the maximum is achieved when #mi(`\langle a, b \rangle`) points in the same direction as #mi(`\langle 4, 3 \rangle`), which means that
    #mitex(```
    \langle a, b \rangle = \left\langle \frac{4}{5}, \frac{3}{5} \right\rangle.
    ```)
    This vector is the direction of the steepest ascent because
    #mitex(```
    \frac{dz}{dt} = 4a + 3b
    ```)
    is telling us how fast #mi(`z`) is changing as we take a small step in the direction of #mi(`\langle a, b \rangle`) starting from #mi(`(1, 1)`).
    Maximizing this quantity is equivalent to answering the question "which direction should we take a small step from #mi(`(1, 1)`) to increase the value of #mi(`z`) the most?"
    Hence, the name steepest ascent.

    We can even generalize this argument to see that the *gradient vector*
    #mitex(```
    \left\langle \frac{\partial z}{\partial x}, \frac{\partial z}{\partial y} \right\rangle
    = \hat{i} \frac{\partial z}{\partial x} + \hat{j} \frac{\partial z}{\partial y}
    ```)
    always points in the direction of the steepest ascent of the function #mi(`z`) at any point.
]
