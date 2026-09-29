#import "@preview/showybox:2.0.4": showybox
#import "@preview/cetz:0.4.2"
#import "@preview/physica:0.9.8"
#import "@preview/numty:0.1.0" as nt

#let canvas(..args) = {
  let body = cetz.canvas(..args)
  [#body#metadata(body)<something>]
}

#let scale-to-container(body, width: auto, height: auto) = layout(ly => {
  let body-size = measure(body)

  scale(
    x: if width == auto { auto } else { ly.width / body-size.width * width },
    y: if height == auto { auto } else { ly.height / body-size.height * height },
    reflow: true,
    body,
  )
})

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

#let remark(body, label: "Remark") = {
  show: it => block(inset: (left: 0.2in, right: 0.2in), it)
  set text(red)
  [#label:]
  body
}

#set heading(numbering: "§I")
#show heading: set block(below: 1em)

#let bf(it) = math.bold(math.upright(it))
#let dd(..args) = physica.dd(..args, d: $d$)


// #title("MAT 21D Discussion 2 Notes")

#let make-title(t: "", author: "", date: datetime.today()) = {
  set document(
    title: t,
    author: author,
    date: date,
  )
  show title: it => text(18pt, weight: "bold", it)
  place(top + center, float: true)[
    #set align(center)
    #title()

    #author

    #date.display("[month repr:long] [day], [year]")
  ]
}

#make-title(
  t: "MAT 21D Discussion 2 Notes",
  author: "Chen Liang",
  date: datetime(year: 2026, month: 1, day: 15)
)

= Warm-Up

#exercise[
  Discuss with your group: is the following equation true or false? Why or why not?
  $
    integral_(-1)^(1) integral_(-1)^(1) (sin(x y^2) + sin(y x^2)) dd(y) dd(x) = 0.
  $
]
#solution[
  The equation is true.
  If we try to compute the inner integral, we would find
  $
    integral_(-1)^(1) sin(y x^2) dd(y) = 0
  $
  because $sin(y x^2)$ is an odd function in $y$.
  However, we would get stuck at computing
  $
    integral_(-1)^(1) sin(x y^2) dd(y).
  $
  We we encounter the same problem even if we apply Fubini's theorem to swap the integral at the beginning.
  The key to this problem is to apply the additivity of double integrals:
  $
    integral.double_R (f + g) dd(A) = integral.double_R f dd(A) + integral.double_R g dd(A).
  $
  If we let $R$ be the square region $-1 <= x <= 1$ and $-1 <= y <= 1$, then the integral in question can be rewritten as
  $
    integral.double_R (sin(x y^2) + sin(y x^2)) dd(A) = integral.double_R sin(x y^2) dd(A) + integral.double_R sin(y x^2) dd(A).
  $
  Then, despite the two double integrals having the same $R$, we need to tackle them differently, using Fubini's theorem with different orders of integration.
  For the first double integral, we compute
  $
    integral.double_R sin(x y^2) dd(A) = integral_(-1)^(1) integral_(-1)^(1) sin(x y^2) dd(x) dd(y) = integral_(-1)^(1) 0 dd(y) = 0,
  $
  and for the second double integral, we compute
  $
    integral.double_R sin(y x^2) dd(A) = integral_(-1)^(1) integral_(-1)^(1) sin(y x^2) dd(y) dd(x) = integral_(-1)^(1) 0 dd(x) = 0.
  $
]

= Average value

The average score times the number of students equals the total score.
The average height of a building times the area of the base equals the volume of the buildings.
In other words,
$
  "average score" = (1)/("number of students") sum_(s) "score of student" s,
$
and
$
  "average height" = (1)/("area of the base") integral.double_R h(x, y) dd(A).
$
Recall that $integral.double_R h(x, y) dd(A)$ represents the volume under the surface $z = h(x, y)$ over the region $R$.

