#import "../Packages/canvas-html.typ": *
#import "@preview/physica:0.9.8" as physica: pdv

#set math.accent(dotless: false)
#let dd = physica.dd.with(d: $d$)
#let dv = physica.dv.with(d: $d$)

#set document(
  title: "Discussion 8 Notes",
  author: "Chen Liang",
  date: datetime(year: 2026, month: 11, day: 17),
)

#show: canvas-html.with(
  course-id: "1103419",
  image-ids: (
    "Contours.svg" : "32623910",
    "Mountain solution.svg" : "32623931",
    "Mountain.svg" : "32623912",
    "Paraboloid.svg" : "32623913",
  ),
)

#show columns: it => {
  if target() == "html" {
    return it.body
  } else {
    it
  }
}

#context if target() == "html" {
  outline()
}

= Warm-Up

#exercise[
  As we discussed in the previous discussion, we can compose a curve with a function $f(x, y)$ to get a single-variable function.
  In particular, when the curve is a straight line, the resulting single-variable function can be seen as the intersection of the graph of $f(x, y)$ with a vertical plane.
  #figure(
    image(
      "Paraboloid.svg",
      width: 95%,
      alt: "The graph of a paraboloid and its level curves. Point A is at the bottom left of the paraboloid.",
    ),
    caption: [
      Example of composing a horizontal line associated with a fixed $y$ and a function $f(x, y)$ to get a single-variable function in $x$.
    ]
  )

  Draw the single-variable function that is the composition of the curve and the function $f(x, y)$ shown in the figure below.
  #figure(
    image(
      "Mountain.svg",
      width: 40%,
      alt: "The level curves of a hill. Point A is at the bottom left. A red horizontal line is drawn through point A.",
    )
  )
]
#solution[
  As we move from the left to the right, we are going up the hill until we reach a height of slightly less than $140$, then we start going down the hill to some point between $100$ and $120$.
  Near the very end, we are going up the hill again.
  #figure(
    image(
      "Mountain solution.svg",
      width: 40%,
      alt: "The graph of a single-variable function that starts off increasing, reaches a peak, then decreases, and finally increases again but only slightly.",
    ),
    caption: [
      The single-variable function that is the composition of the curve and the function $f(x, y)$ shown in the previous figure.
    ]
  ) <fig:mountain-solution>
]

= Partial Derivatives

A two-variable function $f (x, y)$ has two partial derivatives, $f_(x)(x, y)$ and $f_(y)(x, y)$.
They represent how fast $f (x, y)$ changes as we take a small step in the $x$-direction and $y$-direction, respectively.

We have already seen this in discussion 6, two weeks ago!
We were doing the exercise of determining whether a function $f(x, y)$ will increase or decrease as we move in the positive $x$-direction and in the positive $y$-direction starting at various points.
#figure(
  image(
    "Contours.svg",
    width: 40%,
    alt: "Contour plot of a hill. Point A is at the bottom left, point B is at the bottom right, point C at the peak of the hill, and point D is at the top left.",
  ),
  caption: [
    The contour plot in the exercise from discussion 6.
  ]
) <fig:contours>

At point $A$, if we take a small step in the $x$-direction (towards the right), we will go up the hill and the rate at which we are going up is exactly the slope of the function in @fig:mountain-solution at the point $A$.
Thus, we can say that $f_(x) > 0$ at the point $A$.
Similarly, we can also see that $f_(y) > 0$ at the point $A$ because we are also going up the hill at some steady rate if we take a small step in the $y$-direction.

