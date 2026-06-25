#import "../Discussion.typ": *
// #import "@preview/xarrow:0.4.0": xarrow

#show: discussion.with(
  number: 8,
  date: datetime(year: 2026, month: 2, day: 26),
)

= Warm-Up

// Decompose vector field into conservative and non-conservative parts.

#exercise[
  Let $bf(F)(x, y) = (e^x cos y) bf(i) + (x - e^x sin y) bf(j)$, discuss with your group an efficient way to calculate the line integral
  $
    integral_C bf(F) dot.c dd(bf(r))
  $
  where $C$ is the line segment from $(0, 0)$ to $(1, 1)$.
]
#solution[
  The vector field $bf(F)$ is not a conservative vector field, but it can be written as a sum of a conservative vector field and a simple non-conservative vector field.
  If we do the long division from Discussion 7, we have
  #figure(
    table(
      columns: 3,
      stroke: none,
      [], $e^x cos y$, [],
      table.hline(start: 1),
      $nabla$, table.vline(start: 1, end: 2), $(e^x cos y) bf(i)$, $+(x - e^x sin y) bf(j)$,
      [], $(e^x cos y) bf(i)$, $+(-e^x cos y) bf(j)$,
      table.hline(start: 1),
      [], $0$, $x bf(j)$,
    )
  )
  then we see that the reminder is not independent of $x$, so the vector field is not conservative, but it can be written as
  $
    bf(F) = nabla (e^x cos y) + x bf(j).
  $
  Plugging this into the line integral, we have
  $
    integral_C bf(F) dot.c dd(bf(r)) = integral_C nabla (e^x cos y) dot.c dd(bf(r)) + integral_C x bf(j) dot.c dd(bf(r)).
  $
  The first integral can be calculated using the fundamental theorem of line integrals and the second integral can be calculated using direct parameterization of $C$, say $bf(r)(t) = (t, t)$ for $0 <= t <= 1$.
  Then, we have
  $
    integral_C nabla (e^x cos y) dot.c dd(bf(r)) = e^1 cos 1 - e^0 cos 0 = e cos 1 - 1, \
    integral_C x bf(j) dot.c dd(bf(r)) = integral_0^1 t bf(j) dot dv(bf(r), t) dd(t) = integral_0^1 t bf(j) dot (bf(i) + bf(j)) dd(t) = 1/2.
  $
  Thus, the final answer is
  $
    integral_C bf(F) dot.c dd(bf(r)) = e cos 1 - 1/2.
  $
]

= Green's Theorem

#theorem[
  #text(dark-magenta)[(Green's Theorem)]
  If $bf(F) = F_x bf(i) + F_y bf(j)$ and $R$ is a region whose boundary $C$ is a simple (no self-intersection) closed curve oriented counterclockwise, then
  $
    integral_C bf(F) dot.c dd(bf(r)) = integral.double_R (pdv(F_y, x) - pdv(F_x, y)) dd(A).
  $
]

Let me tell how does Green's theorem fit into the bigger picture.
Green's theorem completes our analysis of integrations in the plane.
We have the chain of operations.
#figure(
  canvas({
    import cetz.draw: *

    let x = 5.5
    let y = 1.8

    let padded-content = content.with(padding: 0.1cm)

    padded-content((0, 0), name: "t00")[Scalar functions $f$]
    padded-content((x, 0), name: "t10")[Vector fields $bf(F)$]
    padded-content((2 * x, 0), name: "t20")[Scalar functions $g$]

    let arrow = line.with(mark: (end: "straight"))

    arrow("t00.east", "t10.west", name: "a00")
    content("a00.mid", anchor: "south", padding: 0.2cm)[$nabla$]
    arrow("t10.east", "t20.west", name: "a10")
    content("a10.mid", anchor: "south", padding: 0.2cm)[$display(pdv(F_y, x) - pdv(F_x, y))$]

    padded-content((0, -y), name: "t01")[$display(f(B) - f(A))$]
    padded-content((x, -y), name: "t11")[$display(integral_C bf(F) dot.c dd(bf(r)))$]
    padded-content((2 * x, -y), name: "t21")[$display(integral.double_R g(x, y) dd(A))$]

    line("t01.east", "t11.west", name: "a01", mark: (start: "straight", end: "straight"))
    content("a01.mid", anchor: "south", padding: 0.2cm)[FT of line integrals]
    line("t11.east", "t21.west", name: "a11", mark: (start: "straight", end: "straight"))
    content("a11.mid", anchor: "south", padding: 0.2cm)[Green's theorem]

    padded-content((0, -2 * y), name: "t02")[Points $A$, $B$]
    padded-content((x, -2 * y), name: "t12")[Curves $C$]
    padded-content((2 * x, -2 * y), name: "t22")[Regions $R$]

    arrow("t12.west", "t02.east", name: "a02")
    content("a02.mid", anchor: "south", padding: 0.2cm)[End points]
    arrow("t22.west", "t12.east", name: "a12")
    content("a12.mid", anchor: "south", padding: 0.2cm)[Boundary]
  }),
)
We make several observations:
+ If $bf(F)$ is the gradient of some function, then $pdv(F_y, x) - pdv(F_x, y) = 0$ by direct calculation (see Discussion 7 on component test).
+ If $C$ is the boundary of a region, and $C$ is a loop and has no end points.
  Compare this observation with the previous observation.
