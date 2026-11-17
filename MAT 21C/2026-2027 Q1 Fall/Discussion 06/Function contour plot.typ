#import "@preview/cetz:0.5.0" as cetz: canvas
#import "@preview/numty:0.1.0" as nt
#set page(
  width: auto,
  height: auto,
  margin: (top: 0.8pt, left: 0.8pt, right: 0.8pt, bottom: 0.8pt),
  fill: white.transparentize(100%),
)

#set math.accent(dotless: false)

#canvas(length: 0.8cm, {
  import cetz.draw: *

  let axis = line.with(stroke: 1pt + gray, mark: (end: "straight"))
  let tick = line.with(stroke: 1pt + gray)
  axis((-11, 0), (11, 0))
  content((11, 0), anchor: "west", padding: 2pt, [#set text(20pt); $x$])
  axis((0, -11), (0, 11))
  content((0, 11), anchor: "south", padding: 2pt, [#set text(20pt); $y$])
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
    // content(label.point, frame: "rect", padding: 1pt, stroke: none, fill: white, [#label.height])
    content((r * calc.cos(-45deg), r * calc.sin(-45deg)), frame: "rect", stroke: none, fill: white, padding: 2pt, [#set text(20pt); $#values.at(i)$])
  }

  circle((0, 0), radius: 5pt, fill: blue, stroke: none)
  content((0, 0), anchor: "north-west", padding: 5pt, [#set text(20pt, blue); $100$])

  let test-point = (-4.5, -3.2)
  circle(test-point, radius: 5pt, fill: red, stroke: none)
  content(test-point, anchor: "north-east", padding: 5pt, [#set text(20pt, red); $A$])

  line(test-point, (rel: (2, 0)), stroke: 3pt + red, mark: (end: "straight"))
})