Computationally, to find the derivative of $f (x, y)$ with respect to $x$, we treat $y$ as a constant and vice versa.
For example, if $f (x,y) = x^(4) y^(3)$, then $f_(x) = 4 x^(3) y^(3)$ and $f_(y) = 3 x^(4) y^(2)$.
#tip[
  - The $x$-derivative of $x^(4) 1^(3)$ is $4 x^(3) 1^(3)$.
  - The $x$-derivative of $x^(4) 2^(3)$ is $4 x^(3) 2^(3)$.
  - The $x$-derivative of $x^(4) pi^(3)$ is $4 x^(3) pi^(3)$.
  - The $x$-derivative of $x^(4) y^(3)$ is $4 x^(3) y^(3)$.
  When taking the $x$-derivative, we treat $y$ as a constant just like $1$, $2$, and $pi$ are constants.
]

Another notation for partial derivative is that
$
  f_(x)(x, y) = frac(partial f, partial x)(x, y) quad #text[and] quad f_(y)(x, y) = frac(partial f, partial y)(x, y).
$

#exercise[
  + Let $f (x, y) = x y$, find $f_(x)$ and $f_(y)$.
  + Let $f (x, y) = ln (2 x + 3 y)$, find $f_(x)$ and $f_(y)$.
  + Looking at the plot in @fig:contours and assuming the function is maximized at point $C$, what can we say about the signs of $f_(x)$ and $f_(y)$ at points $B$, $C$, and $D$?
]
#solution[
  + We have $f_(x) = y$ and $f_(y) = x$.
  + We have
    $
      f_(x) = frac(2, 2 x + 3 y) quad #text[and] quad f_(y) = frac(3, 2 x + 3 y).
    $
  + At point $B$, we are going down the hill in the $x$-direction and going up the hill in the $y$-direction.
    So $f_(x) < 0$ and $f_(y) > 0$ at point $B$.

    At point $D$, we are going up the hill in the $x$-direction and going down the hill in the $y$-direction, so $f_(x) > 0$ and $f_(y) < 0$ at point $C$.

    Now, at point $C$, we are at the peak of the hill.
    While it is true that we are going down the hill in both the $x$-direction and the $y$-direction, the rate at which we are going down is arbitrarily small, meaning $0$.
    So $f_(x) = 0$ and $f_(y) = 0$ at point $C$.
    If we consider the intersection of the hill with the vertical planes through point $C$, we will always see that $C$ is a local maximum, and the slope there is zero.
]

= Chain Rule

Let $z = f(x, y)$ be a function of $x$ and $y$, we have discussed that
$
  pdv(z, x) quad "and" quad pdv(z, y)
$
represent how fast $z$ changes as we take a small step in the $x$-direction and $y$-direction, respectively.
Now, if we take a small step $d x$ in the $x$-direction and a small step $d y$ in the $y$-direction, the change in $z$ is going to be the sum of
$
  dd(z) = pdv(z, x) dd(x) + pdv(z, y) dd(y).
$
The same idea leads to the multivariate chain rule
$
  dv(z, t) = pdv(z, x) dv(x, t) + pdv(z, y) dv(y, t)
$
when $x$ and $y$ are functions of $t$.
For example, if we have $z = x y$, $x = cos t$, and $y = sin t$, then
$
  pdv(z, x) = y = sin t, quad pdv(z, y) = x = cos t, quad dv(x, t) = -sin t, quad dv(y, t) = cos t.
$
Putting these together, we have
$
  dv(z, t) = pdv(z, x) dv(x, t) + pdv(z, y) dv(y, t) = y (-sin t) + x (cos t) = cos^(2) t - sin^(2) t.
$
This is exactly the same result when we were doing the exercise about composing curve $arrow(r) = (cos t, sin t)$ with the function $f(x, y) = x y$ in discussion 7.
We first substituted
$
  z = f(arrow(r)) = f(cos t, sin t) = cos t sin t
$
and then computed the derivative
$
  dv(z, t) = cos^(2) t - sin^(2) t.
$
Chain rule allows us to swap the order and do derivative and then substitution.
Both ways are valid and have their own advantages.

