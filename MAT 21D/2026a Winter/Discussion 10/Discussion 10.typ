#import "../Discussion.typ": *
#import "../lighting.typ": *

#show: discussion.with(
  number: 10,
  date: datetime(year: 2026, month: 3, day: 12),
)

= Stokes' Theorem and Divergence Theorem

#theorem[
  #text(red)[(Stokes' Theorem)]
  Let $S$ be an oriented surface with boundary curve $C$ (oriented using the right-hand rule), then for every vector field $bf(F)$ defined everywhere on $S$, we have
  $
    integral_C bf(F) dot.c dd(bf(r)) = integral.double_S (nabla times bf(F)) dot bf(n) dd(sigma).
  $
]

#theorem[
  #text(red)[(Divergence Theorem)]
  Let $D$ be a solid region with boundary surface $S$ (oriented using the outward normal), then for every vector field $bf(G)$ defined everywhere on $D$, we have
  $
    integral.double_S bf(G) dot bf(n) dd(sigma) = integral.triple_D (nabla dot bf(G)) dd(V).
  $
]

These two theorems complete the analysis of integrations in three-dimensional space.
As I mentioned in the very first discussion, there is a overarching theorem called the *generalized Stokes' theorem* that encompasses all of the analysis we did and generalize them to arbitrary dimensions.
It is the reason why I love to share the content of this course with you, and if you are interested, "generalized Stokes' theorem" is the key phrase you can search.
You will encounter unfamiliar phrases like "manifolds" and "differential forms," and you can look them up too as if you are peeling an onion.
It was a really fun journey for me when I was learning this about "generalized Stokes' theorem," and perhaps, some of you will enjoy it too!

#figure(
  canvas({
    import cetz.draw: *

    let x = 4.3
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
    padded-content((2 * x, -y), name: "t21")[$display(integral.double_S bf(G) dot bf(n) dd(sigma))$]
    padded-content((3 * x, -y), name: "t31")[$display(integral.triple_D g(x, y, z) dd(V))$]

    line("t01.east", "t11.west", name: "a01", mark: (start: "straight", end: "straight"))
    content("a01.mid", anchor: "south", padding: 0.2cm)[FT]
    line("t11.east", "t21.west", name: "a11", mark: (start: "straight", end: "straight"))
    content("a11.mid", anchor: "south", padding: 0.2cm)[Stokes' T.]
    line("t21.east", "t31.west", name: "a21", mark: (start: "straight", end: "straight"))
    content("a21.mid", anchor: "south", padding: 0.2cm)[Div. T.]

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

#exercise[
  Let $S$ be the unit sphere surface (oriented using the outward normal) and let
  $
    bf(G) = (y cos 2x) bf(i) + (y^2 sin 2x) bf(j) + (x^2 y + z) bf(k).
  $
  + Using the Divergence theorem, compute
    $
      integral.double_S bf(G) dot bf(n) dd(sigma).
    $
    #h(100%)
  + Is there a vector field $bf(F)$ such that $bf(G) = nabla times bf(F)$?
    Explain your answer.
]
#solution[
  + Divergence theorem tells us that#h(100%)
    $
      integral.double_S bf(G) dot bf(n) dd(sigma) = integral.triple_D (nabla dot bf(G)) dd(V).
    $
    We can calculate that
    $
      nabla dot bf(G) = (-2 y sin 2x) + (2 y sin 2x) + 1 = 1.
    $
    Therefore,
    $
      integral.double_S bf(G) dot bf(n) dd(sigma) = integral.triple_D 1 dd(V) = 4/3 pi
    $
    is just the volume of the unit ball $D$.
    If we do not know the volume of the unit ball, we can also calculate it using spherical coordinates, so
    $
      integral.triple_D 1 dd(V) = integral_0^(2 pi) integral_0^pi integral_0^1 rho^2 sin(phi) dd(rho, phi, theta) = 4/3 pi.
    $
  + Note that for any vector field $bf(F)$, we have
    $
      nabla dot (nabla times bf(F)) = 0.
    $
    We shown this in homework 8.
    However, because $nabla dot bf(G) != 0$, we know that there does not exist a vector field $bf(F)$ such that $bf(G) = nabla times bf(F)$.

    Alternatively, we can argue with Stokes' theorem.
    If $bf(G) = nabla times bf(F)$, then we must have
    $
      integral.double_S bf(G) dot bf(n) dd(sigma) = integral.double_S (nabla times bf(F)) dot bf(n) dd(sigma) = integral_(C) bf(F) dot.c dd(bf(r))
    $
    where $C$ is the boundary curve of $S$.
    In particular, for the unit sphere surface $S$ which has no boundary curve, the line integral is zero, so we must have
    $
      integral.double_S bf(G) dot bf(n) dd(sigma) = 0.
    $
    But we have shown in the previous part that this is not the case, so there does not exist a vector field $bf(F)$ such that $bf(G) = nabla times bf(F)$.
]

= Final Review

The tables in this section are checklists of skills you are expected to learn.
Rate your grasp of each skill from
- 1: I don't know how to do this at all.
- 5: I am confident that I can do this on my own without looking at any notes.
After each checklist, there are exercises for you to practice selected by me personally.
The exercises are all pulled from discussions, homeworks, and exams, so you have the solutions to them.

#let exercise-counter = counter("exercise")

#let exercise(title: none, body) = {
  exercise-counter.step()
  showybox(
    frame: (
      border-color: indigo,
      title-color: indigo,
      body-color: white.darken(10%),
      thickness: (left: 2pt),
      radius: 0pt
    ),
    title: if title != none {
      [Exercise #context exercise-counter.display(): #title]
    } else {
      [Exercise #context exercise-counter.display()]
    },
    title-style: (
      sep-thickness: 0pt,
    ),
    body,
  )
}

#set table(
  stroke: none,
  gutter: 0.1em,
  fill: gray.lighten(70%),
  columns: (1fr, 20pt, 20pt, 20pt, 20pt, 20pt)
)

#let head() = table.header(
  table.cell(align: center)[],
  table.cell(align: center)[1],
  table.cell(align: center)[2],
  table.cell(align: center)[3],
  table.cell(align: center)[4],
  table.cell(align: center)[5],
)

