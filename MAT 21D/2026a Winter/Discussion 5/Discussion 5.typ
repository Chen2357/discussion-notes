#import "@preview/showybox:2.0.4": showybox
#import "@preview/cetz:0.4.2"
#import "@preview/physica:0.9.8" as physica: pdv
#import "@preview/numty:0.1.0" as nt

#let canvas(..args) = {
  let body = cetz.canvas(..args)
  [#body#metadata(body)<something>]
}

#set par(justify: true)

#let indigo = rgb(109, 107, 135)
#let red = rgb(199, 56, 52)
#let blue = rgb(15, 101, 160)
#let dark-magenta = rgb(104, 81, 120)

#let exercise(body) = showybox(
  frame: (
    border-color: indigo,
    body-color: white.darken(10%),
    thickness: (left: 2pt),
    radius: 0pt,
  ),
  breakable: true,
  body,
)

#let theorem(body) = showybox(
  frame: (
    border-color: red,
    body-color: white.darken(10%),
    thickness: (left: 2pt),
    radius: 0pt,
  ),
  breakable: true,
  body,
)

#let solution(body, label: "Solution") = {
  text(red, style: "italic")[#label.]
  body
}

#let remark(body, label: "Remark") = showybox(
  frame: (
    border-color: yellow,
    body-color: white.darken(10%),
    thickness: (left: 2pt),
    radius: 0pt,
  ),
  breakable: true,
  body,
)

#set heading(numbering: "§I")
#show heading: set block(below: 1em)

#let bf(it) = math.bold(math.upright(it))
#let dd(..args) = physica.dd(..args, d: $d$)

#let author = "Chen Liang"
#let date = datetime(year: 2026, month: 2, day: 5)

#set document(
  title: [MAT 21D Discussion 5 Notes],
  author: author,
  date: date,
)

#show title: it => text(18pt, weight: "bold", it)

#place(top + center, float: true, {
  set align(center)
  title()
  author
  linebreak()
  date.display("[month repr:long] [day], [year]")
})

// = Warm-up

= Substitutions in double integrals

#theorem[
  Suppose that $G$ in the $u v$-plane is related (in a one-to-one fashion) to the region $R$ in the $x y$-plane by equations of the form
  $
    x = g(u, v), quad y = h(u, v).
  $
  Then
  $
    integral.double_R f(x, y) dd(x, y) = integral.double_G F(u, v) abs(pdv((x, y), (u, v))) dd(u, v),
  $
  provided that $F(u, v) = f(x, y)$ under the substitution $x = g(u, v)$ and $y = h(u, v)$.

  #figure(
    image("Figure 15.57.png", width: 40%),
    caption: [figure 15.57 in the textbook.]
  )
]
A quick way to remember the formula is to note that
$ dd(x, y) = abs(pdv((x, y), (u, v))) dd(u, v). $
Here, $abs(pdv((x, y), (u, v)))$ is absolute value of the Jacobian determinant defined by
$
  pdv((x, y), (u, v)) = mat(
    delim: "|",
    pdv(x, u), pdv(x, v);
    pdv(y, u), pdv(y, v),
  )
  =
  pdv(x, u) pdv(y, v) - pdv(x, v) pdv(y, u),
$
and we should expect that this a function of $u$ and $v$ only.

Also note that we are setting $x$ and $y$ as functions of $u$ and $v$.
This is the opposite direction compared to $u$-substitution in single variable calculus, where we set $u$ as a function of $x$.
We see a variation of this theorem that is more related to $u$-substitution later in the notes.

