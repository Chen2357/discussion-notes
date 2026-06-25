#import "@preview/showybox:2.0.4": showybox
#import "@preview/cetz:0.4.2"
#import "@preview/physica:0.9.8"
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
#let date = datetime(year: 2026, month: 1, day: 29)

#set document(
  title: [MAT 21D Discussion 4 Notes],
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

#let get-direction(x, y, z) = {
  let transformation-z = (
    (nt.cos(z), nt.sin(z), 0),
    (-nt.sin(z), nt.cos(z), 0),
    (0, 0, 1),
  )
  let transformation-y = (
    (nt.cos(y), 0, nt.sin(y)),
    (0, 1, 0),
    (-nt.sin(y), 0, nt.cos(y)),
  )
  let transformation-x = (
    (1, 0, 0),
    (0, nt.cos(x), nt.sin(x)),
    (0, -nt.sin(x), nt.cos(x)),
  )
  let transformation = nt.matmul(
    nt.matmul(
      transformation-z,
      transformation-y,
    ),
    transformation-x,
  )
  return nt.matmul(transformation, nt.c(0, 0, 1)).map(v => v.at(0))
}

#let spherical-param(r, theta, phi) = (
  r * nt.sin(phi) * nt.cos(theta),
  r * nt.sin(phi) * nt.sin(theta),
  r * nt.cos(phi),
)

#let e-r(r, theta, phi) = (
  nt.sin(phi) * nt.cos(theta),
  nt.sin(phi) * nt.sin(theta),
  nt.cos(phi),
)

#let r-differential(r, theta, phi) = e-r(r, theta, phi)

#let e-theta(r, theta, phi) = (
  -r * nt.sin(phi) * nt.sin(theta),
  r * nt.sin(phi) * nt.cos(theta),
  0,
)

#let theta-differential(r, theta, phi) = nt.mult(1 / nt.pow(r * nt.sin(phi), 2), e-theta(r, theta, phi))

#let e-phi(r, theta, phi) = (
  r * nt.cos(phi) * nt.cos(theta),
  r * nt.cos(phi) * nt.sin(theta),
  -r * nt.sin(phi),
)

#let phi-differential(r, theta, phi) = nt.mult(1 / nt.pow(r, 2), e-phi(r, theta, phi))

#let cross(v, w) = (
  v.at(1) * w.at(2) - v.at(2) * w.at(1),
  v.at(2) * w.at(0) - v.at(0) * w.at(2),
  v.at(0) * w.at(1) - v.at(1) * w.at(0),
)

= Warm-up

#exercise[
  Discuss with your group about how do we proceed to calculate the integral
  $
    I = integral_0^1 integral_0^1 (4 - x - y)^3 dd(x) dd(y).
  $
]
#solution[
  The level 1 trick is to perform $u$-substitution.
  We can evaluate the inner integral by letting $u = 4 - x - y$ and $dd(u) = -dd(x)$, so that it becomes
  $
    integral_0^1 (4 - x - y)^3 dd(x) &= integral_(4 - y)^(3 - y) -u^3 dd(u) \
    &= -1/4 [u^4]_(u = 4 - y)^(u = 3 - y) \
    &= 1/4 ((4 - y)^4 - (3 - y)^4).
  $
  After which, we can evaluate the outer integral by distributing and perform two different $u$-substitutions.
  $
    I = 1/4 integral_0^1 (4 - y)^4 dd(y) - 1/4 integral_0^1 (3 - y)^4 dd(y).
  $
  It should be obvious how to perform the $u$-substitutions from here.

  The level 2 trick is to recognize a general pattern for the anti-derivative of some power of a linear function.
  You have to take a leap of faith and believe that anti-derivative of $(a x + b)^n$ in $x$ is
  $
    (a x + b)^(n + 1) / C
  $
  for some constant $C$.
  Then you can figure out $C$ so that the derivative of $(a x + b)^(n + 1) / C$ is indeed $(a x + b)^n$.
  In our case, the anti-derivative of $(4 - x - y)^3$ in $x$ is
  $
    -(4 - x - y)^4 / 4.
  $
  Notice how when we differentiate, the factor of $4$ coming from power rule cancels with the $4$ in the denominator, and the minus sign coming from chain rule cancels with the minus sign in front.
  Thus, the inner integral is
  $
    integral_0^1 (4 - x - y)^3 dd(x) = [-(4 - x - y)^4 / 4]_(x = 0)^(x = 1) = 1/4 ((4 - y)^4 - (3 - y)^4),
  $
  and we got to the same place.
]

