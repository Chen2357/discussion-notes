#import "../Discussion.typ": *
#import "../lighting.typ": *

#show: discussion.with(
  number: 9,
  date: datetime(year: 2026, month: 3, day: 5),
)

= Warm-Up

#exercise[
  Let $R$ be a region in the $u v$-plane.
  Discuss in groups, why a function of the form
  $
    bf(r)(u, v) = f(u, v) bf(i) + g(u, v) bf(j) + h(u, v) bf(k) quad "where" quad (u, v) in R
  $
  represents a surface in $RR^3$.

  Draw a picture illustrating the quantities
  $
    bf(r)_u = pdv(bf(r), u) quad "and" quad bf(r)_v = pdv(bf(r), v)
  $
  and show them to your group.
]
#solution[
  For each point $(u, v)$ in $R$, the function $bf(r)(u, v)$ gives us a point in $RR^3$ by evaluating the scalar functions $f(u, v)$, $g(u, v)$, and $h(u, v)$ and using them as the coefficients of the standard unit vectors $bf(i)$, $bf(j)$, and $bf(k)$.
  A surface worth of points in $R$ will be mapped to a surface worth of points in $RR^3$, and in this way the function $bf(r)(u, v)$ represents a surface in $RR^3$.
  #figure(
    canvas(length: 2cm, {
      import cetz.draw: *
      let u-min = 0
      let u-max = 1.5
      let v-min = 0
      let v-max = 1.5

      let axis = line.with(stroke: 1pt + gray, mark: (end: "straight"))

      axis((u-min, v-min), (u-max, v-min))
      content((), anchor: "west", padding: (left: 3pt))[$u$]
      axis((u-min, v-min), (u-min, v-max))
      content((), anchor: "south", padding: (bottom: 3pt))[$v$]

      line((0, 0), (1, 0), (1, 1), (0, 1), close: true, stroke: 0.5pt)
      content((1, 1), anchor: "south-west", padding: 3pt)[$R$]

      let u-num = 10
      let v-num = 10
      for u in nt.linspace(0, 1, u-num + 1) {
        for v in nt.linspace(0, 1, v-num + 1) {
          circle((u, v), radius: 0.02, fill: red, stroke: none)
        }
      }

      let x(u, v) = u
      let y(u, v) = v
      let z(u, v) = 3 - u * u - v
      let r(u, v) = (x(u, v), y(u, v), z(u, v))
      let normal(u, v) = (-2 * u, 1, 1)

      let xs = nt.linspace(0, 1, u-num + 1).map(u => nt.linspace(0, 1, v-num + 1).map(v => x(u, v)))
      let ys = nt.linspace(0, 1, u-num + 1).map(u => nt.linspace(0, 1, v-num + 1).map(v => y(u, v)))
      let zs = nt.linspace(0, 1, u-num + 1).map(u => nt.linspace(0, 1, v-num + 1).map(v => z(u, v)))
      let normals = nt.linspace(1 / (2 * u-num), 1 - 1 / (2 * u-num), u-num).map(u => nt.linspace(1 / (2 * u-num), 1 - 1 / (2 * u-num), v-num).map(v => normal(u, v)))
      let intensities = normals.map(row => row.map(n => calculate-lighting(n)))
      let shaded-colors = intensities.map(row => row.map(i => shade-color(blue, i)))

      bezier((1.5, 1.5), (4, 2.5), (2.5, 3), mark: (end: "straight"))
      content((2.8, 2.2))[$bf(r)(u, v)$]

      translate((u-max + 3, 0))

      ortho(x: -70deg, y: 0deg, z: -120deg, {
        line((0, 0, 0), (2, 0, 0), stroke: 1pt + gray, mark: (end: "straight"))
        content((2.2, 0, 0))[$x$]
        line((0, 0, 0), (0, 2, 0), stroke: 1pt + gray, mark: (end: "straight"))
        content((0, 2.2, 0))[$y$]
        line((0, 0, 0), (0, 0, 3), stroke: 1pt + gray)
        content((0, 0, 3.2))[$z$]

        for i in range(u-num) {
          for j in range(v-num) {
            line(
              (xs.at(i).at(j), ys.at(i).at(j), zs.at(i).at(j)),
              (xs.at(i + 1).at(j), ys.at(i + 1).at(j), zs.at(i + 1).at(j)),
              (xs.at(i + 1).at(j + 1), ys.at(i + 1).at(j + 1), zs.at(i + 1).at(j + 1)),
              (xs.at(i).at(j + 1), ys.at(i).at(j + 1), zs.at(i).at(j + 1)),
              close: true,
              fill: shaded-colors.at(i).at(j).transparentize(50%),
              stroke: 0.1pt + shaded-colors.at(i).at(j),
            )
          }
        }
        on-layer(1, {
          for i in range(u-num + 1) {
            for j in range(v-num + 1) {
              circle((xs.at(i).at(j), ys.at(i).at(j), zs.at(i).at(j)), radius: 0.03, fill: red, stroke: none)
            }
          }
        })
      })
    }),
    caption: [
      Illustration of the surface parameterized by $bf(r)(u, v)$.
      Each point in $R$ gets mapped to a point on the surface.
      A grid of points get mapped to a grid of points.
      A surface worth of points get mapped to a surface worth of points.
    ]
  )

  #figure(
    canvas(length: 2cm, {
      import cetz.draw: *
      let u-min = 0
      let u-max = 1.5
      let v-min = 0
      let v-max = 1.5

      let axis = line.with(stroke: 1pt + gray, mark: (end: "straight"))

      axis((u-min, v-min), (u-max, v-min))
      content((), anchor: "west", padding: (left: 3pt))[$u$]
      axis((u-min, v-min), (u-min, v-max))
      content((), anchor: "south", padding: (bottom: 3pt))[$v$]

      line((0, 0), (1, 0), (1, 1), (0, 1), close: true, stroke: 0.5pt)
      content((1, 1), anchor: "south-west", padding: 3pt)[$R$]

      let base-u = 0.5
      let base-v = 0.5
      circle((base-u, base-v), radius: 0.02, fill: red, stroke: none)

      line((base-u, base-v), (base-u + 0.3, base-v), stroke: 0.6pt + purple, mark: (end: "straight"))
      line((base-u, base-v), (base-u, base-v + 0.3), stroke: 0.6pt + red, mark: (end: "stealth"), fill: red)

      let u-num = 10
      let v-num = 10

      let x(u, v) = u
      let y(u, v) = v
      let z(u, v) = 3 - u * u - v
      let r(u, v) = (x(u, v), y(u, v), z(u, v))
      let normal(u, v) = (-2 * u, 1, 1)

      let xs = nt.linspace(0, 1, u-num + 1).map(u => nt.linspace(0, 1, v-num + 1).map(v => x(u, v)))
      let ys = nt.linspace(0, 1, u-num + 1).map(u => nt.linspace(0, 1, v-num + 1).map(v => y(u, v)))
      let zs = nt.linspace(0, 1, u-num + 1).map(u => nt.linspace(0, 1, v-num + 1).map(v => z(u, v)))
      let normals = nt.linspace(1 / (2 * u-num), 1 - 1 / (2 * u-num), u-num).map(u => nt.linspace(1 / (2 * u-num), 1 - 1 / (2 * u-num), v-num).map(v => normal(u, v)))
      let intensities = normals.map(row => row.map(n => calculate-lighting(n)))
      let shaded-colors = intensities.map(row => row.map(i => shade-color(blue, i)))

      bezier((1.5, 1.5), (4, 2.5), (2.5, 3), mark: (end: "straight"))
      content((2.8, 2.2))[$bf(r)(u, v)$]

      translate((u-max + 3, 0))

      ortho(x: -70deg, y: 0deg, z: -120deg, {
        line((0, 0, 0), (2, 0, 0), stroke: 1pt + gray, mark: (end: "straight"))
        content((2.2, 0, 0))[$x$]
        line((0, 0, 0), (0, 2, 0), stroke: 1pt + gray, mark: (end: "straight"))
        content((0, 2.2, 0))[$y$]
        line((0, 0, 0), (0, 0, 3), stroke: 1pt + gray, mark: (end: "straight"))
        content((0, 0, 3.2))[$z$]

        for i in range(u-num) {
          for j in range(v-num) {
            line(
              (xs.at(i).at(j), ys.at(i).at(j), zs.at(i).at(j)),
              (xs.at(i + 1).at(j), ys.at(i + 1).at(j), zs.at(i + 1).at(j)),
              (xs.at(i + 1).at(j + 1), ys.at(i + 1).at(j + 1), zs.at(i + 1).at(j + 1)),
              (xs.at(i).at(j + 1), ys.at(i).at(j + 1), zs.at(i).at(j + 1)),
              close: true,
              fill: shaded-colors.at(i).at(j).transparentize(50%),
              stroke: 0.1pt + shaded-colors.at(i).at(j),
            )
          }
        }

        on-layer(1, {
          circle((r(base-u, base-v)), radius: 0.03, fill: red, stroke: none)
          line((r(base-u, base-v)), (rel: nt.mult(0.5, (1, 0, -2 * base-u))), stroke: 0.6pt + purple, mark: (end: "straight"))
          line((r(base-u, base-v)), (rel: nt.mult(0.5, (0, 1, -1))), stroke: 0.6pt + red, mark: (end: "stealth"), fill: red)
        })
      })
    }),
    caption: [
      Illustration of the vectors $bf(r)_u$ and $bf(r)_v$ at a point on the surface.
      They are tangent to the surface and they point in the direction of how the image point $bf(r)(u,v)$ will move if we increase $u$ or $v$ respectively.
      The tangent vector $bf(r)_u$ is shown in purple, and the tangent vector $bf(r)_v$ is shown in red.
    ]
  )
]