// #let g(body) = table.cell(colspan: 6, fill: none, align: center, inset: 2pt, text(size: 8pt, body))

#let f(..items) = items.pos().map(x => (x, [], [], [], [], [])).flatten()

#set enum(numbering: "(a)")

*Double integral in rectangular coordinates  (Sections 15.1-15.3)*

#table(
  head(),
  ..f(
    [Describe a region given $a <= x <= b$ and $g_1(x) <= y <= g_2(x)$ (or given $c <= y <= d$ and $h_1(x) <= x <= h_2(x)$)],
    [Given a description of a region, set up an iterated integral of a function $f(x, y)$ over this region],
    [Exchange the order of integration in an iterated integral while taking care of the bounds],
    [Calculate the area of a region using rectangular coordinates],
    [Know how to deal with piecewise behavior]
  )
)

#exercise(title: [Midterm 1A, question 1])[
  Let $E$ denote the region in the plane bounded between the line $y = 0$, the line $2 y + x = 4$, and the parabola $x = y^2 - 4$.
  + Sketch the region.
  + Evaluate the double integral
    $
      integral.double_E y dd(A)
    $
    as an iterated integral where the integration is performed in the order $dd(x, y)$
    #h(100%)
]

// #exercise(title: [Example 15.2.3])[
//   Sketch the region of integration for the integral
//   $
//     integral_0^2 integral_(x^2)^(2 x) (4x + 2) dd(y, x)
//   $
//   and write an equivalent integral with the order of integration reversed.
// ]

#exercise(title: [Homework 1, question 3])[
  Sketch the region of integration for the integral
  $
    integral_0^1 integral_(0)^(x^2 - 2x + 1) x y dd(y, x).
  $
  and write an equivalent integral with the order of integration reversed.
]