= Triple integrals in spherical coordinate

// #text(size: 20pt)[]

#{
  let alpha = calc.pi / 6
  let beta = calc.pi / 3
  let phi1 = calc.pi / 6
  let phi2 = calc.pi / 4
  let g1(theta, phi) = 1
  let g1-theta(theta, phi) = 0
  let g1-phi(theta, phi) = 0
  let g2(theta, phi) = 2
  let g2-theta(theta, phi) = 0
  let g2-phi(theta, phi) = 0

  let theta-divisions = 20
  let phi-divisions = 20

  let theta = nt.linspace(alpha, beta, theta-divisions + 1)
  let phi = nt.linspace(phi1, phi2, phi-divisions + 1)

  let surface1 = theta.map(t => phi.map(p => spherical-param(g1(t, p), t, p)))
  let normal1 = theta.map(t => phi.map(p => {
    let r = g1(t, p)
    return nt.mult(-1, nt.sub(
      r-differential(r, t, p),
      nt.add(
        nt.mult(g1-theta(t, p), theta-differential(r, t, p)),
        nt.mult(g1-phi(t, p), phi-differential(r, t, p)),
      ),
    ))
  }))
  let intensities1 = normal1.map(row => row.map(n => calculate-lighting(n)))
  // let shaded-colors1 = intensities1.map(row => row.map(i => shade-color(blue, i)))

  let surface2 = theta.map(t => phi.map(p => spherical-param(g2(t, p), t, p)))
  let normal2 = theta.map(t => phi.map(p => {
    let r = g2(t, p)
    return nt.sub(
      r-differential(r, t, p),
      nt.add(
        nt.mult(g2-theta(t, p), theta-differential(r, t, p)),
        nt.mult(g2-phi(t, p), phi-differential(r, t, p)),
      ),
    )
  }))
  let intensities2 = normal2.map(row => row.map(n => calculate-lighting(n)))
  // let shaded-colors2 = intensities2.map(row => row.map(i => shade-color(blue, i)))

  let wall1-bottom = theta.map(t => spherical-param(g1(t, phi1), t, phi1))
  let wall1-top = theta.map(t => spherical-param(g2(t, phi1), t, phi1))
  let wall1-normal = theta.map(t => nt.mult(-1, phi-differential(1, t, phi1)))
  let wall1-intensities = wall1-normal.map(n => calculate-lighting(n))
  let wall1-shaded-colors = wall1-intensities.map(i => shade-color(blue, i))

  let wall2-bottom = theta.map(t => spherical-param(g1(t, phi2), t, phi2))
  let wall2-top = theta.map(t => spherical-param(g2(t, phi2), t, phi2))
  let wall2-normal = theta.map(t => phi-differential(1, t, phi2))
  let wall2-intensities = wall2-normal.map(n => calculate-lighting(n))
  let wall2-shaded-colors = wall2-intensities.map(i => shade-color(blue, i))

  let wall3-bottom = phi.map(p => spherical-param(g1(alpha, p), alpha, p))
  let wall3-top = phi.map(p => spherical-param(g2(alpha, p), alpha, p))
  let wall3-normal = phi.map(p => nt.mult(-1, theta-differential(1, alpha, p)))
  let wall3-intensities = wall3-normal.map(n => calculate-lighting(n))
  let wall3-shaded-colors = wall3-intensities.map(i => shade-color(blue, i))

  let wall4-bottom = phi.map(p => spherical-param(g1(beta, p), beta, p))
  let wall4-top = phi.map(p => spherical-param(g2(beta, p), beta, p))
  let wall4-normal = phi.map(p => theta-differential(1, beta, p))
  let wall4-intensities = wall4-normal.map(n => calculate-lighting(n))
  let wall4-shaded-colors = wall4-intensities.map(i => shade-color(blue, i))

  let draw-surface1(color: blue) = {
    let shaded-colors1 = intensities1.map(row => row.map(i => shade-color(color, i)))
    import cetz.draw: *
    for i in range(theta-divisions) {
      for j in range(phi-divisions) {
        line(
          surface1.at(i).at(j),
          surface1.at(i + 1).at(j),
          surface1.at(i + 1).at(j + 1),
          surface1.at(i).at(j + 1),
          close: true,
          fill: shaded-colors1.at(i).at(j).transparentize(50%),
          stroke: 0.1pt + shaded-colors1.at(i).at(j),
        )
      }
    }
  }

  let draw-surface2(color: blue) = {
    let shaded-colors2 = intensities2.map(row => row.map(i => shade-color(color, i)))
    import cetz.draw: *
    for i in range(theta-divisions) {
      for j in range(phi-divisions) {
        line(
          surface2.at(i).at(j),
          surface2.at(i + 1).at(j),
          surface2.at(i + 1).at(j + 1),
          surface2.at(i).at(j + 1),
          close: true,
          fill: shaded-colors2.at(i).at(j).transparentize(50%),
          stroke: 0.1pt + shaded-colors2.at(i).at(j),
        )
      }
    }
  }

  let draw-walls() = {
    import cetz.draw: *
    for i in range(theta-divisions) {
      line(
        wall1-bottom.at(i),
        wall1-top.at(i),
        wall1-top.at(i + 1),
        wall1-bottom.at(i + 1),
        close: true,
        fill: wall1-shaded-colors.at(i).transparentize(50%),
        stroke: 0.1pt + wall1-shaded-colors.at(i),
      )
      line(
        wall2-bottom.at(i),
        wall2-top.at(i),
        wall2-top.at(i + 1),
        wall2-bottom.at(i + 1),
        close: true,
        fill: wall2-shaded-colors.at(i).transparentize(50%),
        stroke: 0.1pt + wall2-shaded-colors.at(i),
      )
    }

    for j in range(phi-divisions) {
      line(
        wall3-bottom.at(j),
        wall3-top.at(j),
        wall3-top.at(j + 1),
        wall3-bottom.at(j + 1),
        close: true,
        fill: wall3-shaded-colors.at(j).transparentize(50%),
        stroke: 0.1pt + wall3-shaded-colors.at(j),
      )
      line(
        wall4-bottom.at(j),
        wall4-top.at(j),
        wall4-top.at(j + 1),
        wall4-bottom.at(j + 1),
        close: true,
        fill: wall4-shaded-colors.at(j).transparentize(50%),
        stroke: 0.1pt + wall4-shaded-colors.at(j),
      )
    }
  }

  let draw-axes() = {
    import cetz.draw: *
    line((0, 0, 0), (2, 0, 0), stroke: 1pt + gray, mark: (end: "straight"))
    content((2.2, 0, 0))[$x$]
    line((0, 0, 0), (0, 2, 0), stroke: 1pt + gray, mark: (end: "straight"))
    content((0, 2.2, 0))[$y$]
    line((0, 0, 0), (0, 0, 2), stroke: 1pt + gray, mark: (end: "straight"))
    content((0, 0, 2.2))[$z$]
  }

  let draw-theta-arc(start, end, rho, phi, division: 20, mark-delta-phi: 0.015) = {
    import cetz.draw: *
    let points = nt.linspace(start, end, division + 1).map(t => spherical-param(rho, t, phi))
    line(..points, stroke: 1pt + red)
    line(spherical-param(rho, start, phi - mark-delta-phi), spherical-param(rho, start, phi + mark-delta-phi), stroke: 1pt + red)
    line(spherical-param(rho, end, phi - mark-delta-phi), spherical-param(rho, end, phi + mark-delta-phi), stroke: 1pt + red)
  }

  let draw-phi-arc(start, end, rho, theta, division: 20, mark-length: 0.08) = {
    import cetz.draw: *
    let points = nt.linspace(start, end, division + 1).map(p => spherical-param(rho, theta, p))
    line(..points, stroke: 1pt + red)
    let mark-direction = nt.mult(e-theta(1, theta, end), mark-length)
    line(
      nt.add(spherical-param(rho, theta, start), mark-direction),
      nt.sub(spherical-param(rho, theta, start), mark-direction),
      stroke: 1pt + red,
    )
    line(
      nt.add(spherical-param(rho, theta, end), mark-direction),
      nt.sub(spherical-param(rho, theta, end), mark-direction),
      stroke: 1pt + red,
    )
    // line(spherical-param(rho, theta - delta-theta, start), spherical-param(rho, theta + delta-theta, start), stroke: 1pt + red)
    // line(spherical-param(rho, theta - delta-theta, end), spherical-param(rho, theta + delta-theta, end), stroke: 1pt + red)
  }

  show: it => figure(it)
  grid(
    columns: (45%, 45%),
    align: horizon,
    gutter: 1cm,
    canvas(length: 0.8in, {
      import cetz.draw: *
      ortho(x: -40deg, y: 0deg, z: -100deg, {
        draw-axes()
        draw-surface1()
        draw-surface2()
        draw-walls()

        on-layer(1, {
          let alpha-rho = g2(beta, phi1)
          draw-theta-arc(0, alpha, alpha-rho, phi1 + 0.02)
          content(spherical-param(alpha-rho, alpha / 2, phi1 + 0.02), anchor: "north", padding: (bottom: 2pt), text(red)[$#math.alpha$])

          let beta-rho = g2(beta, phi2)
          draw-theta-arc(0, beta, beta-rho, phi2 + 0.015)
          content(spherical-param(beta-rho, beta / 2, phi2 + 0.03), anchor: "south", padding: (left: 2pt), text(red)[$#math.beta$])

          let phi1-rho = g2(beta, phi1)
          draw-phi-arc(0, phi1, phi1-rho, alpha + 0.03)
          content(spherical-param(phi1-rho, alpha, phi1 / 2), anchor: "east", padding: (top: 4pt), text(red)[$#math.phi _1$])

          let phi2-rho = g2(beta, phi2)
          draw-phi-arc(0, phi2, phi2-rho, beta + 0.04)
          content(spherical-param(phi2-rho, beta, phi2 / 2), anchor: "west", padding: (left: 10pt), text(red)[$#math.phi _2$])
        })
      })
    }),
    canvas(length: 0.8in, {
      import cetz.draw: *
      ortho(x: -40deg, y: 0deg, z: -10deg, {
        draw-axes()
        draw-surface1(color: red)
        draw-surface2(color: red)
        draw-walls()

        on-layer(1, {
          content(nt.mult(2, (1/calc.sqrt(3), 1/calc.sqrt(3), 1/calc.sqrt(3))), anchor: "north-west", text(red)[$g_2(#math.theta, #math.phi)$])
          content(nt.mult(1, (1/calc.sqrt(3), 1/calc.sqrt(3), 1/calc.sqrt(3))), anchor: "south-west", padding: (top: 5pt), text(red)[$g_1(#math.theta, #math.phi)$])
        })
      })
    }),
  )
}

A triple integral in spherical coordinates is given by
$
  integral.triple_D f(rho, theta, phi) dd(V) =
  integral_alpha^beta integral_(phi_1)^(phi_2) integral_(g_1(theta, phi))^(g_2(theta, phi)) f(rho, theta, phi) rho^2 sin(phi) dd(rho, phi, theta)
$
provided that the region is described by $alpha <= theta <= beta$, $phi_1 <= phi <= phi_2$, and $g_1(theta, phi) <= rho <= g_2(theta, phi)$.
This region is depicted in the above figure.

Theoretically, $phi_1$ and $phi_2$ can be functions of $theta$ as well, but they are often constants in practice.
I would be shocked if $phi_1$ and $phi_2$ depend on $theta$ in any homework or exam problems.

#remark[
  The most important use of the spherical coordinate is to integrate over a sphere, so it is worth remembering that the integral over a sphere $D$ of radius $R$ centered at the origin is given by
  $
    integral.triple_(D) f(rho, theta, phi) dd(V) =
    integral_0^(2pi) integral_0^(pi) integral_0^(R) f(rho, theta, phi) rho^2 sin(phi) dd(rho, phi, theta).
  $
]

// #pagebreak()

#exercise[
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
#solution[
  + The region described is the portion of the ball of radius $2$ centered at the origin in the first octant (with $x, y, z >= 0$).
    By looking at $g_2(theta, phi) = 2$, we know that the outer boundary is a sphere of radius $2$, and by looking at $g_1 (theta, phi) = 0$, we know that the inner boundary is the origin.
    Thus, the region is the portion of the ball bounded by $0 <= theta <= pi/2$ and $0 <= phi <= pi/2$.
    The condition $0 <= theta <= pi/2$ restricts us to the the region swept by rotating the the half of $x z$-plane with positive $x$ around the $z$-axis by $pi/2$ to become the half of the $y z$-plane with positive $y$.
    The condition $0 <= phi <= pi/2$ restricts us to the region above $x y$-plane (points in the $x y$-plane has $phi = pi/2$).
    Hence, the region is the portion of the ball in the first octant.
    #figure(
      canvas({
        import cetz.draw: *
        ortho(x: -70deg, y: 0deg, z: -120deg, {
          line((0, 0, 0), (3, 0, 0), stroke: 1pt + gray, mark: (end: "straight"))
          content((3.2, 0, 0))[$x$]
          line((0, 0, 0), (0, 3, 0), stroke: 1pt + gray, mark: (end: "straight"))
          content((0, 3.2, 0))[$y$]
          line((0, 0, 0), (0, 0, 3), stroke: 1pt + gray)
          content((0, 0, 3.2))[$z$]

          let theta-divisions = 10
          let phi-divisions = 10

          let theta = nt.linspace(0, calc.pi/2, theta-divisions + 1)
          let phi = nt.linspace(0, calc.pi/2, phi-divisions + 1)

          let surface = theta.map(t => phi.map(p => spherical-param(2, t, p)))
          let normal = theta.map(t => phi.map(p => r-differential(2, t, p)))
          let intensities = normal.map(row => row.map(n => calculate-lighting(n)))
          let shaded-colors = intensities.map(row => row.map(i => shade-color(blue, i)))

          let wall1-top = phi.map(p => spherical-param(2, 0, p))
          let wall1-normal = (0, -1, 0)
          let wall1-intensities = calculate-lighting(wall1-normal)
          let wall1-shaded-colors = shade-color(blue, wall1-intensities)

          let wall2-top = phi.map(p => spherical-param(2, calc.pi/2, p))
          let wall2-normal = (-1, 0, 0)
          let wall2-intensities = calculate-lighting(wall2-normal)
          let wall2-shaded-colors = shade-color(blue, wall2-intensities)

          let wall3-top = theta.map(t => spherical-param(2, t, calc.pi/2))
          let wall3-normal = (0, 0, -1)
          let wall3-intensities = calculate-lighting(wall3-normal)
          let wall3-shaded-colors = shade-color(blue, wall3-intensities)

          for i in range(theta-divisions) {
            line(
              (0, 0, 0),
              wall3-top.at(i),
              wall3-top.at(i + 1),
              close: true,
              fill: wall3-shaded-colors.transparentize(50%),
              stroke: 0.1pt + wall3-shaded-colors,
            )
          }

          for j in range(phi-divisions) {
            line(
              (0, 0, 0),
              wall1-top.at(j),
              wall1-top.at(j + 1),
              close: true,
              fill: wall1-shaded-colors.transparentize(50%),
              stroke: 0.1pt + wall1-shaded-colors,
            )
            line(
              (0, 0, 0),
              wall2-top.at(j),
              wall2-top.at(j + 1),
              close: true,
              fill: wall2-shaded-colors.transparentize(50%),
              stroke: 0.1pt + wall2-shaded-colors,
            )
          }

          for i in range(theta-divisions) {
            for j in range(phi-divisions) {
              line(
                surface.at(i).at(j),
                surface.at(i + 1).at(j),
                surface.at(i + 1).at(j + 1),
                surface.at(i).at(j + 1),
                close: true,
                fill: shaded-colors.at(i).at(j).transparentize(50%),
                stroke: 0.1pt + shaded-colors.at(i).at(j),
              )
            }
          }
        })
      })
    )

  + Let us again consider $g_1(theta, phi)$ and $g_2(theta, phi)$ first.
    Since the cone starts from the origin, we have $g_1(theta, phi) = 0$.
    The equation $rho = g_2(theta, phi)$ describes the outer boundary of the cone, which in this casa is the top of the cone: the disk $x^2 + y^2 <= 12$ at height $z = 2$.
    A point on this disk satisfies
    $
      rho = 2/cos(phi)
    $
    based on the following sideway view of the cone.
    #figure(
      canvas({
        import cetz.draw: *
        import cetz.decorations: *
        line((0, 0), (0, 3), stroke: 1pt + gray, mark: (end: "straight"))
        content((0, 3.2))[$z$]

        let theta-divisions = 15
        let theta = nt.linspace(calc.pi/2, 3*calc.pi/2, theta-divisions + 1)
        let top = theta.map(t => spherical-param(2 / nt.cos(60deg), t, 60deg)).map(p => (p.at(1), p.at(2)))
        let normal = theta.map(t => nt.mult(-1, phi-differential(4, t, 60deg)))
        let intensities = normal.map(n => calculate-lighting(n))
        let shaded-colors = intensities.map(i => shade-color(blue, i))

        let p_phi = 30deg
        let _p = spherical-param(2 / nt.cos(p_phi), 0, p_phi)
        let p = (_p.at(0), _p.at(2))

        for i in range(theta-divisions) {
          line(
            (0, 0),
            top.at(i),
            top.at(i + 1),
            close: true,
            fill: shaded-colors.at(i).transparentize(50%),
            stroke: none,
          )
        }

        on-layer(1, {
          circle(p, radius: 2pt, fill: red, stroke: none)
          content((), anchor: "south", padding: (bottom: 2pt, left: 2), text(size: 8pt, red)[An arbitrary point on the disk])

          line((0, 0), p, stroke: 1pt + red)
          content(nt.mult(0.5, p), anchor: "west", padding: (left: 2pt), text(red)[$rho$])
          arc((0, 1), radius: 1, start: 90deg, delta: -p_phi, stroke: red, name: "phi")
          content("phi.arc-center", anchor: "south", padding: (bottom: 2pt), text(red)[$phi$])
          brace((0, 0), (0, 2))
          content((-0.2, 1), anchor: "east", padding: (right: 2pt), [$2$])
        })
      })
    )
    Thus, we know that $g_2(theta, phi) = 2 / cos(phi)$.
    It remains to find $alpha$, $beta$, $phi_1$, and $phi_2$ in
    $
      integral.triple_D 1 dd(V) = integral_alpha^beta integral_(phi_1)^(phi_2) integral_(0)^(2/cos(phi)) rho^2 sin(phi) dd(rho, phi, theta).
    $
    The bounds for $theta$ are $0 <= theta <= 2pi$ since the disk is a full circle around the $z$-axis.
    The bounds for $phi$ are $0 <= phi <= pi/3$ from the following sideway view of the cone (the radius of the disk is $sqrt(12)$, and we can find that on the boundary of the disk, we have $rho = 4$ giving us the classic 30-60-90 triangle).
    #figure(
      canvas({
        import cetz.draw: *
        import cetz.decorations: *
        line((0, 0), (0, 3), stroke: 1pt + gray, mark: (end: "straight"))
        content((0, 3.2))[$z$]

        let theta-divisions = 15
        let theta = nt.linspace(calc.pi/2, 3*calc.pi/2, theta-divisions + 1)
        let top = theta.map(t => spherical-param(2 / nt.cos(60deg), t, 60deg)).map(p => (p.at(1), p.at(2)))
        let normal = theta.map(t => nt.mult(-1, phi-differential(4, t, 60deg)))
        let intensities = normal.map(n => calculate-lighting(n))
        let shaded-colors = intensities.map(i => shade-color(blue, i))
        for i in range(theta-divisions) {
          line(
            (0, 0),
            top.at(i),
            top.at(i + 1),
            close: true,
            fill: shaded-colors.at(i).transparentize(50%),
            stroke: none,
          )
        }
        let p_phi = 60deg
        let _p = spherical-param(2 / nt.cos(p_phi), 0, p_phi)
        let p = (_p.at(0), _p.at(2))

        on-layer(1, {
          circle(p, radius: 2pt, fill: red, stroke: none)

          line((0, 0), p, stroke: 1pt + red)
          content(nt.mult(0.5, p), anchor: "west", padding: (left: 2pt, top: 5pt), text(red)[$4$])
          arc((0, 1), radius: 1, start: 90deg, delta: -p_phi, stroke: red, name: "phi")
          content("phi.arc-center", anchor: "south", padding: (bottom: 4pt), text(red)[$pi/3$])

          brace((0, 0), (0, 2))
          content((-0.2, 1), anchor: "east", padding: (right: 2pt), [$2$])
          brace((0, 2), (calc.sqrt(12), 2))
          content((calc.sqrt(12)/2, 2), anchor: "south", padding: (bottom: 8pt), [$sqrt(12)$])
        })
      })
    )
    Thus, the volume of the cone in spherical coordinates is given by
    $
      integral.triple_D 1 dd(V) = integral_0^(2pi) integral_0^(pi/3) integral_0^(2/cos(phi)) rho^2 sin(phi) dd(rho, phi, theta).
    $
]

= Midterm review

Observations from those of you that shown me your practice midterm:
1. You are all experts at computing iterated integrals.
2. Question 1c on describing a 3D region is the source of difficulty.

Here is the canonical answer to question what is the region whose volume is given by
$
  integral.double_R f(x, y) dd(A).
$
"It is the region above $R$ and below the surface $z = f(x, y)$ where $R$ is a triangle/rectangle/disk/half-disk/... in the $x y$-plane."
And you should give some quantitative description of $R$ as well, for example, if $R$ is a triangle, you might consider its vertices or if $R$ is a disk, you might consider its center and radius.
But this alone may or may not give you full credit, you should also attempt to describe the surface $z = f(x, y)$ more explicitly especially when it is a cone, a sphere, a plane, or a paraboloid revolved around the $z$-axis, etc.

Another approach is to describe the region holistically.
This is possible when the shape is simple enough like a tetrahedron or a cylinder, or perhaps the intersection of two simple shapes.
For example, maybe the region is the intersection of a cylinder and a ball (resulting in a pill shape).

To summarize, there are two approaches.
1. The canonical answer but you describe the region $R$ and the surface $z = f(x, y)$.
2. A holistic description of the region if it is a simple shape or the intersection of simple shapes.

The warm-up question for discussion 3, our previous discussion, is a modification of question 1c on the practice midterm, so I recommend you to take a look at that.

= Examples in the textbook

Let's take a guess on what's going to be on the midterm based on Professor Romik's announcement.
1. "There will be one question involving double integrals where you will need to evaluate at least one integral and answer related questions."
2. "There will be one question involving triple integrals."
3. "A third question will be based on one of the examples from the textbook sections we covered."

Based on this, I feel like the actual midterm will basically look exactly like the practice midterm with different functions and numbers.
I expect either question 1 or 2 will test your ability to *describe a region given an integral*, and the other question will test your ability to *set up an integral given a description of a region*.
Looking at the examples in the textbook, I see
- Examples 15.1.1 and 15.1.2: Extremely boring double integrals over rectangles.
- Examples 15.2.1 and 15.2.2: Double integrals over triangles.
- Examples 15.2.3 to 15.3.3: Double integral over strange shapes (often involves parabola) and we need figure out the bounds for Fubini's theorem.
- Examples 15.4.1 to 15.4.2: Double integrals over funny regions in polar coordinates.
- Examples 15.4.3 to 15.4.5: Double integrals in polar coordinates but we need to convert $x$ and $y$ to $r$ and $theta$.
- Example 15.5.2 and 15.5.3: Set up a triple integral over a tetrahedron.
- Example 15.5.4: Uh... too difficult to be on the midterm. (I think.)
- Example 15.5.5 to 15.6.4: Just integrals over box, paraboloid, triangle but with funny physics words (formula will be given on exam).
