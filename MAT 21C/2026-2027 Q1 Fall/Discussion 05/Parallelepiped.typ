#import "@preview/cetz:0.5.2" as cetz: canvas
#import "../Packages/lighting.typ": *
#import "@preview/numty:0.1.0" as nt
#set page(
  width: auto,
  height: auto,
  margin: (top: 5pt, left: 0.5pt, right: 0.5pt, bottom: 0.5pt),
  fill: white.transparentize(100%),
)
#set math.accent(dotless: false)

// #let perspective(FOVx: 90deg, FOVy: 70deg, near: 0.1, far: 1000) = {
//   return cetz.draw.set-transform((
//     (1 / calc.tan(FOVx / 2), 0, 0, 0),
//     (0, 1 / calc.tan(FOVy / 2), 0, 0),
//     (0, 0, -(far + near) / (far - near), -2 * (near * far) / (far - near)),
//     (0, 0, -1, 0),
//   ))
// }

#canvas(length: 2cm, {
  import cetz.draw: *
  perspective(x: -80deg, y: 0deg, z: -10deg, {
    let axis = line.with(stroke: 1pt + gray, fill: gray, mark: (end: (symbol: "straight", stroke: 1pt + gray)))
    axis((0, 0, 0), (4, 0, 0))
    content((4.1, 0, 0))[$x$]
    axis((0, 0, 0), (0, 4, 0))
    content((0, 4.5, 0))[$y$]
    axis((0, 0, 0), (0, 0, 3))
    content((0, 0, 3.1))[$z$]

    let a = (3, 0, 0)
    let a-label = $chevron(3\, 0\, 0)$
    let b = (1, 2, 0)
    let b-label = $chevron(1\, 2\, 0)$
    let c = (1, 1, 2)
    let c-label = $chevron(1\, 1\, 2)$

    let vector = line.with(stroke: 1.5pt + blue, fill: blue, mark: (end: (symbol: "straight", stroke: 1.5pt + blue)))
    vector((0, 0, 0), a, name: "a")
    vector((0, 0, 0), b, name: "b")
    content("a.mid", anchor: "north", padding: 5pt, a-label)
    content("b.end", anchor: "south", padding: 5pt, b-label)
    line(
      (0, 0, 0),
      a,
      nt.add(a, b),
      b,
      close: true,
      stroke: none,
      fill: blue.transparentize(80%),
    )

    let vector-c = line.with(stroke: 1.5pt + purple, fill: purple, mark: (end: (symbol: "straight", stroke: 1.5pt + purple)))
    vector-c((0, 0, 0), c, name: "c")
    content("c.end", anchor: "south", padding: 5pt, c-label)

    line(
      b,
      nt.add(b, c),
      stroke: (dash: "dashed", paint: purple),
    )

    line(
      (0, 0, 0),
      a,
      nt.add(a, c),
      c,
      close: true,
      stroke: none,
      fill: purple.transparentize(80%),
    )

    line(
      a,
      nt.add(a, c),
      stroke: (paint: purple),
    )

    line(
      nt.add(a, b),
      nt.add(a, nt.add(b, c)),
      stroke: (paint: purple),
    )

    line(
      a,
      nt.add(a, b),
      nt.add(a, nt.add(b, c)),
      nt.add(a, c),
      close: true,
      stroke: none,
      fill: purple.transparentize(80%),
    )

    line(
      c,
      nt.add(c, a),
      nt.add(c, nt.add(a, b)),
      nt.add(c, b),
      close: true,
      stroke: none,
      fill: blue.transparentize(80%),
    )
  })
})

