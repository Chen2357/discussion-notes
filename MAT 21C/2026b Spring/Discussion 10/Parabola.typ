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

  let xmin = -5
  let xmax = 5
  let ymin = -2
  let ymax = 10

  let axis = line.with(stroke: gray + 2pt, mark: (end: "stealth"))
  axis((xmin, 0), (xmax, 0))
  content((), anchor: "west", padding: (left: 2pt))[#set text(gray); $x$]
  axis((0, ymin), (0, ymax))
  content((), anchor: "south", padding: (bottom: 2pt))[#set text(gray); $y$]

  let p(x) = x * x + 4 * x + 6
  let p-prime(x) = 2 * x + 4
  let parabola = nt.linspace(-5, 2, 100).map(x => (x, p(x)))
  parabola = parabola.filter(p => ymin <= p.at(1) and p.at(1) <= ymax)
  line(..parabola, stroke: red + 2pt)

  let line-slope = 2
  let line-start = (ymin / line-slope, ymin)
  let line-end = (ymax / line-slope, ymax)
  line(line-start, line-end, stroke: blue + 2pt)

  let optimal-x = -1
  let optimal-y = p(optimal-x)
  let slope-at-x = p-prime(optimal-x)

  circle((optimal-x, optimal-y), radius: 3pt, fill: red, stroke: none)
  let tangent-line = nt.linspace(-5, 5, 100).map(x => (x, optimal-y + slope-at-x * (x - optimal-x)))
  tangent-line = tangent-line.filter(p => ymin <= p.at(1) and p.at(1) <= ymax)
  line(..tangent-line, stroke: (dash: "dashed"))

})