#exercise(title: [Discussion 1])[
  Consider the region $R$ bounded by $y = x^2$, $x = 0$, $y = 1$ in the first quadrant.
  Write down the two iterated integrals in rectangular coordinates that
  $
    integral.double_R x e^(y^2) dd(y, x)
  $
  is equal to, and evaluate either one of them.
]

// #exercise(title: [Homework 2, question 2])[
//   Let $R$ denote the region of points $(x, y)$ satisfying $abs(x) + abs(y) <= 1$.
//   + Sketch the region $R$.
//   + Calculate the average value of the function $f(x, y) = x^4 + y^3$ over the region $R$.
// ]

#exercise(title: [Midterm 1B, question 1])[
  Let $E$ denote the triangular region in the plane with vertices at $(0, 0)$, $(2, 0)$, and $(4, 4)$.
  + Evaluate the double integral
    $
      integral.double_E x y dd(A)
    $
    as an iterated integral where the integration is performed in the order $dd(x, y)$.
  + If the integration is performed in the reverse order $dd(y, x)$, the double integral needs to be broken up into a sum of two iterated integrals for the evaluation to be carried out.
    Write down these two iterated integrals.
]

*Double integral in polar coordinates (Section 15.4)*

#table(
  head(),
  ..f(
    [Understand the curve described by $theta = alpha$ (for some constant $alpha$)],
    [Understand the curve described by $r = g(theta)$],
    [Describe a region given $alpha <= theta <= beta$ and $g_1(theta) <= r <= g_2(theta)$],
    [Given a description of a region (possibly in rectangular coordinates), set up an iterated integral of a function $f(r, theta)$ over this region],
    [Calculate a double integral using polar coordinates]
  )
)

#exercise(title: [Practice midterm 1, question 1])[
  The integral
  $
    integral_0^pi integral_0^3 (3 - r) r dd(r, theta)
  $
  is the representation of the double integral
  $
    integral.double_R f(x, y) dd(A)
  $
  for a suitable region $R$ and a suitable function $f(x, y)$.
  + Write down a formula for $f(x, y)$ and sketch the region $R$.
  + Describe the solid region in three-dimensional space whose volume is calculated by this integral.
]

#exercise(title: [Discussion 2])[
  The figure below shows two curves: the circle $r = 1$ and the cardioid $r = 1 + cos(theta)$.
  Consider the shaded region $R$ in the figure.
  #figure(
    canvas(length: 1cm, {
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
  Calculate the area of the region $R$ using polar coordinates.
]

#exercise(title: [Midterm 1B, question 1])[
  Let $E$ denote the triangular region in the plane with vertices at $(0, 0)$, $(2, 0)$, and $(4, 4)$.
  Rewrite the double integral
  $
    integral.double_E x y dd(A)
  $
  as an iterated integral in polar coordinates.
]

#exercise(title: [Midterm 1A, question 3])[
  Evaluate the iterated integral
  $
    integral_0^1 integral_0^(sqrt(1-x^2)) (x^2 + y^2) dd(y, x)
  $
  by converting it to an iterated integral in polar coordinates.
]

*Triple integral in rectangular coordinates (Section 15.5)*

#table(
  head(),
  ..f(
    [Given a solid region, set up an iterated integral of a function $f(x, y, z)$ over this region],
    [Calculate a triple integral of a region using triple integrals (not on the final exam)],
    [Exchange the order of integration in a triple integral while taking care of the bounds]
  )
)

// #exercise(title: [Homework 3, question 2])[
//   Calculate the moment of inertia $I_x = integral.triple_D (y^2 + z^2) dd(V)$ of the solid region $D$, where $D$ is the set of points satisfying $x, y, z >= 0$, $x + y + z/2 <= 1$.
//   (Geometrically, the solid $D$ is a tetrahedron with vertices at $(0, 0, 0)$, $(1, 0, 0)$, $(0, 1, 0)$, and $(0, 0, 2)$.)
// ]