Recall that the average value of an (integrable) function $f$ over a region $R$ is defined as
#align(center)[
  Average value of $f$ over $R$ = $1/("area of" R) integral.double_R f dd(A)$.
]
The quantify "area of $R$" can be calculated geometrically (either it is a shape that we recognize or can be decomposed into shapes we recognize) or by using the double integral
$
  "area of" R = integral.double_R 1 dd(A).
$

#exercise[
  Let $R$ denote the region of points $(x, y)$ in the plane satisfying $abs(y) + 1 <= x$ and $x <= 3$.
  + Sketch the region $R$.
  + Calculate the average value of the function $f(x, y) = x$ over the region $R$. (You can leave your answer as an algebraic expression of fractions.)
]
#solution[
  + To draw an inequality involving absolute values, we need to do caseworks: drawing one region where the value inside the absolute value is positive (or zero) and drawing one region where it is negative.
    So, for $abs(y) + 1 <= x$, we consider two cases:
    - Case 1: in the region $y >= 0$, we need to draw $y + 1 <= x$.
    - Case 2: in the region $y <= 0$, we need to draw $-y + 1 <= x$.
    Combining the two cases gives us the $abs(y) + 1 <= x$ region.
    #figure(
      grid(
        columns: (auto, auto, auto),
        column-gutter: 6mm,
        row-gutter: 2mm,
        canvas(length: 0.8cm, {
          import cetz.draw: *

          line((-1, 0), (4, 0), mark: (end: "straight"))
          content((), anchor: "west")[$x$]
          line((0, -3), (0, 3), mark: (end: "straight"))
          content((), anchor: "south")[$y$]

          line((1, 0), (4, 3))
          line((1, 0), (4, 3), (4, 0), stroke: none, fill: red.transparentize(50%))
        }),
        canvas(length: 0.8cm, {
          import cetz.draw: *

          line((-1, 0), (4, 0), mark: (end: "straight"))
          content((), anchor: "west")[$x$]
          line((0, -3), (0, 3), mark: (end: "straight"))
          content((), anchor: "south")[$y$]

          line((1, 0), (4, -3))
          line((1, 0), (4, -3), (4, 0), stroke: none, fill: red.transparentize(50%))
        }),
        canvas(length: 0.8cm, {
          import cetz.draw: *

          line((-1, 0), (4, 0), mark: (end: "straight"))
          content((), anchor: "west")[$x$]
          line((0, -3), (0, 3), mark: (end: "straight"))
          content((), anchor: "south")[$y$]

          line((1, 0), (4, 3))
          line((1, 0), (4, -3))
          line((1, 0), (4, 3), (4, -3), stroke: none, fill: red.transparentize(50%))
        }),
        [(a) $y + 1 <= x$ in the region $y >= 0$],
        [(b) $-y + 1 <= x$ in the region $y <= 0$],
        [(c) The region $abs(y) + 1 <= x$],
      )
    )
    Overlapping with $x <= 3$ gives us the final region $R$ shown below.
    #figure(
      canvas(length: 1.5cm, {
        import cetz.draw: *

        line((-1, 0), (4, 0), mark: (end: "straight"))
        content((), anchor: "west")[$x$]
        line((0, -3), (0, 3), mark: (end: "straight"))
        content((), anchor: "south")[$y$]

        line((1, 0), (3, 2))
        line((1, 0), (3, -2))
        line((3, 2), (3, -2))
        line((1, 0), (3, 2), (3, -2), stroke: none, fill: red.transparentize(50%))
        content((1.8, 1), anchor: "east", $y + 1 = x$)
        content((1.8, -1), anchor: "east", $-y + 1 = x$)
        content((3.1, 0.5), anchor: "south-west", $x = 3$)
        circle((3, 2), radius: 1pt, fill: black)
        content((3, 2), anchor: "south-west", padding: (left: 2pt, bottom: 2pt), $(3, 2)$)
        circle((3, -2), radius: 1pt, fill: black)
        content((3, -2), anchor: "north-west", padding: (left: 2pt, top: 2pt), $(3, -2)$)
        circle((1, 0), radius: 1pt, fill: black)
        content((1, 0), anchor: "south-east", padding: (right: 2pt, bottom: 2pt), $(1, 0)$)
      })
    )

  + The region $R$ is a triangle whose area we can calculate geometrically to be $4$.
    Thus, the average value of $f$ over $R$ is
    $
      1/4 integral.double_R x dd(A) = 1/4 integral_(1)^(3) integral_(-x + 1)^(x - 1) x dd(y) dd(x).
    $
    The inner integral is
    $
      integral_(-x + 1)^(x - 1) x dd(y) = x ((x - 1) - (-x + 1)) = 2x (x - 1) = 2x^2 - 2x.
    $
    Thus,
    $
      1/4 integral.double_R x dd(A) &= 1/4 integral_(1)^(3) (2x^2 - 2x) dd(x) \
      &= 1/4 [2/3 x^3 - x^2]_(x = 1)^(x = 3) \
      &= 1/4 (2/3 dot.c 27 - 9 - (2/3 - 1)) \
      &= 7/3.
    $
]

