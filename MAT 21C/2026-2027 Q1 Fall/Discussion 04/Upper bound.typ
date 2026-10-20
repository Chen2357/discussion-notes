#import "@preview/cetz:0.4.2" as cetz
#import "@preview/numty:0.1.0" as nt
#set page(width: auto, height: auto, margin: 0.5pt, fill: white.transparentize(100%))

#cetz.canvas(length: 2cm, {
  import cetz.draw: *

  let f(x) = 1 / (1 + x)
  let a = 0
  let x = 2
  let num-points = 100
  let points = nt.linspace(a, x, num-points).map(c => (c, f(c)))
  let M = 1

  let axis = line.with(stroke: 1pt + gray, mark: (end: "straight"))
  let fun-line = line.with(stroke: 1pt + red.darken(20%))
  let mark = line.with(stroke: 0.5pt + gray)

  axis((a, 0), (x + 0.2, 0))
  content((), anchor: "west", padding: (left: 5pt))[#text(gray)[$t$]]
  axis((a, 0), (a, 1.5))
  mark((a, 0.05), (a, -0.05))
  content((), anchor: "north", padding: (top: 2pt))[#text(gray)[$0$]]
  mark((x, 0.05), (x, -0.05))
  content((), anchor: "north", padding: (top: 2pt))[#text(gray)[$x$]]
  fun-line(..points)
  content((), anchor: "south", padding: (bottom: 10pt))[#text(red.darken(20%))[$abs(f^((n+1)) (c))$]]

  line(stroke: (thickness: 1pt, paint: purple, dash: "dashed"), (a, M), (x + 0.2, M))
  content((a, M), anchor: "east", padding: (right: 2pt))[#text(purple)[$M$]]
})