#exercise(title: [Discussion 3])[
  Here is the region of integration of the integral
  $
    integral_(-1)^(1) integral_(x^2)^(1) integral_0^(1 - y) dd(z) dd(y) dd(x).
  $
  #figure(
    image("../Discussion 3/15.5.21.png", width: 50%),
  )
  Rewrite the integral as an equivalent iterated integral in the order
  + $dd(z, x, y)$,
  + $dd(y, z, x)$,
]


#exercise(title: [Midterm 1B, question 2])[
  Consider the following truncated square pyramid (centered symmetrically around the $z$-axis) with the following dimensions:
  - Width of base $B = 54$, the $x y$-cross-section is the square $-27 <= x <= -27$ and $-27 <= y <= 27$.
  - Width of top $T = 10$, the $x y$-cross-section is the square $-5 <= x <= 5$ and $-5 <= y <= 5$.
  - Height $H = 24$.
  #figure(
    image("Temple.png", width: 50%)
  )
  + The $x y$-cross-section at half of height $z = 12$ is a square with width $54/2 + 10/2 = 32$.
    Describe this $x y$-cross-section as $a <= x <= b$ and $c <= y <= d$.
  + In general, the $x y$-cross-section at the height $z$ is a square with width $(1 - z/24) 54 + (z/24) 10 $.
    Describe the $x y$-cross-section at arbitrary height $z$ as $a(z) <= x <= b(z)$ and $c(z) <= y <= d(z)$.
  + Write down an iterated integral in the order $dd(x, y, z)$ for the the volume of the truncated square pyramid.
]

*Triple integral in cylindrical and spherical coordinates (Section 15.7)*

#table(
  head(),
  ..f(
    [Understand the surface described by $theta = alpha$ (for some constant $alpha$)],
    [Understand the surface described by $r = a$ (for some constant $a$)],
    [Understand the surface described by $z = g(theta, r)$ (for some function $g$)],
    [Understand the surface described by $phi = alpha$ (for some constant $alpha$)],
    [Understand the surface described by $rho = g(theta, phi)$],
    [Set up an iterated integral of a function $f(r, theta, z)$ over a solid region in cylindrical coordinates],
    [Set up an iterated integral of a function $f(rho, theta, phi)$ over a solid region in spherical coordinates],
  )
)

#exercise(title: [Midterm 1B, question 3])[
  + Find an equation in spherical coordinates for the cone $z = sqrt(x^2 + y^2)$.
  + Find an equation in rectangular coordinates for the surface $theta = pi/4$.
  + Describe in plain language the solid region $0 <= theta <= 2 pi$, $0 <= phi <= pi/3$, and $0 <= rho <= 2$.
]


#exercise(title: [Homework 4, question 1])[
  Consider the integrated integral in cylindrical coordinates
  $
    integral_0^(2 pi) integral_0^(1/2) integral_(-sqrt(1 - r^2))^(sqrt(1 - r^2)) f(r, theta, z) r dd(z) dd(r) dd(theta).
  $
  + Describe/sketch the region of integration.
  + Convert the integral to rectangular coordinates in the the order $dd(z, y, x)$.
]