= Double integrals in polar form

Last week, we learned how to compute double integrals
$
  integral.double_R f(x, y) dd(A)
$
by converting to either $dd(x) dd(y)$ or $dd(y) dd(x)$ iterated integrals using Fubini's theorem.
Today, we will learn another theorem that allows us to compute double integrals.
// TODO picture and why r d theta

#theorem[
  If a region $R$ is given by $alpha <= theta <= beta$ and $g_1(theta) <= r <= g_2(theta)$,
  #figure(
    canvas(length: 1.5cm,{
        import cetz.draw: *
        let alpha = calc.pi / 8
        let beta = 3 * calc.pi / 4
        let g1(x) = 1 + 0.2 * nt.sin(2.5 * x)
        let g2(x) = 1.5 - 0.2 * nt.cos(1.2 * x)

        line((-2, 0), (2, 0), mark: (end: "straight"))
        content((), anchor: "west")[$x$]
        line((0, -0.5), (0, 2.5), mark: (end: "straight"))
        content((), anchor: "south")[$y$]

        let curve1 = nt.linspace(alpha, beta, 100).map(x => (g1(x) * nt.cos(x), g1(x) * nt.sin(x)))
        let curve2 = nt.linspace(beta, alpha, 100).map(x => (g2(x) * nt.cos(x), g2(x) * nt.sin(x)))
        line(..curve1)
        content((0.5, 0.7), text(size: 6pt)[$g_1(theta)$])
        line(..curve2)
        content((0.5, 1.7), text(size: 6pt)[$g_2(theta)$])

        merge-path(fill: red.transparentize(50%), stroke: none, {
          line(..curve1)
          line(..curve2)
        })

        line((0, 0), (2 * nt.cos(alpha), 2 * nt.sin(alpha)), stroke: (dash: "dashed", thickness: 0.5pt))
        content((), anchor: "west", padding: (left: 2pt))[#text(size: 6pt)[$theta = #math.alpha$]]
        line((0, 0), (2 * nt.cos(beta), 2 * nt.sin(beta)), stroke: (dash: "dashed", thickness: 0.5pt))
        content((), anchor: "east", padding: (right: 2pt))[#text(size: 6pt)[$theta = #math.beta$]]
    })
  )
  then
  $
    integral.double_R f(r, theta) dd(A) = integral_(alpha)^(beta) integral_(g_1(theta))^(g_2(theta)) f(r, theta) space.thin r dd(r) dd(theta).
  $
]

