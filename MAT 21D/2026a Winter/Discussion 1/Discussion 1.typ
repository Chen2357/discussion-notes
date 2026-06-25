#import "@preview/showybox:2.0.4": showybox
#import "@preview/cetz:0.4.2"
#import "@preview/physica:0.9.8"
#import "@preview/numty:0.1.0" as nt

#let canvas(..args) = {
  let body = cetz.canvas(..args)
  [#body#metadata(body)<something>]
}

#let make-title(title: "", author: "", date: datetime.today().display("[month repr:long] [day], [year]")) = {
  place(top + center, float: true)[
    #set align(center)

    #text(18pt, weight: "bold")[#title]

    #author

    #date
  ]
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

#make-title(
  title: "MAT 21D Discussion 1 Notes",
  author: "Chen Liang",
  date: "January 8, 2026",
)

= Introduction

MAT 21D was my favorite course of the 21 series when I was a undergraduate here at Davis because I was mind-blown by Stokes' Theorem which is in chapter 16 of the textbook (which we will cover).
#theorem[
  (Stokes' Theorem, page 1030)
  $
    integral.cont.ccw_C bf(F) dot.c dd(bf(r)) = integral.double_S (nabla times bf(F)) dot.c bf(n) dd(sigma)
  $
  where $C$ is the boundary curve of the surface $S$.
]

Or rather, because I was doing Directed Reading Program (DRP) at the time, I was amazed by the generalized Stokes' Theorem.
#theorem[
  (Generalized Stokes' Theorem)
  $
    integral_("boundary of" R) f = integral_(R) ("derivative of" f).
  $
]
Just by looking at the equation, if you can smell the fundamental theorem of calculus in it, then that probably means that you have a solid understanding of the fundamental theorem of calculus!
Such brilliant insight is only available if you have a good grasp of the prerequisite materials.

The major theorems in chapter 16 are not much different from the fundamental theorem of calculus in the sense that they are all special cases of the generalized Stokes' Theorem.
If I did not build a solid foundation of MAT 21D, this is not something I would have been able to appreciate, and beautiful theorems like the generalized Stokes' Theorem might have never entered my world.

Now as a mathematics graduate student, I spend days and nights studying whatever that is considered fundamental in my specialization, and I think that is worthwhile because they lead to those joyful moments of epiphany.
*What about you?
Has mathematics ever led to breakthrough moments for you and your understanding of your subject of interest?*

#align(center)[
  #link("https://www.youtube.com/watch?v=1lGM5DEdMaw")[#image("Aleph 0 video thumbnail.png", width: 40%)]
  This YouTube video by Aleph 0 was one of the friends I made along the way trying to understand the generalized Stokes' Theorem. (Tap thumbnail to open YouTube.)
]


= Iterated Integrals

To calculate an iterated integral like
$
  integral_c^d (integral_a^b f(x, y) dd(x)) dd(y),
$
we first evaluate the inner integral for an arbitrary $y$ in $[c, d]$ and write
$
  g(y) = integral_a^b f(x, y) dd(x) = ("some expression in" y).
$
Then, we substitute $g(y)$ into the iterated integral to get
$
  integral_c^d (integral_a^b f(x, y) dd(x)) dd(y) = integral_c^d g(y) dd(y) = ("some number").
$
If $a$, $b$, $c$, and $d$ are concrete given numbers, then the final answer should be a concrete number as well.
Otherwise, if say $a$ is arbitrary, then the final answer might be a number that depends $a$.
However, the final answer should never depend on $x$ or $y$ because they are just dummy variables of integration.