= Surface integral of a scalar function

#theorem[
  If $S$ is a surface parameterized by
  $
    bf(r)(u, v) = f(u, v) bf(i) + g(u, v) bf(j) + h(u, v) bf(k) quad "where" quad (u, v) in R
  $
  for some region $R$ in the $u v$-plane, then the surface integral of a scalar function $G(x, y, z)$ over $S$ is given by
  $
    integral.double_S G(x, y, z) dd(sigma) = integral.double_R G(bf(r)(u, v)) abs(bf(r)_u times bf(r)_v) dd(u, v).
  $
  Here, $G(bf(r)(u, v))$ is the expression obtained by substituting $x = f(u, v)$, $y = g(u, v)$, and $z = h(u, v)$ into $G(x, y, z)$.
]

Like the formula for line integrals over parameterized curves which implies that different parameterization of the same curve give the same line integral.
The above formula for surface integrals implies that different parameterization of the same surface give the same surface integral.
After all, the surface integral
$
  integral.double_S G(x, y, z) dd(sigma)
$
is only dependent on the surface $S$ and the scalar function $G(x, y, z)$, and it makes sense regardless of whether $S$ comes with a parameterization or not.

#exercise[
  #text(dark-magenta)[(Exercise 16.6.5)]
  Let $S$ be the surface parameterized by
  $
    bf(r)(u, v) = u bf(i) + v bf(j) + (4 - u - v) bf(k) quad "where" quad (u, v) in R
  $
  for the standard unit square $R$ in the first quadrant of the $u v$-plane.
  + Draw a picture of the surface $S$.
  + Rewrite the surface integral
    $
      integral.double_S z dd(sigma)
    $
    as an iterated integral in $dd(u, v)$.
    #h(100%)
  + Discuss with your group if the surface $S$ is instead described as: the portion of the plane
    $ x + y + z = 4 $
    that lies above the square $0 <= x <= 1$, $0 <= y <= 1$ in the $x y$-plane, how would you derive the same parameterization as above?
]
#solution[
  + We can reexpress as the parameterization just by changing the variable names from $u$ and $v$ to $x$ and $y$:
    $
      bf(r)(x, y) = x bf(i) + y bf(j) + (4 - x - y) bf(k) quad "where" quad 0 <= x <= 1, 0 <= y <= 1.
    $
    This makes it clear that the surface $S$ is the graph of the function $h(x, y) = 4 - x - y$ over the square $0 <= x <= 1$, $0 <= y <= 1$ in the $x y$-plane.
    We can also figure out the corners of the surface $S$ by plugging in the corners of the square $R$ into the parameterization:
    $
      bf(r)(0, 0) = (0, 0, 4), quad bf(r)(1, 0) = (1, 0, 3), \
      bf(r)(0, 1) = (0, 1, 3), quad bf(r)(1, 1) = (1, 1, 2).
    $
    #figure(
      canvas({
        import cetz.draw: *
        let x(u, v) = u
        let y(u, v) = v
        let z(u, v) = 4 - u - v
        let r(u, v) = (x(u, v), y(u, v), z(u, v))

        ortho(x: -70deg, y: 0deg, z: -120deg, {
          line((0, 0, 0), (2, 0, 0), stroke: 1pt + gray, mark: (end: "straight"))
          content((2.2, 0, 0))[$x$]
          line((0, 0, 0), (0, 2, 0), stroke: 1pt + gray, mark: (end: "straight"))
          content((0, 2.2, 0))[$y$]
          line((0, 0, 0), (0, 0, 4.2), stroke: 1pt + gray, mark: (end: "straight"))
          content((0, 0, 4.4))[$z$]

          line(
            r(0, 0),
            r(1, 0),
            r(1, 1),
            r(0, 1),
            close: true,
            fill: blue.transparentize(50%),
            stroke: blue,
          )
        })
      }),
      caption: [
        Picture of the surface $S$.
        The surface is a portion of the plane $x + y + z = 4$ that lies above the unit square $R$ in the $x y$-plane.
        The corners of the surface are $(0, 0, 4)$, $(1, 0, 3)$, $(0, 1, 3)$, and $(1, 1, 2)$.
      ]
    )
  + We need to express $z$ in terms of $u$ and $v$ and compute $abs(bf(r)_u times bf(r)_v)$.
    Looking at the parameterization, we see that
    $
      z = 4 - u - v
    $
    because $4 - u - v$ is $h(u, v)$ (the $bf(k)$-component of $bf(r)(u, v)$) in the above theorem.
    Next, we compute $bf(r)_u$ and $bf(r)_v$, which are
    $
      bf(r)_u = pdv(bf(r), u) = bf(i) - bf(k) quad "and" quad bf(r)_v = pdv(bf(r), v) = bf(j) - bf(k).
    $
    Taking the cross product, we get
    $
      bf(r)_u times bf(r)_v = mat(delim: "|",
        bf(i), bf(j), bf(k);
        1, 0, -1;
        0, 1, -1
      )
      =
      bf(i) + bf(j) + bf(k).
    $
    I also recommend doing the long multiplication directly instead of using the determinant formula like so:
    #figure(
      table(
        columns: (auto, auto, auto, auto),
        stroke: none,
        [], $bf(i)$, [], $-bf(k)$,
        [$times$], [], $bf(j)$, $-bf(k)$,
        table.hline(),
        [], [], $bf(j)$, [],
        [], $bf(i)$, [], $+bf(k)$,
        table.hline(),
        [], $bf(i)$, $+bf(j)$, $+bf(k)$,
      ),
      caption: [
        Long multiplication of $(bf(i) - bf(k)) times (bf(j) - bf(k))$.
        The first row under the first line is the result of taking the cross product of $bf(i)$ and $-bf(k)$ with $-bf(k)$, noting that $bf(i) times bf(k) = -bf(j)$ and $bf(k) times bf(k) = 0$.
        The second row under the first line is the result of taking the cross product of $bf(i)$ and $-bf(k)$ with $bf(j)$, noting that $bf(i) times bf(j) = bf(k)$ and $bf(k) times bf(j) = -bf(i)$.
        The final line is the sum of the two rows.
      ]
    )
    Thus, $abs(bf(r)_u times bf(r)_v) = sqrt(3)$.
    Therefore, the surface integral is
    $
      integral.double_S z dd(sigma) = integral.double_R (4 - u - v) sqrt(3) dd(u, v) = integral_0^1 integral_0^1 (4 - u - v) sqrt(3) dd(u, v).
    $
  + We will derive the same parameterization by solving for $z$ in terms of $x$ and $y$ for points on the surface.
    The equation of the plane can be rearranged to get
    $
      z = 4 - x - y.
    $
    Thus, the surface $S$ can be parameterized by
    $
      bf(r)(x, y) = x bf(i) + y bf(j) + (4 - x - y) bf(k) quad "where" quad 0 <= x <= 1, 0 <= y <= 1.
    $
    This is the same parameterization as above, just with different variable names.
]

