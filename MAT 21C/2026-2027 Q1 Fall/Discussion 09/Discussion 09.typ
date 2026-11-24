#import "../Packages/canvas-html.typ": *
#import "@preview/physica:0.9.8" as physica: pdv

#set math.accent(dotless: false)
#let dd = physica.dd.with(d: $d$)
#let dv = physica.dv.with(d: $d$)

#set document(
  title: "Discussion 9 Notes",
  author: "Chen Liang",
  date: datetime(year: 2026, month: 11, day: 24),
)

#show: canvas-html.with(
  course-id: "1103419",
  image-ids: (
    "Exception.png": "32690521",
    "Gradient is normal.svg": "32690522",
    "Linear function on circle.svg": "32690523",
    "Naive.png": "32690524",
    "One variable.svg": "32690525",
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

#show figure.caption: it => pad(x: 2em, it)

= Warm-Up

#exercise(label: [Warm-up])[
  The level curves of the function $f(x, y) = 12 x + 5 y$ are shown below.
  Among points on the unit circle $x^2 + y^2 = 1$, what is the maximum value of $f(x, y)$?
  Where does it occur?
  #figure(
    image(
      "Linear function on circle.svg",
      width: 40%,
      alt: "A red circle with a stack of parallel lines spanning the plane.",
    ),
    caption: [
      The unit circle in red and the level curves with values indicated.
      If you zoom in closely, you might be able to see the level curve with the maximum value.
    ],
  )
]
#solution[
  If we were to test whether we can hit the ceiling with a wooden stick, we better point it straight up in the direction perpendicular to the ceiling.
  Same reasoning applies here: we are pointing a stick with unit length from the origin, and we want to see what is the furthest level curve we can reach.
  Thus, we better point the stick in the direction perpendicular to the level curves $12 x + 5 y = c$, which is $chevron(12\, 5)$.
  The unit vector in that direction is
  $
    arrow(u) = frac(1, sqrt(12^(2) + 5^(2))) chevron(12\, 5) = chevron(12/13\, 5/13).
  $
  Therefore, the maximum value of $f(x, y)$ on the unit circle occurs at $(x, y) = (12/13, 5/13)$, and the maximum value is
  $
    f(12/13, 5/13) = 12 dot 12/13 + 5 dot 5/13 = 169/13 = 13.
  $

  Yet another way to solve the problem is to reframe the problem as maximizing $arrow(u) dot chevron(12\, 5)$ among all unit vectors $arrow(u)$.
  We know by the formula
  $
    arrow(u) dot chevron(12\, 5) = abs(arrow(u)) abs(chevron(12\, 5)) cos(theta) = sqrt(12^(2) + 5^(2)) cos(theta)
  $
  that the maximum occurs when $theta = 0$, i.e. when $arrow(u)$ points in the same direction as $chevron(12\, 5)$, and the maximum value is $sqrt(12^(2) + 5^(2)) = 13$.
]

There are two takeaways from the warm-up problem.
- The gradient vector, which is
  $
    nabla f = chevron(pdv(f, x)\, pdv(f, y)) = chevron(12\, 5),
  $
  is perpendicular to the level curves of $f(x, y)$.
- The gradient vector of $f(x, y)$ points in the direction of the steepest increase of $f(x, y)$, exactly in the sense of the wooden stick.

= Gradient

In general, the gradient of a function $f(x, y)$ is defined as
$
  nabla f = chevron(pdv(f, x)\, pdv(f, y)).
$
The gradient can be used to approximate the change of $f(x, y)$ for small changes in $x$ and $y$.
Recall from last discussion that the difference $f (x + dd(x), y + dd(y)) - f (x, y)$ for small $dd(x)$ and $dd(y)$ can be approximated by
$
  pdv(f, x) dd(x) + pdv(f, y) dd(y) = chevron(pdv(f, x)\, pdv(f, y)) dot chevron(dd(x)\, dd(y)) = nabla f dot chevron(dd(x)\, dd(y)).