+ If $A$ and $B$ are end points of $C$ and $bf(F) = nabla f$, then the fundamental theorem of line integrals says that
  $
    f(B) - f(A) = integral_C bf(F) dot.c dd(bf(r)).
  $
  So the "pairing" of $f$ and $A$ and $B$ is the same as the "pairing" of $bf(F)$ and $C$.
+ If $C$ is the boundary of a region $R$ and $g(x, y) = pdv(F_y, x) - pdv(F_x, y)$, then Green's theorem says that
  $
    integral_C bf(F) dot.c dd(bf(r)) = integral.double_R g(x, y) dd(A).
  $
  So the "pairing" of $bf(F)$ and $C$ is the same as the "pairing" of $g$ and $R$.

The rest of the quarter will be about completing the analysis for three-dimensional space and making the same observations.
Which is to say that we are completing the diagram.
#figure(
  canvas({
    import cetz.draw: *

    let x = 4
    let y = 1.8

    let padded-content = content.with(padding: 0.1cm)

    padded-content((0, 0), name: "t00")[Scalar functions $f$]
    padded-content((x, 0), name: "t10")[Vector fields $bf(F)$]
    padded-content((2 * x, 0), name: "t20")[Vector fields $bf(G)$]
    padded-content((3 * x, 0), name: "t30")[Scalar functions $g$]

    let arrow = line.with(mark: (end: "straight"))

    arrow("t00.east", "t10.west", name: "a00")
    content("a00.mid", anchor: "south", padding: 0.2cm)[$nabla$]
    arrow("t10.east", "t20.west", name: "a10")
    content("a10.mid", anchor: "south", padding: 0.2cm)[$nabla #h(0em) times$]
    arrow("t20.east", "t30.west", name: "a20")
    content("a20.mid", anchor: "south", padding: 0.2cm)[$nabla #h(0em)dot$]

    padded-content((0, -y), name: "t01")[$display(f(B) - f(A))$]
    padded-content((x, -y), name: "t11")[$display(integral_C bf(F) dot.c dd(bf(r)))$]
    let h = 1
    let w = 2
    group(name: "t21", padding: 0.2cm, {
      rect((2 * x - w/2, -y - h/2), (rel: (w, h)), stroke: red)
    padded-content((2 * x, -y))[??]
    })
    padded-content((3 * x, -y), name: "t31")[$display(integral.triple_D g(x, y, z) dd(V))$]

    line("t01.east", "t11.west", name: "a01", mark: (start: "straight", end: "straight"))
    content("a01.mid", anchor: "south", padding: 0.2cm)[FT]
    line("t11.east", "t21.west", name: "a11", mark: (start: "straight", end: "straight"))
    content("a11.mid", anchor: "south", padding: 0.2cm)[#box(stroke: red, outset: 0.2em)[??]]
    line("t21.east", "t31.west", name: "a21", mark: (start: "straight", end: "straight"))
    content("a21.mid", anchor: "south", padding: 0.2cm)[#box(stroke: red, outset: 0.2em)[??]]

    padded-content((0, -2 * y), name: "t02")[Points $A$, $B$]
    padded-content((x, -2 * y), name: "t12")[Curves $C$]
    padded-content((2 * x, -2 * y), name: "t22")[Surfaces $S$]
    padded-content((3 * x, -2 * y), name: "t32")[Solid regions $D$]

    arrow("t12.west", "t02.east", name: "a02")
    content("a02.mid", anchor: "south", padding: 0.2cm)[End points]
    arrow("t22.west", "t12.east", name: "a12")
    content("a12.mid", anchor: "south", padding: 0.2cm)[Boundary]
    arrow("t32.west", "t22.east", name: "a22")
    content("a22.mid", anchor: "south", padding: 0.2cm)[Boundary]
  }),
)
Problem 1 on this this week's homework asks you to show that composing any two consecutive operations in the top row gives you zero.
You should compare this fact to the fact that composing any two consecutive operations in the bottom row gives you something empty.

Green's theorem is really easy to use---you apply it and you are done.
So, the exercise today will be part review of change of variables in multiple integrals.
I want to first do an example on how do you transform a curve under a change of variables.
#exercise[
  #text(dark-magenta)[(Example)]
  Consider the change of variables (assume $u > 0$ and $v > 0$)
  $
    x = u/v quad "and" quad y = u v.
  $
  Let $C$ be the line segment from $(2, 2)$ to $(4, 4)$.
  Find its corresponding curve $C'$ in the $u v$-plane.
]
#solution[
  We first begin by writing $C$ using equation:
  $
    C : y = x quad "from" quad (2, 2) quad "to" quad (4, 4).
  $
  Then, we need to do two things:
  1. Reexpress the equation of $y = x$ in terms of $u$ and $v$.
  2. Find the end points of $C'$ in the $u v$-plane.
  The first is direct substitution, and we get
  $
    u v = u/v <==> v^2 = 1 <==> v = 1.
  $
  Thus, the equation of $C'$ is $v = 1$.
  Now, let $(u_1, v_1)$ and $(u_2, v_2)$ be the end points of $C'$, then we want them to satisfy
  $
    (u_1/v_1, u_1 v_1) = (2, 2) quad "and" quad (u_2/v_2, u_2 v_2) = (4, 4).
  $
  We know $v_1 = v_2 = 1$, so we can solve for $u_1$ and $u_2$
  $
    u_1 = 2 quad "and" quad u_2 = 4.
  $
  Thus, the end points of $C'$ are $(2, 1)$ and $(4, 1)$.

  As an alternative method for finding the end points of $C'$, we can first finding the inverse transformation.
  Note that
  $
    x y = u^2 quad "and" quad y/x = v^2,
  $
  so we have
  $
    u = sqrt(x y) quad "and" quad v = sqrt(y/x).
  $
  Plugging in $(2, 2)$ and $(4, 4)$ into $(x, y)$, we will get the end points of $C'$:
  $
    "from" quad (sqrt(2 dot 2), sqrt(2/2)) = (2, 1) quad "to" quad (sqrt(4 dot 4), sqrt(4/4)) = (4, 1).
  $
  Thus, the curve $C'$ in the $u v$-plane corresponding to $C$ is
  $
    C' : v = 1 quad "from" quad (2, 1) quad "to" quad (4, 1).
  $
  It is a straight line again, but in general, the curve $C'$ can be just a curve.
  Also note that inverse transformation is not always easy to use, especially when the transformation contains trig functions such as for polar to cartesian transformation.
]
// The exercise today will be part review of

// The entire point of this course are these two diagrams.
// Everything we learned about multi-integrals is building up to this moment.

// Before I show
// The exercise question can actually be easily solved

#exercise[
  Let
  $
    bf(F)(x, y) = sin(x^2) bf(i) + (ln(x) + cos(y^2)) bf(j).
  $
  Calculate the line integral
  $
    integral_C bf(F) dot.c dd(bf(r))
  $
  where $C$ is a loop comprised of four curves:
  $
    C_1 &: "the line segment from" (2, 2) "to" (4, 4), \
    C_2 &: "the curve segment from" (4, 4) "to" (2, 8) "along the hyperbola" x y = 16, \
    C_3 &: "the line segment from" (2, 8) "to" (1, 4), \
    C_4 &: "the curve segment from" (1, 4) "to" (2, 2) "along the hyperbola" x y = 4.
  $
  #figure(
    canvas(length: 0.4cm, {
      import cetz.draw: *

      let x-bound = 12
      let y-bound = 12

      let arrow = line.with(mark: (end: "straight"))
      arrow((-0.2, 0), (x-bound, 0))
      content((x-bound, 0), anchor: "west", padding: (left: 0.1cm))[$x$]
      arrow((0, -0.2), (0, y-bound))
      content((0, y-bound), anchor: "south", padding: (bottom: 0.1cm))[$y$]

      let xmin = 4 / y-bound
      let xmin2 = 16 / y-bound
      let curve-1 = nt.linspace(xmin, 1, 10).map(x => (x, 4 / x))
      let curve-2 = nt.linspace(1, 2, 30).map(x => (x, 4 / x))
      let curve-3 = nt.linspace(2, x-bound, 20).map(x => (x, 4 / x))

      let curve-4 = nt.linspace(xmin2, 2, 10).map(x => (x, 16 / x))
      let curve-5 = nt.linspace(4, 2, 30).map(x => (x, 16 / x))
      let curve-6 = nt.linspace(4, x-bound, 20).map(x => (x, 16 / x))
      line(..curve-1)
      line(..curve-3)
      line(..curve-4)
      line(..curve-6)

      line(..curve-5, (1, 4), ..curve-2, stroke: red + 0.06cm, close: true)
      content((3, 16/3), anchor: "south-west", padding: 0.1cm)[#text(red)[$C$]]

      mark((3, 3), (rel: (1, 1)), symbol: "straight", stroke: red)
      // mark((4, 4), (rel: (-1, 1)), symbol: "straight", stroke: red)
      // mark((6, 1.5), (rel: (4, 1)), symbol: "straight", stroke: red)
      // mark((1.5, 6), (rel: (-1, -4)), symbol: "straight", stroke: red)
      // mark((2, 2), (rel: (1, -1)), symbol: "straight", stroke: red)
      // content((4, 4), anchor: "south-west", padding: 0.1cm)[#text(red)[$C$]]
    })
  )

  Hint: after we apply the Green's theorem, we will get a double integral that is best to be evaluated by considering the change of variables in the previous example.
]