#exercise(title: [Discussion 4])[
  + Describe the region of integration for the integral
    $
      integral_(0)^(pi/2) integral_(0)^(pi/2) integral_(0)^(2) f(rho, theta, phi) rho^2 sin(phi) dd(rho, phi, theta).
    $
    #h(100%)
  + Express as a triple integral in spherical coordinates the volume of the cone obtained by connecting the boundary of the disk described by the two equations $x^2 + y^2 <= 12$ and $z = 2$ to the origin.
  #figure(
    canvas(length: 1cm, {
      import cetz.draw: *
      ortho(x: -70deg, y: 0deg, z: -120deg, {
        line((0, 0, 0), (4, 0, 0), stroke: 1pt + gray, mark: (end: "straight"))
        content((4.2, 0, 0))[$x$]
        line((0, 0, 0), (0, 4, 0), stroke: 1pt + gray, mark: (end: "straight"))
        content((0, 4.2, 0))[$y$]
        line((0, 0, 0), (0, 0, 2), stroke: 1pt + gray)
        on-layer(1, {
          line((0, 0, 2), (0, 0, 3.5), stroke: 1pt + gray, mark: (end: "straight"))
        })
        content((0, 0, 3.7))[$z$]
        let disk-normal = (0, 0, 1)
        let disk-intensity = calculate-lighting(disk-normal)
        let disk-shaded-color = shade-color(blue, disk-intensity)
        circle((0, 0, 2), radius: calc.sqrt(12), stroke: 1pt + disk-shaded-color, fill: disk-shaded-color.transparentize(50%))

        let theta-divisions = 30
        let theta = nt.linspace(0, 2 * calc.pi, theta-divisions + 1)
        let top = theta.map(t => (calc.sqrt(12) * nt.cos(t), calc.sqrt(12) * nt.sin(t), 2))
        let normal = theta.map(t => nt.mult(-1, phi-differential(4, t, 60deg)))
        let intensities = normal.map(n => calculate-lighting(n))
        let shaded-colors = intensities.map(i => shade-color(blue, i))

        for i in range(theta-divisions) {
          line(
            (0, 0, 0),
            top.at(i),
            top.at(i + 1),
            close: true,
            fill: shaded-colors.at(i).transparentize(50%),
            stroke: 0.1pt + shaded-colors.at(i),
          )
        }
      })
    })
  )
]

*Substitutions in multiple integrals (Section 15.8)*

#table(
  head(),
  ..f(
    [Transform a region using inequalities],
    [Transform a region using boundary curves],
    // [Find the region that gets mapped to a given region (using inequalities)],
    // [Find the region that gets mapped to a given region (using boundary curves)],
    [Understand why $dd(A) = r dd(r, theta)$ using substitutions],
    [Understand why $dd(V) = r dd(z, r, theta)$ using substitutions],
    [Understand why $dd(V) = rho^2 sin(phi) dd(rho, phi, theta)$ using substitutions],
    [
      Perform substitutions with $x$ and $y$ as functions of $u$ and $v$:
      $
        integral.double_R f(x, y) dd(x, y) = integral.double_G F(u, v) abs(pdv((x, y), (u, v))) dd(u, v)
      $
    ],
    [
      Perform substitutions with $u$ and $v$ as functions of $x$ and $y$:
      $
        integral.double_R f(x, y) abs(pdv((u, v), (x, y))) dd(x, y) = integral.double_G F(u, v) dd(u, v)
      $
    ],
    [Perform substitutions in triple integrals]
  )
)

#exercise(title: [Discussion 5])[
  Let $R$ be a tilted square in the $x y$-plane with vertices $(1, 0)$, $(0, 1)$, $(-1, 0)$, and $(0, -1)$.
  + Region $R$ is bounded by 4 lines. Reexpress $R$ using inequalities based on the equations of these lines.
  + Consider the transformation
    $
      x = (u + v)/2, quad y = (u - v)/2.
    $
    Find the inverse transformation and use it to find the region $G$ in the $u v$-plane that corresponds to $R$.
  + Evaluate the double integral
    $
      integral.double_R (x + y)^2 e^(x - y) dd(x, y).
    $
]

#exercise(title: [Discussion 5])[
  Let $R$ be the region in the first quadrant of $x y$-plane bounded by the curves
  $ x y = 1, quad x y = 4, quad y = x, quad y = 2 x. $
  Evaluate the double integral
  $
    integral.double_R y/x dd(x, y)
  $
  using the substitution $u = x y$ and $v = y/x$.
]

#exercise(title: [Homework 5, question 3])[
  + Compute the Jacobian of the map #h(100%)
    $
      cases(
        x = u,
        y = u + v,
        z = u + v + w
      )
    $
  + Use the Jacobian calculation to convert the triple integral
    $
      integral_0^1 integral_(x)^(x + 2) integral_(y)^(y + 3) (y^2 - x^2) dd(z, y, x)
    $
    to an equivalent integral in $u v w$-coordinates.
]

