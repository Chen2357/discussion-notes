#import "@preview/cetz:0.5.0" as cetz: canvas
#import "@preview/numty:0.1.0" as nt
#set page(
  width: auto,
  height: auto,
  margin: (top: 0.8pt, left: 0.8pt, right: 0.8pt, bottom: 0.8pt),
  fill: white.transparentize(100%),
)

#set math.accent(dotless: false)

#let d = read("contours.csv")
#let rows = d.split("\n").slice(0, -1)
#let data = rows.map(row => row.split(",").map(s => float(s.slice(0, s.len() - 1))))

#let labels = (
  (point: (-3.8, -4), height: 40),
  (point: (-2.4, -3.6), height: 80),
  (point: (-0.8, -3.3), height: 120),
  (point: (-0, -2.35), height: 160),
  (point: (0.5, -1.3), height: 200),
  (point: (0.9, -0.2), height: 240),
  (point: (-0.8, 3.08), height: 120),
  (point: (1.2, 2.8), height: 160),
  (point: (-3.4, 3.3), height: 120),
  (point: (-4.5, 4.0), height: 160),
)

#let letters = (
  (point: (-3.3, -3.0), label: $A$, anchor: "east"),
  (point: (2.4, -1.5), label: $B$, anchor: "north"),
  (point: (-0.5, 1.86), label: $C$, anchor: "east"),
)

#let multi-bezier(points, ctrl, ease) = {
  let end-ctrl = nt.sub(points, nt.sub(ctrl, points).map(it => nt.mult(ease, it)))

  return range(points.len() - 1).map(
    i => cetz.draw.bezier.with(points.at(i), points.at(i + 1), ctrl.at(i), end-ctrl.at(i + 1)),
  )
}

#canvas(length: 0.8cm, {
  import cetz.draw: *

  let r = 5
  for row in data {
    let points = row.chunks(2).filter(p => -r <= p.at(0) and p.at(0) <= r and -r <= p.at(1) and p.at(1) <= r)
    if points.len() < 2 { continue }
    line(..points, stroke: gray + 1.5pt)
  }

  for label in labels {
    content(label.point, frame: "rect", padding: 1pt, stroke: none, fill: white, [#label.height])
  }

  let paths = multi-bezier(
    (
      (-2.5, -5),
      (-1.5, -3),
      (-1.1, -0.2),
      (-1.5, 2),
      (-1, 5),
    ),
    (
      (-2, -4.1),
      (-1, -2),
      (-1.1, 1),
      (-1.8, 3),
      (0, 6),
    ),
    0.8
  )
  for path in paths {
    path(stroke: blue + 2pt)
  }

  circle((-1.1, -0.2), radius: 3pt, fill: red, stroke: none)
  let gradient = line.with(stroke: red + 1pt, mark: (end: "straight"))
  gradient((-1.1, -0.2), (rel: (0.6, 0)))
  gradient((0, 1.1), (rel: nt.mult((1, -2), 0.3)))
  gradient((2, 1.35), (rel: nt.mult((-1, -1.7), 0.3)))
  gradient((1.5, -1.3), (rel: nt.mult((-1, 1.8), 0.3)))
})




