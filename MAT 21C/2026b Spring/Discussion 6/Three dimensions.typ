#import "@preview/cetz:0.5.0" as cetz: canvas
#import "../Template/lighting.typ": *
#import "@preview/numty:0.1.0" as nt
#set page(
  width: auto,
  height: auto,
  margin: (top: 5pt, left: 0.5pt, right: 0.5pt, bottom: 0.5pt),
  fill: white.transparentize(100%),
)

#canvas(length: 2cm, {
  import cetz.draw: *
  ortho(x: -70deg, y: 0deg, z: -120deg, {
    let axis = line.with(stroke: 1pt + gray, fill: gray, mark: (end: (symbol: "straight", stroke: 1pt + gray)))
    axis((0, 0, 0), (2, 0, 0))
    content((2.2, 0, 0))[$x$]
    axis((0, 0, 0), (0, 2, 0))
    content((0, 2.2, 0))[$y$]
    axis((0, 0, 0), (0, 0, 2))
    content((0, 0, 2.2))[$z$]
  })
})
