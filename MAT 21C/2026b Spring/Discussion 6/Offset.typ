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

#canvas(length: 1cm, {
  import cetz.draw: *
  import cetz.decorations: *

  let y = calc.sqrt(6)
  let d = 5 / calc.sqrt(6)
  let r = -3

  let vector(stroke: 1pt, ..args) = line(stroke: stroke, mark: (end: (symbol: "straight", stroke: stroke)), ..args)
  vector((0, 0), (0, y))
  content((0, y), anchor: "west", padding: (left: 2pt), [$chevron.l 2, 1, -1 chevron.r$])
  line((-r, d), (r, d), stroke: 2pt + red)
  
  brace((0, d), (0, 0), name: "b")
  content("b.spike", anchor: "west", padding: (left: 2pt), [$5/sqrt(6)$])
})
  