#solution[
  We have
  $
    integral_C bf(F) dot.c dd(bf(r)) = integral.double_R (pdv(F_y, x) - pdv(F_x, y)) dd(A).
  $
  where $R$ is the region enclosed by $C$.
  We calculate
  $
    pdv(F_y, x) - pdv(F_x, y) = pdv(,x) (ln(x) + cos(y^2)) - pdv(,y) (sin(x^2)) = 1/x - 0 = 1/x.
  $
  So we need to evaluate
  $
    integral.double_R 1/x dd(x, y).
  $
  Now, using the change of variables, we have
  $
    integral.double_R 1/x dd(x, y) = integral.double_G v/u abs(pdv((x, y), (u, v))) dd(u, v)
  $
  where $G$ is a region in the $u v$-plane corresponding to $R$.
  To find $G$, let us first write down the equations of the curves
  $
    C_1 : y/x = 1 quad "from" quad (2, 2) quad "to" quad (4, 4), \
    C_2 : x y = 16 quad "from" quad (4, 4) quad "to" quad (2, 8), \
    C_3 : y/x = 4 quad "from" quad (2, 8) quad "to" quad (1, 4), \
    C_4 : x y = 4 quad "from" quad (1, 4) quad "to" quad (4, 1).
  $
  We already know from the previous example that the curve $C'_1$ in the $u v$-plane corresponding to $C_1$ is
  $
    C'_1 : v = 1 quad "from" quad (2, 1) quad "to" quad (4, 1).
  $

  Next, we work out $C_2$.
  After the substitution, the equation becomes $u^2 = 16$, so $u = 4$.
  To find the end points, we just plug $(4, 4)$ and $(2, 8)$ into the inverse transformation
  $
    u = sqrt(x y) quad "and" quad v = sqrt(y/x),
  $
  and we get
  $
    "from" quad (sqrt(4 dot 4), sqrt(4/4)) = (4, 1) quad "to" quad (sqrt(2 dot 8), sqrt(8/2)) = (4, 2).
  $
  Thus, the curve $C'_2$ in the $u v$-plane corresponding to $C_2$ is
  $
    C'_2 : u = 4 quad "from" quad (4, 1) quad "to" quad (4, 2).
  $

  Repeating the same process for $C_3$ and $C_4$, we get
  $
    C_3 "in" u v"-plane" &: v = 2 quad "from" quad (4, 2) quad "to" quad (2, 2),  \
    C_4 "in" u v"-plane" &: u = 2 quad "from" quad (2, 2) quad "to" quad (2, 1).
  $
  This is a square in the $u v$-plane with vertices at $(2, 1)$, $(4, 1)$, $(4, 2)$, and $(2, 2)$.
  Therefore,
  $
    integral.double_G v/u abs(pdv((x, y), (u, v))) dd(u, v) = integral_(1)^(2) integral_(2)^(4) v/u abs(pdv((x, y), (u, v))) dd(u, v).
  $
  Now, we calculate the Jacobian determinant
  $
    pdv((x, y), (u, v)) = mat(delim: "|", pdv(x, u), pdv(x, v); pdv(y, u), pdv(y, v)) = mat(delim: "|", 1/v, -u/v^2; v, u) = 2 u/v.
  $
  Therefore, the integral becomes
  $
    integral_(1)^(2) integral_(2)^(4) v/u (2 u/v) dd(u, v) = integral_(1)^(2) integral_(2)^(4) 2 dd(u, v) = 4.
  $
]

