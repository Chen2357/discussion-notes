#import "@preview/cetz:0.4.2" as cetz
#import "@preview/numty:0.1.0" as nt
#set page(width: auto, height: auto, margin: 0.5pt, fill: white.transparentize(100%))

#cetz.canvas(length: 2cm, {
  import cetz.draw: *

  let axis = line.with(stroke: 1pt + black, mark: (end: "straight"))
  let grid-line = line.with(stroke: 0.5pt + gray)

  let x-min = -1.2
  let x-max = 3.5
  let y-min = -1.5
  let y-max = 1.5

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

  let curve-1(t) = (calc.cos(t), calc.sin(t))
  let t1-min = -calc.pi
  let t1-max = calc.pi
  let curve-1-points = nt.linspace(t1-min, t1-max, 100).map(curve-1)
  let curve-1-label = $arrow(r)_1 (t)$

  let curve-2(t) = (1 + t * t, t)
  let t2-min = -2
  let t2-max = 2
  let curve-2-points = nt.linspace(t2-min, t2-max, 100).map(curve-2).filter(p => x-min <= p.at(0) and p.at(0) <= x-max and y-min <= p.at(1) and p.at(1) <= y-max)
  let curve-2-label = $arrow(r)_2 (t)$

  line(..curve-1-points, stroke: blue + 1.5pt)
  content(curve-1(calc.pi / 4), anchor: "north-east", padding: 2pt)[#text(blue, 14pt, curve-1-label)]

  line(..curve-2-points, stroke: red + 1.5pt)
  content(curve-2(1), anchor: "north-west", padding: 4pt)[#text(red, 14pt, curve-2-label)]
})

