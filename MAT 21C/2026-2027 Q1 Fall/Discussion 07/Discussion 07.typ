#import "../Packages/canvas-html.typ": *
#import "@preview/physica:0.9.8"

#set math.accent(dotless: false)
#let dd = physica.dd.with(d: $d$)
#let dv = physica.dv.with(d: $d$)

#set document(
  title: "Discussion 7 Notes",
  author: "Chen Liang",
  date: datetime(year: 2026, month: 11, day: 10),
)

#show: canvas-html.with(
  course-id: "1103419",
  image-ids: (
    "Path hint.svg" : "32544874",
    "Tangent curves.svg" : "32544875",
    "Trail elevation.svg" : "32544876",
    "Trail options unified.svg" : "32544877",
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

#exercise(label: [Warm-up])[
  Consider the following plan for a hiking trail on a topographic map.
  #figure(
    image(
      "Trail elevation.svg",
      width: 50%,
      alt: "A trail plan with three marked points labeled 8am, 12pm, and 6pm."
    ),
    caption: "The trail plan."
  )
  Which of the following graphs best represents the elevation of the trail as a function of time?
  #figure(
    image(
      "Trail options unified.svg",
      width: 95%,
      alt: "Three graphs labeled options A, B, and C. Each graph has time on the x-axis and elevation on the y-axis."
    ),
    caption: [Candidates for the elevation function.],
  )
]
#solution[
  The correct option is Option (B).
  We can observe the following features of the trail plan:
  - The trail starts at an elevation between $60$ and $80$, and we are climbing up.
  - At 12pm, we are at an elevation of around $160$, and we are still climbing up.
  - After 12pm, we reach a maximum elevation of around $200$ and we start to descent.
  - We descent to an elevation just above $140$, and we start to climb up again until we reach the end of the trail at an elevation of just above $160$.
  The only option that satisfies all of these features is Option (B).

  Option (A) shows a descent at 12pm, and Option (C) shows a descent at the end of the trail, so they are both incorrect.
]

= Composing Curves and Functions

The warm-up exercise above is an example of composing a curve (_i.e._ a vector valued function) $arrow(r)(t)$ with a function $f(x, y)$ to produce a single-variable function $g(t) = f(arrow(r)(t))$.

Here is a more concrete example.
Consider the curve $arrow(r)(t) = (t, t^2)$ and the function $f(x, y) = x + y$.
Then the composition $f(arrow(r)(t))$ is obtained by looking at $x + y$ and substituting the components of $arrow(r)(t)$ via $x = t$ and $y = t^2$, so the end result is
$
  f(arrow(r)(t)) = f(t, t^2) = t + t^2.
$

#exercise[
  Consider the function $f(x, y) = x y$ and two curves $arrow(r)_1 (t) = (cos t, sin t)$ and $arrow(r)_2 (t) = (1 + t^2, t)$.
  #figure(
    image(
      "Tangent curves.svg",
      width: 50%,
      alt: "Two curves in the xy-plane. The first curve is a circle of radius 1 centered at the origin. The second curve is a parabola that opens to the right. They are tangent to each other at the point (1, 0)."
    ),
    caption: [The two curves $arrow(r)_1 (t)$ and $arrow(r)_2 (t)$.],
  )
  + Write the composition $w_1 = f(arrow(r)_1 (t))$ and $w_2 = f(arrow(r)_2 (t))$ as functions of $t$.
  + Compute and verify that the curves $arrow(r)_1 (t)$ and $arrow(r)_2 (t)$ have the same position and velocity vector at $t = 0$, that is
    $
      arrow(r)_1 (0) = arrow(r)_2 (0) quad "and" quad
      arrow(r)'_1 (0) = arrow(r)'_2 (0).
    $
    Compute the derivatives
    $
      dv(w_1, t) quad "and" quad dv(w_2, t)
    $
    and verify that the derivatives are equal at $t = 0$.
  + If there is a third curve with the same position and velocity vector at $t = 0$, is it always true that the derivatives of the compositions is the same at $t = 0$?
]
#solution[
  + We have
    $
      w_1 = cos (t) sin (t) quad "and" quad w_2 = (1 + t^2) t = t + t^3.
    $
  + We have
    $
      arrow(r)_1 (0) = (cos 0, sin 0) = (1, 0) quad "and" quad arrow(r)_2 (0) = (1 + 0^2, 0) = (1, 0),
    $
    and
    $
      arrow(r)'_1 (t) = chevron(-sin t\, cos t) & ==> arrow(r)'_1 (0) = chevron(0\, 1), \
      arrow(r)'_2 (t) = chevron(2 t\, 1) & ==> arrow(r)'_2 (0) = chevron(0\, 1).
    $
    Therefore, the the curves $arrow(r)_1 (t)$ and $arrow(r)_2 (t)$ have the same position and velocity vector at $t = 0$.
    We compute
    $
      dv(w_1, t) = cos^2 t - sin^2 t & ==> [dv(w_1, t)]_(t = 0) = 1, \
      dv(w_2, t) = 1 + 3 t^2 & ==> [dv(w_2, t)]_(t = 0) = 1.
    $
    The derivatives of $w_1$ and $w_2$ are equal at $t = 0$.
  + Yes, it is always true!
    If we have a third curve $arrow(r)_3 (t) = (x(t), y(t))$ such that $(x(0), y(0)) = (1, 0)$ and $chevron(x' (0)\, y' (0)) = chevron(0\, 1)$, then we can write
    $
      w_3 = f(arrow(r)_3 (t)) = x(t) y(t)
    $
    and compute
    $
      dv(w_3, t) = x' (t) y(t) + x(t) y' (t) \
      ==> [dv(w_3, t)]_(t = 0) = x' (0) y(0) + x(0) y' = 0 dot 0 + 1 dot 1 = 1.
    $
    This is also a straight forward consequence of the multivariable chain rule, which we will discuss in the next discussion.
]