The trickiest part is to identify the region $G$ in the $u v$-plane, so let us first do an example.
#exercise[
  #text(dark-magenta)[(Example)]
  Rewrite the integral
  $
    integral_0^1 integral_(x)^(x+1) x y dd(y, x)
  $
  using the substitution
  $
    x = u, quad y = u + v.
  $
]
#solution[
  We first describe the region $R$ of integration in the $x y$-plane.
  Reading the bounds of the integral, we see that $R$ is given by
  $
    0 <= x <= 1, quad x <= y <= x + 1.
  $
  Using the substitution, we have
  $
    0 <= u <= 1, quad u <= u + v <= u + 1,
  $
  which is equivalent to
  $
    0 <= u <= 1, quad 0 <= v <= 1.
  $
  Thus, this region $G$ in the $u v$-plane is a unit square.
  Next, we need to compute the Jacobian determinant.
  We have
  $
    pdv((x, y), (u, v)) = mat(
      delim: "|",
      pdv(x, u), pdv(x, v);
      pdv(y, u), pdv(y, v),
    )
    =
    mat(
      delim: "|",
      1, 0;
      1, 1,
    )
    =
    1.
  $
  Thus, we have $dd(y, x) = dd(v, u)$, and the integral becomes
  $
    integral_0^1 integral_0^1 u (u + v) dd(v, u).
  $
]

Note that at no point was drawing or imagining the region $R$ necessary.
Being less dependent on visualization is important here because the region $R$ can be very complicated and can get more complicated in the triple integral case.

// #exercise[
//   #text(dark-magenta)[(Exercise 15.8.9)]
//   Let $R$ be the region in the first quadrant of $x y$-plane bounded by
//   $
//     x y = 1, quad x y = 9, quad y = x, quad y = 4 x.
//   $
//   Use the substitution $x = u\/v$ and $y = u v$ to rewrite
//   $
//     integral.double_R (sqrt(y/x) + sqrt(x y)) dd(x, y)
//   $
//   as an integral over an appropriate region $G$ in the $u v$-plane.
//   Then evaluate the $u v$-integral over $G$.

//   _Hint: express $R$ in terms of inequalities and then apply the substitution to obtain inequalities that describe $G$._
// ]

#exercise[
  Let $R$ be a tilted square in the $x y$-plane with vertices $(1, 0)$, $(0, 1)$, $(-1, 0)$, and $(0, -1)$.
  1. Region $R$ is bounded by 4 lines. Reexpress $R$ using inequalities based on the equations of these lines.
  2. Consider the transformation
    $
      x = (u + v)/2, quad y = (u - v)/2.
    $
    Find the region $G$ in the $u v$-plane that would be transformed into $R$ by this transformation.
  3. Evaluate the double integral
    $
      integral.double_R (x + y)^2 e^(x - y) dd(x, y).
    $
]
#solution[
  1. The lines that bound $R$ are given by $y = 1 - x$, $y = -1 - x$, $y = x - 1$ and $y = x + 1$.
    #figure(
      canvas(length: 2cm, {
        import cetz.draw: *

        line((-1.5, 0), (1.5, 0), mark: (end: "straight"))
        content((), anchor: "west")[$x$]
        line((0, -1.5), (0, 1.5), mark: (end: "straight"))
        content((), anchor: "south")[$y$]

        line((1, 0), (0, 1))
        content((0.6, 0.6), anchor: "south-west")[$y = 1 - x$]
        line((-1, 0), (0, -1))
        content((-0.6, -0.6), anchor: "north-east")[$y = -1 - x$]
        line((1, 0), (0, -1))
        content((0.6, -0.6), anchor: "north-west")[$y = x - 1$]
        line((-1, 0), (0, 1))
        content((-0.6, 0.6), anchor: "south-east")[$y = x + 1$]

        line((1, 0), (0, 1), (-1, 0), (0, -1), close: true, stroke: none, fill: blue.transparentize(50%))
      })
    )
    In terms of inequalities, we can express $R$ as
    $
      y <= 1 - x, quad y >= -1 - x, quad y >= x - 1, quad y <= x + 1.
    $
  2. We can make the substitution $x = (u + v)/2$ and $y = (u - v)/2$ to rewrite the inequalities as
    $
      (u - v)/2 <= 1 - (u + v)/2, quad (u - v)/2 >= -1 - (u + v)/2, quad (u - v)/2 >= (u + v)/2 - 1, quad (u - v)/2 <= (u + v)/2 + 1,
    $
    which simplify to
    $
      u <= 1, quad u >= -1, quad v >= -1, quad v <= 1.
    $
    Thus, the region $G$ in the $u v$-plane is the square defined by $-1 <= u <= 1$ and $-1 <= v <= 1$.

    #remark[
      A quicker way to arrive at $G$ is to note that the inequalities that define $R$ can be written as
      $
        -1 <= x + y <= 1, quad -1 <= x - y <= 1.
      $
      Since under the substitution, we have $x + y = u$ and $x - y = v$, and so the inequalities that define $G$ are
      $
        -1 <= u <= 1, quad -1 <= v <= 1.
      $
    ]
  3. The Jacobian determinant is given by
    $
      pdv((x, y), (u, v)) = mat(
        delim: "|",
        pdv(x, u), pdv(x, v);
        pdv(y, u), pdv(y, v),
      )
      =
      mat(
        delim: "|",
        1/2, 1/2;
        1/2, -1/2,
      )
      =
      -1/2.
    $
    Thus, we have $dd(x, y) = 1/2 dd(u, v)$.
    Under the substitution, we have
    $
      x + y = u, quad x - y = v,
    $
    and so the original integrand is
    $
      (x + y)^2 e^(x - y) = u^2 e^v.
    $
    Finally, we can rewrite and compute the integral as
    $
      integral.double_R (x + y)^2 e^(x - y) dd(x, y) &= integral.double_G u^2 e^v 1/2 dd(u, v) \
      &= 1/2 integral_(-1)^(1) integral_(-1)^(1) u^2 e^v dd(u, v) \
      &= 1/2 integral_(-1)^(1) 2/3 e^v dd(v) \
      &= 1/3 (e - 1/e).
    $
]
This exercise may seem like a very deliberate example, but you would be surprised how often these kind of integrals that can be easily solved by substitution come up in practice!
In physical context, it often indicates that the new variables $u$ and $v$, which make an integral is nice, have physical meanings and worth understanding.