#exercise[
  1. Evaluate the iterated integral
    $
      integral_0^2 (integral_0^3 x y dd(x)) dd(y).
    $
  2. The bounds of the inner integral can depend on the variable of integration of the outer integral too.
    Evaluate the iterated integral
    $
      integral_0^2 (integral_0^y x y dd(x)) dd(y).
    $
]
#solution[
  1. We have
    $
      integral_0^3 x y dd(x) = [x^2/2 y]_(x = 0)^(x = 3) = 9/2 y.
    $
    Note that in this calculation, we are treating $y$ as a constant!
    It's almost exactly like
    $
      integral_0^3 x pi dd(x) = [x^2/2 pi]_(x = 0)^(x = 3) = 9/2 pi,
    $
    but we just use $y$ instead of $pi$.
    The important difference is that $integral_0^3 x y dd(x) = 9/2 y$ is saying that it is true for any $y$ not just $pi$ or $e$ or $sqrt(2)$.
    Also note that I am not writing $[x^2/2 y]_(0)^(3)$ because it would be ambiguous whether it is $x$ or $y$ that is supposed to take on the value $0$ and $3$.
    If you made the mistake of substituting $0$ and $3$ into $y$, you would get $integral_0^3 x y dd(x) = 3/2 x^2$ which should alert you because the inner integral $integral_0^3 x y dd(x)$ is expected to be an expression in $y$ and not $x$.

    Thus,
    $
      integral_0^2 (integral_0^3 x y dd(x)) dd(y) = integral_0^2 9/2 y dd(y) = [9/4 y^2]_(y = 0)^(y = 2) = 9.
    $
  2. We have
    $
      integral_0^y x y dd(x) = [x^2/2 y]_(x = 0)^(x = y) = 1/2 y^3.
    $
    Thus,
    $
      integral_0^2 (integral_0^y x y dd(x)) dd(y) = integral_0^2 1/2 y^3 dd(y) = [1/8 y^4]_(y = 0)^(y = 2) = 2.
    $
    #h(100%)
]

#remark[
  I am writing the solution in sentences and treating equations as part of the sentences.
  The textbook also does this.
  I recommend you to practice writing solutions in this way because no matter what fields you are in, if it involves writing mathematics, you need to able to integrate equations into your sentences.
]

= Double Integrals

Double integrals are a distinct concept from iterated integrals.
Formally, they are defined as the limit of a sum (see textbook page 899-900) representing the volume under a surface, and that is how you calculate them numerically on a computer.

However, 21 series focuses on the theoretical aspect of calculus, and we use theorems to calculate double integrals.
In particular, the Fubini's Theorem allows us to compute double integrals using iterated integrals.
Then, we can use theorems like fundamental theorem of calculus or integration by parts to compute the iterated integrals.
It is theorems all the way down!

Assume all functions are continuous in the following theorem.