#exercise[
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
#solution[
  + While the surface $S$ cannot be described as a graph of a function in $x$ and $y$ (does not pass the vertical line test), it can be described as a graph of a function in $x$ and $z$ (or in $y$ and $z$).
    For example, the $y$ value of a point on the surface is uniquely determined by $x$ and $z$, and we can see this by rearranging the equation of the plane to get
    $
      y = 1 - x.
    $
    Thus, the surface $S$ can be parameterized by
    $
      bf(r)(x, z) = x bf(i) + (1 - x) bf(j) + z bf(k) quad "where" quad 0 <= x <= 1, 0 <= z <= 1.
    $
    Next, we calculate
    $
      bf(r)_x = pdv(bf(r), x) = bf(i) - bf(j) quad "and" quad bf(r)_z = pdv(bf(r), z) = bf(k).
    $
    Therefore, we have
    $
      bf(r)_x times bf(r)_z = (bf(i) - bf(j)) times bf(k) = bf(i) times bf(k) - bf(j) times bf(k) = -bf(j) - bf(i),
    $
    and so $abs(bf(r)_x times bf(r)_z) = sqrt(2)$.
    Finally, the surface integral is
    $
      integral.double_S (x - y - z) dd(sigma) = integral_0^1 integral_0^1 (x - (1 - x) - z) sqrt(2) dd(x, z).
    $
  + One way is to parameterize the sphere is with spherical coordinates
    $
      bf(r)(phi, theta) = sin(phi) cos(theta) bf(i) + sin(phi) sin(theta) bf(j) + cos(phi) bf(k) quad "where" quad 0 <= phi <= pi/2, 0 <= theta <= pi/2.
    $
    Next, we calculate
    $
      bf(r)_phi &= pdv(bf(r), phi) = cos(phi) cos(theta) bf(i) + cos(phi) sin(theta) bf(j) - sin(phi) bf(k), \
      bf(r)_theta &= pdv(bf(r), theta) = -sin(phi) sin(theta) bf(i) + sin(phi) cos(theta) bf(j).
    $
    Taking the cross product, we get
    #figure(
      table(
        columns: (auto, auto, auto, auto),
        stroke: none,
        [], $cos(phi) cos(theta) bf(i)$, $+cos(phi) sin(theta) bf(j)$, $-sin(phi) bf(k)$,
        [$times$], $-sin(phi) sin(theta) bf(i)$, $+sin(phi) cos(theta) bf(j)$, [],
        table.hline(),
        [], $sin^2(phi) cos(theta) bf(i)$, [], $+cos(phi) sin(phi) cos^2(theta) bf(k)$,
        [], [], $sin^2(phi) sin(theta) bf(j)$, $+cos(phi) sin(phi) sin^2(theta) bf(k)$,
        table.hline(),
        [], $sin^2(phi) cos(theta) bf(i)$, $+sin^2(phi) sin(theta) bf(j)$, $+cos(phi) sin(phi) bf(k)$
      )
    )
    and so $bf(r)_phi times bf(r)_theta = sin^2(phi) cos(theta) bf(i) + sin^2(phi) sin(theta) bf(j) + cos(phi) sin(phi) bf(k)$.
    Thus, we have
    $
      abs(bf(r)_phi times bf(r)_theta) &= sqrt(sin^4(phi) cos^2(theta) + sin^4(phi) sin^2(theta) + sin^2(phi) cos^2(phi)) \
      &= sqrt(sin^4(phi) + sin^2(phi) cos^2(phi)) \
      &= sin(phi).
    $
    Finally, the surface integral is
    $
      integral.double_S (x - y - z) dd(sigma) = integral_0^(pi/2) integral_0^(pi/2) (sin(phi) cos(theta) - sin(phi) sin(theta) - cos(phi)) sin(phi) dd(phi, theta).
    $
]