$
The geometric meanings of the gradient are all coming from this formula.
+ The gradient points in the direction of the steepest increase, meaning that the directional derivative
  $
    D_(arrow(u)) f = nabla f dot arrow(u)
  $
  is the greatest among unit vectors $u$ precisely when $u$ points in the same direction as the gradient.
  This is for the exact same reason as the warm-up problem (see @fig:gradient-is-normal).
  The magnitude of the gradient $abs(nabla f)$ is precisely the value of the greatest directional derivative.
  #figure(
    image(
      "Gradient is normal.svg",
      width: 60%,
      alt: "Circular looking level curves of a function and a marked point with an arrow attached that is perpendicular to the level curve. A zoomed in view around the point shows that the level curves look straight.",
    ),
    caption: [
      If we zoom in on a point of an arbitrary function, the level curves will look like straight lines, and it will reduce to the setup of the warm-up problem.
    ],
  ) <fig:gradient-is-normal>
+ The gradient of $f (x, y)$ is perpendicular to the level curves, and so it is a normal vector to the tangent line of the level curve.
  In particular, the tangent line to the level curve of $f (x, y)$ at $(x_(0), y_(0))$ is given by
  $
    nabla f (x_(0), y_(0)) dot chevron.l x - x_(0), y - y_(0) chevron.r = 0 .
  $
  In $3$-dimensions, the tangent plane to the level surface of $f (x, y, z)$ at $(x_(0), y_(0), z_(0))$ is given by
  $
    nabla f (x_(0), y_(0), z_(0)) dot chevron.l x - x_(0), y - y_(0), z - z_(0) chevron.r = 0 .
  $
+ We must have $nabla f (x, y) = chevron(0\, 0)$ at a local maximum or minimum of $f (x, y)$.
  After all, if the gradient is nonzero, then we can move in that direction to increase or move in the opposite direction to decrease the value of $f (x, y)$.
  The points where $nabla f (x, y) = chevron(0\, 0)$ are called *critical points* of $f (x, y)$.

#exercise[
  + Find the gradient of $f (x, y) = x^(2) - x y + 1/2 y^(2) + 3$.
    Then, evaluate $nabla f (3, 2)$.
  + Use the approximation formula
    $
      f (x + dd(x), y + dd(y)) - f (x, y) approx pdv(f, x) dd(x) + pdv(f, y) dd(y),
    $
    to approximate $f(3.01, 2.1)$.
  + The approximation we obtained in the previous part is called the *linear approximation*, we denote it by $L(3.01, 2.1)$.
    The error $E (3.01, 2.1) = f (3.01, 2.1) - L (3.01, 2.1)$ is bounded by
    $
      abs(E (3.01, 2.1)) <= 1/2 M (abs(3.01 - 3) + abs(2.1 - 2))^(2)
    $
    where $M$ must be an upper bound of $abs(f_(x x))$, $abs(f_(y y))$, and $abs(f_(x y))$ for all points $3 <= x <= 3.01$ and $2 <= y <= 2.1$.
    Find the error bound.
  + Find the only critical point of $f (x, y)$.
    Do you think it is a local maximum, local minimum, or neither?
]
#solution[
  + The gradient of $f (x, y)$ is
    $
      nabla f = lr(chevron.l frac(partial f, partial x), frac(partial f, partial y) chevron.r) = chevron.l 2 x - y, - x + y chevron.r .
    $
    Evaluating at $(3, 2)$, we get
    $
      nabla f (3, 2) = chevron.l 4, - 1 chevron.r .
    $
  + Rearrange the approximation formula, we have
    $
      f (x + dd(x), y + dd(y)) approx f (x, y) + pdv(f, x) dd(x) + pdv(f, y) dd(y).
    $
    Plugging in $x = 3$, $y = 2$, and $dd(x) = 0.01$, $dd(y) = 0.1$, we have
    $
      f(3, 2) = 3^(2) - 3 dot 2 + 1/2 dot 2^(2) + 3 = 8, \
      pdv(f, x)(3, 2) = 2 dot 3 - 2 = 4, \
      pdv(f, y)(3, 2) = - 3 + 2,
    $
    and so
    $
      f(3.01, 2.1) & approx f(3, 2) + pdv(f, x)(3, 2) dd(x) + pdv(f, y)(3, 2) dd(y) \
                   & = 8 + 4 (0.01) - 1 (0.1) \
                   & = 7.94.
    $
  + Note that we are defining
    $
      L(x, y) = f (3, 2) + pdv(f, x)(3, 2) (x - 3) + pdv(f, y)(3, 2) (y - 2),
    $
    so that $L(3.01, 2.1) = 7.94$.
    The second derivatives of $f(x, y)$ are
    $
      f_(x x) = 2, quad f_(y y) = 1, quad f_(x y) = - 1 .
    $
    Thus, we can take $M = 2$ as an upper bound for the second derivatives, and the error is bounded by
    $
      abs(E (3.01, 2.1)) <= 1/2 dot 2 (abs(3.01 - 3) + abs(2.1 - 2))^(2) = 0.0121.
    $
    This tells us that the actual value of $f (3.01, 2.1)$ is between $7.94 - 0.0121$ and $7.94 + 0.0121$.
  + We have found in the part (a) that
    $
      nabla f = chevron.l 2 x - y, - x + y chevron.r .
    $
    Setting the gradient to zero, we get
    $
      2 x - y = 0, quad - x + y = 0 .
    $
    Solving the system of equations, we get the critical point $(0, 0)$.

    If we look at the single-variable functions $f(x, 0) = x^2 + 3$ and $f(0, y) = 1/2 y^2 + 3$, we see that they are both parabolas that open upward, so the critical point $(0, 0)$ cannot be a local maximum.
    Can we conclude that it is a local minimum?
    Not yet, because of the $-x y$ term, we cannot rule out the possibility that the function dips below $3$.
    We need a more systematic way to classify the critical point, which we will discuss in the next section.
]

