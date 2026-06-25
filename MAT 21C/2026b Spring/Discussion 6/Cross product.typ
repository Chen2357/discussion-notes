#import "@preview/cetz:0.5.2" as cetz: canvas
#import "../Template/lighting.typ": *
#import "@preview/numty:0.1.0" as nt
#set page(
  width: auto,
  height: auto,
  margin: (top: 5pt, left: 0.5pt, right: 0.5pt, bottom: 0.5pt),
  fill: white.transparentize(100%),
)
#set math.accent(dotless: false)

#canvas(length: 2cm, {
  import cetz.draw: *
  ortho(x: -8deg, y: 2deg, z: -0.8deg, {
    let axis = line.with(stroke: 1pt + gray, fill: gray, mark: (end: (symbol: "straight", stroke: 1pt + gray)))
    axis((0, 0, 0), (4, 0, 0))
    content((4.1, 0, 0))[$x$]
    axis((0, 0, 0), (0, 2, 0))
    content((0, 2.1, 0))[$y$]
    axis((0, 0, 0), (0, 0, 8))
    content((0, 0, 8.8))[$z$]

    let vector = line.with(stroke: 1.5pt + blue, fill: blue, mark: (end: (symbol: "straight", stroke: 1.5pt + blue)))
    vector((0, 0, 0), (3, 0, 0), name: "a")
    vector((0, 0, 0), (1, 2, 0), name: "b")
    content("a.mid", angle: (3, 0, 0), anchor: "north", padding: 5pt, $3 hat(i)$)
    content("b.mid", angle: (1, 2, 0), anchor: "south", padding: 5pt, $hat(i) + 2 hat(j)$)
    line(
      (0, 0, 0),
      (3, 0, 0),
      (4, 2, 0),
      (1, 2, 0),
      close: true,
      stroke: none,
      fill: blue.transparentize(80%),
    )

    let result-vector = line.with(stroke: 1.5pt + red, fill: red, mark: (end: (symbol: "straight", stroke: 1.5pt + red)))
    result-vector((0, 0, 0), (0, 0, 6))
    content((0, 0, 3), anchor: "east", padding: 5pt, $6 hat(k)$)
  })
})