= Surface integral of a vector field

#theorem[
  If $S$ is a (oriented) surface parameterized by
  $
    bf(r)(u, v) = f(u, v) bf(i) + g(u, v) bf(j) + h(u, v) bf(k) quad "where" quad (u, v) in R
  $
  for some region $R$ in the $u v$-plane, then the surface integral of a vector field $bf(G)(x, y, z)$ is given by
  $
    integral.double_S bf(G)(x, y, z) dot bf(n) dd(sigma) = integral.double_R bf(G)(bf(r)(u, v)) dot (plus.minus (bf(r)_u times bf(r)_v)) dd(u, v).
  $
  The plus or minus sign is chosen so that $bf(n)$ points in the same direction as $plus.minus (bf(r)_u times bf(r)_v)$.
  Also, $bf(G)(bf(r)(u, v))$ is the expression obtained by substituting $x = f(u, v)$, $y = g(u, v)$, and $z = h(u, v)$ into $bf(G)(x, y, z)$.
]

The surface integral of a vector field gets us a step closer to completing the analysis of integrations on 3-dimensional space.

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
    padded-content((2 * x, -y), name: "t21")[$display(integral.double_S bf(G) dot bf(n) dd(sigma))$]
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

#exercise[
  Let $S$ be the portion of the plane $x + y = 1$ in the first octant between $z = 0$ and $z = 1$ in the direction away from the $z$-axis (the same surface as in the previous exercise).
  Let
  $
    bf(G)(x, y, z) = x bf(i) + y bf(j).
  $
  Let $bf(r)(u, v)$ be the parameterization of $S$ that you found in the previous exercise (you may use different symbols than $u$ and $v$).
  + Use picture and *not calculation* to decide which sign to use so that $plus.minus (bf(r)_u times bf(r)_v)$ points in the same direction as $bf(n)$.
    Discuss with your group if you do not know how to do it with pictures.
  + Find $bf(G)(bf(r)(u, v))$.
  + Calculate the surface integral
    $
      integral.double_S bf(G)(x, y, z) dot bf(n) dd(sigma).
    $
]
#solution[
  We can just reuse the parameterization
    $
      bf(r)(x, z) = x bf(i) + (1 - x) bf(j) + z bf(k) quad "where" quad 0 <= x <= 1, 0 <= z <= 1.
    $
    #h(100%)
  + The following figure shows $bf(r)_x$ and $bf(r)_z$ and their cross product $bf(r)_x times bf(r)_z$.
    #figure(
      canvas(length: 2cm, {
        import cetz.draw: *

        ortho(x: -70deg, y: 0deg, z: -120deg, {
          on-layer(-1, {
            line((0, 0, 0), (2, 0, 0), stroke: 1pt + gray, mark: (end: "straight"))
            content((2.2, 0, 0))[$x$]
            line((0, 0, 0), (0, 2, 0), stroke: 1pt + gray, mark: (end: "straight"))
            content((0, 2.2, 0))[$y$]
            line((0, 0, 0), (0, 0, 1.6), stroke: 1pt + gray, mark: (end: "straight"))
            content((0, 0, 1.8))[$z$]
          })

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

          on-layer(1, {
            line(
              (0.3, 0.7, 0.3),
              (rel: nt.mult(0.8, (0.5, -0.5, 0))),
              stroke: 0.6pt + purple,
              mark: (end: "straight"),
            )
            content((), anchor: "east")[$bf(r)_x$]

            line(
              (0.3, 0.7, 0.3),
              (rel: nt.mult(0.8, (0, 0, 1))),
              stroke: 0.6pt + red,
              mark: (end: "stealth"),
              fill: red,
            )
            content((), anchor: "north-west")[$bf(r)_z$]
          })

          line(
            (0.3, 0.7, 0.3),
            (rel: nt.mult(0.8, (-1, -1, 0))),
            stroke: 0.6pt + orange,
            mark: (end: "stealth"),
            fill: orange,
          )
          content((), anchor: "east")[$bf(r)_x times bf(r)_z$]
        })
      }),
      caption: [
        The tangent vector $bf(r)_x$ is found by letting $x$ increase while keeping $z$ fixed, and the tangent vector $bf(r)_z$ is found by letting $z$ increase while keeping $x$ fixed.
        Their cross product $bf(r)_x times bf(r)_z$ is found by the right hand rule.
      ]
    )
    We see that $bf(r)_x times bf(r)_z$ points in the direction towards the $z$-axis, and so it points in the opposite direction of $bf(n)$, which points away from the $z$-axis.
    Therefore, the sign should be $-(bf(r)_x times bf(r)_z)$.
  + We have
    $
      bf(G)(bf(r)(x, z)) = x bf(i) + (1 - x) bf(j).
    $
  + We have already computed $bf(r)_x times bf(r)_z$ in the previous exercise, and it is $-bf(j) - bf(i)$.
    Therefore, we have
    $
      bf(G)(bf(r)(x, z)) dot (minus (bf(r)_x times bf(r)_z)) = (x bf(i) + (1 - x) bf(j)) dot (bf(j) + bf(i)) = x + (1 - x) = 1.
    $
    Finally, the surface integral is
    $
      integral.double_S bf(G)(x, y, z) dot bf(n) dd(sigma) = integral_0^1 integral_0^1 1 dd(x, z) = 1.
    $
]