= Review for Midterm 2

#set list(spacing: 1.2em)

- Integration in cylindrical and spherical coordinates #text(dark-magenta)[(15.7, Discussion 4)]
  - Set up the integral given a description of a region.
  - Describe the region given an integral.
- Substitution in multiple integrals #text(dark-magenta)[(15.8, Discussion 5)]
  - Calculate the Jacobian determinant.
  - 🤔 Describe how curves (and surfaces) transform under a change of variables.
- Arc length, curvature, and normal vectors #text(dark-magenta)[(13.1-5, Discussion 6)]
  - Calculate the above quantities given a curve (it looks like formula will be provided).
- Line integrals of scalar functions and vector fields #text(dark-magenta)[(16.1-2, Discussion 6)]
  - Calculate line integrals of scalar functions and vector fields.
- Potential functions and conservative vector fields #text(dark-magenta)[(16.3, Discussion 7)]
  - Determine if a vector field is conservative.
  - Find potential functions of conservative vector fields.
  - Separate conservative part of a vector field to cleverly calculate line integrals.

I am most worried about transformation of shapes or region of integration under change of variables.
On midterm 1, the average on the question writing a double integral over a triangle in polar coordinates was pretty bad.
So, let us do more exercises.

// #pagebreak()
#exercise[
  #let item-counter = counter("item-counter")
  #set enum(start: 0)

  #show enum: it => {
    if it.start != 0 { return it }
    let args = it.fields()
    let items = args.remove("children")
    context enum(..args, start: item-counter.get().first() + 1, ..items)
    item-counter.update(i => i + it.children.len())
  }

  + Let $C$ be the line segment from $(0, 1)$ to $(1, 1)$ in the $u v$-plane.
    Find its corresponding curve $C'$ in the $x y$-space under the change of variables
    $
      x = e^u cos v quad "and" quad y = e^u sin v
    $
    Express $C'$ as a parametric curve:
    $
      C' : (x, y) = ("some expression of" t) quad "for" t_1 <= t <= t_2
    $
    The variable $t$ can also be $u$ or $v$ or any other letter if you want.
    Also express $C'$ in the form of
    $
      C' : ("some equation in terms of" x "and" y) quad "from" quad (x_1, y_1) quad "to" quad (x_2, y_2).
    $
    Draw the curve $C'$ in the $x y$-plane.
  + Let $C$ be the line segment from $(2, 0)$ to $(0, 2)$ in the $u v$-plane.
    Find its corresponding curve $C'$ in the $x y$-space under the change of variables
    $
      x = sqrt(u) quad "and" quad y = v + 2 u - 2
    $
    Express $C'$ as a parametric curve:
    $
      C' : (x, y) = ("some expression of" t) quad "for" t_1 <= t <= t_2
    $
    Also express $C'$ in the form of
    $
      C' : ("some equation in terms of" x "and" y) quad "from" quad (x_1, y_1) quad "to" quad (x_2, y_2).
    $
    Draw the curve $C'$ in the $x y$-plane.
]
#solution[
  + We can parametrize $C$ as $(u, v) = (t, 1)$ for $0 <= t <= 1$, then we can find the corresponding curve $C'$ in the $x y$-plane by plugging $u = t$ and $v = 1$ into $x = e^u cos v$ and $y = e^u sin v$, and we get
    $
      C' : (x, y) = (e^t cos 1, e^t sin 1) quad "for" 0 <= t <= 1.
    $
    Notice that as change $t$, $(x, y)$ stay proportional to $(cos 1, sin 1)$, so $C'$ lies on the line $y/x = tan 1$.
    Thus, we can also express $C'$ as
    $
      C' : y/x = tan 1 quad "from" quad (cos 1, sin 1) quad "to" quad (e cos 1, e sin 1).
    $
    #figure(
      canvas({
        import cetz.draw: *

        let x-bound = 3
        let y-bound = 3

        let arrow = line.with(mark: (end: "straight"))
        arrow((-0.2, 0), (x-bound, 0))
        content((x-bound, 0), anchor: "west", padding: (left: 0.1cm))[$x$]
        arrow((0, -0.2), (0, y-bound))
        content((0, y-bound), anchor: "south", padding: (bottom: 0.1cm))[$y$]

        line((calc.cos(1), calc.sin(1)), (calc.e * calc.cos(1), calc.e * calc.sin(1)), stroke: red + 0.06cm)
        mark((2 * calc.cos(1), 2 * calc.sin(1)), (rel: (1, calc.tan(1))), symbol: "straight", stroke: red)
        circle((calc.cos(1), calc.sin(1)), radius: 0.05cm, fill: red, stroke: none)
        content((), anchor: "north-west", padding: 0.1cm)[#text(red)[$(cos 1, sin 1)$]]
        circle((calc.e * calc.cos(1), calc.e * calc.sin(1)), radius: 0.05cm, fill: red, stroke: none)
        content((), anchor: "south-west", padding: 0.1cm)[#text(red)[$(e cos 1, e sin 1)$]]
      })
    )

  + We can parametrize $C$ as $(u, v) = (2 - t, t)$ for $0 <= t <= 2$, then we can find the corresponding curve $C'$ in the $x y$-plane by plugging $u = 2 - t$ and $v = t$ into $x = sqrt(u)$ and $y = v + 2 u - 2$, and we get
    $
      C' : (x, y) = (sqrt(2 - t), t + 2 (2 - t) - 2) quad "for" 0 <= t <= 2.
    $
    This simplifies to
    $
      C' : (x, y) = (sqrt(2 - t), 2 - t) quad "for" 0 <= t <= 2.
    $
    We can also express $C'$ in the form of
    $
      C' : y = x^2 quad "from" quad (sqrt(2), 2) quad "to" quad (0, 0).
    $
    #figure(
      canvas(length: 1.3cm, {
        import cetz.draw: *

        let x-bound = 2
        let y-bound = 2

        let arrow = line.with(mark: (end: "straight"))
        arrow((-0.2, 0), (x-bound, 0))
        content((x-bound, 0), anchor: "west", padding: (left: 0.1cm))[$x$]
        arrow((0, -0.2), (0, y-bound))
        content((0, y-bound), anchor: "south", padding: (bottom: 0.1cm))[$y$]

        let curve = nt.linspace(0, 2, 20).map(t => (calc.sqrt(2 - t), 2 - t))
        line(..curve, stroke: red + 0.06cm)
        mark((1, 1), (rel: (-1, -2)), symbol: "straight", stroke: red)
        circle((calc.sqrt(2), 2), radius: 0.05cm, fill: red, stroke: none)
        content((), anchor: "north-west", padding: 0.1cm)[#text(red)[$(sqrt(2), 2)$]]
        circle((0, 0), radius: 0.05cm, fill: red, stroke: none)
        content((), anchor: "south-east", padding: 0.1cm)[#text(red)[$(0, 0)$]]
      })
    )
]