Sometimes, the substitution is given in terms of $u$ and $v$ as functions of $x$ and $y$.
We may consider trying to invert the transformation to express $x$ and $y$ in terms of $u$ and $v$, but sometimes it makes the Jacobian calculation more complicated.
Instead, we may want to consider applying the theorem the other way around.

#theorem[
  Suppose that $R$ in the $x y$-plane is related (in a one-to-one fashion) to the region $G$ in the $u v$-plane by equations of the form
  $
    u = U(x, y), quad v = V(x, y).
  $
  Then we have
  $
    integral.double_R f(x, y) abs(pdv((u, v), (x, y))) dd(x, y) = integral.double_G F(u, v) dd(u, v),
  $
  provided that $F(u, v) = f(x, y)$ under the substitution $u = U(x, y)$ and $v = V(x, y)$.
]

In this method, we hope that we can find a factor of $abs(pdv((u, v), (x, y)))$ in the integrand.
It is exactly like how when evaluating
$
  integral_0^1 x e^(x^2) dd(x),
$
we apply the substitution $u = x^2$ and hope that we can find $dd(u) = 2 x dd(x)$ in the integrand (which we do in this case if you multiply by $2/2$).
This second theorem is more similar to $u$-substitution in the single variable case.
I tend to not associate the first theorem with $u$-substitution.