#exercise(title: [Practice midterm 2, question 1])[
  Consider the transformation
  $
    cases(
      x = e^u cos v\,,
      y = e^u sin v.,
    )
  $
  Let $R$ be the standard unit square in the $u v$-plane defined by $0 <= u <= 1$ and $0 <= v <= 1$.
  Write down the equations of the boundary curves of $S$ in the $x y$-plane that corresponds to $R$ under this transformation and sketch the region $S$.
]

*Geometry of curves (Sections 13.1-13.5)*

#table(
  head(),
  ..f(
    [Find arc length parameterization],
    [Formula will be given for quantities of curves, just need to know how to take derivatives and magnitudes],
    [Know which quantities are independent of parameterization],
    [Parameterize a curve given description]
  )
)

#exercise(title: [Midterm 2B, question 2])[
  Let curve $C$ be given by the parametric equations
  $
    bf(r)(t) = (3 cos t) bf(i) + (3 sin t) bf(j) + 4 t bf(k), quad 0 <= t <= 8 pi.
  $
  + Find the arc length parameter $s(t) = integral_0^t abs(bf(r)'(t')) dd(t')$.
  + Write down a reparameterization $bf(q)(s)$ in terms of the arc length parameter.
  + Compute the tangent vector $bf(T) = (dv(bf(r), t, style: "horizontal"))/abs(dv(bf(r), t, style: "horizontal"))$.
  + Compute the curvature $kappa = 1/abs(dv(bf(r), t, style: "horizontal")) abs(dv(bf(T), t))$.
  + Compute the principal unit normal $bf(N) = (dv(bf(T), t, style: "horizontal"))/abs(dv(bf(T), t, style: "horizontal"))$.
]

Also see practice midterm 2, midterm 2A, homework 6, and discussion 6 for more exercises.

*Between potential functions and line integrals (Section 16.1-16.3)*

#table(
  head(),
  ..f(
    [Compute line integrals of scalar functions],
    [Compute line integrals of vector fields],
    [Use fundamental theorem of calculus for line integrals],
    [Determine if a vector field is conservative using component test],
    [Find a potential function for a conservative vector field],
    [Decompose a vector field into conservative and non-conservative parts]
  )
)

#exercise(title: [Midterm 2B, question 1])[
  Consider the vector fields
  $
    bf(F)(x, y) = 2 y bf(i) - 2y bf(j) quad "and" quad
    bf(G)(x, y) = (x^2 + y^2) bf(i) + 2x y bf(j).
  $
  Let $C$ be the curve with the parameterization
  $
    bf(r)(t) = t bf(i) + t^2 bf(j), quad 0 <= t <= 1.
  $
  + Explain whether there exist a potential function $U(x, y)$ such that $bf(F) = nabla U$? If so, find one.
  + Explain whether there exist a potential function $V(x, y)$ such that $bf(G) = nabla V$? If so, find one.
  + Evaluate
    $
      integral_C bf(F) dot dd(bf(r)).
    $
    Use the fundamental theorem of calculus for line integrals if possible.
  + Evaluate
    $
      integral_C bf(G) dot dd(bf(r)).
    $
    Use the fundamental theorem of calculus for line integrals if possible.
]

#exercise(title: [Discussion 7])[
  Determine if the vector field
  $
    bf(F)(x, y, z) = e^y bf(i) + (x e^y + z) bf(j) + y bf(k)
  $
  is conservative. If it is, find a potential function $U(x, y, z)$ that satisfies $U(0, 0, 0) = 1$.
]

#exercise(title: [Discussion 8])[
  Let $bf(F)(x, y) = (e^x cos y) bf(i) + (x - e^x sin y) bf(j)$ and $C$ be the line segment from $(0, 0)$ to $(1, 1)$.
  Evaluate the line integral
  $
    integral_C bf(F) dot.c dd(bf(r))
  $
  by decomposing $bf(F)$ into a conservative part and a non-conservative part.
]

