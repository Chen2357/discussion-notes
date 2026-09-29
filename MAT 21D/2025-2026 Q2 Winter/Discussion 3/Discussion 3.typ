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

#let author = "Chen Liang"
#let date = datetime(year: 2026, month: 1, day: 22)

#set document(
  title: [MAT 21D Discussion 3 Notes],
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

/// Calculate lighting intensity using Lambertian shading.
#let calculate-lighting(
  light-direction: (0, -1, 1),
  ambient-light: 0.2,
  diffuse-strength: 0.8,
  normal,
) = {
  let norm-light = nt.normalize(light-direction)
  let norm-normal = nt.normalize(normal)

  // Lambertian (diffuse) shading.
  let diffuse = calc.max(0, nt.dot(norm-normal, norm-light))

  // Combine ambient and diffuse lighting.
  let intensity = ambient-light + diffuse-strength * diffuse
  return calc.min(1, intensity) // Clamp to [0, 1].
}

/// Interpolate between two colors based on intensity
#let shade-color(color, intensity) = {
  // Convert intensity to RGB scaling.
  // Minimum brightness to avoid pure black.
  let scale = calc.max(0.1, intensity)

  // For built-in colors, create a lighter/darker version
  if type(color) == std.color {
    return color.lighten(100% * (intensity - 0.5))
  }

  // For custom colors, you might need different handling
  return color
}

= Warm-up

// #nt.is-1d((3, 4, 0))
// #normalize((((3, 4, 0), (3, 4, 0)), ((3, 4, 0), (3, 4, 0))))

#exercise[
  The iterated integral
  $
    integral_0^(2 pi) integral_0^3 r^2 dd(r) dd(theta)
  $
  describes the volume of a solid.
  Describe the solid to your group in words or with a sketch.
]
#solution[
  Note that because $dd(A) = r dd(r) dd(theta)$, we have
  $
    integral_0^(2 pi) integral_0^3 r^2 dd(r) dd(theta) = integral.double_R r dd(A)
  $
  where $R$ is the disk of radius $3$ centered at the origin in the $x y$-plane.
  Thus, the solid is the region above the disk and below the graph of $z = r = sqrt(x^2 + y^2)$.

  We can describe it as a "crown shaped" region obtained by removing a cone from the cylinder of radius $3$ and height $3$.
  #figure(
    canvas({
      import cetz.draw: *

      let fill = blue
      let r = 3
      let theta-divisions = 100

      let get-cylinder-point(theta, z) = {
        let x = r * nt.cos(theta)
        let y = r * nt.sin(theta)
        return (x, y, z)
      }

      let get-cylinder-normal(theta) = {
        let nx = nt.cos(theta)
        let ny = nt.sin(theta)
        let nz = 0
        return (nx, ny, nz)
      }

      let get-cone-normal(theta) = {
        let nx = -nt.cos(theta)
        let ny = -nt.sin(theta)
        return (nx, ny, 1)
      }

      ortho(x: -40deg, y: 0deg, {
        let theta = nt.linspace(0, 2 * calc.pi, theta-divisions + 1)
        let cylinder-bottom-points = theta.map(t => get-cylinder-point(t, 0))
        let cylinder-top-points = theta.map(t => get-cylinder-point(t, r))
        let cylinder-normals = range(theta-divisions).map(i => get-cylinder-normal((theta.at(i) + theta.at(i + 1)) / 2))
        let cylinder-intensities = cylinder-normals.map(n => calculate-lighting(n))
        let cylinder-shaded-colors = cylinder-intensities.map(i => shade-color(fill, i))
        let cone-normals = theta.map(t => get-cone-normal(t))
        let cone-intensities = cone-normals.map(n => calculate-lighting(n))
        let cone-shaded-colors = cone-intensities.map(i => shade-color(fill, i))

        for i in range(theta-divisions) {
          cetz.draw.line(
            cylinder-bottom-points.at(i),
            cylinder-bottom-points.at(i + 1),
            cylinder-top-points.at(i + 1),
            cylinder-top-points.at(i),
            close: true,
            fill: cylinder-shaded-colors.at(i),
            stroke: 0.1pt + cylinder-shaded-colors.at(i),
          )

          cetz.draw.line(
            cylinder-top-points.at(i),
            cylinder-top-points.at(i + 1),
            (0, 0, 0),
            close: true,
            fill: cone-shaded-colors.at(i),
            stroke: 0.1pt + cone-shaded-colors.at(i),
          )
        }
      })
    }),
  )
]