= Two-Variable Limits

The formal definition of
$
  lim_((x, y) -> (x_(0), y_(0))) f (x, y) = L
$
is not important to us.
If $f (x, y)$ is continuous and well-defined at $(x_(0), y_(0))$, then we can simply substitute $(x_(0), y_(0))$ into $f (x, y)$ to get
$
  lim_((x, y) -> (x_(0), y_(0))) f (x, y) = f (x_(0), y_(0)).
$
If $f (x, y)$ is not well-defined at $(x_(0), y_(0))$, then we have three strategies at our disposal.
+ Rewrite $f (x, y)$ into a function that agrees with $f (x, y)$ near $(x_(0), y_(0))$ and is well-defined at $(x_(0), y_(0))$.
  For example, if we look at
  $
    lim_((x, y) -> (1, 1)) (x^2 - y^2)/(x - y),
  $
  we see that we cannot substitute $(0, 0)$ in, but we can factor the numerator to get
  $
    lim_((x, y) -> (1, 1)) ((x - y)(x + y)) / (x - y) = lim_((x, y) -> (1, 1)) (x + y) = 2.
  $
+ Another strategy is to use the sandwich theorem.
  If we look at
  $
    lim_((x, y) -> (0, 0)) x sin(1/y),
  $
  then we can use the fact that $-1 <= sin(1/y) <= 1$ to get
  $
    -x <= x sin(1/y) <= x.
  $
  The limits of both the left and right hand sides as $(x, y) -> (0, 0)$ are $0$, so by the sandwich theorem, we have
  $
    lim_((x, y) -> (0, 0)) x sin(1/y) = 0.
  $
+ The third strategy is to expand a function into its Taylor series.
  I will leave this for you to discover in the following exercise.

#tip[
  L'Hôpital's rule is not one of the three strategies!
  We can only use L'Hôpital's rule for single-variable limits.
]

#exercise[
  The following limits correspond to the three strategies: rewriting, sandwich, Taylor.
  Evaluate them.
  #set enum(spacing: 1em)
  + $display(lim_((x, y) -> (4, 3)) (sqrt(x) - sqrt(y + 1))/(x - y - 1))$
  + $display(lim_((x, y) -> (0, 0)) (x y^2)/(x^2 + y^2))$
  + $display(lim_((x, y) -> (0, 0)) sin(x y)/(x y))$
]
#solution[
  + We can rewrite
    $
      (sqrt(x) - sqrt(y + 1))/(x - y - 1) = (sqrt(x) - sqrt(y + 1))/((sqrt(x) - sqrt(y + 1))(sqrt(x) + sqrt(y + 1))) = 1/(sqrt(x) + sqrt(y + 1)),
    $
    and so
    $
      lim_((x, y) -> (4, 3)) (sqrt(x) - sqrt(y + 1))/(x - y - 1) = lim_((x, y) -> (4, 3)) 1/(sqrt(x) + sqrt(y + 1)) = 1/4.
    $
  + We have
    $
      abs((x y^2)/(x^2 + y^2)) = abs(x) (y^2/(x^2 + y^2)) <= abs(x)
    $
    and so
    $
      -abs(x) <= (x y^2)/(x^2 + y^2) <= abs(x).
    $
    The limits of both the left and right hand sides as $(x, y) -> (0, 0)$ are $0$, so we have
    $
      lim_((x, y) -> (0, 0)) (x y^2)/(x^2 + y^2) = 0.
    $
  + We can use the Taylor series expansion of $sin(x y)$ to get
    $
      sin(x y) = x y - frac((x y)^3, 3!) + frac((x y)^5, 5!) - dots.c
    $
    and so
    $
      lim_((x, y) -> (0, 0)) sin(x y)/(x y) = lim_((x, y) -> (0, 0)) (1 - frac((x y)^2, 3!) + frac((x y)^4, 5!) - dots.c) = 1.
    $
]