// #pagebreak()
#exercise[
  Let $R$ be the region in the first quadrant of $x y$-plane bounded by the curves
  $ x y = 1, quad x y = 4, quad y = x, quad y = 2 x. $
  Evaluate the double integral
  $
    integral.double_R y/x dd(x, y)
  $
  using the substitution $u = x y$ and $v = y/x$.
]
#solution[
  The region $R$ is given by
  $
    1 <= x y <= 4, quad x <= y <= 2 x,
  $
  which we can rewrite as
  $
    1 <= x y <= 4, quad 1 <= y/x <= 2.
  $
  Thus, the region $G$ in the $u v$-plane is given by
  $
    1 <= u <= 4, quad 1 <= v <= 2.
  $
  Next, we compute the Jacobian determinant.
  We have
  $
    pdv((u, v), (x, y)) = mat(
      delim: "|",
      pdv(u, x), pdv(u, y);
      pdv(v, x), pdv(v, y),
    )
    =
    mat(
      delim: "|",
      y, x;
      -y/x^2, 1/x,
    )
    =
    y/x + y/x = 2 y/x.
  $
  Thus, we have
  $
    dd(u, v) = 2 y/x dd(x, y), quad "and so" quad 1/2 dd(u, v) = y/x dd(x, y).
  $
  Therefore, the integral is equal to
  $
    integral.double_R y/x dd(x, y) = integral.double_G 1/2 dd(u, v) = 3/2.
  $
  I just used the facts that $integral.double_G 1/2 dd(u, v)$ is half the area of $G$ and that the area of $G$ is $(4-1)(2-1) = 3$ here.
  Direct computation of the integral will give the same answer.
]

= Substitutions in triple integrals

#theorem[
  Suppose that $G$ in the $u v w$-space is related (in a one-to-one fashion) to the region $R$ in the $x y z$-space by equations of the form
  $
    x = g(u, v, w), quad y = h(u, v, w), quad z = k(u, v, w).
  $
  Then
  $
    integral.triple_R f(x, y, z) dd(x, y, z) = integral.triple_G F(u, v, w) abs(pdv((x, y, z), (u, v, w))) dd(u, v, w),
  $
  provided that $F(u, v, w) = f(x, y, z)$ under the substitution $x = g(u, v, w)$, $y = h(u, v, w)$ and $z = k(u, v, w)$.
]

The idea is exactly the same as in the double integral case.
Similarly, there is also a version of the theorem going the other way.

#theorem[
  Suppose that $R$ in the $x y z$-space is related (in a one-to-one fashion) to the region $G$ in the $u v w$-space by equations of the form
  $ u = U(x, y, z), quad v = V(x, y, z), quad w = W(x, y, z). $
  Then we have
  $
    integral.triple_R f(x, y, z) abs(pdv((u, v, w), (x, y, z))) dd(x, y, z) = integral.triple_G F(u, v, w) dd(u, v, w),
  $
  provided that $F(u, v, w) = f(x, y, z)$ under the substitution $u = U(x, y, z)$, $v = V(x, y, z)$ and $w = W(x, y, z)$.
]

#exercise[
  Evaluate the integral
  $
    integral_0^1 integral_(x)^(x + 1) integral_(y)^(y+1) ((z - x)^2 - (x - y)^2) dd(z, y, x)
  $
  using the transformation
  $
    x = u, quad y = u + v, quad z = u + v + w.
  $
]
#solution[
  The region $R$ of integration in the $x y z$-space is given by
  $
    0 <= x <= 1, quad x <= y <= x + 1, quad y <= z <= y + 1.
  $
  Under the transformation, we have
  $
    0 <= u <= 1, quad u <= u + v <= u + 1, quad u + v <= u + v + w <= u + v + 1,
  $
  which is equivalent to
  $
    0 <= u <= 1, quad 0 <= v <= 1, quad 0 <= w <= 1.
  $
  The Jacobian determinant is given by
  $
    pdv((x, y, z), (u, v, w)) = mat(
      delim: "|",
      pdv(x, u), pdv(x, v), pdv(x, w);
      pdv(y, u), pdv(y, v), pdv(y, w);
      pdv(z, u), pdv(z, v), pdv(z, w),
    )
    =
    mat(
      delim: "|",
      1, 0, 0;
      1, 1, 0;
      1, 1, 1,
    )
    = 1.
  $
  Under the transformation, we have
  $
    (z - x)^2 - (x - y)^2 = (v + w)^2 - (v)^2 = w^2 + 2 v w.
  $
  Thus, the integral becomes
  $
    integral_0^1 integral_0^1 integral_0^1 (w^2 + 2 v w) dd(u, v, w) &= integral_0^1 integral_0^1 (w^2 + 2 v w) dd(v, w) \
    &= integral_0^1 (w^2 + w) dd(w) = 1/3 + 1/2 = 5/6.
  $
]