#tip[
  In general, the linear approximation of a function $f (x, y)$ at a point $(x_(0), y_(0))$ is given by
  $
    L (x, y) = f (x_(0), y_(0)) + nabla f (x_(0), y_(0)) dot chevron.l x - x_(0), y - y_(0) chevron.r .
  $
  The error of the linear approximation on a rectangle containing $(x_(0), y_(0))$ is bounded by
  $
    abs(E (x, y)) <= 1/2 M (abs(x - x_(0)) + abs(y - y_(0)))^(2)
  $
  where $M$ is an upper bound of the second derivatives of $f$ for all points in the rectangle.
]

= Second Derivative Test

If we want to find the local extrema of a function $f (x)$ of one variable, we can find the critical points by solving $f '(x) = 0$, and then determine which critical points are local maxima or local minima by using the second derivative test.
To recap, the second derivative test for one variable says that:
- If $f ''(x) > 0$, then the function is "happy" (curving upward), so the critical point is a local minimum.
- If $f ''(x) < 0$, then the function is "sad" (curving downward), so the critical point is a local maximum.
#figure(
  image(
    "One variable.svg",
    width: 60%,
    alt: "Left graph showing a parabola that opens upward labeled f'' > 0. Right graph showing a parabola that opens downward labeled f'' < 0.",
  ),
  caption: [
    The second derivative test for one variable.
  ],
)

For a function $f (x, y)$ of two variables, we can find the critical points by solving
$
  nabla f (x, y) = chevron(0\, 0),
$
or equivalently, by solving the system of equations
$
  f_x (x, y) = 0, quad f_y (x, y) = 0.