Pay close attention to the extra factor $r$.
The factor comes from the fact a tiny area element $Delta A$ is approximately a rectangle with side lengths $Delta r$ and $r Delta theta$.
#figure(
  canvas(length: 2cm, {
    import cetz.draw: *

    let delta-r = 0.5
    let delta-theta = calc.pi / 6
    let theta = calc.pi / 8
    let r = 1.0

    circle((0, 0), radius: 1pt, fill: black)
    content((), anchor: "east", padding: (right: 5pt), $O$)

    merge-path(close: true, fill: red.transparentize(50%), {
      arc((r * nt.cos(theta), r * nt.sin(theta)), radius: r, start: theta / calc.pi * 180deg, delta: delta-theta / calc.pi * 180deg)
      arc(((r + delta-r) * nt.cos(theta + delta-theta), (r + delta-r) * nt.sin(theta + delta-theta)), radius: r + delta-r, start: (theta + delta-theta) / calc.pi * 180deg, delta: -delta-theta / calc.pi * 180deg)
    })

    content(((r + delta-r / 2) * nt.cos(theta + delta-theta / 2), (r + delta-r / 2) * nt.sin(theta + delta-theta / 2)), anchor: "center", $Delta A$)
    content(((r + delta-r) * nt.cos(theta + delta-theta / 2), (r + delta-r) * nt.sin(theta + delta-theta / 2)), anchor: "south-west", padding: (left: 2pt), $r Delta #math.theta$)
    content(((r + delta-r / 2) * nt.cos(theta), (r + delta-r / 2) * nt.sin(theta)), anchor: "north-west", padding: (top: 2pt), $Delta r$)

    line((0, 0), (r * nt.cos(theta), r * nt.sin(theta)), stroke: (dash: "dashed", thickness: 0.5pt))
    line((0, 0), ((r + delta-r) * nt.cos(theta + delta-theta), (r + delta-r) * nt.sin(theta + delta-theta)), stroke: (dash: "dashed", thickness: 0.5pt))
  })
)
If you are an scientist or engineer, you may also think in units.
The area element $dd(A)$ has unit length squared.
The angular element $dd(theta)$ is unitless, so you need to compensate it by multiplying a length $r$, so that $dd(r)$ times $r dd(theta)$ has unit length squared.

#exercise[
  The figure below shows two curves: the circle $r = 1$ and the cardioid $r = 1 + cos(theta)$.
  Consider the shaded region $R$ in the figure.
  #figure(
    canvas(length: 1.5cm, {
        import cetz.draw: *
        let r(theta) = 1 + nt.cos(theta)

        line((-2, 0), (2, 0), mark: (end: "straight"))
        content((), anchor: "west")[$x$]
        line((0, -2), (0, 2), mark: (end: "straight"))
        content((), anchor: "south")[$y$]

        let curve = nt.linspace(0, 2 * calc.pi, 200).map(x => (r(x) * nt.cos(x), r(x) * nt.sin(x)))
        line(..curve)
        circle((0, 0), radius: 1)
        // circle((0, 1), radius: 1)
        // arc((0, 0), radius: 2, start: 0deg, stop: 90deg)
        //
        let half-curve = nt.linspace(-calc.pi / 2, calc.pi / 2, 100).map(x => (r(x) * nt.cos(x), r(x) * nt.sin(x)))

        merge-path(fill: red.transparentize(50%), {
          line(..half-curve)
          arc((0, 1), radius: 1, start: 90deg, stop: -90deg)
        })
    })
  )
  + Express the shaded region $R$ as $alpha <= theta <= beta$ and $g_1(theta) <= r <= g_2(theta)$ for some constants $alpha$, $beta$ and functions $g_1(theta)$, $g_2(theta)$.
  + Express the area of $R$ as an iterated integral in polar coordinates.
  + Calculate the area of $R$.
]
#solution[
  + The shaded region $R$ can be expressed as $-pi/2 <= theta <= pi/2$ and $1 <= r <= 1 + cos(theta)$.

  + The area of $R$ can be expressed as
    $
      integral.double_R 1 dd(A) = integral_(-pi/2)^(pi/2) integral_(1)^(1 + cos(theta)) r dd(r) dd(theta).
    $
  + The integral evaluates to
    $
      integral.double_R 1 dd(A) &= integral_(-pi/2)^(pi/2) [1/2 r^2]_(r = 1)^(r = 1 + cos(theta)) dd(theta) \
      &= integral_(-pi/2)^(pi/2) (1/2 (1 + cos(theta))^2 - 1/2) dd(theta) \
      &= integral_(-pi/2)^(pi/2) ((cos^2(theta))/2 + cos(theta)) dd(theta) \
      &= integral_(-pi/2)^(pi/2) ((1 + cos(2 theta))/4 + cos(theta)) dd(theta) \
      &= [1/4 theta + 1/8 sin(2 theta) + sin(theta)]_(-pi/2)^(pi/2) \
      &= (1/4 (pi/2) + 0 + 1) - (1/4 (-pi/2) + 0 - 1) \
      &= pi/4 + 2.
    $
    #h(100%)
]