A more general version of chain rule applies to partial derivative as well.
Given $z (x, y)$, $x (u, v)$, and $y (u, v)$, we have
$
  pdv(z, u) = pdv(z, x) pdv(x, u) + pdv(z, y) pdv(y, u).
$

#exercise[
  #set enum(spacing: 1em)
  Find the following, determine whether the chain rule is easier or the substitution-first method is easier.

  + Let $z = ln (2 x + 3 y)$, $x = u + 3 v$, and $y = u - 2 v$, find $display(frac(partial z, partial u))$ and $display(frac(partial z, partial v))$.
  + Let $z = x^(4) y^(3)$, $display(x = 1 + frac(t, sqrt(5)))$, and $display(y = 1 + frac(2 t, sqrt(5)))$, find $display(frac(d z, d t))$ at $t = 0$.
]
#solution[
  + This problem can be easily done with substitution, we have
    $
      z = ln (2 (u + 3 v) + 3 (u - 2 v)) = ln (5 u).
    $
    So we have
    $
      frac(partial z, partial u) = frac(5, 5 u) = 1/u quad #text[and] quad frac(partial z, partial v) = 0 .
    $

    #tip[
      We can definitely still do it with the chain rule as well.
      We have found in the previous exercise that
      $
        frac(partial z, partial x) = frac(2, 2 x + 3 y) quad #text[and] quad frac(partial z, partial y) = frac(3, 2 x + 3 y).
      $
      We also have
      $
        frac(partial x, partial u) = 1 quad #text[and] quad frac(partial y, partial u) = 1
      $
      and so
      $
        frac(partial z, partial u) = frac(2, 2 x + 3 y) dot 1 + frac(3, 2 x + 3 y) dot 1 = frac(5, 2 x + 3 y) = 1/u.
      $
      Similarly, we have
      $
        frac(partial x, partial v) = 3 quad #text[and] quad frac(partial y, partial v) = - 2
      $
      and so
      $
        frac(partial z, partial v) = frac(2, 2 x + 3 y) dot 3 + frac(3, 2 x + 3 y) dot (- 2) = 0 .
      $
      Sure enough, we get the same answers using both methods.
    ]

  + Chain rule shines in this problem.
    We computed in the previous part that
    $
      frac(partial z, partial x) = 4 x^(3) y^(3) quad #text[and] quad frac(partial z, partial y) = 3 x^(4) y^(2),
    $
    We also have
    $
      frac(partial x, partial t) = frac(1, sqrt(5)) quad #text[and] quad frac(partial y, partial t) = frac(2, sqrt(5)).
    $
    So we have
    $
      frac(d z, d t) = 4 x^(3) y^(3) dot frac(1, sqrt(5)) + 3 x^(4) y^(2) dot frac(2, sqrt(5)).
    $
    Instead of expanding $x$ and $y$ into expressions in terms of $t$ and plugging in $t = 0$, it is simpler to the values of $x$ and $y$ at $t = 0$ and then plug them into the expression above.
    At $t = 0$, we have
    $
      x = 1 quad #text[and] quad y = 1,
    $
    so
    $
      frac(d z, d t) = 4 frac(1, sqrt(5)) + 3 frac(2, sqrt(5)) = frac(10, sqrt(5)).
    $
    #tip[
      We can write $d z slash d t$ completely in terms of $t$ first then plug in $t = 0$.
      Doing this, we have
      $
        frac(d z, d t) & = 4(1 + frac(t, sqrt(5)))^(3) (1 + frac(2 t, sqrt(5)))^(3) dot frac(1, sqrt(5)) + 3(1 + frac(t, sqrt(5)))^(4) (1 + frac(2 t, sqrt(5)))^(2) dot frac(2, sqrt(5)) \ & = 4 frac(1, sqrt(5)) + 3 frac(2, sqrt(5))
      $
      which is of course the same answer but has a lot to write.
      Knowing to compute $x$ and $y$ at $t = 0$ and plugging them in is a very useful trick.
    ]
]