$
At critical points, the function is flat like the one variable case.
A naive classification of the critical points might be to just look at the second derivatives $f_(x x)$ and $f_(y y)$:
- A local maximum is curving downward in both directions, so we expect $f_(x x) < 0$ and $f_(y y) < 0$.
- A local minimum is curving upward in both directions, so we expect $f_(x x) > 0$ and $f_(y y) > 0$.
- If $f_(x x)$ and $f_(y y)$ have different signs, then the function is curving upward in one direction and curving downward in the other, so the critical point is a saddle point.
#figure(
  image(
    "Naive.png",
    width: 70%,
    alt: "Left graph showing a parabolic surface that opens downward. Middle graph showing a parabolic surface that opens upward. Right graph showing a saddle surface.",
  ),
  caption: [
    Naive expectation of the second derivative test for two variables. (Image credit: #link("https://intellectualmathematics.com/dl/calculus.pdf")[Viktor Blåsjö])
  ],
)
This characterization is _almost complete_.
The fact that a surface is curving upward in both axes directions does not mean that it is curving upward in all directions: if it dips along the diagonal, then it is a saddle after all.
#figure(
  image(
    "Exception.png",
    width: 55%,
    alt: "A saddle surface with two parabolic curves along the x and y axes that open upward, but the surface dips along the diagonal.",
  ),
  caption: [
    A surface with $f_(x x) > 0$ and $f_(y y) > 0$, but it is still a saddle point because it dips along the diagonal. (Image credit: #link("https://intellectualmathematics.com/dl/calculus.pdf")[Viktor Blåsjö])
  ],
)
To take the diagonal effect into account, the complete second derivative test for two variables look at the so-called *discriminant* $f_(x x) f_(y y) - f_(x y)^(2)$.
- If $f_(x x) f_(y y) - f_(x y)^(2) > 0$ and $f_(x x) > 0$ (or $f_(y y) > 0$), then the critical point is a local minimum.
- If $f_(x x) f_(y y) - f_(x y)^(2) > 0$ and $f_(x x) < 0$ (or $f_(y y) < 0$), then the critical point is a local maximum.
- If $f_(x x) f_(y y) - f_(x y)^(2) < 0$, then the critical point is a saddle point.
- If $f_(x x) f_(y y) - f_(x y)^(2) = 0$, the test is inconclusive.

#tip[
  Note that our naive classification is a special case of the discriminant test.
  - For local extrema, we have $f_(x x) f_(y y) - f_(x y)^(2) > 0$ which can only happen when $f_(x x)$ and $f_(y y)$ have the same sign.
  - When $f_(x x)$ and $f_(y y)$ have different signs, we are guaranteed to have $f_(x x) f_(y y) - f_(x y)^(2) < 0$, so it is a saddle point.
]

#exercise[
  + Determine whether the critical point $(0, 0)$ of $f (x, y) = x^(2) - x y + 1/2 y^(2) + 3$ found in the previous exercise is a local maximum, a local minimum, or a saddle point.
  + Find the critical points of $g (x, y) = 3 y^(2) - 2 y^(3) - 3 x^(2) + 6 x y$.
  + Determine whether the critical points of $g(x, y)$ are local maxima, local minima, or saddle points.
]
#solution[
  + We have found the second derivatives of $f$ in the previous exercise, which are
    $
      f_(x x) = 2, quad f_(y y) = 1, quad f_(x y) = - 1 .
    $
    Thus, we have
    $
      f_(x x) f_(y y) - f_(x y)^(2) = 2 dot 1 - (- 1)^(2) = 1 > 0,
    $
    and since $f_(x x) > 0$, the critical point $(0, 0)$ is a local minimum.
  + We need to solve
    $
      f_(x) = - 6 x + 6 y = 0 quad #text[and] quad f_(y) = 6 y - 6 y^(2) + 6 x = 0 .
    $
    From the first equation, we find $x = y$, and substitution for $y$ into the second equation gives us
    $
      - 6 x^(2) + 12 x = 0 quad #text[or] quad - 6 x (x - 2) = 0 .
    $
    The solutions are $x = 0$ and $x = 2$, so the critical points are $(0, 0)$ and $(2, 2)$.
  + We calculate the second derivatives
    $
      f_(x x) = - 6, quad f_(y y) = 6 - 12 y, quad f_(x y) = 6 .
    $
    The discriminant is
    $
      f_(x x) f_(y y) - f_(x y)^(2) = - 36 + 72 y - 36 = 72 (y - 1).
    $
    - At the critical point $(0, 0)$, the discriminant is $-72$ which is negative, so it is a saddle point.
    - At the critical point $(2, 2)$, the discriminant is $72$ which is positive, and since $f_(x x) < 0$, it is a local maximum.
]