#remark[
  Note the important identity:
  $
    cos^2(theta) = (1 + cos(2 theta))/2.
  $
  This is extremely helpful when integrating trigonometric functions.
  We also have a similar identity for $sin^2(theta)$:
  $
    sin^2(theta) = (1 - cos(2 theta))/2.
  $
]

#exercise[
  The figure below shows the rose $r = 12 cos(3 theta)$ with the leaf in the right half-plane shaded.
  #figure(
    canvas(length: 0.15cm, {
      import cetz.draw: *

      line((-14, 0), (14, 0), mark: (end: "straight"))
      content((), anchor: "west")[$x$]
      line((0, -14), (0, 14), mark: (end: "straight"))
      content((), anchor: "south")[$y$]

      let r(theta) = 12 * nt.cos(3 * theta)
      let curve = nt.linspace(0, calc.pi, 100).map(x => (r(x) * nt.cos(x), r(x) * nt.sin(x)))

      line(..curve)

      let partial-curve = nt.linspace(-calc.pi / 6, calc.pi / 6, 100).map(x => (r(x) * nt.cos(x), r(x) * nt.sin(x)))
      line(..partial-curve, fill: red.transparentize(50%))

    })
  )
  + Express the shaded region $R$ as $alpha <= theta <= beta$ and $g_1(theta) <= r <= g_2(theta)$ for some constants $alpha$, $beta$ and functions $g_1(theta)$, $g_2(theta)$.

    _Hint: the ray enters and exists the shaded region exactly when it is tangent to the rose._
  + Express the area of $R$ as an iterated integral in polar coordinates.
  + Find the area of $R$.
]
#solution[
  + The shaded region $R$ can be expressed as $-pi/6 <= theta <= pi/6$ and $0 <= r <= 12 cos(3 theta)$.
    We found $-pi/6$ and $pi/6$ because it is exactly at these angles that the ray is tangent to the rose (i.e., $r = 0$).

  + The area of $R$ can be expressed as
    $
      integral.double_R 1 dd(A) = integral_(-pi/6)^(pi/6) integral_(0)^(12 cos(3 theta)) r dd(r) dd(theta).
    $
  + The integral evaluates to
    $
      integral.double_R 1 dd(A) &= integral_(-pi/6)^(pi/6) [1/2 r^2]_(r = 0)^(r = 12 cos(3 theta)) dd(theta) \
      &= integral_(-pi/6)^(pi/6) 72 cos^2(3 theta) dd(theta) \
      &= integral_(-pi/6)^(pi/6) 72 (1 + cos(6 theta))/2 dd(theta) \
      &= 36 [theta + 1/6 sin(6 theta)]_(-pi/6)^(pi/6) \
      &= 36 ( (pi/6 + 0) - (-pi/6 + 0) ) \
      &= 12 pi.
    $
]