#theorem[
  (Fubini's Theorem, page 901)
  1. If region $R$ is given by $a <= x <= b$, $g_1(x) <= y <= g_2(x)$,
  #align(
    center,
    canvas({
        import cetz.draw: *
        let a = 1
        let b = 4
        let g_1(x) = 1 - 0.5 * nt.sin(1.5 * (x - 1))
        let g_2(x) = 2 + nt.sin(2 * (x - 1) / 3)

        let n = 100
        let curve-1 = nt.linspace(a, b, n).map(x => (x, g_1(x)))
        let curve-2 = nt.linspace(a, b, n).map(x => (x, g_2(x)))

        line((a, g_1(a)), (a, g_2(a)), stroke: (dash: "dashed"))

        line(..curve-1)
        content((2.3, g_1(2.3)), anchor: "north-west")[#text(size: 8pt)[$y = g_1(x)$]]

        line(..curve-2)
        content((2, g_2(2)), anchor: "south-east")[#text(size: 8pt)[$y = g_2(x)$]]

        line((b, g_1(b)), (b, g_2(b)), stroke: (dash: "dashed"))

        line(..curve-1, ..curve-2.rev(), stroke: none, fill: red.lighten(75%), name: "R")
        content("R.centroid", anchor: "center")[$R$]

        line((-0.6, 0), (b + 0.8, 0), mark: (end: "straight"))
        content((), anchor: "west")[$x$]
        line((0, -0.6), (0, g_2(b) + 0.5), mark: (end: "straight"))
        content((), anchor: "south")[$y$]

        line((a, g_1(a)), (a, -0.2), stroke: (dash: "dashed"))
        content((a, -0.2), anchor: "north")[$a$]

        line((b, g_1(b)), (b, -0.2), stroke: (dash: "dashed"))
        content((b, -0.2), anchor: "north")[$b$]
    })
  )
  then
  $
    integral.double_R f(x, y) dd(A) = integral_a^b (integral_(g_1(x))^(g_2(x)) f(x, y) dd(y)) dd(x).
  $

  2. If region $R$ is given by $c <= y <= d$, $h_1(y) <= x <= h_2(y)$,
  #align(
    center,
    canvas({
        import cetz.draw: *
        let c = 1
        let d = 4
        let h_1(y) = 1 - 0.5 * nt.cos(1.5 * (y - 1))
        let h_2(y) = 2  + nt.sin(2 * (y - 1) / 3)
        let n = 100
        let curve-1 = nt.linspace(c, d, n).map(y => (h_1(y), y))
        let curve-2 = nt.linspace(c, d, n).map(y => (h_2(y), y))

        line((h_1(c), c), (h_2(c), c), stroke: (dash: "dashed"))

        line(..curve-1)
        content((h_1(3), 3), anchor: "east", padding: (right: 0.1))[#text(size: 8pt)[$x = h_1(y)$]]

        line(..curve-2)
        content((h_2(2), 2), anchor: "west", padding: (left: 0.1, top: 0.4))[#text(size: 8pt)[$x = h_2(y)$]]

        line((h_1(d), d), (h_2(d), d), stroke: (dash: "dashed"))

        line(..curve-1, ..curve-2.rev(), stroke: none, fill: red.lighten(75%), name: "R")
        content("R.centroid", anchor: "center")[$R$]

        line((-0.6, 0), (h_2(d) + 0.8, 0), mark: (end: "straight"))
        content((), anchor: "west")[$x$]
        line((0, -0.6), (0, d + 0.5), mark: (end: "straight"))
        content((), anchor: "south")[$y$]

        line((h_1(c), c), (-0.2, c), stroke: (dash: "dashed"))
        content((-0.2, c), anchor: "east")[$c$]

        line((h_1(d), d), (-0.2, d), stroke: (dash: "dashed"))
        content((-0.2, d), anchor: "east")[$d$]
    })
  )
  then
  $
    integral.double_R f(x, y) dd(A) = integral_c^d (integral_(h_1(y))^(h_2(y)) f(x, y) dd(x)) dd(y).
  $
]

One of the most important usage of Fubini's Theorem is when the region $R$ can be described in both ways given in the theorem.
In that case, the two iterated integrals and the double integral are all equal.
We can choose to evaluate either of the *three*.

I am not saying that we always compute double integrals using either of the *two* iterated integrals.
We will have situations where both iterated integrals are hard and there are other theorems that allow us to compute double integrals (such as converting to polar coordinates or applying Green's Theorem).
Just because we are learning Fubini's Theorem first does not mean that it is _the definition of_ or _the way to calculate_ double integrals.

#exercise[
  Consider the region $R$ bounded by $y = x^2$, $x = 0$, and $y = 1$ in the first quadrant.
  + Draw the region $R$.
  + Describe the region $R$ by $a <= x <= b$, $g_1(x) <= y <= g_2(x)$ for some numbers $a$ and $b$ and functions $g_1(x)$ and $g_2(x)$.
  + Describe the region $R$ by $c <= y <= d$, $h_1(y) <= x <= h_2(y)$ for some numbers $c$ and $d$ and functions $h_1(y)$ and $h_2(y)$.
  + What are the other two integrals that the iterated integral
    $
      integral_0^1 (integral_(x^2)^(1) x e^(y^2) dd(y)) dd(x)
    $
    is equal to?
    With what we have learned, which one is easier to evaluate? Evaluate it.
]
#solution[
  1. #align(
      center,
      canvas(length: 3cm, {
        import cetz.draw: *
        let n = 100
        let curve-1 = nt.linspace(0, 1, n).map(x => (x, x * x))

        line(..curve-1)
        content((0.7, 0.49), anchor: "north-west")[#text(size: 8pt)[$y = x^2$]]

        line((1, 1), (1, -0.05), stroke: (dash: "dashed"))
        content((), anchor: "north")[$1$]
        line((1, 1), (-0.05, 1), stroke: (dash: "dashed"))
        content((), anchor: "east")[$1$]

        line(..curve-1, (1, 1), (0, 1), stroke: none, fill: red.lighten(75%), name: "R")
        content("R.centroid", anchor: "center")[$R$]

        line((-0.2, 0), (1.2, 0), mark: (end: "straight"))
        content((), anchor: "west")[$x$]
        line((0, -0.2), (0, 1.2), mark: (end: "straight"))
        content((), anchor: "south")[$y$]
      })
    )
    Note that the parabola can also be labeled $x = sqrt(y)$.

  2. We can describe $R$ as $0 <= x <= 1$ and $x^2 <= y <= 1$.

    Here is how we get the bounds.
    The inequality $a <= x <= b$ represents the vertical strip (blue strip in the drawing below) that the region $R$ is in.
    #align(
      center,
      canvas(length: 3cm, {
        import cetz.draw: *
        let n = 100
        let curve-1 = nt.linspace(0, 1, n).map(x => (x, x * x))

        line(..curve-1, (1, 1), (0, 1), stroke: none, fill: red.lighten(75%), name: "R")
        content("R.centroid", anchor: "center")[$R$]

        line((-0.2, 0), (1.2, 0), mark: (end: "straight"))
        content((), anchor: "west")[$x$]
        line((0, -0.2), (0, 1.2), mark: (end: "straight"))
        content((), anchor: "south")[$y$]

        line((0, -0.2), (1, -0.2), (1, 1.2), (0, 1.2), stroke: none, fill: blue.lighten(50%).transparentize(50%))
        line((1, -0.2), (1, 1.2), stroke: (dash: "dashed"))
        content((1, 0.5), anchor: "west", padding: 4pt)[$x = 1$]
      })
    )
    From the drawing, we can read off that $0 <= x <= 1$.
    Now, to get functions $g_1(x)$ and $g_2(x)$ that bound $y$, we need to look at the curve that bounds $R$ from below and above respectively and express them as functions of $x$.
    #align(
      center,
      grid(
        columns: (auto, auto),
        canvas(length: 3cm, {
          import cetz.draw: *
          let n = 100
          let curve-1 = nt.linspace(0, 1, n).map(x => (x, x * x))

          line(..curve-1, (1, 1), (0, 1), stroke: none, fill: red.lighten(75%), name: "R")
          content("R.centroid", anchor: "center")[$R$]

          line((-0.2, 0), (1.2, 0), mark: (end: "straight"))
          content((), anchor: "west")[$x$]
          line((0, -0.2), (0, 1.2), mark: (end: "straight"))
          content((), anchor: "south")[$y$]

          line(..curve-1, stroke: purple.lighten(40%))
          content((0.7, 0.46), anchor: "north-west")[#text(size: 8pt, purple.lighten(40%))[$g_1 (x) = x^2$ bounds $R$ from below]]
        }),
        canvas(length: 3cm, {
          import cetz.draw: *
          let n = 100
          let curve-1 = nt.linspace(0, 1, n).map(x => (x, x * x))

          line(..curve-1, (1, 1), (0, 1), stroke: none, fill: red.lighten(75%), name: "R")
          content("R.centroid", anchor: "center")[$R$]

          line((-0.2, 0), (1.2, 0), mark: (end: "straight"))
          content((), anchor: "west")[$x$]
          line((0, -0.2), (0, 1.2), mark: (end: "straight"))
          content((), anchor: "south")[$y$]

          line((0, 1), (1, 1), stroke: purple.lighten(40%))
          content((0.8, 1.05), anchor: "south")[#text(size: 8pt, purple.lighten(40%))[$g_2 (x) = 1$ bounds $R$ from above]]
        })
      )
    )
    From the drawing, we can read off that $x^2 <= y <= 1$.

  3. We can describe $R$ as $0 <= y <= 1$ and $0 <= x <= sqrt(y)$.

    Here is how we get the bounds.
    The inequality $a <= y <= b$ represents the horizontal strip (blue strip in the drawing below) that the region $R$ is in.
    #align(
      center,
      canvas(length: 3cm, {
        import cetz.draw: *
        let n = 100
        let curve-1 = nt.linspace(0, 1, n).map(x => (x, x * x))

        line(..curve-1, (1, 1), (0, 1), stroke: none, fill: red.lighten(75%), name: "R")
        content("R.centroid", anchor: "center")[$R$]

        line((-0.2, 0), (1.2, 0), mark: (end: "straight"))
        content((), anchor: "west")[$x$]
        line((0, -0.2), (0, 1.2), mark: (end: "straight"))
        content((), anchor: "south")[$y$]

        line((-0.2, 0), (1.2, 0), (1.2, 1), (-0.2, 1), stroke: none, fill: blue.lighten(50%).transparentize(50%))
        line((1.2, 1), (-0.2, 1), stroke: (dash: "dashed"))
        content((0.5, 1.1))[$y = 1$]
      })
    )
    From the drawing, we can read off that $0 <= y <= 1$.
    Now, to get functions $h_1(y)$ and $h_2(y)$ that bound $x$, we need to look at the curve that bounds $R$ from the left and right respectively and express them as functions of $y$.
    #align(
      center,
      grid(
        columns: (auto, auto),
        gutter: 10pt,
        canvas(length: 3cm, {
          import cetz.draw: *
          let n = 100
          let curve-1 = nt.linspace(0, 1, n).map(x => (x, x * x))

          line(..curve-1, (1, 1), (0, 1), stroke: none, fill: red.lighten(75%), name: "R")
          content("R.centroid", anchor: "center")[$R$]

          line((-0.2, 0), (1.2, 0), mark: (end: "straight"))
          content((), anchor: "west")[$x$]
          line((0, -0.2), (0, 1.2), mark: (end: "straight"))
          content((), anchor: "south")[$y$]

          line((0, 0), (0, 1), stroke: purple.lighten(40%))
          content((-0.05, 0.5), anchor: "east")[#text(size: 8pt, purple.lighten(40%))[$h_1 (y) = 0$ bounds $R$ from the left]]
        }),
        canvas(length: 3cm, {
          import cetz.draw: *
          let n = 100
          let curve-1 = nt.linspace(0, 1, n).map(x => (x, x * x))

          line(..curve-1, (1, 1), (0, 1), stroke: none, fill: red.lighten(75%), name: "R")
          content("R.centroid", anchor: "center")[$R$]

          line((-0.2, 0), (1.2, 0), mark: (end: "straight"))
          content((), anchor: "west")[$x$]
          line((0, -0.2), (0, 1.2), mark: (end: "straight"))
          content((), anchor: "south")[$y$]

          line(..curve-1, stroke: purple.lighten(40%))
          content((0.7, 0.46), anchor: "north-west")[#text(size: 8pt, purple.lighten(40%))[$h_2 (y) = sqrt(y)$ bounds $R$ from the right]]
        })
      )
    )
    From the drawing, we can read off that $0 <= x <= sqrt(y)$, but figuring out $h_2(y) = sqrt(y)$ requires realizing that we can express the curve $y = x^2$ (in the first quadrant) as $x = sqrt(y)$.
    Or you can tilt your head to the right and see that the $0$ function is bounding $R$ from "below" and the $sqrt(y)$ function is bounding $R$ from "above".
  4. Fubini's theorem tells us
    $
      integral_0^1 (integral_(x^2)^(1) x e^(y^2) dd(y)) dd(x) = integral.double_R x e^(y^2) dd(A) = integral_0^1 (integral_0^(sqrt(y)) x e^(y^2) dd(x)) dd(y).
    $
    We can evaluate the last integral:
    $
      integral_0^1 (integral_0^(sqrt(y)) x e^(y^2) dd(x)) dd(y) = integral_0^1 [1/2 x^2 e^(y^2)]_(x = 0)^(x = sqrt(y)) dd(y) = integral_0^1 1/2 y e^(y^2) dd(y) = [1/4 e^(y^2)]_(y = 0)^(y = 1) = (e - 1)/4.
    $
]

#remark[
  Fubini's Theorem is not simple change of integrals.
  Notice that the bounds of the outer integral are always constant.
  An expression like
  $
    integral_(x^2)^(1) (integral_0^1 x e^(y^2) dd(x)) dd(y)
  $
  would not even make sense.
  In the general Fubini's Theorem, we can see that the bounds are in general completely different: the bounds go from $a, b, g_1(x), g_2(x)$ to $c, d, h_1(y), h_2(y)$.
]