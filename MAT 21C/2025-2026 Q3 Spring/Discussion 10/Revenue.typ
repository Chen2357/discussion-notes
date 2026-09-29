#import "@preview/cetz:0.5.0" as cetz: canvas
#import "@preview/numty:0.1.0" as nt
#set page(
  width: auto,
  height: auto,
  margin: (top: 0.8pt, left: 0.8pt, right: 0.8pt, bottom: 0.8pt),
  fill: white.transparentize(100%),
)

#set math.accent(dotless: false)

#canvas(length: 0.5cm, {
  import cetz.draw: *

  let xmax = 11
  let ymax = 21

  let axis = line.with(stroke: black + 2pt, mark: (end: "stealth"))
  axis((0, 0), (xmax, 0))
  content((), anchor: "west", padding: (left: 2pt))[$x$]
  axis((0, 0), (0, ymax))
  content((), anchor: "south", padding: (bottom: 2pt))[$y$]

  let levels = (14, 32, 50, 68, 86, 104)
  let contours = levels.map(l =>
    nt.linspace(l / xmax, ymax, 100).map(y => (l / y, y))
  )

  for i in range(contours.len()) {
    line(..contours.at(i), stroke: gray + 1pt)
    content((xmax, levels.at(i) / xmax), anchor: "west", padding: (left: 2pt))[#set text(8pt); $#levels.at(i)$]
  }

  let constraint = nt.linspace(0, 10, 100).map(x => (x, 20 - 2 * x))
  line(..constraint, stroke: red + 3pt)

  let points = (
    (5, 10),
    (2, 16),
    (8, 4)
  )

  for point in points {
    circle(point, radius: 3pt, fill: red, stroke: none)
    on-layer(1, {
      line(point, (rel: nt.mult(1, (2, 1))), stroke: red + 1pt, fill: red, mark: (end: "stealth"))
      content(nt.sub(point, (0.2, 0.2)), anchor: "north-east", frame: "rect", stroke: none, fill: white, padding: 1pt)[#set text(8pt); $(#point.at(0), #point.at(1))$]
    })
    line(point, (rel: nt.mult(0.3, (point.at(1), point.at(0)))), stroke: blue + 1pt, fill: blue, mark: (end: "stealth"))
  }
})
