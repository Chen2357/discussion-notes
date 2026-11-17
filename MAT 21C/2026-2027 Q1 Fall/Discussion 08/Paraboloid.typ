#import "@preview/cetz:0.5.2" as cetz: canvas
#import "../Packages/lighting.typ": *
#import "../Packages/split-quad.typ": *
#import "@preview/numty:0.1.0" as nt
#set page(
  width: auto,
  height: auto,
  margin: (top: 5pt, left: 0.5pt, right: 0.5pt, bottom: 7pt),
  fill: white.transparentize(100%),
)
#set math.accent(dotless: false)

#let f(r, theta) = {
  return (100 - r * r) * 0.10
}

#let f_x_y(x, y) = {
  return f(calc.sqrt(x * x + y * y), calc.atan2(y, x))
}

#let test-point = (-4.5, -3.2)
#let test-z = f_x_y(..test-point)

#let paraboloid = [
  #canvas(length: 0.45cm, {
    import cetz.draw: *
    perspective(x: -70deg, y: 0deg, z: -15deg, cull-face: "cw", {
      let axis = line.with(stroke: 1pt + gray, fill: gray, mark: (end: (symbol: "straight", stroke: 1pt + gray)))
      on-layer(-1, {
        axis((-13, 0, 0), (13, 0, 0))
        content((13.5, 0, 0))[#set text(20pt); $x$]
        axis((0, -13, 0), (0, 24, 0))
        content((0, 26, 0))[#set text(20pt); $y$]
        axis((0, 0, 0), (0, 0, 12.5))
        content((0, 0, 13.5))[#set text(20pt); $z$]
      })

      let r-space = nt.linspace(0, 10, 20)
      let theta-space = nt.linspace(0, 2 * calc.pi, 30)
      let z-values = r-space.map(r => theta-space.map(theta => f(r, theta)))
      let z-min = calc.min(..z-values.flatten())
      let z-max = calc.max(..z-values.flatten())
      let base-color-map = color.map.crest.rev()
      let z-color-step = (z-max - z-min) / (base-color-map.len() - 1)

      let color-map(z) = {
        let i = calc.floor((z - z-min) / z-color-step)
        return base-color-map.at(i)
      }

      for i in range(r-space.len() - 1) {
        for j in range(theta-space.len() - 1) {
          let z00 = z-values.at(i).at(j)
          let z01 = z-values.at(i).at(j + 1)
          let z10 = z-values.at(i + 1).at(j)
          let z11 = z-values.at(i + 1).at(j + 1)
          let color = color-map((z00 + z01 + z10 + z11) / 4)
          let p00 = (
            r-space.at(i) * calc.cos(theta-space.at(j)),
            r-space.at(i) * calc.sin(theta-space.at(j)),
            z00,
          )
          let p01 = (
            r-space.at(i) * calc.cos(theta-space.at(j + 1)),
            r-space.at(i) * calc.sin(theta-space.at(j + 1)),
            z01,
          )
          let p10 = (
            r-space.at(i + 1) * calc.cos(theta-space.at(j)),
            r-space.at(i + 1) * calc.sin(theta-space.at(j)),
            z10,
          )
          let p11 = (
            r-space.at(i + 1) * calc.cos(theta-space.at(j + 1)),
            r-space.at(i + 1) * calc.sin(theta-space.at(j + 1)),
            z11,
          )
          let (intersected, shapes) = split-quad-y(
            p00,
            p10,
            p11,
            p01,
            test-point.at(1),
          )
          if intersected {
            let center-y = (shapes.at(0).at(0).at(1) + shapes.at(0).at(1).at(1) + shapes.at(0).at(2).at(1)) / 3
            let layer = if center-y < test-point.at(1) { 2 } else { 0 }
            on-layer(layer, {
              line(
                ..shapes.at(0),
                close: true,
                stroke: none,
                fill: color,
              )
            })
            on-layer(2 - layer, {
              line(
                ..shapes.at(1),
                close: true,
                stroke: none,
                fill: color,
              )
            })
          } else {
            let layer = if p00.at(1) < test-point.at(1) { 2 } else { 0 }
            on-layer(layer, {
              line(
                p00,
                p10,
                p11,
                p01,
                close: true,
                stroke: none,
                fill: color,
              )
            })
          }
        }
      }

      on-layer(3, {
        on-perspective((..test-point, test-z), {
          circle((0, 0), radius: 4pt, fill: red, stroke: none)
          content((0, 0), anchor: "south-east", padding: 5pt)[#set text(25pt, red); $A$]
        })
        let y = test-point.at(1)
        let x = nt.linspace(-calc.sqrt(100 - y * y), calc.sqrt(100 - y * y), 40)
        let z = x.map(x => f_x_y(x, test-point.at(1)))
        line(
          ..array.zip(x, z).map(p => (p.at(0), test-point.at(1), p.at(1))),
          stroke: 2pt + red,
        )
      })

      on-layer(1, {
        line(
          (-12, test-point.at(1), 0),
          (13, test-point.at(1), 0),
          (13, test-point.at(1), 12.5),
          (-12, test-point.at(1), 12.5),
          close: true,
          fill: gray.transparentize(40%),
          stroke: none,
        )
      })
    })
  })
]

#let contour = [
  #canvas(length: 0.4cm, {
    import cetz.draw: *

    let axis = line.with(stroke: 1pt + gray, mark: (end: "straight"))
    let tick = line.with(stroke: 1pt + gray)
    axis((-11, 0), (11, 0))
    content((11, 0), anchor: "west", padding: 2pt, [#set text(18pt); $x$])
    axis((0, -11), (0, 11))
    content((0, 11), anchor: "south", padding: 2pt, [#set text(18pt); $y$])
    for i in range(-10, 11) {
      if i == 0 { continue }
      tick((i, -0.2), (i, 0.2))
      tick((-0.2, i), (0.2, i))
    }

    let values = (0, 25, 50, 75, 90)
    let radii = values.map(v => calc.sqrt(100 - v))
    for i in range(0, values.len()) {
      let r = radii.at(i)
      circle((0, 0), radius: r, stroke: 1.5pt)
      content(
        (r * calc.cos(-45deg), r * calc.sin(-45deg)),
        frame: "rect",
        stroke: none,
        fill: white,
        padding: 2pt,
        [#set text(12pt); $#values.at(i)$],
      )
    }

    circle((0, 0), radius: 4pt, fill: blue, stroke: none)
    content((0, 0), anchor: "north-west", padding: 5pt, [#set text(12pt, blue); $100$])

    circle(test-point, radius: 3.5pt, fill: red, stroke: none)
    content(test-point, anchor: "north", padding: 7pt, [#set text(28pt, red); $A$])

    line(
      (-11, test-point.at(1)),
      (11, test-point.at(1)),
      stroke: 2.5pt + red,
    )
  })
]

#let intersection = [
  #canvas(length: 0.4cm, {
    import cetz.draw: *

    let axis = line.with(stroke: 1pt + gray, mark: (end: "straight"))
    axis((-11, 0), (11, 0))
    content((11, 0), anchor: "west", padding: 2pt, [#set text(18pt); $x$])
    axis((0, -5), (0, 11))
    content((0, 11), anchor: "south", padding: 2pt, [#set text(18pt); $z$])

    let y = test-point.at(1)
    let x = nt.linspace(-11, 11, 40)
    let z = x.map(x => f_x_y(x, test-point.at(1)))

    line(
      ..array.zip(x, z),
      stroke: 1.5pt + red,
    )
    circle((test-point.at(0), test-z), radius: 3.5pt, fill: red, stroke: none)
    content((test-point.at(0), test-z), anchor: "south-east", padding: 7pt, [#set text(28pt, red); $A$])
  })
]

#context {
  grid(
    columns: (
      measure(contour).width,
      measure(paraboloid).width,
      measure(intersection).width,
    ),
    align: center + horizon,
    row-gutter: 0.6em,
    column-gutter: 2em,
    contour, paraboloid, intersection,
    grid.cell(align: center + top)[#set text(24pt); Level curves of $f(x, y)$],
    grid.cell(align: center + top)[#set text(24pt); Intersection between the graph of $f(x, y)$ and a plane],
    grid.cell(align: center + top)[#set text(24pt); The function $f(x, y)$ in $x$ with a fixed $y$],
  )
}
