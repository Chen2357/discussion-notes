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
  let v = (3, 2)
  let vector(stroke: 1pt, ..args) = line(stroke: stroke, mark: (end: (symbol: "straight", stroke: stroke)), ..args)
  vector((0, 0), v, stroke: 1pt + blue)
  vector((0, 0), (v.at(0), 0), stroke: 1pt + blue.darken(30%))
  vector((0, 0), (1, 0))

  content((0.5, 0), anchor: "south", padding: (bottom: 2pt), [$hat(i)$])
  content(nt.mult(v, 0.5), anchor: "south", padding: (bottom: 4pt, right: 4pt), [#set text(blue); $arrow(a)$])
  content((v.at(0) * 0.66, 0), anchor: "south", padding: (bottom: 4pt, right: 4pt), [#set text(blue.darken(30%)); Projection of $arrow(a)$ onto $hat(i)$])

  let aux = line.with(stroke: (thickness: 1pt, paint: gray, dash: "dashed"))
  aux((v.at(0), 0), v)
  brace((v.at(0), 0), (0, 0), name: "b")
  content("b.spike", anchor: "north", padding: (top: 2pt), [$arrow(a) dot.c hat(i)$])
})
