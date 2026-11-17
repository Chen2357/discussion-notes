#import "@preview/cetz:0.4.2" as cetz
#import "@preview/numty:0.1.0" as nt
#set page(width: auto, height: auto, margin: 0.5pt, fill: white.transparentize(100%))

#cetz.canvas(length: 2cm, {
  import cetz.draw: *

  let axis = line.with(stroke: 1pt + black, mark: (end: "straight"))
  let grid-line = line.with(stroke: 0.5pt + gray)

  let x-min = -0.5
  let x-max = 2.5
  let y-min = -0.5
  let y-max = 2.5

  axis((x-min, 0), (x-max, 0))
  content((x-max, 0), anchor: "north-east", padding: (top: 2pt))[#text(14pt, $x$)]
  axis((0, y-min), (0, y-max))
  content((0, y-max), anchor: "north-west", padding: (left: 4pt))[#text(14pt, $y$)]

  on-layer(-1, {
    for i in range(calc.ceil(x-min), calc.floor(x-max + 1)) {
      grid-line((i, y-min), (i, y-max))
    }

    for j in range(calc.ceil(y-min), calc.floor(y-max + 1)) {
      grid-line((x-min, j), (x-max, j))
    }
  })

  let p = (1, 1)
  let label = $(1, 1)$
  on-layer(1, {
    circle(p, radius: 3pt, fill: black, stroke: none)
    content(p, anchor: "north-west", padding: 5pt)[#text(14pt, label)]
  })

  let left = calc.max(x-min, y-min)
  let right = calc.min(x-max, y-max)
  line((left, left), (right, right), stroke: blue + 1.5pt)
  line((1, y-min), (1, y-max), stroke: red + 1.5pt)
})