To show that a two-variable limit does not exist, we need to find two different curves to $(x_(0), y_(0))$ along which $f (x, y)$ approaches different limits.
The most general curve is a vector valued function $arrow(r)(t)$ such that $arrow(r) (t_0) = (x_0, y_0)$ for some $t_0$, and then we will look at the limit of $f (arrow(r)(t))$ as $t -> t_0$.

In practice however, we just look at curves that are graphs of functions $y = g (x)$ that pass through $(x_(0), y_(0))$.
If $g(x_0) = y_0$, then we can evaluate the limit of $f(x, y)$ along the curve by
$
  lim_(limits(y = g (x))^((x, y) -> (x_(0), y_(0)))) f (x, y) = lim_(x -> x_(0)) f (x, g(x)).
$
If we can find two paths $y = g_1 (x)$ and $y = g_2 (x)$ with $y_0 = g_1 (x_0) = g_2 (x_0)$ such that
$
  lim_(limits(y = g_1 (x))^((x, y) -> (x_(0), y_(0)))) f (x, y) != lim_(limits(y = g_2 (x))^((x, y) -> (x_(0), y_(0)))) f (x, y),
$
then we can conclude that the two-variable limit
$
  lim_((x, y) -> (x_(0), y_(0))) f (x, y) quad "does not exist."
$
#tip[
  We can describe a path using $x = h (y)$ also, we will similarly evaluate the limit along this path by
  $
    lim_(limits(x = h (y))^((x, y) -> (x_(0), y_(0)))) f (x, y) = lim_(y -> y_(0)) f (h(y), y)
  $
  and if this is different from the limit along some other path, then we can also conclude that the two-variable limit does not exist.
]

For example, we can show that the limit
$
  lim_((x, y) -> (0, 0)) y/x
$
does not exist by evaluating the limit along the paths $y = k x$:
$
  lim_(limits(y = k x)^((x, y) -> (0, 0))) y/x = lim_(x -> 0) frac(k x, x) = k .
$
Since the limit depends on the value of $k$, we can conclude that the two-variable limit does not exist.

#tip[
  Usually straight line paths will suffice.
  On the rare occasion where it does not, we can try parabolas $y = k x^2$.
]

#exercise[
  #set enum(spacing: 1em)
  Show that $display(lim_((x, y) -> (1, 1)) (x y^2 - 1)/(y - 1))$ does not exist. _Hint:_ try the following curves through $(1, 1)$.
    #figure(
      image(
        "Path hint.svg",
        width: 30%,
        alt: "Two lines through the point (1, 1). The red line is vertical. The blue line is diagonal with slope 1."
      ),
      caption: [Hint for the exercise.],
    )
]
#solution[
  The two paths in the hint are $x = 1$ (the red line) and $y = x$ (the blue line).
  - Along the path $x = 1$, we have
    $
      lim_(limits(x = 1)^((x, y) -> (1, 1))) (x y^2 - 1)/(y - 1) = lim_(y -> 1) (y^2 - 1)/(y - 1) = lim_(y -> 1) (y + 1) = 2.
    $
  - Along the path $y = x$, we have
    $
      lim_(limits(y = x)^((x, y) -> (1, 1))) (x y^2 - 1)/(y - 1) = lim_(x -> 1) (x^3 - 1)/(x - 1) = lim_(x -> 1) (x^2 + x + 1) = 3.
    $
  Since the two limits are different, we can conclude that
  $
    lim_((x, y) -> (1, 1)) (x y^2 - 1)/(y - 1) quad "does not exist."
  $
]
