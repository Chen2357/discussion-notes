#import "@preview/cetz:0.5.0" as cetz: canvas
#import "../Template/lighting.typ": *
#import "@preview/numty:0.1.0" as nt
#set page(
  width: auto,
  height: auto,
  margin: (top: 5pt, left: 0.5pt, right: 0.8pt, bottom: 0.5pt),
  fill: white.transparentize(100%),
)

#set math.accent(dotless: false)

#canvas(length: 2cm, {
  import cetz.draw: *
  import cetz.decorations: *

  let a = (3, 0)
  let b = (1, 2)
  let vector(stroke: 1pt, ..args) = line(stroke: stroke, mark: (end: (symbol: "straight", stroke: stroke)), ..args)
  vector((0, 0), a, stroke: 1pt + blue)
  vector((0, 0), b, stroke: 1pt + blue)

  line(
    (0, 0),
    a,
    nt.add(a, b),
    b,
    close: true,
    stroke: blue,
  )
  on-layer(-1, {
    line(
      (0, 0),
      a,
      b,
      close: true,
      stroke: black,
      fill: blue.lighten(80%),
    )
  })
})