*Between line integrals and surface integrals (Sections 16.4-16.7)*

#table(
  head(),
  ..f(
    [Compute surface integrals of scalar functions],
    [Compute surface integrals of vector fields],
    [Use Green's or Stokes' theorem to evaluate integrals],
    [Use Green's theorem to compute area]
  )
)

#exercise(title: [Discussion 9])[
  Let $S$ be the portion of the plane
  $ x + y + z = 4 $
  that lies above the square $0 <= x <= 1$, $0 <= y <= 1$ in the $x y$-plane.
  + Draw a picture of the surface $S$.
  + Rewrite the surface integral
    $
      integral.double_S z dd(sigma)
    $
    as an iterated integral in $dd(u, v)$.
    #h(100%)
]

#exercise(title: [Discussion 9])[
  Rewrite the surface integral
  $
    integral.double_S (x - y - z) dd(sigma)
  $
  as iterated integrals for each of the following surfaces $S$.
  + The portion of the plane $x + y = 1$ in the first octant between $z = 0$ and $z = 1$.
    #figure(
      canvas(length: 2cm, {
        import cetz.draw: *

        ortho(x: -70deg, y: 0deg, z: -120deg, {
          line((0, 0, 0), (2, 0, 0), stroke: 1pt + gray, mark: (end: "straight"))
          content((2.2, 0, 0))[$x$]
          line((0, 0, 0), (0, 2, 0), stroke: 1pt + gray, mark: (end: "straight"))
          content((0, 2.2, 0))[$y$]
          line((0, 0, 0), (0, 0, 1.6), stroke: 1pt + gray, mark: (end: "straight"))
          content((0, 0, 1.8))[$z$]

          line(
            (1, 0, 0),
            (0, 1, 0),
            (0, 1, 1),
            (1, 0, 1),
            close: true,
            fill: blue.transparentize(50%),
            stroke: blue,
          )

          line((1, 0, 1), (0, 0, 1), stroke: (dash: "dashed", paint: black.lighten(40%)))
          line((0, 1, 1), (0, 0, 1), stroke: (dash: "dashed", paint: black.lighten(40%)))
        })
      }),
      caption: [Picture of the portion of the plane $x + y = 1$.]
    )
  + The portion of the sphere $x^2 + y^2 + z^2 = 1^2$ in the first octant.
]

#exercise(title: [Homework 10, question 1])[
  The torus is a surface given in parametric form by
  $
    bf(r)(u, v) = cos(u) (r cos(v) + R) bf(i) + sin(u) (r cos(v) + R) bf(j) + r sin(v) bf(k)
  $
  where $R$ is the major radius and $r$ is the minor radius, and both parameters $u$ and $v$ range from $0$ to $2 pi$.
  Calculate the surface area of the torus.
]

#exercise(title: [Homework 10, question 2])[
  Calculate the surface integral $integral.double_S bf(F) dot bf(n) dd(sigma)$ where $bf(F) = x^2 bf(i) + bf(j) + x z bf(k)$ and $S$ is the surface given in parametric form by
  $
    bf(r)(u, v) = v cos(u) bf(i) + v cos(u) bf(j) + v sin(u) bf(k)
  $
  for $0 <= u <= 1$ and $0 <= v <= 2 pi$.
]

There is also homework 9 for a question about Green's theorem.
Stokes' theorem is potentially on the final exam, but the question will be more conceptual it seems based on professor Romik's announcement.
There is no homework coverage for Stokes' theorem, so I doubt the question would be computational.

*Between surface integrals and triple integrals (Section 16.8)*

#table(
  head(),
  ..f(
    [Use divergence to determine whether a vector field is a curl of a vector field],
    [Use divergence theorem to write down equivalent integrals],
  )
)

This very discussion! But divergence theorem would not be on the final exam..