#pagebreak()

= Triple integrals

#theorem[
  If a region $D$ has shadow $R$ in the $x y$-plane and is described by $f_1(x, y) <= z <= f_2(x, y)$, then the triple integral over $D$ can be computed as
  $
    integral.triple_D F(x, y, z) dd(V) = integral.double_R integral_(f_1(x, y))^(f_2(x, y)) F(x, y, z) dd(z) dd(A).
  $
  #figure(
    image("Textbook (page 920).png", width: 60%),
  )
  Furthermore, if $R$ is described by $a <= x <= b$ and $g_1(x) <= y <= g_2(x)$, then
  $
    integral.triple_D F(x, y, z) dd(V) = integral_(a)^(b) integral_(g_1(x))^(g_2(x)) integral_(f_1(x, y))^(f_2(x, y)) F(x, y, z) dd(z) dd(y) dd(x).
  $
]

The first part of the above theorem is the important part.
The second part is is just an application of Fubini's theorem to the double integral.
Fubini's theorem is not the only way to compute double integrals.
You also know about polar coordinates, and if we switch out the second part of the theorem with evaluating by polar coordinates, we will get a formula for triple integrals in cylindrical coordinates.

#exercise[
  // #text(dark-magenta)[(Example)]
  Let $D$ denote the solid region lying above the square with vertices $(0, 0, 0)$, $(1, 0, 0)$, $(0, 2, 0)$, and $(1, 2, 0)$ in the $x y$-plane and bounded above by the graph of the function $z = f(x, y) = x^2$.
  + Compute the volume of the region $D$ by evaluating the triple integral
    $
      integral.triple_D 1 dd(V).
    $
  + Evaluate the triple integral
    $
      integral.triple_D x dd(V).
    $
    #h(100%)
]
#solution[
  The shadow of the region $D$ in the $x y$-plane is the rectangle given by $0 <= x <= 1$ and $0 <= y <= 2$, and the bounds of $z$ are given by $0 <= z <= x^2$.
  #figure(
    grid(
      columns: (auto, auto, auto),
      column-gutter: 6mm,
      row-gutter: 2mm,
      canvas({
        import cetz.draw: *

        ortho(
          x: -40deg,
          y: 0deg,
          z: -120deg,
          {
            line((0, 0, 0), (2, 0, 0), stroke: 1pt + gray, mark: (end: "straight"))
            content((2.2, 0, 0))[$x$]
            line((0, 0, 0), (0, 3, 0), stroke: 1pt + gray, mark: (end: "straight"))
            content((0, 3.2, 0))[$y$]
            line((0, 0, 0), (0, 0, 2), stroke: 1pt + gray, mark: (end: "straight"))
            content((0, 0, 2.2))[$z$]

            on-xy({
              rect((0, 0), (1, 2), fill: blue.lighten(50%), stroke: none)
              on-layer(1, {
                content((0.5, 1))[$R$]
              })
            })
          },
        )
      }),
      canvas({
        import cetz.draw: *

        ortho(
          x: -40deg,
          y: 0deg,
          z: -120deg,
          {
            line((0, 0, 0), (2, 0, 0), stroke: 1pt + gray, mark: (end: "straight"))
            content((2.2, 0, 0))[$x$]
            line((0, 0, 0), (0, 3, 0), stroke: 1pt + gray, mark: (end: "straight"))
            content((0, 3.2, 0))[$y$]
            line((0, 0, 0), (0, 0, 2), stroke: 1pt + gray, mark: (end: "straight"))
            content((0, 0, 2.2))[$z$]

            let x-divisions = 50
            let x = nt.linspace(0, 1, x-divisions + 1)
            let z = nt.pow(x, 2)
            for i in range(x-divisions) {
              line(
                (x.at(i), 0, z.at(i)),
                (x.at(i + 1), 0, z.at(i + 1)),
                stroke: 0.5pt,
              )
            }
            content((1.2, 0, 1.2), anchor: "east")[$z = x^2$]
          },
        )
      }),
      canvas({
        import cetz.draw: *

        ortho(
          x: -40deg,
          y: 0deg,
          z: -120deg,
          {
            line((0, 0, 0), (2, 0, 0), stroke: 1pt + gray, mark: (end: "straight"))
            content((2.2, 0, 0))[$x$]
            line((0, 0, 0), (0, 3, 0), stroke: 1pt + gray, mark: (end: "straight"))
            content((0, 3.2, 0))[$y$]
            line((0, 0, 0), (0, 0, 2), stroke: 1pt + gray, mark: (end: "straight"))
            content((0, 0, 2.2))[$z$]

            let x-divisions = 50
            let x = nt.linspace(0, 1, x-divisions + 1)
            let z = nt.pow(x, 2)
            let normals = x.map(t => (-2 * t, 0, 1))
            let intensities = normals.map(n => calculate-lighting(n))
            let shaded-colors = intensities.map(i => shade-color(blue, i))

            for i in range(x-divisions) {
              line(
                (x.at(i), 0, z.at(i)),
                (x.at(i), 2, z.at(i)),
                (x.at(i + 1), 2, z.at(i + 1)),
                (x.at(i + 1), 0, z.at(i + 1)),
                close: true,
                fill: shaded-colors.at(i),
                stroke: 0.1pt + shaded-colors.at(i),
              )
              line(
                (x.at(i), 2, 0),
                (x.at(i), 2, z.at(i)),
                (x.at(i + 1), 2, z.at(i + 1)),
                (x.at(i + 1), 2, 0),
                close: true,
                fill: shade-color(blue, calculate-lighting((0, 1, 0))),
                stroke: 0.1pt + shade-color(blue, calculate-lighting((0, 1, 0))),
              )
            }
            line(
              (1, 0, 0),
              (1, 2, 0),
              (1, 2, 1),
              (1, 0, 1),
              close: true,
              fill: shade-color(blue, calculate-lighting((0, 0, 1))),
              stroke: 0.1pt + shade-color(blue, calculate-lighting((0, 0, 1))),
            )
            content((0, 1, 0.5), anchor: "west")[$D$]
          },
        )
      }),
    ),
  )

  + The volume of the region $D$ is given by
    $
      integral_0^1 integral_0^2 integral_0^(x^2) 1 dd(z) dd(y) dd(x) = integral_0^1 integral_0^2 x^2 dd(y) dd(x) = integral_0^1 2 x^2 dd(x) = 2/3.
    $
    #h(100%)
  + The value of the triple integral is
    $
      integral_0^1 integral_0^2 integral_0^(x^2) x dd(z) dd(y) dd(x) & = integral_0^1 integral_0^2 x^3 dd(y) dd(x) \
                                                                     & = integral_0^1 2 x^3 dd(x) \
                                                                     & = 1/2.
    $
]

Sometimes you need to be flexible with variations of the theorem for triple integrals.
You may want to cast the shadow to a different plane like the $y z$-plane or the $x z$-plane.
For example, here is variation of the theorem about casting the shadow to the $y z$-plane.

#theorem[
  If a region $D$ has shadow $R$ in the $y z$-plane and is described by $f_1(y, z) <= x <= f_2(y, z)$, then the triple integral over $D$ can be computed as
  $
    integral.triple_D F(x, y, z) dd(V) = integral.double_R integral_(f_1(y, z))^(f_2(y, z)) F(x, y, z) dd(x) dd(A).
  $
  When evaluating the double integral over $R$, be mindful that $R$ is in the $y z$-plane, so $dd(A)$ is $dd(y) dd(z)$ or $dd(z) dd(y)$.
]

The triple integral can be thought of as a bridge between all the iterated integrals in different orders.

#exercise[
  #text(dark-magenta)[(Exercise 15.5.21)]
  Here is the region of integration of the integral
  $
    integral_(-1)^(1) integral_(x^2)^(1) integral_0^(1 - y) dd(z) dd(y) dd(x).
  $
  #figure(
    image("15.5.21.png", width: 50%),
  )
  Rewrite the integral as an equivalent iterated integral in the order
  + $dd(z, x, y)$
  + $dd(x, y, z)$
  + $dd(x, z, y)$
  + $dd(y, z, x)$
  + $dd(y, x, z)$.
  Choose two of the iterated integrals and evaluate them to verify that they give the same value.
]
#solution[
  + The shadow of the region in the $x y$-plane is given by $-1 <= x <= 1$ and $x^2 <= y <= 1$.
    Equivalently, it is given by $0 <= y <= 1$ and $-sqrt(y) <= x <= sqrt(y)$.
    Thus, the integral in the order $dd(z, x, y)$ is
    $
      integral_0^(1) integral_(-sqrt(y))^(sqrt(y)) integral_0^(1 - y) dd(z) dd(x) dd(y)
      &= integral_0^(1) integral_(-sqrt(y))^(sqrt(y)) (1 - y) dd(x) dd(y) \
      &= integral_0^(1) 2 sqrt(y) (1 - y) dd(y) \
      &= 2 integral_0^(1) (y^(1/2) - y^(3/2)) dd(y) \
      &= 2 (2/3 - 2/5) \
      &= 8/15.
    $

  + The bounds of $x$ described as functions of $y$ and $z$ are $-sqrt(y) <= x <= sqrt(y)$.
    Thus, the triple integral is equal to
    $
      integral.double_R integral_(-sqrt(y))^(sqrt(y)) dd(x) dd(A)
    $
    where $R$ is the shadow of the region in the $y z$-plane.

    This shadow $R$ is the triangle bounded by the $y$ and $z$ axes and $y + z = 1$.
    We can describe $R$ as $0 <= z <= 1$ and $0 <= y <= 1 - z$.
    Thus, the integral in the order $dd(x, y, z)$ is
    $
      integral_0^(1) integral_0^(1 - z) integral_(-sqrt(y))^(sqrt(y)) dd(x) dd(y) dd(z)
      &= integral_0^(1) integral_0^(1 - z) 2 sqrt(y) dd(y) dd(z) \
      &= integral_0^(1) (4/3) (1 - z)^(3/2) dd(z) \
      &= -integral_1^0 (4/3) u^(3/2) dd(u) \
      &= -[ (4/3) (2/5) u^(5/2) ]_1^0 \
      &= 8/15.
    $
    We have used the substitution $u = 1 - z$ and thus $dd(u) = -dd(z)$.

  + We also start with
    $
      integral.double_R integral_(-sqrt(y))^(sqrt(y)) dd(x) dd(A).
    $
    Now, we describe $R$ as $0 <= y <= 1$ and $0 <= z <= 1 - y$.
    Thus, the integral in the order $dd(x, z, y)$ is
    $
      integral_0^(1) integral_0^(1 - y) integral_(-sqrt(y))^(sqrt(y)) dd(x) dd(z) dd(y)
      &= integral_0^(1) integral_0^(1 - y) 2 sqrt(y) dd(z) dd(y) \
      &= integral_0^(1) 2 sqrt(y) (1 - y) dd(y) \
      &= 2 integral_0^(1) (y^(1/2) - y^(3/2)) dd(y) \
      &= 8/15.
    $
    We have already done the last integral in part 1.

  + The bounds of $y$ described as functions of $x$ and $z$ are $x^2 <= y <= 1 - z$.
    Thus, the triple integral is equal to
    $
      integral.double_S integral_(x^2)^(1 - z) dd(y) dd(A)
    $
    where $S$ is the shadow of the region in the $x z$-plane.
    We can find the bounds of $S$ by projecting the intersection of $y = x^2$ and $y + z = 1$ to the $x z$-plane.
    #figure(
      grid(
        columns: (auto, auto),
        column-gutter: 6mm,
        row-gutter: 2mm,
        canvas(length: 2cm, {
          import cetz.draw: *

          ortho(
            x: -40deg,
            y: 0deg,
            z: -120deg,
            {
              line((-1.5, 0, 0), (1.5, 0, 0), stroke: 1pt + gray, mark: (end: "straight"))
              content((1.7, 0, 0))[$x$]
              line((0, 0, 0), (0, 2, 0), stroke: 1pt + gray, mark: (end: "straight"))
              content((0, 2.2, 0))[$y$]
              line((0, 0, 0), (0, 0, 2), stroke: 1pt + gray, mark: (end: "straight"))
              content((0, 0, 2.2))[$z$]

              let x-divisions = 100
              let x = nt.linspace(-1, 1, x-divisions + 1)
              let y = nt.pow(x, 2)
              let z = nt.sub(1, y)

              for i in range(x-divisions) {
                line(
                  (x.at(i), y.at(i), z.at(i)),
                  (x.at(i + 1), y.at(i + 1), z.at(i + 1)),
                  stroke: 1pt,
                )
              }
            },
          )
        }),
        canvas(length: 2cm, {
          import cetz.draw: *

          ortho(
            x: -40deg,
            y: 0deg,
            z: -120deg,
            {
              line((-1.5, 0, 0), (1.5, 0, 0), stroke: 1pt + gray, mark: (end: "straight"))
              content((1.7, 0, 0))[$x$]
              line((0, 0, 0), (0, 2, 0), stroke: 1pt + gray, mark: (end: "straight"))
              content((0, 2.2, 0))[$y$]
              line((0, 0, 0), (0, 0, 2), stroke: 1pt + gray, mark: (end: "straight"))
              content((0, 0, 2.2))[$z$]

              let x-divisions = 100
              let x = nt.linspace(-1, 1, x-divisions + 1)
              let y = nt.pow(x, 2)
              let z = nt.sub(1, y)

              // for i in range(x-divisions) {
              //   line(
              //     (x.at(i), 0, z.at(i)),
              //     (x.at(i + 1), 0, z.at(i + 1)),
              //     stroke: 1pt,
              //   )
              // }

              line(
                ..range(x-divisions).map(i => (x.at(i), 0, z.at(i))),
                close: true,
                fill: blue.transparentize(50%)
              )
              content((-0.2, 0.1, 0), anchor: "west")[$S$]
            }
          )
        }),
        [(a) Intersection of $y = x^2$ and $y + z = 1$.],
        [(b) Shadow $S$ in the $x z$-plane. The boundary is obtained by projecting the intersection in subfigure (a) onto the $x z$-plane.],
      ),
    )

    This can be done by finding the relationship between $x$ and $z$ when we have both $y = x^2$ and $y + z = 1$.
    Doing so gives us $x^2 + z = 1$.
    // TODO picture
    Thus, we can describe $S$ as $-1 <= x <= 1$ and $0 <= z <= 1 - x^2$.
    Thus, the integral in the order $dd(y, z, x)$ is
    $
      integral_(-1)^(1) integral_0^(1 - x^2) integral_(x^2)^(1 - z) dd(y) dd(z) dd(x)
      &= integral_(-1)^(1) integral_0^(1 - x^2) (1 - z - x^2) dd(z) dd(x) \
      &= integral_(-1)^(1) ((1 - x^2)^2 - 1/2 (1 - x^2)^2) dd(x) \
      &= 1/2 integral_(-1)^(1) (1 - x^2)^2 dd(x) \
      &= 1/2 integral_(-1)^(1) (1 - 2 x^2 + x^4) dd(x) \
      &= 1/2 [x - (2/3) x^3 + (1/5) x^5]_(-1)^(1) \
      &= 1 - 2/3 + 1/5 \
      &= 8/15.
    $

  + Finally, we can also describe $S$ as $0 <= z <= 1$ and $-sqrt(1 - z) <= x <= sqrt(1 - z)$.
    Thus, the integral in the order $dd(y, x, z)$ is
    $
      integral_0^(1) integral_(-sqrt(1 - z))^(sqrt(1 - z)) integral_(x^2)^(1 - z) dd(y) dd(x) dd(z)
      &= integral_0^(1) integral_(-sqrt(1 - z))^(sqrt(1 - z)) (1 - z - x^2) dd(x) dd(z) \
      &= integral_0^(1) [ (1 - z) x - 1/3 x^3 ]_(-sqrt(1 - z))^(sqrt(1 - z)) dd(z) \
      &= integral_0^(1) (4/3) (1 - z)^(3/2) dd(z) \
      &= 8/15.
    $
    We have done the last integral in part 2.
]
